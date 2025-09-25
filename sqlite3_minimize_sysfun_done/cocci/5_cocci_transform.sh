#!/bin/bash

# Coccinelle Batch Transform Script
# Usage: ./cocci_transform.sh <directory>

set -e

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 함수: 사용법 출력
show_usage() {
    echo "Usage: $0 <directory>"
    echo "  directory: Directory containing .c and .h files to transform"
    echo ""
    echo "Example:"
    echo "  $0 ../src"
    echo "  $0 /path/to/source/files"
    exit 1
}

# 함수: 로그 출력
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 인자 검사
if [ $# -ne 1 ]; then
    log_error "Invalid number of arguments"
    show_usage
fi

TARGET_DIR="$1"
COCCI_FILE="5_transform_fp_callsites.cocci"
ERROR_LIST="error_list.txt"
SUCCESS_LIST="success_list.txt"
TEMP_OUTPUT="/tmp/cocci_output_$$"

# 디렉토리 존재 확인
if [ ! -d "$TARGET_DIR" ]; then
    log_error "Directory not found: $TARGET_DIR"
    exit 1
fi

# Cocci 파일 존재 확인
if [ ! -f "$COCCI_FILE" ]; then
    log_error "Coccinelle file not found: $COCCI_FILE"
    exit 1
fi

# 결과 파일들 초기화
> "$ERROR_LIST"
> "$SUCCESS_LIST"

log_info "Starting Coccinelle transformation..."
log_info "Target directory: $TARGET_DIR"
log_info "Cocci file: $COCCI_FILE"
echo ""

# .c 및 .h 파일 찾기
SOURCE_FILES=$(find "$TARGET_DIR" \( -name "*.c" -o -name "*.h" \) -type f)

if [ -z "$SOURCE_FILES" ]; then
    log_warning "No .c or .h files found in $TARGET_DIR"
    exit 0
fi

# 파일 개수 계산
TOTAL_FILES=$(echo "$SOURCE_FILES" | wc -l)
CURRENT_FILE=0
SUCCESS_COUNT=0
ERROR_COUNT=0

log_info "Found $TOTAL_FILES source files (.c and .h) to process"
echo ""

# 각 파일에 대해 spatch 실행
while IFS= read -r file; do
    CURRENT_FILE=$((CURRENT_FILE + 1))
    
    # 상대 경로로 표시
    RELATIVE_FILE=$(realpath --relative-to=. "$file")
    
    printf "[%3d/%3d] Processing: %s" "$CURRENT_FILE" "$TOTAL_FILES" "$RELATIVE_FILE"
    
    # spatch 실행하고 출력 캡처
    if spatch --sp-file "$COCCI_FILE" --in-place "$file" > "$TEMP_OUTPUT" 2>&1; then
        # 성공한 경우에도 에러 메시지 확인
        if grep -q "An error occurred when attempting to transform some files" "$TEMP_OUTPUT"; then
            printf " ${RED}[ERROR]${NC}\n"
            echo "$RELATIVE_FILE" >> "$ERROR_LIST"
            ERROR_COUNT=$((ERROR_COUNT + 1))
            
            # 에러 상세 정보 출력 (선택적)
            if [ -s "$TEMP_OUTPUT" ]; then
                echo "  Error details:"
                sed 's/^/    /' "$TEMP_OUTPUT" | head -5
            fi
        else
            printf " ${GREEN}[OK]${NC}\n"
            echo "$RELATIVE_FILE" >> "$SUCCESS_LIST"
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
        fi
    else
        # spatch 자체가 실패한 경우
        printf " ${RED}[FAILED]${NC}\n"
        echo "$RELATIVE_FILE" >> "$ERROR_LIST"
        ERROR_COUNT=$((ERROR_COUNT + 1))
        
        # 에러 상세 정보 출력
        if [ -s "$TEMP_OUTPUT" ]; then
            echo "  Error details:"
            sed 's/^/    /' "$TEMP_OUTPUT" | head -5
        fi
    fi
    
done <<< "$SOURCE_FILES"

# 임시 파일 정리
rm -f "$TEMP_OUTPUT"

echo ""
log_info "Transformation completed!"
echo ""

# 결과 요약
log_info "=== SUMMARY ==="
log_success "Successfully transformed: $SUCCESS_COUNT files"
log_error "Failed to transform: $ERROR_COUNT files"
log_info "Total processed: $TOTAL_FILES files"

# 성공률 계산
if [ $TOTAL_FILES -gt 0 ]; then
    SUCCESS_RATE=$((SUCCESS_COUNT * 100 / TOTAL_FILES))
    log_info "Success rate: $SUCCESS_RATE%"
fi

echo ""

# 에러가 있는 경우 에러 파일 목록 출력
if [ $ERROR_COUNT -gt 0 ]; then
    log_warning "Files with errors saved to: $ERROR_LIST"
    log_info "Error files:"
    cat "$ERROR_LIST" | sed 's/^/  /'
    echo ""
fi

# 성공한 파일 목록도 저장
if [ $SUCCESS_COUNT -gt 0 ]; then
    log_info "Successfully transformed files saved to: $SUCCESS_LIST"
fi

# 최종 정리
if [ $ERROR_COUNT -eq 0 ]; then
    log_success "All files transformed successfully! 🎉"
    exit 0
else
    log_warning "Some files had errors. Check $ERROR_LIST for details."
    exit 1
fi
