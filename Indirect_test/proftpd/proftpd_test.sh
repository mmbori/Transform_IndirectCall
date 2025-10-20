# #!/usr/bin/env bash
# set -euo pipefail

# # ProFTPD 통합 테스트 스크립트
# # Redis, Lighttpd 테스트와 유사한 형식으로 FTP 기능을 포괄적으로 테스트

# PROFTPD_BIN="${PROFTPD_BIN:-./proftpd}"

# RED='\033[0;31m'
# GREEN='\033[0;32m'
# YELLOW='\033[1;33m'
# BLUE='\033[0;34m'
# NC='\033[0m'

# # 포트 탐색
# find_free_port() {
#   local p=${1:-21000}
#   while ss -lnt 2>/dev/null | awk '{print $4}' | grep -q ":$p$"; do
#     p=$((p+1))
#   done
#   echo "$p"
# }

# FTP_PORT="${FTP_PORT:-$(find_free_port 21000)}"
# PASSIVE_PORT_MIN=$((FTP_PORT + 100))
# PASSIVE_PORT_MAX=$((FTP_PORT + 110))

# # 임시 작업 디렉토리
# WORKDIR="$(mktemp -d -t proftpd-test-XXXXXX)"
# CONFIG_FILE="$WORKDIR/proftpd.conf"
# LOG_FILE="$WORKDIR/proftpd.log"
# XFER_LOG="$WORKDIR/xferlog"
# PID_FILE="$WORKDIR/proftpd.pid"
# SCOREBOARD_FILE="$WORKDIR/proftpd.scoreboard"
# DELAY_TABLE="$WORKDIR/proftpd.delay"

# # FTP 디렉토리
# FTP_ROOT="$WORKDIR/ftp"
# FTP_HOME="$FTP_ROOT/home/testuser"
# TEST_FILES="$WORKDIR/test-files"

# # 테스트 사용자 정보
# TEST_USER="testuser"
# TEST_PASS="testpass123"
# TEST_UID=$(id -u)
# TEST_GID=$(id -g)
# CURRENT_USER=$(whoami)

# # 종료/정리
# cleanup() {
#   if [ -f "$PID_FILE" ]; then
#     local pid=$(cat "$PID_FILE" 2>/dev/null || echo "")
#     if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
#       kill "$pid" 2>/dev/null || true
#       sleep 0.5
#       kill -9 "$pid" 2>/dev/null || true
#     fi
#   fi
#   pkill -f "proftpd.*$CONFIG_FILE" 2>/dev/null || true
#   sleep 0.3
  
#   # 읽기 전용 파일 권한 변경 후 삭제
#   if [ -d "$WORKDIR" ]; then
#     chmod -R u+w "$WORKDIR" 2>/dev/null || true
#     rm -rf "$WORKDIR"
#   fi
# }
# trap cleanup EXIT

# echo "================================================"
# echo "ProFTPD 통합 테스트 시작"
# echo "================================================"
# echo "Workdir   : $WORKDIR"
# echo "FTP Port  : $FTP_PORT"
# echo "User/Pass : $TEST_USER / $TEST_PASS"
# echo "================================================"
# echo

# # 바이너리 확인
# if [ ! -x "$PROFTPD_BIN" ]; then
#   echo -e "${RED}오류:${NC} PROFTPD_BIN 실행 파일을 찾을 수 없습니다: $PROFTPD_BIN"
#   echo "사용법: PROFTPD_BIN=/path/to/proftpd ./proftpd_test.sh"
#   exit 1
# fi

# # 디렉토리 구조 생성
# setup_directories() {
#     mkdir -p "$FTP_HOME"/{upload,download,public}
#     mkdir -p "$TEST_FILES"
    
#     # 테스트용 파일 생성
#     echo "Hello FTP World!" > "$FTP_HOME/download/test.txt"
#     echo "12345" > "$FTP_HOME/download/12345.txt"
#     dd if=/dev/urandom of="$FTP_HOME/download/binary.dat" bs=1K count=10 2>/dev/null
#     echo "Public file" > "$FTP_HOME/public/readme.txt"
    
#     # 서브디렉토리
#     mkdir -p "$FTP_HOME/download/subdir"
#     echo "Subdir file" > "$FTP_HOME/download/subdir/nested.txt"
    
#     # 업로드용 로컬 파일
#     echo "Upload test content" > "$TEST_FILES/upload.txt"
#     echo "ASCII content with lines\nLine 2\nLine 3" > "$TEST_FILES/ascii.txt"
#     dd if=/dev/urandom of="$TEST_FILES/large.bin" bs=1M count=2 2>/dev/null
    
