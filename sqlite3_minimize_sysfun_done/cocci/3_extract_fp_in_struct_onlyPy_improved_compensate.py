#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
향상된 함수 포인터 할당 추출기 (증분 복구 + 매크로/3항/래퍼 강화판)

- 기존 기능(구조체 FP 수집, 할당 스캔, 선언 수집, 인자 역추적) 유지/강화
- "증분 복구 모드": fpNameDecl/*.txt에서 "// 선언을 찾을 수 없음"이 있는 FP만 재추적
- 할당 탐지 보강: 3항, 지정자 초기화 말미, 매크로 래퍼, 매크로/로컬 별칭 해제
"""

import argparse
import os
import re
import sys
from typing import Dict, List, Set, Tuple, Optional
import glob
from collections import defaultdict
import time

# -------------------------------
# 0) 유틸
# -------------------------------

def read_text(p):
    with open(p, "r", encoding="utf-8", errors="ignore") as f:
        return f.read()

def write_text(p, s):
    with open(p, "w", encoding="utf-8") as f:
        f.write(s)

def ensure_dir(d):
    os.makedirs(d, exist_ok=True)

# -------------------------------
# 1) 구조체 내부 FP 수집(기존)
# -------------------------------

def find_struct_with_function_pointers(source_dir: str, verbose: bool = False) -> Dict[str, List[Tuple[str, str, str]]]:
    """
    Python으로 구조체의 함수 포인터 검색
    returns: { struct_name: [(return_type, fp_name, args), ...], ... }
    """
    struct_fp_map: Dict[str, List[Tuple[str, str, str]]] = {}
    
    # 구조체 패턴
    struct_patterns = [
        re.compile(r'struct\s+(\w+)\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}\s*;', re.MULTILINE | re.DOTALL),
        re.compile(r'typedef\s+struct\s+(\w+)\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}\s*\w*\s*;', re.MULTILINE | re.DOTALL),
        re.compile(r'typedef\s+struct\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}\s*(\w+)\s*;', re.MULTILINE | re.DOTALL),
    ]

    # 함수 포인터 필드 패턴(직접형)
    fp_patterns = [
        re.compile(r'(\w+(?:\s+\w+)*\s*\*?)\s*\(\s*\*\s*(\w+)\s*\)\s*\(([^)]*)\)\s*;', re.MULTILINE),
        re.compile(r'(struct\s+\w+\s*\*?|\w+\s*\*+)\s*\(\s*\*\s*(\w+)\s*\)\s*\(([^)]*)\)\s*;', re.MULTILINE),
        re.compile(r'((?:const\s+|volatile\s+)*\w+(?:\s+\w+)*\s*\*?)\s*\(\s*\*\s*(\w+)\s*\)\s*\(([^)]*)\)\s*;', re.MULTILINE),
    ]
    
    # 파일 후보
    file_patterns = [
        os.path.join(source_dir, "src/*.c"),
        os.path.join(source_dir, "src/*.h"),
        os.path.join(source_dir, "tsrc/*.c"),
        os.path.join(source_dir, "tsrc/*.h"),
        os.path.join(source_dir, "ext/*.c"),
        os.path.join(source_dir, "ext/*.h"),
    ]
    files_to_process = set()
    for pattern in file_patterns:
        files_to_process.update(glob.glob(pattern, recursive=True))
    files = list(files_to_process)
    if verbose:
        print(f"[INFO] 구조체 검색: {len(files)}개 파일")

    for file_path in files:
        try:
            content = read_text(file_path)
            # 주석 제거
            content = re.sub(r'//.*?\n', '\n', content)
            content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
            
            for i, struct_pattern in enumerate(struct_patterns):
                for sm in struct_pattern.finditer(content):
                    if i == 2:
                        struct_body = sm.group(1)
                        struct_name = sm.group(2)
                    else:
                        struct_name = sm.group(1)
                        struct_body = sm.group(2) if len(sm.groups()) > 1 else sm.group(1)
                    if not struct_name or not struct_body:
                        continue

                    fps = []
                    for ptn in fp_patterns:
                        for m in ptn.finditer(struct_body):
                            rt = m.group(1).strip()
                            fn = m.group(2).strip()
                            args = m.group(3).strip()
                            if fn and len(fn) > 1:
                                fps.append((rt, fn, args))
                    if fps:
                        exist = set([x[1] for x in struct_fp_map.get(struct_name, [])])
                        new = [x for x in fps if x[1] not in exist]
                        if new:
                            struct_fp_map.setdefault(struct_name, []).extend(new)
                            if verbose:
                                print(f"[FOUND] {struct_name}: +{len(new)} FP")
        except Exception as e:
            if verbose:
                print(f"[WARN] 구조체 스캔 실패 {file_path}: {e}")
    return struct_fp_map

# -------------------------------
# 2) 매크로/별칭 맵 수집
# -------------------------------

def build_macro_alias_map(source_dir: str, verbose: bool=False) -> Dict[str, str]:
    """
    #define ALIAS REALFUNC  스타일 별칭 수집
    - 괄호가 들어가면(매크로 함수) 제외
    - 전부 대문자 상수 같은 경우는 제외(함수 후보에 의미 없음)
    """
    alias_map: Dict[str, str] = {}
    file_patterns = [
        os.path.join(source_dir, "src/*.[ch]"),
        os.path.join(source_dir, "tsrc/*.[ch]"),
        os.path.join(source_dir, "ext/*.[ch]"),
        os.path.join(source_dir, "include/*.[chh]"),
    ]
    files = set()
    for p in file_patterns:
        files.update(glob.glob(p, recursive=True))
    for f in files:
        try:
            s = read_text(f)
            for m in re.finditer(r'^[ \t]*#\s*define\s+([A-Za-z_]\w+)\s+([A-Za-z_]\w+)[ \t]*$', s, flags=re.MULTILINE):
                a, b = m.group(1), m.group(2)
                # 대상/치환 둘 다 함수명 같은 식별자여야 의미 있음
                if "(" in b or ")" in b:
                    continue
                # 모두 대문자면 상수일 확률 높음 -> 스킵(원한다면 주석 처리)
                if a.isupper() and b.isupper():
                    continue
                alias_map[a] = b
        except Exception:
            pass
    if verbose and alias_map:
        print(f"[INFO] 매크로 별칭 {len(alias_map)}개 수집")
    return alias_map

def build_local_alias_map(content: str) -> Dict[str, str]:
    """
    동일 파일 내 간단 별칭: cb = foo; 형태를 수집
    """
    m: Dict[str, str] = {}
    for mm in re.finditer(r'\b([A-Za-z_]\w*)\s*=\s*&?\s*([A-Za-z_]\w+)\s*;', content):
        a, b = mm.group(1), mm.group(2)
        if a != b:
            m[a] = b
    return m

def resolve_alias(name: str, macro_map: Dict[str,str], local_map: Dict[str,str]) -> str:
    seen = set()
    cur = name
    while True:
        if cur in seen:
            return cur
        seen.add(cur)
        if cur in local_map:
            cur = local_map[cur]; continue
        if cur in macro_map:
            cur = macro_map[cur]; continue
        break
    return cur

# -------------------------------
# 3) 함수 포인터 할당 스캔(강화)
# -------------------------------

def find_function_pointer_assignments(
    source_dir: str,
    fp_names: Set[str],
    verbose: bool = False,
    restrict_to: Optional[Set[str]] = None,
    macro_alias_map: Optional[Dict[str,str]] = None
) -> Dict[str, Set[str]]:
    """
    함수 포인터 할당 검색 (정규식, 빠름)
    - restrict_to: 주어진 FP 이름만 스캔(증분 복구에서 사용)
    - macro_alias_map: #define 별칭을 함수명에 적용
    """
    targets = set(fp_names)
    if restrict_to is not None:
        targets &= set(restrict_to)
    if not targets:
        return {}

    fp_assignments: Dict[str, Set[str]] = defaultdict(set)

    # 파일 후보
    file_patterns = [
        os.path.join(source_dir, "src/*.[ch]"),
        os.path.join(source_dir, "tsrc/*.[ch]"),
        os.path.join(source_dir, "ext/*.[ch]"),
        os.path.join(source_dir, "include/*.[chh]"),
    ]
    files = set()
    for p in file_patterns:
        files.update(glob.glob(p, recursive=True))
    files = list(files)
    if verbose:
        print(f"[INFO] 할당 스캔 파일: {len(files)}개, 대상 FP: {len(targets)}개")

    # FP별 패턴 사전 컴파일
    compiled = {}
    for fp in targets:
        # E.fp = foo; / E->fp = &foo; / E.a->fp = foo;
        assign_basic = re.compile(rf'(?:\.|->)\s*{re.escape(fp)}\s*=\s*&?\s*([A-Za-z_]\w+)', re.MULTILINE)
        # 지정자 초기화: { .fp = foo } (말미 항목 허용: , 또는 } 또는 ) 앞)
        init_designated = re.compile(rf'\.\s*{re.escape(fp)}\s*=\s*&?\s*([A-Za-z_]\w+)\s*(?=[,}}\)])', re.MULTILINE | re.DOTALL)
        # 3항 연산자: E.fp = cond ? f1 : f2;
        assign_ternary = re.compile(rf'(?:\.|->)\s*{re.escape(fp)}\s*=\s*[^;?]*\?\s*&?\s*([A-Za-z_]\w+)\s*:\s*&?\s*([A-Za-z_]\w+)', re.MULTILINE | re.DOTALL)
        # 매크로 래퍼(대략): MACRO( ..., .fp 또는 ->fp 가 인자에 등장, ..., func )
        macro_wrapper = re.compile(
            rf'\b([A-Za-z_]\w*)\s*\(([^;]*?(?:\.|->)\s*{re.escape(fp)}[^;]*?),\s*&?\s*([A-Za-z_]\w+)[^;]*?\)',
            re.MULTILINE | re.DOTALL
        )
        compiled[fp] = (assign_basic, init_designated, assign_ternary, macro_wrapper)

    start = time.time()
    for i, path in enumerate(files, 1):
        try:
            content = read_text(path)
            # 주석 제거
            content_nc = re.sub(r'//.*?\n', '\n', content)
            content_nc = re.sub(r'/\*.*?\*/', '', content_nc, flags=re.DOTALL)
            local_alias = build_local_alias_map(content_nc)

            for fp in targets:
                ab, idz, ter, mw = compiled[fp]

                # 기본/포인터 할당
                for m in ab.finditer(content_nc):
                    cand = m.group(1)
                    cand = resolve_alias(cand, macro_alias_map or {}, local_alias)
                    if cand and cand.isidentifier() and re.search(r'[a-z]', cand):
                        fp_assignments[fp].add(cand)
                        if verbose:
                            print(f"[ASSIGN] {fp} = {cand} @ {os.path.basename(path)}")

                # 지정자 초기화 (마지막 항목 포함)
                for m in idz.finditer(content_nc):
                    cand = m.group(1)
                    cand = resolve_alias(cand, macro_alias_map or {}, local_alias)
                    if cand and cand.isidentifier() and re.search(r'[a-z]', cand):
                        fp_assignments[fp].add(cand)
                        if verbose:
                            print(f"[INIT ] {fp} = {cand} @ {os.path.basename(path)}")

                # 3항 연산자
                for m in ter.finditer(content_nc):
                    f1, f2 = m.group(1), m.group(2)
                    for cand0 in (f1, f2):
                        cand = resolve_alias(cand0, macro_alias_map or {}, local_alias)
                        if cand and cand.isidentifier() and re.search(r'[a-z]', cand):
                            fp_assignments[fp].add(cand)
                            if verbose:
                                print(f"[TERN ] {fp} = {cand} @ {os.path.basename(path)}")

                # 매크로 래퍼(마지막 인자 쪽을 함수로 간주)
                for m in mw.finditer(content_nc):
                    cand = m.group(3)
                    cand = resolve_alias(cand, macro_alias_map or {}, local_alias)
                    if cand and cand.isidentifier() and re.search(r'[a-z]', cand):
                        fp_assignments[fp].add(cand)
                        if verbose:
                            print(f"[MACRO] {fp} = {cand} @ {os.path.basename(path)}")

        except Exception as e:
            if verbose:
                print(f"[WARN] 할당 스캔 실패 {path}: {e}")
        if verbose and i % 200 == 0:
            print(f"[PROGRESS] {i}/{len(files)} ({time.time()-start:.1f}s)")
    return dict(fp_assignments)

