# #!/bin/bash

# # Coccinelle Transform Script
# # Applies a .cocci file to all source files in a directory
# # Usage: ./5_cocci_transform.sh <cocci_file> <target_directory>

# set -e

# # 색상 정의
# RED='\033[0;31m'
# GREEN='\033[0;32m'
# YELLOW='\033[1;33m'
# BLUE='\033[0;34m'
# CYAN='\033[0;36m'
# NC='\033[0m' # No Color

# # 함수: 사용법 출력
# show_usage() {
#     echo "Usage: $0 <cocci_file> <target_directory>"
#     echo ""
#     echo "Arguments:"
#     echo "  cocci_file:       Coccinelle (.cocci) file to apply"
#     echo "  target_directory: Directory containing .c and .h files to transform"
#     echo ""
#     echo "Examples:"
#     echo "  $0 5_test.cocci ../src"
#     echo "  $0 /path/to/transform.cocci /path/to/source"
#     echo ""
#     echo "The script will apply the .cocci file to all .c and .h files recursively"
#     echo "in the target directory using --in-place option."
#     exit 1
# }

# # 함수: 로그 출력
# log_info() {
#     echo -e "${BLUE}[INFO]${NC} $1"
# }

# log_success() {
#     echo -e "${GREEN}[SUCCESS]${NC} $1"
# }

# log_warning() {
#     echo -e "${YELLOW}[WARNING]${NC} $1"
# }

# log_error() {
#     echo -e "${RED}[ERROR]${NC} $1"
# }

# log_step() {
#     echo -e "${CYAN}[STEP]${NC} $1"
# }

# # 인자 검사
# if [ $# -ne 2 ]; then
#     log_error "Invalid number of arguments"
#     show_usage
# fi

# COCCI_FILE="$1"
# TARGET_DIR="$2"

# # Cocci 파일 존재 확인
# if [ ! -f "$COCCI_FILE" ]; then
#     log_error "Coccinelle file not found: $COCCI_FILE"
#     exit 1
# fi

# # 디렉토리 존재 확인
# if [ ! -d "$TARGET_DIR" ]; then
#     log_error "Directory not found: $TARGET_DIR"
#     exit 1
# fi

# log_info "Starting Coccinelle transformation..."
# log_info "Cocci file: $COCCI_FILE"
# log_info "Target directory: $TARGET_DIR"
# echo ""

# # .c 및 .h 파일 찾기 (재귀적으로)
# SOURCE_FILES=$(find "$TARGET_DIR" \( -name "*.c" -o -name "*.h" \) -type f)

# if [ -z "$SOURCE_FILES" ]; then
#     log_warning "No .c or .h files found in $TARGET_DIR"
#     exit 0
# fi

# TOTAL_FILES=$(echo "$SOURCE_FILES" | wc -l)
# log_info "Found $TOTAL_FILES source files (.c and .h) to process"
# echo ""

# # 결과 파일들
# ERROR_LIST="error_list.txt"
# SUCCESS_LIST="success_list.txt"

# > "$ERROR_LIST"
# > "$SUCCESS_LIST"

# CURRENT_FILE=0
# SUCCESS_COUNT=0
# ERROR_COUNT=0
# TEMP_OUTPUT="/tmp/cocci_output_$$"

# log_step "Processing files..."
# echo ""

# # 각 파일에 대해 spatch 실행
# while IFS= read -r file; do
#     CURRENT_FILE=$((CURRENT_FILE + 1))
    
#     RELATIVE_FILE=$(realpath --relative-to=. "$file" 2>/dev/null || echo "$file")
    
#     printf "[%3d/%3d] Processing: %-60s" "$CURRENT_FILE" "$TOTAL_FILES" "$RELATIVE_FILE"
    
#     # spatch --in-place 실행
#     if spatch --sp-file "$COCCI_FILE" --in-place "$file" > "$TEMP_OUTPUT" 2>&1; then
#         if grep -q "An error occurred when attempting to transform some files" "$TEMP_OUTPUT"; then
#             printf " ${RED}[ERROR]${NC}\n"
#             echo "$RELATIVE_FILE" >> "$ERROR_LIST"
#             ERROR_COUNT=$((ERROR_COUNT + 1))
#         else
#             printf " ${GREEN}[OK]${NC}\n"
#             echo "$RELATIVE_FILE" >> "$SUCCESS_LIST"
#             SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
#         fi
#     else
#         printf " ${RED}[FAILED]${NC}\n"
#         echo "$RELATIVE_FILE" >> "$ERROR_LIST"
#         ERROR_COUNT=$((ERROR_COUNT + 1))
#     fi
    
