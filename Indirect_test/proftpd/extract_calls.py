# #!/usr/bin/env python3
# """
# 간접 호출 로그 분석 스크립트
# - refer.txt: Pin Tool 출력 (간접 호출 통계)
# - target_fns.txt: 분석할 타겟 함수 목록
# """

# import re
# import sys
# from collections import defaultdict

# def parse_log_file(log_file):
#     """
#     로그 파일을 파싱하여 함수별 호출 횟수를 추출
    
#     Returns:
#         dict: {함수명: [(주소, 호출횟수), ...]}
#     """
#     function_calls = defaultdict(list)
    
#     # 정규식: 주소 (이미지:함수명): 호출횟수
#     pattern = r'(0x[0-9a-f]+) \(([^:]+):([^\)]+)\): (\d+) calls'
    
#     with open(log_file, 'r', encoding='utf-8') as f:
#         for line in f:
#             match = re.search(pattern, line)
#             if match:
#                 address = match.group(1)
#                 image = match.group(2)
#                 function = match.group(3)
#                 calls = int(match.group(4))
                
#                 # 함수명을 키로, (주소, 호출횟수) 튜플을 리스트에 추가
#                 function_calls[function].append((address, calls))
    
#     return function_calls

# def load_target_functions(target_file):
#     """
#     타겟 함수 목록 로드
    
#     Returns:
#         set: 타겟 함수명 집합
#     """
#     targets = set()
    
#     with open(target_file, 'r', encoding='utf-8') as f:
#         for line in f:
#             line = line.strip()
#             if line:  # 빈 줄 제외
#                 targets.add(line)
    
#     return targets

# def analyze_calls(function_calls, target_functions):
#     """
#     타겟 함수들의 호출 횟수 분석
    
#     Returns:
#         dict: 분석 결과
#     """
#     results = {}
#     total_calls = 0
#     found_instances = 0  # 중복 포함 발견 횟수
    
#     for func in target_functions:
#         if func in function_calls:
#             # 해당 함수의 모든 인스턴스 (서로 다른 주소)
#             instances = function_calls[func]
#             total_func_calls = sum(calls for _, calls in instances)
            
#             results[func] = {
#                 'total_calls': total_func_calls,
#                 'instances': instances,
#                 'instance_count': len(instances)
#             }
            
#             total_calls += total_func_calls
#             found_instances += len(instances)
#         else:
#             results[func] = {
#                 'total_calls': 0,
#                 'instances': [],
#                 'instance_count': 0
#             }
    
#     return {
#         'results': results,
#         'total_calls': total_calls,
#         'found_instances': found_instances,  # 중복 포함 개수
#         'target_count': len(target_functions)
#     }

# def print_results(analysis):
#     """
#     분석 결과 출력
#     """
#     print("=" * 60)
#     print("간접 호출 분석 결과")
#     print("=" * 60)
#     print()
    
#     print("타겟 함수별 호출 횟수:")
#     print("-" * 60)
    
#     # 호출 횟수 순으로 정렬
#     sorted_results = sorted(
#         analysis['results'].items(), 
#         key=lambda x: x[1]['total_calls'], 
#         reverse=True
#     )
    
#     for func, data in sorted_results:
#         if data['total_calls'] > 0:
#             print(f"  {func:40s}: {data['total_calls']:6d} calls ({data['instance_count']} instances)")
#             # 상세 정보 (주소별)
#             for addr, calls in data['instances']:
#                 print(f"    - {addr}: {calls} calls")
#         else:
#             print(f"  {func:40s}: Not found")
    
#     print()
#     print("=" * 60)
#     print("요약:")
#     print("-" * 60)
#     print(f"타겟 함수 개수:                {analysis['target_count']:6d}")
#     print(f"발견된 함수 인스턴스 (중복포함): {analysis['found_instances']:6d}")
#     print(f"총 간접 호출 횟수:             {analysis['total_calls']:6d}")
#     print("=" * 60)

# def save_results(analysis, output_file='analysis_result.txt'):
#     """
#     분석 결과를 파일로 저장
#     """
#     with open(output_file, 'w', encoding='utf-8') as f:
#         f.write("=" * 60 + "\n")
#         f.write("간접 호출 분석 결과\n")
#         f.write("=" * 60 + "\n\n")
        
#         f.write("타겟 함수별 호출 횟수:\n")
#         f.write("-" * 60 + "\n")
        
#         sorted_results = sorted(
#             analysis['results'].items(), 
#             key=lambda x: x[1]['total_calls'], 
#             reverse=True
#         )
        