# -------------------------------
# 4) 함수 선언 수집(기존)
# -------------------------------

def find_function_declarations(source_dir: str, func_names: Set[str], verbose: bool = False) -> Dict[str, str]:
    """
    Python으로 함수 선언/정의 시그니처 수집
    returns: { func_name: "ret func(args)" }
    """
    func_declarations: Dict[str, str] = {}
    if not func_names:
        return func_declarations
    
    patterns = []
    for fn in func_names:
        # return_type name(args) { 또는 ;
        patterns.append((fn, re.compile(rf'((?:static\s+|extern\s+)?\w+(?:\s+\w+)*\s*\*?)\s+{re.escape(fn)}\s*\(([^)]*)\)\s*[;{{]', re.MULTILINE)))

    file_patterns = [
        os.path.join(source_dir, "src/*.[ch]"),
        os.path.join(source_dir, "tsrc/*.[ch]"),
        os.path.join(source_dir, "ext/*.[ch]"),
        os.path.join(source_dir, "include/*.[chh]"),
    ]
    files = set()
    for p in file_patterns:
        files.update(glob.glob(p, recursive=True))
    files = list(files)

    for path in files:
        try:
            s = read_text(path)
            s = re.sub(r'//.*?\n', '\n', s)
            s = re.sub(r'/\*.*?\*/', '', s, flags=re.DOTALL)
            for fn, pat in patterns:
                if fn in func_declarations:
                    continue
                for m in pat.finditer(s):
                    rt = m.group(1).strip()
                    rt = re.sub(r'\b(static|extern)\b\s*', '', rt)
                    args = (m.group(2) or '').strip()
                    func_declarations[fn] = f"{rt} {fn}({args})"
                    if verbose:
                        print(f"[DECL] {func_declarations[fn]} @ {os.path.basename(path)}")
                    break
        except Exception as e:
            if verbose:
                print(f"[WARN] 선언 스캔 실패 {path}: {e}")
    return func_declarations

