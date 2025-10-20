#!/bin/bash
# objdump를 이용한 간접 호출 카운팅 스크립트

BINARY_FILE="$1"

if [ -z "$BINARY_FILE" ]; then
    echo "사용법: $0 <binary_file>"
    exit 1
fi

echo "=== Indirect Call Analysis for $BINARY_FILE ==="
echo

# 전체 call 명령어 수
total_calls=$(objdump -d "$BINARY_FILE" | grep -c "call")

# Direct calls (immediate address) - call 0x401000 형태
direct_calls=$(objdump -d "$BINARY_FILE" | grep -E "call\s+0x[0-9a-f]+" | wc -l)

# Indirect calls with * (register/memory) - call *%rax, call *0x8(%rbp) 형태  
indirect_star=$(objdump -d "$BINARY_FILE" | grep -E "call\s+\*" | wc -l)

# Register calls without * - callq %rax 형태 (일부 objdump 버전)
register_calls=$(objdump -d "$BINARY_FILE" | grep -E "call[qlw]?\s+%[a-z]" | wc -l)

# Memory calls - call *offset(%reg) 형태
memory_calls=$(objdump -d "$BINARY_FILE" | grep -E "call\s+\*.*\(" | wc -l)

# 총 간접 호출 (중복 제거를 위해 실제 패턴으로 다시 계산)
indirect_total=$(objdump -d "$BINARY_FILE" | grep -E "call\s+(\*|%)" | wc -l)

echo "결과 요약:"
echo "========================================="
echo "전체 CALL 명령어: $total_calls"
echo "Direct calls (call 0xXXXX): $direct_calls" 
echo "Indirect calls 총계: $indirect_total"
echo "  - call *register: $(objdump -d "$BINARY_FILE" | grep -E "call\s+\*%[a-z]" | wc -l)"
echo "  - call *memory: $(objdump -d "$BINARY_FILE" | grep -E "call\s+\*.*\(" | wc -l)"
echo "  - call register: $(objdump -d "$BINARY_FILE" | grep -E "call[qlw]?\s+%[a-z]" | grep -v "\*" | wc -l)"
echo "========================================="

echo
echo "상세 내용:"
echo "----------------------------------------"
echo "1. Register calls (call *%reg):"
objdump -d "$BINARY_FILE" | grep -E "call\s+\*%[a-z]" | head -10

echo
echo "2. Memory calls (call *mem):"  
objdump -d "$BINARY_FILE" | grep -E "call\s+\*.*\(" | head -10

echo
echo "3. Direct register calls (call %reg):"
objdump -d "$BINARY_FILE" | grep -E "call[qlw]?\s+%[a-z]" | grep -v "\*" | head -10

echo
echo "전체 간접 호출을 파일로 저장하려면:"
echo "objdump -d $BINARY_FILE | grep -E 'call\s+(\*|%)' > indirect_calls.txt"
