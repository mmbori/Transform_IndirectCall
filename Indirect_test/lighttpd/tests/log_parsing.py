# #!/usr/bin/env python3
# # -*- coding: utf-8 -*-
# """
# log_to_json_dedup_with_srcline_ordered.py
# - PIN 로그 파싱 → JSON 생성
# - 각 아이템의 키 순서: callsite_caller, callsite, src_line, callee
# - callee 리스트는 실제 호출 순서로 기록
# - callsite_caller는 항상 기록
# """

# import argparse, json, re
# from collections import defaultdict, Counter

# RE_ENTER  = re.compile(r'^\[srv\.like\.enter\]\s+(.*)$')
# RE_LEAVE  = re.compile(r'^\[srv\.like\.leave\]\s+(.*)$')
# RE_FNCALL = re.compile(r'^\[srv\.like\.fn\.call\]\s+(.*)$')

# # key='value with spaces' / key="..." / key=bare
# _KV_RE = re.compile(r"""(\w+)=('([^']*)'|"([^"]*)"|[^\s]+)""")

# def parse_kv(payload: str) -> dict:
#     out = {}
#     for m in _KV_RE.finditer(payload):
#         k = m.group(1)
#         if m.group(3) is not None:
#             v = m.group(3)      # 'single-quoted'
#         elif m.group(4) is not None:
#             v = m.group(4)      # "double-quoted"
#         else:
#             v = m.group(2)      # bare
#         out[k] = v
#     return out

# def pick_most_common(counter: Counter) -> str:
#     if not counter:
#         return ""
#     val, _ = counter.most_common(1)[0]
#     return val or ""

# def main():
#     ap = argparse.ArgumentParser()
#     ap.add_argument('log_path', help='입력 로그 파일 경로 (예: test_log.txt)')
#     ap.add_argument('-o', '--out', default='callsites.json', help='출력 JSON 경로')
#     args = ap.parse_args()

#     in_session = False
#     cur_cs = None        # callsite (dispatcher name)
#     cur_caller = None    # caller_fn
#     cur_callees = None   # list() - 순서 보장을 위해 list 사용
#     cur_srcs = None      # list of src_line strings

#     sessions = []  # [{callsite, caller, callees:list, srcs:list}]
#     with open(args.log_path, 'r', encoding='utf-8', errors='ignore') as f:
#         for line in f:
#             line = line.rstrip('\n')

#             m = RE_ENTER.match(line)
#             if m:
#                 kv = parse_kv(m.group(1))
#                 in_session = True
#                 cur_cs = kv.get('callee', '')          # dispatcher name
#                 cur_caller = kv.get('caller_fn', '')   # may be ""
#                 cur_callees = []  # list로 변경하여 순서 보장
#                 cur_srcs = []
#                 continue

#             m = RE_FNCALL.match(line)
#             if m and in_session:
#                 kv = parse_kv(m.group(1))
#                 fn = kv.get('fn', '')
#                 if fn:
#                     cur_callees.append(fn)  # append로 순서 보장
#                 # src_line 또는 srv_line(오타 대비) 수집
#                 sl = kv.get('src_line') or ''
#                 if sl:
#                     cur_srcs.append(sl)
#                 continue

#             m = RE_LEAVE.match(line)
#             if m and in_session:
#                 if not cur_callees:
#                     cur_callees = [""]  # 세션 내 호출 없으면 [""] 유지
#                 sessions.append({
#                     "callsite": cur_cs or "",
#                     "caller": cur_caller or "",
#                     "callees": list(cur_callees),  # 순서가 보장된 리스트
#                     "srcs": list(cur_srcs or []),
#                 })
#                 in_session = False
#                 cur_cs = cur_caller = None
#                 cur_callees = cur_srcs = None
#                 continue

#     # caller 종류 집계(빈 문자열 제외)
#     nonempty_callers_by_cs = defaultdict(set)
#     for s in sessions:
#         cs = s["callsite"]
#         caller = s["caller"]
#         if caller:
#             nonempty_callers_by_cs[cs].add(caller)