# -------------------------------
# 5) “함수 포인터 인자” 경로 역추적(기존+)
# -------------------------------

def find_function_parameters(source_dir: str, func_name: str, verbose: bool = False) -> List[Tuple[str, int, str]]:
    """
    func_name이 '다른 함수의 매개변수'로 선언되는 패턴을 찾음
    returns: [(parent_func, param_index, param_decl), ...]
    """
    param_info: List[Tuple[str,int,str]] = []
    file_patterns = [
        os.path.join(source_dir, "src/*.[ch]"),
        os.path.join(source_dir, "tsrc/*.[ch]"),
        os.path.join(source_dir, "ext/*.[ch]"),
        os.path.join(source_dir, "include/*.[chh]"),
    ]
    files = set()
    for p in file_patterns:
        files.update(glob.glob(p, recursive=True))

    # parent_func(func_name, ...) 형태의 시그니처
    # 단순화된 패턴이지만 실제 프로젝트에서 대체로 작동
    pat = re.compile(rf'(\w+)\s*\(([^)]*?\b{re.escape(func_name)}\b[^)]*)\)', re.MULTILINE)
    for path in files:
        try:
            s = read_text(path)
            s = re.sub(r'//.*?\n', '\n', s)
            s = re.sub(r'/\*.*?\*/', '', s, flags=re.DOTALL)
            for m in pat.finditer(s):
                parent = m.group(1)
                params_str = m.group(2)
                # 쉼표 기반 단순 분리
                params = [x.strip() for x in params_str.split(',') if x.strip()]
                for idx, pstr in enumerate(params):
                    if re.search(r'\(\s*\*\s*' + re.escape(func_name) + r'\s*\)\s*\(', pstr):
                        param_info.append((parent, idx, pstr))
                        if verbose:
                            print(f"[FP-PARAM] {func_name} is param#{idx} of {parent}")
                        break
        except Exception:
            pass
    return param_info