# done <<< "$SOURCE_FILES"

# # 임시 파일 정리
# rm -f "$TEMP_OUTPUT"

# # 결과 요약
# echo ""
# echo ""
# log_info "═══════════════════════════════════════════════════════════"
# log_info "                       SUMMARY"
# log_info "═══════════════════════════════════════════════════════════"
# echo ""
# log_info "Cocci file: $COCCI_FILE"
# log_info "Target directory: $TARGET_DIR"
# log_info "Total files processed: $TOTAL_FILES"
# echo ""
# log_success "Successfully transformed: $SUCCESS_COUNT files"
# log_error "Failed to transform: $ERROR_COUNT files"
# echo ""

# # 성공률 계산
# if [ $TOTAL_FILES -gt 0 ]; then
#     SUCCESS_RATE=$((SUCCESS_COUNT * 100 / TOTAL_FILES))
#     log_info "Success rate: $SUCCESS_RATE%"
# fi

# echo ""

# # 결과 파일 정보
# if [ $SUCCESS_COUNT -gt 0 ]; then
#     log_info "Success list saved to: $SUCCESS_LIST"
# fi

# if [ $ERROR_COUNT -gt 0 ]; then
#     log_warning "Error list saved to: $ERROR_LIST"
# fi

# echo ""

# # 최종 결과
# if [ $ERROR_COUNT -eq 0 ]; then
#     log_success "All transformations completed successfully!"
#     exit 0
# else
#     log_warning "Some transformations had errors. Check $ERROR_LIST for details."
#     exit 1
# fi


#!/bin/bash

# Coccinelle Transform Script
# Applies a .cocci file to all source files in a directory
# Usage: ./cocci_transform.sh <cocci_file> <target_directory>

