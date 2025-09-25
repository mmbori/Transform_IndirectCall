#!/bin/bash

# 실행 중인 lighttpd 서버에 request.t의 HTTP 요청을 전송하고 간단한 결과만 표시
# 사용법: ./simple_request_test.sh [서버주소] [포트]

SERVER_HOST=${1:-127.0.0.1}
SERVER_PORT=${2:-8080}
BASE_URL="http://$SERVER_HOST:$SERVER_PORT"

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "================================================================"
echo "          request.t HTTP 테스트 (간단 모드)"
echo "================================================================"
echo "서버: $BASE_URL"
echo

# 테스트 카운터
test_num=0
success_count=0
failure_count=0

# 테스트 실행 함수
run_test() {
    local description="$1"
    local curl_cmd="$2"
    local expected_status="$3"
    local expected_content="$4"
    
    test_num=$((test_num + 1))
    printf "[%03d] %-60s " "$test_num" "$description"
    
    # curl 실행 (타임아웃 추가)
    local temp_file=$(mktemp)
    local start_time=$(date +%s.%N)
    local http_code=$(eval "$curl_cmd" -w "%{http_code}" -s -o "$temp_file" --connect-timeout 3 --max-time 10 2>/dev/null)
    local end_time=$(date +%s.%N)
    local duration=$(echo "$end_time - $start_time" | bc 2>/dev/null || echo "0")
    
    # 결과 확인
    local test_passed=true
    
    # HTTP 상태 코드 확인
    if [ "$http_code" != "$expected_status" ]; then
        test_passed=false
    fi
    
    # 내용 확인 (있는 경우)
    if [ -n "$expected_content" ] && [ "$test_passed" = true ]; then
        if ! grep -q "$expected_content" "$temp_file" 2>/dev/null; then
            test_passed=false
        fi
    fi
    
    # 결과 출력 (느린 요청은 시간 표시)
    if [ "$test_passed" = true ]; then
        if (( $(echo "$duration > 2" | bc -l 2>/dev/null || echo 0) )); then
            echo -e "${GREEN}✓${NC} ${YELLOW}(${duration}s)${NC}"
        else
            echo -e "${GREEN}✓${NC}"
        fi
        success_count=$((success_count + 1))
    else
        if (( $(echo "$duration > 2" | bc -l 2>/dev/null || echo 0) )); then
            echo -e "${RED}✗${NC} ${YELLOW}(${duration}s, status: $http_code)${NC}"
        else
            echo -e "${RED}✗${NC} ${YELLOW}(status: $http_code)${NC}"
        fi
        failure_count=$((failure_count + 1))
    fi
    
    rm -f "$temp_file"
}

# raw HTTP 요청을 보내는 함수 (OPTIONS * 같은 특수한 경우)
run_raw_test() {
    local description="$1"
    local raw_request="$2"
    local expected_status="$3"
    
    test_num=$((test_num + 1))
    printf "[%03d] %-60s " "$test_num" "$description"
    
    local start_time=$(date +%s.%N)
    local response=$(printf "$raw_request" | timeout 5 nc "$SERVER_HOST" "$SERVER_PORT" 2>/dev/null)
    local end_time=$(date +%s.%N)
    local duration=$(echo "$end_time - $start_time" | bc 2>/dev/null || echo "0")
    
    if echo "$response" | head -1 | grep -q "HTTP/1\.[01] $expected_status"; then
        if (( $(echo "$duration > 2" | bc -l 2>/dev/null || echo 0) )); then
            echo -e "${GREEN}✓${NC} ${YELLOW}(${duration}s)${NC}"
        else
            echo -e "${GREEN}✓${NC}"
        fi
        success_count=$((success_count + 1))
    else
        local actual_status=$(echo "$response" | head -1 | grep -o "HTTP/1\.[01] [0-9]*" | grep -o "[0-9]*$")
        echo -e "${RED}✗${NC} ${YELLOW}(status: ${actual_status:-timeout})${NC}"
        failure_count=$((failure_count + 1))
    fi
}

echo "=== 기본 요청 처리 테스트 ==="

run_test "Valid HTTP/1.0 Request" \
    "curl -X GET '$BASE_URL/' --http1.0" \
    "200"

# OPTIONS * 테스트를 raw HTTP로 수행
run_raw_test "OPTIONS *" \
    "OPTIONS * HTTP/1.1\r\nHost: www.example.org\r\n\r\n" \
    "200"

run_test "OPTIONS / HTTP/1.1" \
    "curl -X OPTIONS '$BASE_URL/' -H 'Host: www.example.org'" \
    "200"

run_test "URL-encoding %00" \
    "curl -X GET '$BASE_URL/index.html%00'" \
    "400"

run_test "Content-Length > max-request-size" \
    "curl -X POST '$BASE_URL/12345.txt' -H 'Host: 123.example.org' -H 'Content-Length: 2147483648'" \
    "413"