def find_function_calls_with_args(source_dir: str, func_name: str, param_index: int, verbose: bool=False) -> Set[str]:
    """
    parent func 호출부에서 해당 인자 위치에 전달되는 함수명을 수집
    """
    calls: Set[str] = set()
    file_patterns = [
        os.path.join(source_dir, "src/*.[ch]"),
        os.path.join(source_dir, "tsrc/*.[ch]"),
        os.path.join(source_dir, "ext/*.[ch]"),
        os.path.join(source_dir, "include/*.[chh]"),
    ]
    files = set()
    for p in file_patterns:
        files.update(glob.glob(p, recursive=True))
    pat = re.compile(rf'\b{re.escape(func_name)}\s*\(([^;]*?)\)', re.MULTILINE | re.DOTALL)
    for path in files:
        try:
            s = read_text(path)
            s = re.sub(r'//.*?\n', '\n', s)
            s = re.sub(r'/\*.*?\*/', '', s, flags=re.DOTALL)
            for m in pat.finditer(s):
                args = [a.strip() for a in m.group(1).split(',') if a.strip()]
                if len(args) > param_index:
                    a = re.sub(r'^&\s*', '', args[param_index])
                    if a.isidentifier() and re.search(r'[a-z]', a):
                        calls.add(a)
                        if verbose:
                            print(f"[CALL-ARG] {func_name} arg{param_index} = {a}")
        except Exception:
            pass
    return calls