#     # callsite+caller 단위로 합집합/카운터 (callees를 순서가 보장된 리스트로 처리)
#     agg = {}  # (cs, caller) -> {"callees": list(), "src_counter": Counter()}
#     for s in sessions:
#         key = (s["callsite"], s["caller"])
#         if key not in agg:
#             agg[key] = {"callees": [], "src_counter": Counter()}
        
#         # callees 순서 보장하면서 중복 제거
#         for callee in s["callees"]:
#             if callee not in agg[key]["callees"]:
#                 agg[key]["callees"].append(callee)
        
#         agg[key]["src_counter"].update(s["srcs"])

#     def mk_item(callsite_caller: str, callsite: str, src_counter: Counter, callees_list: list):
#         # 원하는 키 순서대로 삽입
#         item = {}
#         item["callsite_caller"] = callsite_caller or ""
#         item["callsite"] = callsite or ""
#         item["src_line"] = pick_most_common(src_counter)
#         if not callees_list:
#             callees_list = [""]
#         item["callee"] = callees_list  # 순서가 보장된 리스트 그대로 사용
#         return item

#     out_items = []

#     # 모든 callsite에 대해 caller별로 항목 생성 (단일/다중 관계없이)
#     all_cs = set()
#     for (cs, _caller) in agg.keys():
#         all_cs.add(cs)

#     for cs in sorted(all_cs):
#         callers_for_cs = set()
#         for (k_cs, caller) in agg.keys():
#             if k_cs == cs:
#                 callers_for_cs.add(caller)
        
#         # caller별로 개별 항목 생성
#         for caller in sorted(callers_for_cs):
#             payload = agg.get((cs, caller), {"callees": [], "src_counter": Counter()})
#             out_items.append(mk_item(caller, cs, payload["src_counter"], payload["callees"]))

#     with open(args.out, 'w', encoding='utf-8') as jf:
#         json.dump(out_items, jf, ensure_ascii=False, indent=2)

#     print(f"[OK] unique items: {len(out_items)} -> {args.out}")

# if __name__ == "__main__":
#     main()

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
log_to_json_dedup_with_srcline_ordered.py
- PIN 로그 파싱 → JSON 생성
- 각 아이템의 키 순서: callsite_caller, callsite, src_line, callee
- callee 리스트는 실제 호출 순서로 기록
- callsite_caller는 callsite에 대해 caller가 하나만 있을 때는 비워둠
"""

import argparse, json, re
from collections import defaultdict, Counter

RE_ENTER  = re.compile(r'^\[srv\.like\.enter\]\s+(.*)$')
RE_LEAVE  = re.compile(r'^\[srv\.like\.leave\]\s+(.*)$')
RE_FNCALL = re.compile(r'^\[srv\.like\.fn\.call\]\s+(.*)$')

# key='value with spaces' / key="..." / key=bare
_KV_RE = re.compile(r"""(\w+)=('([^']*)'|"([^"]*)"|[^\s]+)""")

def parse_kv(payload: str) -> dict:
    out = {}
    for m in _KV_RE.finditer(payload):
        k = m.group(1)
        if m.group(3) is not None:
            v = m.group(3)      # 'single-quoted'
        elif m.group(4) is not None:
            v = m.group(4)      # "double-quoted"
        else:
            v = m.group(2)      # bare
        out[k] = v
    return out