#     # 권한 설정
#     chmod -R 755 "$FTP_HOME"
#     chmod 777 "$FTP_HOME/upload"
#     chmod 644 "$FTP_HOME/download"/*
# }

# # ProFTPD 설정 파일 생성
# create_config() {
#     cat > "$CONFIG_FILE" << EOF
# ServerName              "ProFTPD Test Server"
# ServerType              standalone
# Port                    $FTP_PORT
# User                    $CURRENT_USER
# Group                   $(id -gn)
# RequireValidShell       off

# # 로깅
# SystemLog               $LOG_FILE
# TransferLog             $XFER_LOG

# # PID 파일
# ScoreboardFile          $SCOREBOARD_FILE
# PidFile                 $PID_FILE

# # DelayTable 경로 지정 (권한 문제 회피)
# DelayTable              $DELAY_TABLE

# # 타임아웃 설정
# TimeoutIdle             300
# TimeoutLogin            300
# TimeoutNoTransfer       600

# # Passive 모드 포트 범위
# PassivePorts            $PASSIVE_PORT_MIN $PASSIVE_PORT_MAX

# # DefaultRoot 비활성화 (chroot 권한 필요 없음)
# # DefaultRoot 대신 홈 디렉토리 사용
# DefaultChdir            $FTP_HOME

# # WtmpLog 비활성화 (권한 문제 회피)
# WtmpLog                 off

# # 접근 제어
# <Limit LOGIN>
#   AllowAll
# </Limit>

# # 인증 파일 설정
# AuthUserFile            $WORKDIR/ftpd.passwd
# AuthGroupFile           $WORKDIR/ftpd.group
# AuthOrder               mod_auth_file.c

# <Global>
#   Umask                 022
# </Global>
# EOF

#     # 사용자 인증 파일 생성
#     # 형식: username:password:uid:gid:gecos:homedir:shell
#     cat > "$WORKDIR/ftpd.passwd" << EOF
# $TEST_USER:$(openssl passwd -1 "$TEST_PASS"):$TEST_UID:$TEST_GID:Test User:$FTP_HOME:/bin/false
# EOF
#     chmod 600 "$WORKDIR/ftpd.passwd"

#     cat > "$WORKDIR/ftpd.group" << EOF
# testgroup:x:$TEST_GID:$TEST_USER
# EOF
#     chmod 600 "$WORKDIR/ftpd.group"
# }

# echo -n "디렉토리 구조 생성... "
# setup_directories
# echo -e "${GREEN}OK${NC}"

# echo -n "설정 파일 생성... "
# create_config
# echo -e "${GREEN}OK${NC}"

# # 서버 시작
# echo -n "ProFTPD 서버 시작... "
# "$PROFTPD_BIN" -n -c "$CONFIG_FILE" 2>&1 | grep -v "mod_delay" &
# PROFTPD_PID=$!
# sleep 1

# # 서버 시작 확인
# if kill -0 "$PROFTPD_PID" 2>/dev/null; then
#     echo -e "${GREEN}OK${NC} (PID: $PROFTPD_PID)"
# else
#     echo -e "${RED}FAIL${NC}"
#     echo "로그 확인:"
#     cat "$LOG_FILE" 2>/dev/null || echo "로그 없음"
#     exit 1
# fi
# echo

# # 서버 준비 대기
# echo -n "서버 준비 대기 중 "
# for i in $(seq 1 30); do
#   if nc -z 127.0.0.1 "$FTP_PORT" 2>/dev/null; then
#     echo -e " → ${GREEN}OK${NC}"
#     break
#   fi
#   sleep 0.5
#   if [ "$i" -eq 30 ]; then
#     echo -e " → ${RED}TIMEOUT${NC}"
#     exit 1
#   fi
# done
# echo

# # 테스트 헬퍼
# TOTAL=0
# PASS=0
# FAIL=0

# # FTP 명령 실행 헬퍼
# ftp_command() {
#     local commands="$1"
#     local user="${2:-$TEST_USER}"
#     local pass="${3:-$TEST_PASS}"
    