def resolve_parameter_functions(
    source_dir: str,
    fp_assignments: Dict[str, Set[str]],
    func_declarations: Dict[str, str],
    verbose: bool = False
) -> Tuple[Dict[str, Set[str]], Dict[str, str]]:
    """
    '함수 포인터 인자'를 통해 흘러들어온 후보를 실제 함수로 치환
    """
    res_assign = {k: set(v) for k, v in fp_assignments.items()}
    res_decl = dict(func_declarations)

    unknowns: Set[str] = set()
    for _, funcs in fp_assignments.items():
        for fn in funcs:
            if fn not in func_declarations:
                unknowns.add(fn)
    if not unknowns:
        return res_assign, res_decl

    for unk in list(unknowns):
        info = find_function_parameters(source_dir, unk, verbose)
        if not info:
            continue
        # 첫 parent 기준
        parent, idx, _ = info[0]
        real = find_function_calls_with_args(source_dir, parent, idx, verbose)
        if not real:
            continue
        # 교체
        for fp in res_assign:
            if unk in res_assign[fp]:
                res_assign[fp].remove(unk)
                res_assign[fp].update(real)
                if verbose:
                    print(f"[REPLACE] {fp}: {unk} -> {sorted(real)}")
        # 선언 보강
        new_decl = find_function_declarations(source_dir, real, verbose)
        res_decl.update(new_decl)
        if unk in res_decl:
            del res_decl[unk]
    return res_assign, res_decl

# -------------------------------
# 6) 결과 저장(기존)
# -------------------------------