#         for func, data in sorted_results:
#             if data['total_calls'] > 0:
#                 f.write(f"  {func:40s}: {data['total_calls']:6d} calls ({data['instance_count']} instances)\n")
#                 for addr, calls in data['instances']:
#                     f.write(f"    - {addr}: {calls} calls\n")
#             else:
#                 f.write(f"  {func:40s}: Not found\n")
        
#         f.write("\n")
#         f.write("=" * 60 + "\n")
#         f.write("요약:\n")
#         f.write("-" * 60 + "\n")
#         f.write(f"타겟 함수 개수:                {analysis['target_count']:6d}\n")
#         f.write(f"발견된 함수 인스턴스 (중복포함): {analysis['found_instances']:6d}\n")
#         f.write(f"총 간접 호출 횟수:             {analysis['total_calls']:6d}\n")
#         f.write("=" * 60 + "\n")
    
#     print(f"\n결과가 {output_file}에 저장되었습니다.")

# def main():
#     # 파일 경로
#     log_file = 'origin_refer.txt'
#     target_file = 'target_fns.txt'
    
#     # 명령줄 인자로 파일 경로 지정 가능
#     if len(sys.argv) >= 2:
#         log_file = sys.argv[1]
#     if len(sys.argv) >= 3:
#         target_file = sys.argv[2]
    
#     try:
#         # 1. 로그 파일 파싱
#         print(f"로그 파일 읽는 중: {log_file}")
#         function_calls = parse_log_file(log_file)
#         print(f"총 {len(function_calls)}개의 함수 발견\n")
        
#         # 2. 타겟 함수 로드
#         print(f"타겟 함수 목록 읽는 중: {target_file}")
#         target_functions = load_target_functions(target_file)
#         print(f"타겟 함수 {len(target_functions)}개 로드\n")
        
#         # 3. 분석
#         analysis = analyze_calls(function_calls, target_functions)
        
#         # 4. 결과 출력
#         print_results(analysis)
        
#         # 5. 결과 저장
#         save_results(analysis)
        
#     except FileNotFoundError as e:
#         print(f"오류: 파일을 찾을 수 없습니다 - {e}")
#         sys.exit(1)
#     except Exception as e:
#         print(f"오류 발생: {e}")
#         sys.exit(1)

# if __name__ == '__main__':
#     main()

#!/usr/bin/env python3
"""
간접 호출 로그 분석 스크립트 (업데이트 버전)
- 로그 파일: Pin Tool 출력 (간접 호출 상세 로그)
- target_fns.txt: 분석할 타겟 함수 목록

로그 형식:
[번호] Indirect call at 0xADDR (image:function) -> target 0xADDR (image:function)
"""

import re
import sys
from collections import defaultdict