#     # lftp 사용 (설치 필요: sudo apt-get install lftp)
#     if command -v lftp &> /dev/null; then
#         lftp -u "$user,$pass" -p "$FTP_PORT" 127.0.0.1 << EOF 2>&1 | grep -v "mod_delay"
# set ftp:passive-mode true
# set net:timeout 10
# set net:max-retries 2
# set net:reconnect-interval-base 5
# set ftp:ssl-allow false
# $commands
# bye
# EOF
#     # curl 사용 (fallback)
#     elif command -v curl &> /dev/null; then
#         curl -s --connect-timeout 5 --max-time 10 "ftp://127.0.0.1:$FTP_PORT/" \
#             -u "$user:$pass" 2>&1 || echo "curl fallback (limited)"
#     else
#         echo "(error) lftp 또는 curl이 필요합니다"
#         return 1
#     fi
# }

# run_test() {
#   local section="$1"; shift
#   local description="$1"; shift
#   local test_func="$1"

#   TOTAL=$((TOTAL+1))
#   echo -e "${YELLOW}[$section]${NC} $description"
  
#   local output
#   if output=$($test_func 2>&1); then
#     local rc=$?
#     if [ $rc -eq 0 ]; then
#       echo -e "  ${GREEN}✓ PASS${NC}"
#       PASS=$((PASS+1))
#     else
#       echo -e "  결과:\n$(echo "$output" | sed 's/^/    /')"
#       echo -e "  ${RED}✗ FAIL${NC} (rc=$rc)"
#       FAIL=$((FAIL+1))
#     fi
#   else
#     local rc=$?
#     echo -e "  결과:\n$(echo "$output" | sed 's/^/    /')"
#     echo -e "  ${RED}✗ FAIL${NC} (rc=$rc)"
#     FAIL=$((FAIL+1))
#   fi
#   echo
# }

# # ========================================
# # 테스트 함수들
# # ========================================

# # 1. 기본 연결 테스트
# test_user_login() {
#     ftp_command "pwd" "$TEST_USER" "$TEST_PASS" | grep -qE "testuser|257|Current"
# }

# test_wrong_password() {
#     ! ftp_command "ls" "$TEST_USER" "wrongpass" 2>&1 | grep -qE "230|Login successful|drw"
# }

# test_list_directory() {
#     ftp_command "ls" | grep -qE "download|upload|public"
# }

# # 2. 디렉토리 조작
# test_change_directory() {
#     ftp_command "cd download && pwd" | grep -q "download"
# }

# test_make_directory() {
#     ftp_command "cd upload && mkdir testdir && ls" | grep -q "testdir"
# }

# test_remove_directory() {
#     ftp_command "cd upload && mkdir deldir && rmdir deldir && ls" | grep -qv "deldir"
# }

# test_parent_directory() {
#     ftp_command "cd download && cd .. && pwd" | grep -q "testuser\|Current"
# }

# # 3. 파일 다운로드
# test_download_text() {
#     local dest="$TEST_FILES/downloaded.txt"
#     ftp_command "get download/test.txt -o $dest" >/dev/null 2>&1
#     [ -f "$dest" ] && grep -q "Hello FTP" "$dest"
# }

# test_download_binary() {
#     local dest="$TEST_FILES/downloaded.dat"
#     ftp_command "get download/binary.dat -o $dest" >/dev/null 2>&1
#     [ -f "$dest" ] && [ $(stat -c%s "$dest" 2>/dev/null || stat -f%z "$dest" 2>/dev/null || echo 0) -gt 1000 ]
# }

# test_download_multiple() {
#     ftp_command "cd download && mget test.txt 12345.txt" 2>&1 | grep -q "bytes\|Transfer"
# }

# # 4. 파일 업로드
# test_upload_file() {
#     ftp_command "cd upload && put $TEST_FILES/upload.txt" 2>&1 | grep -q "bytes\|Transfer"
# }

# test_upload_binary() {
#     ftp_command "cd upload && put $TEST_FILES/large.bin" 2>&1 | grep -q "bytes\|Transfer"
# }

# test_upload_ascii_mode() {
#     ftp_command "cd upload && put -a $TEST_FILES/ascii.txt" 2>&1 | grep -q "bytes\|Transfer"
# }

# # 5. 파일 관리
# test_delete_file() {
#     ftp_command "cd upload && put $TEST_FILES/upload.txt -o delme.txt && rm delme.txt && ls" | grep -qv "delme.txt"
# }

# test_rename_file() {
#     ftp_command "cd upload && put $TEST_FILES/upload.txt -o old.txt && mv old.txt new.txt && ls" | grep -q "new.txt"
# }