def save_results(fp_assignments: Dict[str, Set[str]], func_declarations: Dict[str, str], verbose: bool = False):
    ensure_dir("fpName")
    ensure_dir("fpNameDecl")
    for fp, funcs in fp_assignments.items():
        if not funcs:
            continue
        write_text(f"fpName/{fp}.txt", "".join(f"{x}\n" for x in sorted(funcs)))
        decls = []
        for fn in sorted(funcs):
            if fn in func_declarations:
                decls.append(f"{func_declarations[fn]};")
            else:
                decls.append(f"// 선언을 찾을 수 없음: {fn}")
        write_text(f"fpNameDecl/{fp}.txt", "// Function declarations for {fp}\n\n" + "\n".join(decls))
        if verbose:
            print(f"[SAVE] fpName/{fp}.txt, fpNameDecl/{fp}.txt")

# -------------------------------
# 7) 증분 복구(Incremental repair)
# -------------------------------

def repair_missing_declarations(
    source_dir: str,
    verbose: bool = False,
    use_param_resolve: bool = True
):
    """
    fpNameDecl/*.txt 를 순차적으로 확인하고
    - "// 선언을 찾을 수 없음: <name>" 이 있으면
      => 해당 파일명(FP 이름)에 대해서만 재추적(할당 스캔 + 선택적 인자 역추적)
      => fpName/FP.txt 갱신, fpNameDecl/FP.txt 재작성
    """
    decl_dir = PathLike("fpNameDecl")
    name_dir = PathLike("fpName")
    if not os.path.isdir(decl_dir):
        if verbose:
            print("[INFO] fpNameDecl 디렉토리가 없어 증분 복구 생략")
        return

    macro_alias = build_macro_alias_map(source_dir, verbose=verbose)

    for p in sorted(glob.glob(os.path.join(decl_dir, "*.txt"))):
        fp = os.path.splitext(os.path.basename(p))[0]
        content = read_text(p)
        missing = []
        for line in content.splitlines():
            m = re.search(r'//\s*선언을\s*찾을\s*수\s*없음\s*:\s*([A-Za-z_]\w+)', line)
            if m:
                missing.append(m.group(1))
        if not missing:
            if verbose:
                print(f"[SKIP] {os.path.basename(p)}: 누락 없음")
            continue

        if verbose:
            print(f"[REPAIR] {fp}: 누락 {len(missing)}개 → 재추적")

        # 기존 후보 불러오기
        old_candidates: Set[str] = set()
        fp_txt = os.path.join(name_dir, f"{fp}.txt")
        if os.path.isfile(fp_txt):
            old_candidates = set(x.strip() for x in read_text(fp_txt).splitlines() if x.strip())

        # 해당 FP만 제한하여 재스캔
        new_assign = find_function_pointer_assignments(
            source_dir,
            {fp},
            verbose=verbose,
            restrict_to={fp},
            macro_alias_map=macro_alias
        )
        candidates = set(new_assign.get(fp, set())) | old_candidates

        # 선언 확보
        decls = find_function_declarations(source_dir, candidates, verbose=verbose)
        assign_for_resolve = {fp: set(candidates)}
        if use_param_resolve:
            assign_for_resolve, decls = resolve_parameter_functions(source_dir, assign_for_resolve, decls, verbose=verbose)

        # 파일 갱신
        final_candidates = assign_for_resolve.get(fp, set())
        write_text(fp_txt, "".join(f"{x}\n" for x in sorted(final_candidates)))

        # 선언 파일 재작성
        out = ["// Function declarations for {fp}", ""]
        for fn in sorted(final_candidates):
            if fn in decls:
                out.append(decls[fn] + ";")
            else:
                out.append(f"// 선언을 찾을 수 없음: {fn}")
        write_text(p, "\n".join(out))
        if verbose:
            print(f"[UPDATED] {os.path.basename(fp_txt)}, {os.path.basename(p)}")

# -------------------------------
# 8) 경로 도우미
# -------------------------------

def PathLike(p: str) -> str:
    return os.path.normpath(p)

# -------------------------------
# 9) 메인
# -------------------------------