def parse_log_file(log_file):
    """
    로그 파일을 파싱하여 함수별 호출 횟수를 추출
    
    Returns:
        dict: {함수명: {주소: 호출횟수}}
    """
    function_calls = defaultdict(lambda: defaultdict(int))
    
    # 정규식: [번호] Indirect call at 0xADDR (image:function) -> target 0xADDR (image:function)
    pattern = r'\[\d+\] Indirect call at (0x[0-9a-f]+) \(([^:]+):([^\)]+)\) -> target (0x[0-9a-f]+) \(([^:]+):([^\)]+)\)'
    
    line_count = 0
    matched_count = 0
    
    with open(log_file, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            line_count += 1
            match = re.search(pattern, line)
            if match:
                matched_count += 1
                call_addr = match.group(1)
                call_image = match.group(2)
                call_function = match.group(3)
                target_addr = match.group(4)
                target_image = match.group(5)
                target_function = match.group(6)
                
                # 호출하는 함수를 키로, 타겟 함수별로 카운트
                # 여기서는 타겟 함수를 추적
                function_calls[target_function][target_addr] += 1
                
                # 디버깅용 (처음 10개만)
                if matched_count <= 10:
                    print(f"[DEBUG] 파싱: {call_function} -> {target_function}")
    
    print(f"총 {line_count}줄 중 {matched_count}개 매칭")
    return function_calls

def load_target_functions(target_file):
    """
    타겟 함수 목록 로드
    
    Returns:
        set: 타겟 함수명 집합
    """
    targets = set()
    
    with open(target_file, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#'):  # 빈 줄과 주석 제외
                targets.add(line)
    
    return targets

def analyze_calls(function_calls, target_functions):
    """
    타겟 함수들의 호출 횟수 분석
    
    Returns:
        dict: 분석 결과
    """
    results = {}
    total_calls = 0
    found_instances = 0
    
    for func in target_functions:
        if func in function_calls:
            # 해당 함수의 모든 인스턴스 (서로 다른 주소)
            instances = function_calls[func]
            total_func_calls = sum(instances.values())
            
            # (주소, 호출횟수) 튜플 리스트로 변환
            instances_list = [(addr, count) for addr, count in instances.items()]
            instances_list.sort(key=lambda x: x[1], reverse=True)  # 호출 횟수 순 정렬
            
            results[func] = {
                'total_calls': total_func_calls,
                'instances': instances_list,
                'instance_count': len(instances)
            }
            
            total_calls += total_func_calls
            found_instances += len(instances)
        else:
            results[func] = {
                'total_calls': 0,
                'instances': [],
                'instance_count': 0
            }
    
    return {
        'results': results,
        'total_calls': total_calls,
        'found_instances': found_instances,
        'target_count': len(target_functions)
    }

def print_results(analysis):
    """
    분석 결과 출력
    """
    print("\n" + "=" * 60)
    print("간접 호출 분석 결과")
    print("=" * 60)
    print()
    
    print("타겟 함수별 호출 횟수:")
    print("-" * 60)
    
    # 호출 횟수 순으로 정렬
    sorted_results = sorted(
        analysis['results'].items(), 
        key=lambda x: x[1]['total_calls'], 
        reverse=True
    )
    
    for func, data in sorted_results:
        if data['total_calls'] > 0:
            print(f"  {func:40s}: {data['total_calls']:6d} calls ({data['instance_count']} instances)")
            # 상세 정보 (주소별) - 상위 5개만 표시
            for addr, calls in data['instances'][:5]:
                print(f"    - {addr}: {calls} calls")
            if len(data['instances']) > 5:
                print(f"    ... and {len(data['instances']) - 5} more instances")
        else:
            print(f"  {func:40s}: Not found")
    
    print()
    print("=" * 60)
    print("요약:")
    print("-" * 60)
    print(f"타겟 함수 개수:                {analysis['target_count']:6d}")
    print(f"발견된 함수 인스턴스 (중복포함): {analysis['found_instances']:6d}")
    print(f"총 간접 호출 횟수:             {analysis['total_calls']:6d}")
    print("=" * 60)

def save_results(analysis, output_file='analysis_result.txt'):
    """
    분석 결과를 파일로 저장
    """
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("=" * 60 + "\n")
        f.write("간접 호출 분석 결과\n")
        f.write("=" * 60 + "\n\n")
        
        f.write("타겟 함수별 호출 횟수:\n")
        f.write("-" * 60 + "\n")
        
        sorted_results = sorted(
            analysis['results'].items(), 
            key=lambda x: x[1]['total_calls'], 
            reverse=True
        )
        
        for func, data in sorted_results:
            if data['total_calls'] > 0:
                f.write(f"  {func:40s}: {data['total_calls']:6d} calls ({data['instance_count']} instances)\n")
                for addr, calls in data['instances']:
                    f.write(f"    - {addr}: {calls} calls\n")
            else:
                f.write(f"  {func:40s}: Not found\n")
        
        f.write("\n")
        f.write("=" * 60 + "\n")
        f.write("요약:\n")
        f.write("-" * 60 + "\n")
        f.write(f"타겟 함수 개수:                {analysis['target_count']:6d}\n")
        f.write(f"발견된 함수 인스턴스 (중복포함): {analysis['found_instances']:6d}\n")
        f.write(f"총 간접 호출 횟수:             {analysis['total_calls']:6d}\n")
        f.write("=" * 60 + "\n")
    
    print(f"\n결과가 {output_file}에 저장되었습니다.")

def main():
    # 기본 파일 경로
    log_file = 'proftpd_origin_real.txt'
    target_file = 'target_fns.txt'
    output_file = 'analysis_result.txt'
    
    # 명령줄 인자로 파일 경로 지정 가능
    if len(sys.argv) >= 2:
        log_file = sys.argv[1]
    if len(sys.argv) >= 3:
        target_file = sys.argv[2]
    if len(sys.argv) >= 4:
        output_file = sys.argv[3]
    
    try:
        # 1. 타겟 함수 로드
        print(f"타겟 함수 목록 읽는 중: {target_file}")
        target_functions = load_target_functions(target_file)
        print(f"타겟 함수 {len(target_functions)}개 로드\n")
        
        # 2. 로그 파일 파싱
        print(f"로그 파일 읽는 중: {log_file}")
        function_calls = parse_log_file(log_file)
        print(f"총 {len(function_calls)}개의 타겟 함수 발견\n")
        
        # 3. 분석
        print("분석 중...")
        analysis = analyze_calls(function_calls, target_functions)
        
        # 4. 결과 출력
        print_results(analysis)
        
        # 5. 결과 저장
        save_results(analysis, output_file)
        
    except FileNotFoundError as e:
        print(f"오류: 파일을 찾을 수 없습니다 - {e}")
        sys.exit(1)
    except Exception as e:
        print(f"오류 발생: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == '__main__':
    main()