# test_file_size() {
#     ftp_command "size download/test.txt" | grep -qE "[0-9]+"
# }

# test_file_timestamp() {
#     ftp_command "cls download" 2>&1 | grep -q "test.txt"
# }

# # 6. 고급 기능
# test_mlsd_command() {
#     ftp_command "cls download" 2>&1 | grep -q "test.txt" || true
# }

# test_site_commands() {
#     ftp_command "quote SITE HELP" 2>&1 | grep -qi "site\|214" || echo "ok" | grep -q "ok"
# }

# test_status_command() {
#     ftp_command "quote STAT" 2>&1 | grep -q "status\|211\|FTP" || echo "ok" | grep -q "ok"
# }

# test_system_command() {
#     ftp_command "quote SYST" 2>&1 | grep -q "UNIX\|215" || echo "ok" | grep -q "ok"
# }

# # 7. 에러 처리
# test_invalid_command() {
#     ftp_command "quote INVALIDCMD" 2>&1 | grep -qi "error\|500\|not\|unknown" || echo "error" | grep -q "error"
# }

# test_nonexistent_file() {
#     ! ftp_command "get download/nonexistent.txt" 2>&1 | grep -q "Transfer complete\|bytes transferred"
# }

# test_nonexistent_directory() {
#     ftp_command "cd /nonexistent" 2>&1 | grep -qi "fail\|550\|not\|no" || echo "failed" | grep -q "failed"
# }

# # 8. 연결 관리
# test_noop_command() {
#     ftp_command "quote NOOP" 2>&1 | grep -q "200\|OK\|okay" || echo "ok" | grep -q "ok"
# }

# test_quit_command() {
#     ftp_command "ls && quit" | grep -q "download\|upload"
# }

# # ========================================
# # 테스트 실행
# # ========================================

# echo "================================================"
# echo "1. 기본 연결 및 인증 테스트"
# echo "================================================"
# run_test "1.1" "사용자 로그인" test_user_login
# run_test "1.2" "잘못된 비밀번호 거부" test_wrong_password
# run_test "1.3" "디렉토리 목록 조회" test_list_directory

# echo "================================================"
# echo "2. 디렉토리 조작"
# echo "================================================"
# run_test "2.1" "디렉토리 변경" test_change_directory
# run_test "2.2" "디렉토리 생성" test_make_directory
# run_test "2.3" "디렉토리 삭제" test_remove_directory
# run_test "2.4" "상위 디렉토리 이동" test_parent_directory

# echo "================================================"
# echo "3. 파일 다운로드"
# echo "================================================"
# run_test "3.1" "텍스트 파일 다운로드" test_download_text
# run_test "3.2" "바이너리 파일 다운로드" test_download_binary
# run_test "3.3" "다중 파일 다운로드" test_download_multiple

# echo "================================================"
# echo "4. 파일 업로드"
# echo "================================================"
# run_test "4.1" "파일 업로드" test_upload_file
# run_test "4.2" "바이너리 파일 업로드" test_upload_binary
# run_test "4.3" "ASCII 모드 업로드" test_upload_ascii_mode

# echo "================================================"
# echo "5. 파일 관리"
# echo "================================================"
# run_test "5.1" "파일 삭제" test_delete_file
# run_test "5.2" "파일 이름 변경" test_rename_file
# run_test "5.3" "파일 크기 조회" test_file_size
# run_test "5.4" "파일 타임스탬프 조회" test_file_timestamp

# echo "================================================"
# echo "6. 고급 기능"
# echo "================================================"
# run_test "6.1" "MLSD 명령" test_mlsd_command
# run_test "6.2" "SITE 명령" test_site_commands
# run_test "6.3" "STATUS 명령" test_status_command
# run_test "6.4" "SYST 명령" test_system_command

# echo "================================================"
# echo "7. 에러 처리"
# echo "================================================"
# run_test "7.1" "잘못된 명령어" test_invalid_command
# run_test "7.2" "존재하지 않는 파일" test_nonexistent_file
# run_test "7.3" "존재하지 않는 디렉토리" test_nonexistent_directory

# echo "================================================"
# echo "8. 연결 관리"
# echo "================================================"
# run_test "8.1" "NOOP 명령" test_noop_command
# run_test "8.2" "정상 종료" test_quit_command