set -e

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# 함수: 사용법 출력
show_usage() {
    echo "Usage: $0 <cocci_file> <target_directory>"
    echo ""
    echo "Arguments:"
    echo "  cocci_file:       Coccinelle (.cocci) file to apply"
    echo "  target_directory: Directory containing .c and .h files to transform"
    echo ""
    echo "Examples:"
    echo "  $0 5_test.cocci ../src"
    echo "  $0 /path/to/transform.cocci /path/to/source"
    echo ""
    echo "The script will apply the .cocci file to all .c and .h files recursively"
    echo "in the target directory using --in-place option."
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

log_step() {
    echo -e "${CYAN}[STEP]${NC} $1"
}

# 인자 검사
if [ $# -ne 2 ]; then
    log_error "Invalid number of arguments"
    show_usage
fi

COCCI_FILE="$1"
TARGET_DIR="$2"

# Cocci 파일 존재 확인
if [ ! -f "$COCCI_FILE" ]; then
    log_error "Coccinelle file not found: $COCCI_FILE"
    exit 1
fi

# 디렉토리 존재 확인
if [ ! -d "$TARGET_DIR" ]; then
    log_error "Directory not found: $TARGET_DIR"
    exit 1
fi

log_info "Starting Coccinelle transformation..."
log_info "Cocci file: $COCCI_FILE"
log_info "Target directory: $TARGET_DIR"
echo ""

# .c 및 .h 파일 찾기 (재귀적으로)
SOURCE_FILES=$(find "$TARGET_DIR" \( -name "*.c" -o -name "*.h" \) -type f)

if [ -z "$SOURCE_FILES" ]; then
    log_warning "No .c or .h files found in $TARGET_DIR"
    exit 0
fi

TOTAL_FILES=$(echo "$SOURCE_FILES" | wc -l)
log_info "Found $TOTAL_FILES source files (.c and .h) to process"
echo ""

# 결과 파일들
ERROR_LIST="error_list.txt"
SUCCESS_LIST="success_list.txt"
NOCHANGE_LIST="nochange_list.txt"

> "$ERROR_LIST"
> "$SUCCESS_LIST"
> "$NOCHANGE_LIST"

CURRENT_FILE=0
SUCCESS_COUNT=0
ERROR_COUNT=0
NOCHANGE_COUNT=0
TEMP_OUTPUT="/tmp/cocci_output_$$"

log_step "Processing files..."
echo ""

# 각 파일에 대해 spatch 실행
while IFS= read -r file; do
    CURRENT_FILE=$((CURRENT_FILE + 1))
    
    RELATIVE_FILE=$(realpath --relative-to=. "$file" 2>/dev/null || echo "$file")
    
    printf "[%3d/%3d] Processing: %-60s" "$CURRENT_FILE" "$TOTAL_FILES" "$RELATIVE_FILE"
    
    # 파일 변경 전 체크섬 저장
    CHECKSUM_BEFORE=$(md5sum "$file" | awk '{print $1}')
    
    # spatch --in-place 실행
    if spatch --sp-file "$COCCI_FILE" --in-place "$file" > "$TEMP_OUTPUT" 2>&1; then
        # 파일 변경 후 체크섬 확인
        CHECKSUM_AFTER=$(md5sum "$file" | awk '{print $1}')
        
        if grep -q "An error occurred when attempting to transform some files" "$TEMP_OUTPUT"; then
            printf " ${RED}[ERROR]${NC}\n"
            echo "$RELATIVE_FILE" >> "$ERROR_LIST"
            ERROR_COUNT=$((ERROR_COUNT + 1))
        elif [ "$CHECKSUM_BEFORE" = "$CHECKSUM_AFTER" ]; then
            # 파일이 변경되지 않음
            printf " ${GRAY}[-]${NC}\n"
            echo "$RELATIVE_FILE" >> "$NOCHANGE_LIST"
            NOCHANGE_COUNT=$((NOCHANGE_COUNT + 1))
        else
            # 파일이 변경됨
            printf " ${GREEN}[OK]${NC}\n"
            echo "$RELATIVE_FILE" >> "$SUCCESS_LIST"
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
        fi
    else
        printf " ${RED}[FAILED]${NC}\n"
        echo "$RELATIVE_FILE" >> "$ERROR_LIST"
        ERROR_COUNT=$((ERROR_COUNT + 1))
    fi
    
done <<< "$SOURCE_FILES"

# 임시 파일 정리
rm -f "$TEMP_OUTPUT"

# 결과 요약
echo ""
echo ""
log_info "═══════════════════════════════════════════════════════════"
log_info "                       SUMMARY"
log_info "═══════════════════════════════════════════════════════════"
echo ""
log_info "Cocci file: $COCCI_FILE"
log_info "Target directory: $TARGET_DIR"
log_info "Total files processed: $TOTAL_FILES"
echo ""
log_success "Successfully transformed: $SUCCESS_COUNT files"
echo -e "${GRAY}[INFO]${NC} No changes needed: $NOCHANGE_COUNT files"
log_error "Failed to transform: $ERROR_COUNT files"
echo ""

# 성공률 계산
if [ $TOTAL_FILES -gt 0 ]; then
    SUCCESS_RATE=$((SUCCESS_COUNT * 100 / TOTAL_FILES))
    PROCESSED_RATE=$(((SUCCESS_COUNT + NOCHANGE_COUNT) * 100 / TOTAL_FILES))
    log_info "Transformation rate: $SUCCESS_RATE%"
    log_info "Successfully processed rate: $PROCESSED_RATE%"
fi

echo ""

# 결과 파일 정보
if [ $SUCCESS_COUNT -gt 0 ]; then
    log_info "Transformed files list saved to: $SUCCESS_LIST"
fi

if [ $NOCHANGE_COUNT -gt 0 ]; then
    echo -e "${GRAY}[INFO]${NC} No-change files list saved to: $NOCHANGE_LIST"
fi

if [ $ERROR_COUNT -gt 0 ]; then
    log_warning "Error list saved to: $ERROR_LIST"
fi

echo ""

# 최종 결과
if [ $ERROR_COUNT -eq 0 ]; then
    if [ $SUCCESS_COUNT -gt 0 ]; then
        log_success "All transformations completed successfully!"
        log_info "$SUCCESS_COUNT file(s) modified, $NOCHANGE_COUNT file(s) unchanged"
    else
        log_info "All files processed successfully (no transformations needed)"
    fi
    exit 0
else
    log_warning "Some transformations had errors. Check $ERROR_LIST for details."
    exit 1
fi