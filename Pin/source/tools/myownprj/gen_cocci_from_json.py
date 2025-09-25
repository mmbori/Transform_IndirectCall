#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JSON(callsite_new.json) -> lighttpd_from_json.cocci 생성기
요구 사항:
  1) callsite_caller == ""  -> callsite 함수 내부에서 src_line/루프 매칭 후 언롤 + 직접호출
  2) callsite_caller != ""  -> caller 함수에서 callsite(...) 호출 자리에 callsite 로직을 "복사" (직접호출 블록 삽입)
  3) src_line == "" 또는 callee 비어있음 -> 스킵
참고: SmPL 문법/메타변수/추가/삭제 마킹은 Coccinelle 공식 문서에 따름.
"""

import json, re, sys
from pathlib import Path

INPUT  = sys.argv[1] if len(sys.argv) > 1 else "callsite_new.json"
OUTPUT = sys.argv[2] if len(sys.argv) > 2 else "lighttpd_from_json.cocci"

# callsite별 인자/반환형 특성 (lighttpd 디스패처 시그니처)
# - *_req_data:  handler_t f(request_st *r, void *p_d)
# - *_con_data:  handler_t f(connection  *con, void *p_d)
# - *_srv_data:  handler_t f(server     *srv, void *p_d)
# - *_srv_data_all: void f(server *srv, void *p_d)
CALLSIG = {
    "plugins_call_fn_req_data":     ("r",   "HANDLER_GO_ON", True),
    "plugins_call_fn_con_data":     ("con", "HANDLER_GO_ON", True),
    "plugins_call_fn_srv_data":     ("srv", "HANDLER_GO_ON", True),
    "plugins_call_fn_srv_data_all": ("srv", None,            False),
}

# while-루프 패턴(간접호출) — SmPL 매칭용 앵커
# * 실제 코드는 공백/개행이 달라도 AST로 매칭됩니다.
LOOP_PATTERNS = {
    "plugins_call_fn_req_data": r"""
@@
identifier F =~ "^plugins_call_fn_req_data$";
expression PLFD, DATA;
identifier rc;
identifier r;
@@
- while (PLFD->fn && (rc = PLFD->fn(r, DATA)) == HANDLER_GO_ON)
-   ++PLFD;
""",
    "plugins_call_fn_con_data": r"""
@@
identifier F =~ "^plugins_call_fn_con_data$";
expression PLFD, DATA;
identifier rc;
identifier con;
@@
- while (PLFD->fn && (rc = PLFD->fn(con, DATA)) == HANDLER_GO_ON)
-   ++PLFD;
""",
    "plugins_call_fn_srv_data": r"""
@@
identifier F =~ "^plugins_call_fn_srv_data$";
expression PLFD, DATA;
identifier rc;
identifier srv;
@@
- while (PLFD->fn && (rc = PLFD->fn(srv,DATA)) == HANDLER_GO_ON)
-   ++PLFD;
""",
    "plugins_call_fn_srv_data_all": r"""
@@
identifier F =~ "^plugins_call_fn_srv_data_all$";
expression PLFD, DATA;
identifier srv;
@@
- while (PLFD->fn) { PLFD->fn(srv, DATA); ++PLFD; }
"""
}

# 단일 간접호출 한 줄 패턴: "XX->xx(ARG0, DATA)" 에 해당 (루프가 아닌 경우)
# callsite별로 첫 번째 인자 식별자만 다름.
def single_call_pattern(callsite: str) -> str:
    who, _, _ = CALLSIG[callsite]
    return rf"""
@@
identifier F =~ "^{re.escape(callsite)}$";
expression PLFD, DATA;
identifier {who};
@@
- PLFD->fn({who}, DATA);
"""

# 직접호출 블록 생성
def gen_direct_block(callsite: str, caller_name: str, callees: list) -> str:
    who, cont, has_rc = CALLSIG[callsite]
    out = []
    out.append(f"/* BEGIN DIRECT CALLS (from {caller_name or callsite}) */")
    out.append("size_t __i = 0;")
    for c in callees:
        if not c: 
            continue
        out.append(f'assert(plfd[__i].fn == &{c});')
        if has_rc:
            out.append(f'rc = {c}({who}, plfd[__i++].data);')
            out.append( 'if (rc != HANDLER_GO_ON) return rc;')
        else:
            out.append(f'{c}({who}, plfd[__i++].data);')
    out.append("/* END DIRECT CALLS */")
    return "\n".join(out) + "\n"

# callsite() 호출을 caller에서 찾아 치환하는 패턴
def caller_inline_pattern(callsite: str, direct_block: str) -> str:
    # callsite( ... ) 한 문장을 "직접호출 블록"으로 치환
    return rf"""
@@
identifier CALLER;
identifier CS =~ "^{re.escape(callsite)}$";
@@
- CS(...);
+ {{
{direct_block.rstrip()}
+ }}
"""

def sanitize_ident(x: str) -> str:
    return x if re.match(r"^[A-Za-z_][A-Za-z0-9_]*$", x or "") else ""

def main():
    data = json.load(open(INPUT, "r", encoding="utf-8"))
    # 생성할 SmPL 조각들을 누적
    pieces = []

    for ent in data:
        callsite        = (ent.get("callsite") or "").strip()
        caller          = (ent.get("callsite_caller") or "").strip()
        src_line        = (ent.get("src_line") or "").strip()
        callees_raw     = ent.get("callee") or []
        callees         = [sanitize_ident(c.strip()) for c in callees_raw if sanitize_ident(c.strip())]

        # 규칙 3: src_line 또는 callee 공백이면 스킵
        if not src_line or not callees:
            continue
        if callsite not in CALLSIG:
            continue

        # 직접호출 블록 생성
        direct_block = gen_direct_block(callsite, caller, callees)

        if not caller:
            # 규칙 1: callsite 함수 안에서 처리
            if src_line.lstrip().startswith("while ("):
                pieces.append(LOOP_PATTERNS[callsite].strip())
                pieces.append("+" + direct_block)
            else:
                pieces.append(single_call_pattern(callsite).strip())
                pieces.append("+" + direct_block)
        else:
            # 규칙 2: caller에서 callsite(...) 호출을 직접호출 블록으로 치환
            pieces.append(caller_inline_pattern(callsite, direct_block).strip())

    # 결과 쓰기
    Path(OUTPUT).write_text("\n\n".join(pieces) + "\n", encoding="utf-8")
    print(f"[OK] Wrote {OUTPUT}")

if __name__ == "__main__":
    main()