def pick_most_common(counter: Counter) -> str:
    if not counter:
        return ""
    val, _ = counter.most_common(1)[0]
    return val or ""

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('log_path', help='입력 로그 파일 경로 (예: test_log.txt)')
    ap.add_argument('-o', '--out', default='callsites.json', help='출력 JSON 경로')
    args = ap.parse_args()

    in_session = False
    cur_cs = None        # callsite (dispatcher name)
    cur_caller = None    # caller_fn
    cur_callees = None   # list() - 순서 보장을 위해 list 사용
    cur_srcs = None      # list of src_line strings

    sessions = []  # [{callsite, caller, callees:list, srcs:list}]
    with open(args.log_path, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            line = line.rstrip('\n')

            m = RE_ENTER.match(line)
            if m:
                kv = parse_kv(m.group(1))
                in_session = True
                cur_cs = kv.get('callee', '')          # dispatcher name
                cur_caller = kv.get('caller_fn', '')   # may be ""
                cur_callees = []  # list로 변경하여 순서 보장
                cur_srcs = []
                continue

            m = RE_FNCALL.match(line)
            if m and in_session:
                kv = parse_kv(m.group(1))
                fn = kv.get('fn', '')
                if fn:
                    cur_callees.append(fn)  # append로 순서 보장
                # src_line 또는 srv_line(오타 대비) 수집
                sl = kv.get('src_line') or ''
                if sl:
                    cur_srcs.append(sl)
                continue

            m = RE_LEAVE.match(line)
            if m and in_session:
                if not cur_callees:
                    cur_callees = [""]  # 세션 내 호출 없으면 [""] 유지
                sessions.append({
                    "callsite": cur_cs or "",
                    "caller": cur_caller or "",
                    "callees": list(cur_callees),  # 순서가 보장된 리스트
                    "srcs": list(cur_srcs or []),
                })
                in_session = False
                cur_cs = cur_caller = None
                cur_callees = cur_srcs = None
                continue

    # caller 종류 집계(빈 문자열 제외)
    nonempty_callers_by_cs = defaultdict(set)
    for s in sessions:
        cs = s["callsite"]
        caller = s["caller"]
        if caller:
            nonempty_callers_by_cs[cs].add(caller)

    # callsite+caller 단위로 합집합/카운터 (callees를 순서가 보장된 리스트로 처리)
    agg = {}  # (cs, caller) -> {"callees": list(), "src_counter": Counter()}
    for s in sessions:
        key = (s["callsite"], s["caller"])
        if key not in agg:
            agg[key] = {"callees": [], "src_counter": Counter()}
        
        # callees 순서 보장하면서 중복 제거
        for callee in s["callees"]:
            if callee not in agg[key]["callees"]:
                agg[key]["callees"].append(callee)
        
        agg[key]["src_counter"].update(s["srcs"])

    def mk_item(callsite_caller: str, callsite: str, src_counter: Counter, callees_list: list, should_show_caller: bool):
        # 원하는 키 순서대로 삽입
        item = {}
        # callsite에 대한 caller가 하나만 있을 때는 callsite_caller를 비워둠
        item["callsite_caller"] = callsite_caller if should_show_caller else ""
        item["callsite"] = callsite or ""
        item["src_line"] = pick_most_common(src_counter)
        if not callees_list:
            callees_list = [""]
        item["callee"] = callees_list  # 순서가 보장된 리스트 그대로 사용
        return item

    out_items = []

    # 모든 callsite에 대해 caller별로 항목 생성 (단일/다중 관계없이)
    all_cs = set()
    for (cs, _caller) in agg.keys():
        all_cs.add(cs)

    for cs in sorted(all_cs):
        callers_for_cs = set()
        for (k_cs, caller) in agg.keys():
            if k_cs == cs:
                callers_for_cs.add(caller)
        
        # 해당 callsite에 대한 non-empty caller가 몇 개인지 확인
        non_empty_callers_for_cs = nonempty_callers_by_cs.get(cs, set())
        should_show_caller = len(non_empty_callers_for_cs) > 1
        
        # caller별로 개별 항목 생성
        for caller in sorted(callers_for_cs):
            payload = agg.get((cs, caller), {"callees": [], "src_counter": Counter()})
            out_items.append(mk_item(caller, cs, payload["src_counter"], payload["callees"], should_show_caller))

    with open(args.out, 'w', encoding='utf-8') as jf:
        json.dump(out_items, jf, ensure_ascii=False, indent=2)

    print(f"[OK] unique items: {len(out_items)} -> {args.out}")

if __name__ == "__main__":
    main()