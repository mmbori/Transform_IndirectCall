#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import re
import json
import argparse
from collections import defaultdict, Counter, OrderedDict

RUNTIME_RE = re.compile(
    r'\[srv\.like\.runtime\.call\]'
    r'.*?callsite=(?P<callsite>\S+)'
    r'.*?caller=(?P<caller>\S+)'
    r'.*?callee_fn=(?P<callee>\S+)'
    r'.*?src_code=(?P<src>.+?)$'
)

def extract_src_line(src_field: str) -> str:
    s = src_field.strip()
    m = re.match(r'^"(?P<q>.*)"$', s)
    if m:
        return m.group('q').strip()
    return s

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--in", dest="infile", required=True, help="input log file path")
    ap.add_argument("--out", dest="outfile", required=True, help="output json file path")
    args = ap.parse_args()

    callers_per_callsite = defaultdict(set)
    agg = defaultdict(lambda: {"callees": [], "src_counter": Counter(), "seen_callees": set()})

    with open(args.infile, "r", encoding="utf-8", errors="ignore") as f:
        for line in f:
            if "[srv.like.runtime.call]" not in line:
                continue
            m = RUNTIME_RE.search(line)
            if not m:
                continue

            callsite = m.group("callsite")
            caller = m.group("caller")
            callee = m.group("callee")
            raw_src = m.group("src")
            src_line = extract_src_line(raw_src)

            callers_per_callsite[callsite].add(caller)
            key = (callsite, caller)

            if callee not in agg[key]["seen_callees"]:
                agg[key]["callees"].append(callee)
                agg[key]["seen_callees"].add(callee)
            if src_line:
                agg[key]["src_counter"][src_line] += 1

    records = []
    seen = set()

    for (callsite, caller), data in agg.items():
        callees = data["callees"]
        src_line = data["src_counter"].most_common(1)[0][0] if data["src_counter"] else ""

        multi_caller = len(callers_per_callsite[callsite]) > 1

        item = OrderedDict()
        if multi_caller:
            item["callsite_caller"] = caller
        else : item["callsite_caller"] = ""
        item["callsite"] = callsite
        item["src_line"] = src_line
        item["callee"] = callees

        caller_or_empty = caller if multi_caller else ""
        dedup_key = (callsite, caller_or_empty, tuple(callees))
        if dedup_key in seen:
            continue
        seen.add(dedup_key)
        records.append(item)

    with open(args.outfile, "w", encoding="utf-8") as out:
        json.dump(records, out, ensure_ascii=False, indent=2)

if __name__ == "__main__":
    main()