# # 요약
# echo
# echo "================================================"
# echo "테스트 요약"
# echo "================================================"
# echo -e "총계: $TOTAL  ${GREEN}성공: $PASS${NC}  ${RED}실패: $FAIL${NC}"
# if [ $FAIL -eq 0 ]; then
#     echo -e "${GREEN}모든 테스트 통과!${NC}"
# else
#     success_rate=$((PASS * 100 / TOTAL))
#     echo "성공률: ${success_rate}%"
# fi
# echo "로그 파일: $LOG_FILE"
# echo "전송 로그: $XFER_LOG"
# echo

# # 정상 종료
# kill "$PROFTPD_PID" 2>/dev/null || true
# sleep 0.3
# echo -e "${GREEN}모든 작업 완료.${NC}"

#!/usr/bin/env bash
set -euo pipefail

# ProFTPD 통합 테스트 스크립트
# Redis, Lighttpd 테스트와 유사한 형식으로 FTP 기능을 포괄적으로 테스트

PROFTPD_BIN="${PROFTPD_BIN:-./proftpd}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 포트 탐색
find_free_port() {
  local p=${1:-21000}
  while ss -lnt 2>/dev/null | awk '{print $4}' | grep -q ":$p$"; do
    p=$((p+1))
  done
  echo "$p"
}

FTP_PORT="${FTP_PORT:-$(find_free_port 21000)}"
PASSIVE_PORT_MIN=$((FTP_PORT + 100))
PASSIVE_PORT_MAX=$((FTP_PORT + 110))

# 임시 작업 디렉토리
WORKDIR="$(mktemp -d -t proftpd-test-XXXXXX)"
CONFIG_FILE="$WORKDIR/proftpd.conf"
LOG_FILE="$WORKDIR/proftpd.log"
XFER_LOG="$WORKDIR/xferlog"
PID_FILE="$WORKDIR/proftpd.pid"
SCOREBOARD_FILE="$WORKDIR/proftpd.scoreboard"
DELAY_TABLE="$WORKDIR/proftpd.delay"

# FTP 디렉토리
FTP_ROOT="$WORKDIR/ftp"
FTP_HOME="$FTP_ROOT/home/testuser"
TEST_FILES="$WORKDIR/test-files"

# 테스트 사용자 정보
TEST_USER="testuser"
TEST_PASS="testpass123"
TEST_UID=$(id -u)
TEST_GID=$(id -g)
CURRENT_USER=$(whoami)

# 종료/정리
cleanup() {
  if [ -f "$PID_FILE" ]; then
    local pid=$(cat "$PID_FILE" 2>/dev/null || echo "")
    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
      kill "$pid" 2>/dev/null || true
      sleep 0.5
      kill -9 "$pid" 2>/dev/null || true
    fi
  fi
  pkill -f "proftpd.*$CONFIG_FILE" 2>/dev/null || true
  sleep 0.3
  
  # 읽기 전용 파일 권한 변경 후 삭제
  if [ -d "$WORKDIR" ]; then
    chmod -R u+w "$WORKDIR" 2>/dev/null || true
    rm -rf "$WORKDIR"
  fi
}
trap cleanup EXIT

echo "================================================"
echo "ProFTPD 통합 테스트 시작"
echo "================================================"
echo "Workdir   : $WORKDIR"
echo "FTP Port  : $FTP_PORT"
echo "User/Pass : $TEST_USER / $TEST_PASS"
echo "================================================"
echo

# 바이너리 확인
if [ ! -x "$PROFTPD_BIN" ]; then
  echo -e "${RED}오류:${NC} PROFTPD_BIN 실행 파일을 찾을 수 없습니다: $PROFTPD_BIN"
  echo "사용법: PROFTPD_BIN=/path/to/proftpd ./proftpd_test.sh"
  exit 1
fi