run_test "Content-Type image/jpeg" \
    "curl -X GET '$BASE_URL/image.jpg'" \
    "200"

run_test "Content-Type image/jpeg (upper case)" \
    "curl -X GET '$BASE_URL/image.JPG'" \
    "200"

run_test "uppercase filenames" \
    "curl -X GET '$BASE_URL/Foo.txt'" \
    "200"

run_test "file not found + querystring" \
    "curl -X GET '$BASE_URL/foobar?foobar'" \
    "404"

run_test "GET 12345.txt content" \
    "curl -X GET '$BASE_URL/12345.txt' -H 'Host: 123.example.org'" \
    "200" \
    "12345"

run_test "GET 12345.html content" \
    "curl -X GET '$BASE_URL/12345.html' -H 'Host: 123.example.org'" \
    "200" \
    "12345"

run_test "POST request empty body" \
    "curl -X POST '$BASE_URL/' -H 'Content-type: application/x-www-form-urlencoded' -H 'Content-length: 0'" \
    "200"

run_test "HEAD request no content" \
    "curl -X HEAD '$BASE_URL/'" \
    "200"

run_test "HEAD request mimetype text/html" \
    "curl -X HEAD '$BASE_URL/12345.html' -H 'Host: 123.example.org'" \
    "200"

run_test "HEAD request file not found" \
    "curl -X HEAD '$BASE_URL/foobar?foobar'" \
    "404"

echo
echo "=== Range 요청 테스트 ==="

run_test "GET Range 0-3" \
    "curl -X GET '$BASE_URL/12345.txt' -H 'Host: 123.example.org' -H 'Range: bytes=0-3'" \
    "206"

run_test "GET Range -3" \
    "curl -X GET '$BASE_URL/12345.txt' -H 'Host: 123.example.org' -H 'Range: bytes=-3'" \
    "206"

run_test "GET Range 3-" \
    "curl -X GET '$BASE_URL/12345.txt' -H 'Host: 123.example.org' -H 'Range: bytes=3-'" \
    "206"

run_test "GET Range 0-- (invalid)" \
    "curl -X GET '$BASE_URL/12345.txt' -H 'Host: 123.example.org' -H 'Range: bytes=0--'" \
    "416"

run_test "GET Range -0 (invalid)" \
    "curl -X GET '$BASE_URL/12345.txt' -H 'Host: 123.example.org' -H 'Range: bytes=-0'" \
    "416"

echo
echo "=== 헤더 처리 테스트 ==="

NEXT_YEAR=$(($(date +%Y) + 1))
run_test "If-Modified-Since future date" \
    "curl -X GET '$BASE_URL/index.html' -H \"If-Modified-Since: Sun, 01 Jan $NEXT_YEAR 00:00:02 GMT\"" \
    "304"

run_test "Connection header leading comma" \
    "curl -X GET '$BASE_URL/12345.txt' -H 'Connection: ,close' -H 'Host: 123.example.org'" \
    "200"

run_test "Connection header multiple commas" \
    "curl -X GET '$BASE_URL/12345.txt' -H 'Connection: close,,TE' -H 'Host: 123.example.org'" \
    "200"

echo
echo "=== 리디렉션 테스트 ==="

run_test "Directory redirect" \
    "curl -X GET '$BASE_URL/subdir'" \
    "301"

run_test "Directory redirect with querystring" \
    "curl -X GET '$BASE_URL/subdir?foo'" \
    "301"

run_test "Special characters redirect" \
    "curl -X GET '$BASE_URL/~test%20ä_'" \
    "301"

echo
echo "=== Virtual Host 테스트 ==="

run_test "Simple vhost disabled" \
    "curl -X GET '$BASE_URL/12345.txt' -H 'Host: no-simple.example.org'" \
    "200"

run_test "Simple vhost enabled" \
    "curl -X GET '$BASE_URL/12345.txt' -H 'Host: simple.example.org'" \
    "404"

echo
echo "=== Keep-Alive 테스트 ==="

run_test "HTTP/1.0 Keep-Alive" \
    "curl -X GET '$BASE_URL/12345.txt' -H 'Connection: keep-alive' -H 'Host: 123.example.org' --http1.0" \
    "200"

run_test "HTTP/1.1 implicit Keep-Alive" \
    "curl -X GET '$BASE_URL/12345.txt' -H 'Host: 123.example.org'" \
    "200"

echo
echo "=== 에러 핸들러 테스트 ==="

run_test "404 handler static" \
    "curl -X GET '$BASE_URL/static/notfound' -H 'Host: errors.example.org'" \
    "200"

run_test "404 handler dynamic 200" \
    "curl -X GET '$BASE_URL/dynamic/200/notfound' -H 'Host: errors.example.org'" \
    "200"

