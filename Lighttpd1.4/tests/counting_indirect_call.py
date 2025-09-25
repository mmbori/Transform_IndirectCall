import re
from collections import Counter

# 로그 파일 경로 지정
log_file = "before_inlining_log.txt"  # 파일 경로에 맞게 수정

# 정규 표현식 패턴: mapped.indirect.call 줄에서 callee_fn=값 추출
pattern = re.compile(r"\[mapped\.indirect\.call\].*?callee_fn=([\w\d_]+)")

# callee 함수 이름들을 저장할 리스트
callee_fn_list = []

# 파일 열고 callee_fn 수집
with open(log_file, 'r', encoding='utf-8') as f:
    for line in f:
        match = pattern.search(line)
        if match:
            callee_fn_list.append(match.group(1))

# 중복 없이 set으로 변환
unique_callee_fn = set(callee_fn_list)

# 각 callee_fn별 호출 횟수 세기
callee_counts = Counter(callee_fn_list)

# 결과 출력
print("🔁 전체 indirect call 호출 수:", len(callee_fn_list))
print("✅ 중복 없는 callee 함수 수:", len(unique_callee_fn))
print("📋 함수별 호출 횟수:")
for fn_name, count in callee_counts.items():
    print(f"  {fn_name}: {count}")