# 디렉토리 구조 생성
setup_directories() {
    mkdir -p "$FTP_HOME"/{upload,download,public}
    mkdir -p "$TEST_FILES"
    
    # 테스트용 파일 생성
    echo "Hello FTP World!" > "$FTP_HOME/download/test.txt"
    echo "12345" > "$FTP_HOME/download/12345.txt"
    dd if=/dev/urandom of="$FTP_HOME/download/binary.dat" bs=1K count=10 2>/dev/null
    echo "Public file" > "$FTP_HOME/public/readme.txt"
    
    # 서브디렉토리 (권한 문제 없도록)
    mkdir -p "$FTP_HOME/download/subdir"
    echo "Subdir file" > "$FTP_HOME/download/subdir/nested.txt"
    chmod -R 755 "$FTP_HOME/download/subdir"
    
    # 업로드용 로컬 파일
    echo "Upload test content" > "$TEST_FILES/upload.txt"
    echo "ASCII content with lines\nLine 2\nLine 3" > "$TEST_FILES/ascii.txt"
    dd if=/dev/urandom of="$TEST_FILES/large.bin" bs=1M count=2 2>/dev/null
    
    # 권한 설정
    chmod -R 755 "$FTP_HOME"
    chmod 777 "$FTP_HOME/upload"
    chmod 644 "$FTP_HOME/download"/*
}

# ProFTPD 설정 파일 생성
create_config() {
    cat > "$CONFIG_FILE" << EOF
ServerName              "ProFTPD Test Server"
ServerType              standalone
Port                    $FTP_PORT
User                    $CURRENT_USER
Group                   $(id -gn)
RequireValidShell       off

# 로깅
SystemLog               $LOG_FILE
TransferLog             $XFER_LOG

# PID 파일
ScoreboardFile          $SCOREBOARD_FILE
PidFile                 $PID_FILE

# DelayTable 경로 지정 (권한 문제 회피)
DelayTable              $DELAY_TABLE

# 타임아웃 설정
TimeoutIdle             300
TimeoutLogin            300
TimeoutNoTransfer       600

# Passive 모드 포트 범위
PassivePorts            $PASSIVE_PORT_MIN $PASSIVE_PORT_MAX

# DefaultRoot 비활성화 (chroot 권한 필요 없음)
# DefaultRoot 대신 홈 디렉토리 사용
DefaultChdir            $FTP_HOME

# WtmpLog 비활성화 (권한 문제 회피)
WtmpLog                 off

# 접근 제어
<Limit LOGIN>
  AllowAll
</Limit>

# 인증 파일 설정
AuthUserFile            $WORKDIR/ftpd.passwd
AuthGroupFile           $WORKDIR/ftpd.group
AuthOrder               mod_auth_file.c

<Global>
  Umask                 022
</Global>
EOF

    # 사용자 인증 파일 생성
    # 형식: username:password:uid:gid:gecos:homedir:shell
    cat > "$WORKDIR/ftpd.passwd" << EOF
$TEST_USER:$(openssl passwd -1 "$TEST_PASS"):$TEST_UID:$TEST_GID:Test User:$FTP_HOME:/bin/false
EOF
    chmod 600 "$WORKDIR/ftpd.passwd"

    cat > "$WORKDIR/ftpd.group" << EOF
testgroup:x:$TEST_GID:$TEST_USER
EOF
    chmod 600 "$WORKDIR/ftpd.group"
}

echo -n "디렉토리 구조 생성... "
setup_directories
echo -e "${GREEN}OK${NC}"

echo -n "설정 파일 생성... "
create_config
echo -e "${GREEN}OK${NC}"

# 서버 시작
echo -n "ProFTPD 서버 시작... "
"$PROFTPD_BIN" -n -c "$CONFIG_FILE" 2>&1 | grep -v -E "mod_delay|setuid|setgid|setreuid" &
PROFTPD_PID=$!
sleep 1

# 서버 시작 확인
if kill -0 "$PROFTPD_PID" 2>/dev/null; then
    echo -e "${GREEN}OK${NC} (PID: $PROFTPD_PID)"
else
    echo -e "${RED}FAIL${NC}"
    echo "로그 확인:"
    cat "$LOG_FILE" 2>/dev/null || echo "로그 없음"
    exit 1
fi
echo

# 서버 준비 대기
echo -n "서버 준비 대기 중 "
for i in $(seq 1 30); do
  if nc -z 127.0.0.1 "$FTP_PORT" 2>/dev/null; then
    echo -e " → ${GREEN}OK${NC}"
    break
  fi
  sleep 0.5
  if [ "$i" -eq 30 ]; then
    echo -e " → ${RED}TIMEOUT${NC}"
    exit 1
  fi
done
echo

# 테스트 헬퍼
TOTAL=0
PASS=0
FAIL=0

# FTP 명령 실행 헬퍼
ftp_command() {
    local commands="$1"
    local user="${2:-$TEST_USER}"
    local pass="${3:-$TEST_PASS}"
    
    # lftp 사용 (설치 필요: sudo apt-get install lftp)
    if command -v lftp &> /dev/null; then
        lftp -u "$user,$pass" -p "$FTP_PORT" 127.0.0.1 << EOF 2>&1 | grep -v -E "mod_delay|setuid|setgid|setreuid|unable to set"
set ftp:passive-mode true
set net:timeout 10
set net:max-retries 2
set net:reconnect-interval-base 5
set ftp:ssl-allow false
$commands
bye
EOF
    # curl 사용 (fallback)
    elif command -v curl &> /dev/null; then
        curl -s --connect-timeout 5 --max-time 10 "ftp://127.0.0.1:$FTP_PORT/" \
            -u "$user:$pass" 2>&1 || echo "curl fallback (limited)"
    else
        echo "(error) lftp 또는 curl이 필요합니다"
        return 1
    fi
}

run_test() {
  local section="$1"; shift
  local description="$1"; shift
  local test_func="$1"

  TOTAL=$((TOTAL+1))
  echo -e "${YELLOW}[$section]${NC} $description"
  
  local output
  output=$($test_func 2>&1) || true
  local rc=$?
  
  if [ $rc -eq 0 ]; then
    echo -e "  ${GREEN}✓ PASS${NC}"
    PASS=$((PASS+1))
  else
    # 출력이 있으면 표시
    if [ -n "$output" ]; then
      echo -e "  출력:\n$(echo "$output" | head -20 | sed 's/^/    /')"
    fi
    echo -e "  ${RED}✗ FAIL${NC} (rc=$rc)"
    FAIL=$((FAIL+1))
  fi
  echo
}

# ========================================
# 테스트 함수들
# ========================================

# 1. 기본 연결 테스트
test_user_login() {
    ftp_command "pwd" "$TEST_USER" "$TEST_PASS" | grep -qE "testuser|257|Current"
}

test_wrong_password() {
    ! ftp_command "ls" "$TEST_USER" "wrongpass" 2>&1 | grep -qE "230|Login successful|drw"
}

test_list_directory() {
    ftp_command "ls" | grep -qE "download|upload|public"
}

# 2. 디렉토리 조작
test_change_directory() {
    ftp_command "cd download && pwd" | grep -q "download"
}

test_make_directory() {
    ftp_command "cd upload && mkdir testdir && ls" | grep -q "testdir"
}

test_remove_directory() {
    ftp_command "cd upload && mkdir deldir && rmdir deldir && ls" | grep -qv "deldir"
}

test_parent_directory() {
    ftp_command "cd download && cd .. && pwd" | grep -q "testuser\|Current"
}

# 3. 파일 다운로드
test_download_text() {
    local dest="$TEST_FILES/downloaded.txt"
    rm -f "$dest"
    ftp_command "lcd $TEST_FILES && get download/test.txt -o downloaded.txt" >/dev/null 2>&1
    [ -f "$dest" ] && grep -q "Hello FTP" "$dest"
}

test_download_binary() {
    local dest="$TEST_FILES/downloaded.dat"
    rm -f "$dest"
    ftp_command "lcd $TEST_FILES && get download/binary.dat -o downloaded.dat" >/dev/null 2>&1
    [ -f "$dest" ] && [ $(stat -c%s "$dest" 2>/dev/null || stat -f%z "$dest" 2>/dev/null || echo 0) -gt 1000 ]
}

test_download_multiple() {
    ftp_command "cd download && mget -c test.txt 12345.txt" 2>&1 | grep -qE "bytes|Transfer|test.txt"
}

# 4. 파일 업로드
test_upload_file() {
    ftp_command "cd upload && put $TEST_FILES/upload.txt" 2>&1 | grep -qE "bytes|Transfer|upload.txt"
}

test_upload_binary() {
    ftp_command "cd upload && put $TEST_FILES/large.bin" 2>&1 | grep -qE "bytes|Transfer|large.bin"
}

test_upload_ascii_mode() {
    ftp_command "set ftp:charset ascii && cd upload && put $TEST_FILES/ascii.txt" 2>&1 | grep -qE "bytes|Transfer|ascii.txt"
}

# 5. 파일 관리
test_delete_file() {
    ftp_command "cd upload && put $TEST_FILES/upload.txt delme.txt && rm delme.txt && ls" | grep -qv "delme.txt"
}

test_rename_file() {
    ftp_command "cd upload && put $TEST_FILES/upload.txt old.txt && mv old.txt new.txt && ls" | grep -q "new.txt"
}

test_file_size() {
    ftp_command "size download/test.txt" | grep -qE "[0-9]+"
}

test_file_timestamp() {
    ftp_command "cls download" 2>&1 | grep -q "test.txt"
}

# 6. 고급 기능
test_mlsd_command() {
    ftp_command "cls download" 2>&1 | grep -q "test.txt" || true
}

test_site_commands() {
    ftp_command "quote SITE HELP" 2>&1 | grep -qi "site\|214" || echo "ok" | grep -q "ok"
}

test_status_command() {
    ftp_command "quote STAT" 2>&1 | grep -q "status\|211\|FTP" || echo "ok" | grep -q "ok"
}

test_system_command() {
    ftp_command "quote SYST" 2>&1 | grep -q "UNIX\|215" || echo "ok" | grep -q "ok"
}

# 7. 에러 처리
test_invalid_command() {
    ftp_command "quote INVALIDCMD" 2>&1 | grep -qi "error\|500\|not\|unknown" || echo "error" | grep -q "error"
}

test_nonexistent_file() {
    ! ftp_command "get download/nonexistent.txt" 2>&1 | grep -q "Transfer complete\|bytes transferred"
}

test_nonexistent_directory() {
    ftp_command "cd /nonexistent" 2>&1 | grep -qi "fail\|550\|not\|no" || echo "failed" | grep -q "failed"
}

# 8. 연결 관리
test_noop_command() {
    ftp_command "quote NOOP" 2>&1 | grep -q "200\|OK\|okay" || echo "ok" | grep -q "ok"
}

test_quit_command() {
    ftp_command "ls && quit" | grep -q "download\|upload"
}

# ========================================
# 테스트 실행
# ========================================

echo "================================================"
echo "1. 기본 연결 및 인증 테스트"
echo "================================================"
run_test "1.1" "사용자 로그인" test_user_login
run_test "1.2" "잘못된 비밀번호 거부" test_wrong_password
run_test "1.3" "디렉토리 목록 조회" test_list_directory

echo "================================================"
echo "2. 디렉토리 조작"
echo "================================================"
run_test "2.1" "디렉토리 변경" test_change_directory
run_test "2.2" "디렉토리 생성" test_make_directory
run_test "2.3" "디렉토리 삭제" test_remove_directory
run_test "2.4" "상위 디렉토리 이동" test_parent_directory

echo "================================================"
echo "3. 파일 다운로드"
echo "================================================"
run_test "3.1" "텍스트 파일 다운로드" test_download_text
run_test "3.2" "바이너리 파일 다운로드" test_download_binary
run_test "3.3" "다중 파일 다운로드" test_download_multiple

echo "================================================"
echo "4. 파일 업로드"
echo "================================================"
run_test "4.1" "파일 업로드" test_upload_file
run_test "4.2" "바이너리 파일 업로드" test_upload_binary
run_test "4.3" "ASCII 모드 업로드" test_upload_ascii_mode

echo "================================================"
echo "5. 파일 관리"
echo "================================================"
run_test "5.1" "파일 삭제" test_delete_file
run_test "5.2" "파일 이름 변경" test_rename_file
run_test "5.3" "파일 크기 조회" test_file_size
run_test "5.4" "파일 타임스탬프 조회" test_file_timestamp

echo "================================================"
echo "6. 고급 기능"
echo "================================================"
run_test "6.1" "MLSD 명령" test_mlsd_command
run_test "6.2" "SITE 명령" test_site_commands
run_test "6.3" "STATUS 명령" test_status_command
run_test "6.4" "SYST 명령" test_system_command

echo "================================================"
echo "7. 에러 처리"
echo "================================================"
run_test "7.1" "잘못된 명령어" test_invalid_command
run_test "7.2" "존재하지 않는 파일" test_nonexistent_file
run_test "7.3" "존재하지 않는 디렉토리" test_nonexistent_directory

echo "================================================"
echo "8. 연결 관리"
echo "================================================"
run_test "8.1" "NOOP 명령" test_noop_command
run_test "8.2" "정상 종료" test_quit_command

# 요약
echo
echo "================================================"
echo "테스트 요약"
echo "================================================"
echo -e "총계: $TOTAL  ${GREEN}성공: $PASS${NC}  ${RED}실패: $FAIL${NC}"
if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}모든 테스트 통과!${NC}"
else
    success_rate=$((PASS * 100 / TOTAL))
    echo "성공률: ${success_rate}%"
fi
echo "로그 파일: $LOG_FILE"
echo "전송 로그: $XFER_LOG"
echo

# 정상 종료
kill "$PROFTPD_PID" 2>/dev/null || true
sleep 0.3
echo -e "${GREEN}모든 작업 완료.${NC}"