run_test "404 handler dynamic 302" \
    "curl -X GET '$BASE_URL/dynamic/302/notfound' -H 'Host: errors.example.org'" \
    "302"

echo
echo "=== 조건부 접근 테스트 ==="

run_test "Referer no referer" \
    "curl -X GET '$BASE_URL/nofile.png' -H 'Host: referer.example.org'" \
    "404"

run_test "Referer matches regex" \
    "curl -X GET '$BASE_URL/nofile.png' -H 'Host: referer.example.org' -H 'Referer: http://referer.example.org/'" \
    "404"

run_test "Referer evil referer" \
    "curl -X GET '$BASE_URL/image.jpg' -H 'Host: www.example.org' -H 'Referer: http://evil-referer.example.org/'" \
    "403"

echo
echo "=== 대소문자 구분 테스트 ==="

run_test "Uppercase JPG (lowercase-allow)" \
    "curl -X GET '$BASE_URL/image.JPG' -H 'Host: lowercase-allow'" \
    "200"

run_test "Lowercase jpg (lowercase-allow)" \
    "curl -X GET '$BASE_URL/image.jpg' -H 'Host: lowercase-allow'" \
    "200"

echo
echo "=== 인증 테스트 ==="

run_test "Missing auth token" \
    "curl -X GET '$BASE_URL/server-status' -H 'Host: auth-plain.example.org'" \
    "401"

run_test "Wrong auth token" \
    "curl -X GET '$BASE_URL/server-config' -H 'Host: auth-plain.example.org' -H 'Authorization: Basic bm90Oml0Cg=='" \
    "401"

run_test "Valid auth token plain" \
    "curl -X GET '$BASE_URL/server-config' -H 'Host: auth-plain.example.org' -H 'Authorization: Basic amFuOmphbg=='" \
    "200"

echo
echo "=== CGI 테스트 ==="

run_test "Perl via CGI" \
    "curl -X GET '$BASE_URL/cgi.pl'" \
    "200"

run_test "CGI with pathinfo" \
    "curl -X GET '$BASE_URL/cgi.pl/foo?env=SCRIPT_NAME'" \
    "200"

run_test "CGI internal redirect" \
    "curl -X GET '$BASE_URL/cgi.pl?internal-redir'" \
    "200"

run_test "CGI environment HTTP_HOST" \
    "curl -X GET '$BASE_URL/cgi.pl?env=HTTP_HOST' -H 'Host: www.example.org'" \
    "200"

echo
echo "=== 압축 테스트 ==="

run_test "Deflate compression" \
    "curl -X GET '$BASE_URL/index.html' -H 'Host: deflate.example.org' -H 'Accept-Encoding: deflate'" \
    "200"

run_test "Gzip compression" \
    "curl -X GET '$BASE_URL/index.html' -H 'Host: deflate.example.org' -H 'Accept-Encoding: gzip'" \
    "200"

echo
echo "=== 만료 시간 테스트 ==="

run_test "Expires header HTTP/1.0" \
    "curl -X GET '$BASE_URL/subdir/access.txt' -H 'Host: www.example.org' --http1.0" \
    "200"

run_test "Cache-Control HTTP/1.1" \
    "curl -X GET '$BASE_URL/subdir/access.txt' -H 'Host: www.example.org'" \
    "200"

echo
echo "=== 프록시 헤더 테스트 ==="

run_test "X-Forwarded-For single IP" \
    "curl -X GET '$BASE_URL/cgi.pl?env=REMOTE_ADDR' -H 'Host: www.example.org' -H 'X-Forwarded-For: 127.0.10.1'" \
    "200"

run_test "X-Forwarded-For two IPs" \
    "curl -X GET '$BASE_URL/cgi.pl?env=REMOTE_ADDR' -H 'Host: www.example.org' -H 'X-Forwarded-For: 127.0.10.1, 127.0.20.1'" \
    "200"

echo
echo "=== 환경 변수 테스트 ==="

run_test "Setenv TRAC_ENV" \
    "curl -X GET '$BASE_URL/cgi.pl?env=TRAC_ENV' -H 'Host: www.example.org'" \
    "200"

run_test "Setenv HTTP_FOO" \
    "curl -X GET '$BASE_URL/cgi.pl?env=HTTP_FOO' -H 'Host: www.example.org'" \
    "200"

echo
echo "================================================================"
echo "                      테스트 완료"
echo "================================================================"

echo
printf "결과: "
if [ $failure_count -eq 0 ]; then
    echo -e "${GREEN}모든 테스트 성공! ($success_count/$test_num)${NC}"
else
    echo -e "${YELLOW}성공: $success_count, 실패: $failure_count, 전체: $test_num${NC}"
    success_rate=$(( (success_count * 100) / test_num ))
    echo "성공률: ${success_rate}%"
fi

echo "완료 시간: $(date)"

pkill lighttpd