def main():
    ap = argparse.ArgumentParser(description="향상된 함수 포인터 추출기 (증분 복구 포함)")
    ap.add_argument("--source-dir", required=True, help="소스 코드 루트 디렉토리")
    ap.add_argument("--verbose", "-v", action="store_true")
    ap.add_argument("--benchmark", "-b", action="store_true")
    ap.add_argument("--incremental", "-i", action="store_true", help="증분 복구만 수행 (fpNameDecl/*.txt 기반)")
    args = ap.parse_args()

    if not os.path.isdir(args.source_dir):
        print(f"[ERROR] 소스 디렉토리를 찾을 수 없음: {args.source_dir}")
        sys.exit(1)

    if args.incremental:
        # 증분 복구 전용 실행
        repair_missing_declarations(args.source_dir, verbose=args.verbose, use_param_resolve=True)
        return

    total_start = time.time()
    print("[INFO] 함수 포인터 분석 시작")

    # 1) 구조체 FP 수집
    print("\n=== 1단계: 구조체 함수 포인터 수집 ===")
    st = time.time()
    struct_fp_map = find_struct_with_function_pointers(args.source_dir, args.verbose)
    step1 = time.time() - st
    if not struct_fp_map:
        print("[INFO] 구조체에서 함수 포인터를 찾지 못함")
        return
    all_fp = set()
    total_fps = 0
    for s, fps in struct_fp_map.items():
        for _, name, _ in fps:
            all_fp.add(name); total_fps += 1
    print(f"[SUMMARY] {len(struct_fp_map)}개 구조체 / {total_fps}개 FP ({step1:.2f}s)")

    # 2) 할당 스캔
    print("\n=== 2단계: 할당 스캔(강화) ===")
    st = time.time()
    macro_alias = build_macro_alias_map(args.source_dir, verbose=args.verbose)
    fp_assign = find_function_pointer_assignments(args.source_dir, all_fp, verbose=args.verbose, macro_alias_map=macro_alias)
    step2 = time.time() - st
    cnt_assign = sum(len(v) for v in fp_assign.values())
    print(f"[SUMMARY] {len(fp_assign)}개 FP에서 {cnt_assign}개 후보 ({step2:.2f}s)")

    # 3) 선언 수집
    print("\n=== 3단계: 선언 수집 ===")
    st = time.time()
    all_funcs = set()
    for v in fp_assign.values():
        all_funcs |= set(v)
    decls = find_function_declarations(args.source_dir, all_funcs, verbose=args.verbose)
    step3 = time.time() - st
    print(f"[SUMMARY] 선언 {len(decls)}개 수집 ({step3:.2f}s)")

    # 4) 인자 경로 역추적 (옵션)
    print("\n=== 4단계: 인자 경로 역추적(선택) ===")
    st = time.time()
    fp_assign2, decls2 = resolve_parameter_functions(args.source_dir, fp_assign, decls, verbose=args.verbose)
    step4 = time.time() - st
    cnt_assign2 = sum(len(v) for v in fp_assign2.values())
    print(f"[SUMMARY] 역추적 후 후보 {cnt_assign2}개 / 선언 {len(decls2)}개 ({step4:.2f}s)")

    # 5) 저장
    print("\n=== 5단계: 결과 저장 ===")
    st = time.time()
    save_results(fp_assign2, decls2, verbose=args.verbose)
    step5 = time.time() - st

    # 6) 증분 복구 1패스 (선택)
    print("\n=== 6단계: 증분 복구(누락만 재추적) ===")
    repair_missing_declarations(args.source_dir, verbose=args.verbose, use_param_resolve=True)

    total = time.time() - total_start
    print("\n=== 완료 요약 ===")
    print(f"총 소요: {total:.2f}s (1:{step1:.2f}s, 2:{step2:.2f}s, 3:{step3:.2f}s, 4:{step4:.2f}s, 5:{step5:.2f}s)")
    print("결과 디렉토리: fpName/, fpNameDecl/")

if __name__ == "__main__":
    main()
