#!/usr/bin/env python3
"""
링커 에러 로그에서 undefined reference 함수 이름 추출
"""

import re
import sys

def extract_undefined_functions(log_file):
    """로그 파일에서 undefined reference to '함수명' 패턴 추출"""
    functions = set()
    
    # undefined reference to `함수명' 패턴
    pattern = r"undefined reference to `([^']+)'"
    
    try:
        with open(log_file, 'r', encoding='utf-8') as f:
            for line in f:
                matches = re.findall(pattern, line)
                functions.update(matches)
        
        return sorted(functions)
    
    except Exception as e:
        print(f"에러: {e}", file=sys.stderr)
        return []

def main():
    if len(sys.argv) < 2:
        print("사용법: python extract_undefined.py <log_file>")
        sys.exit(1)
    
    log_file = sys.argv[1]
    functions = extract_undefined_functions(log_file)
    
    if functions:
        print(f"추출된 함수 ({len(functions)}개):")
        for func in functions:
            print(func)
    else:
        print("undefined reference 함수를 찾을 수 없습니다.")

if __name__ == "__main__":
    main()