#!/usr/bin/env bash
set -euo pipefail

REDIS_SERVER="${REDIS_SERVER:-./redis-server_origin}"
REDIS_CLI="${REDIS_CLI:-./redis-cli}"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

# 포트 탐색
find_free_port() {
  local p=${1:-6380}
  while ss -lnt 2>/dev/null | awk '{print $4}' | grep -q ":$p$"; do
    p=$((p+1))
  done
  echo "$p"
}
PORT="${PORT:-$(find_free_port 6380)}"

# 임시 작업 디렉터리
WORKDIR="$(mktemp -d -t redis-test-XXXXXX)"
DATA_DIR="$WORKDIR/data"
LOG_FILE="$WORKDIR/redis.log"
CONF_FILE="$WORKDIR/redis.conf"  # 추가
mkdir -p "$DATA_DIR"

# 임시 설정 파일 생성
cat > "$CONF_FILE" << EOF
port $PORT
bind 127.0.0.1
daemonize yes
save ""
appendonly no
dir $DATA_DIR
logfile $LOG_FILE
EOF

# 종료/정리
cleanup() {
  if "$REDIS_CLI" -p "$PORT" PING >/dev/null 2>&1; then
    "$REDIS_CLI" -p "$PORT" SHUTDOWN NOSAVE >/dev/null 2>&1 || true
  fi
  sleep 0.2
  rm -rf "$WORKDIR"
}
trap cleanup EXIT

echo "================================================"
echo "Redis 통합 테스트 시작"
echo "Workdir: $WORKDIR"
echo "Port   : $PORT"
echo "================================================"
echo ""

# 서버 실행
if [ ! -x "$REDIS_SERVER" ]; then
  echo -e "${RED}에러:${NC} REDIS_SERVER 실행 파일을 찾을 수 없습니다: $REDIS_SERVER"
  exit 1
fi

# 설정 파일로 실행
"$REDIS_SERVER" "$CONF_FILE"

# ---------- 준비 상태 대기 ----------
# echo -n "서버 준비 대기(PING) "
for i in $(seq 1 60); do
  if "$REDIS_CLI" -p "$PORT" PING >/dev/null 2>&1; then
    # echo -e " → ${GREEN}OK${NC}"
    break
  fi
  sleep 0.25
  if [ "$i" -eq 60 ]; then
    # echo -e " → ${RED}TIMEOUT${NC}"
    # echo "로그 확인: $LOG_FILE"
    exit 1
  fi
done
# echo ""

# ---------- 테스트 헬퍼 ----------
TOTAL=0
PASS=0
FAIL=0

# 여러 명령을 한 번에 넘길 수 있도록:
#  - 인자로 받은 문자열에서 ';' 또는 줄바꿈을 명령 구분자로 사용
#  - redis-cli에는 개행으로 파이프 전달
_run_redis() {
  local cmds="$1"
  # 세미콜론을 줄바꿈으로 변환 (따옴표 내부 세미콜론까지 바꾸는 단순 전략)
#   cmds="${cmds//;/\n}"
  # 실제 실행
  # --raw: 결과 가독성 향상, 실패 판단은 exit code와 '(error)' 문자열로 병행
  local out
  if ! out=$(printf "%b\n" "$cmds" | "$REDIS_CLI" -p "$PORT" --raw 2>&1); then
    # echo "$out"
    return 1
  fi
  # echo "$out"
  # redis가 에러를 문자열로 반환하는 경우
  if grep -qiE '^\(error\)|^ERR ' <<<"$out"; then
    return 2
  fi
  return 0
}

run_test() {
  local section="$1"; shift
  local description="$1"; shift
  local command="$*"

  TOTAL=$((TOTAL+1))
  # echo -e "${YELLOW}[${section}]${NC} ${description}"
  # echo "  명령어:"
  # echo "  $command" | sed 's/^/    /'
  local output
  if output=$(_run_redis "$command"); then
    # echo -e "  결과:\n$(sed 's/^/    /' <<<"$output")"
    # echo -e "  ${GREEN}✔ PASS${NC}\n"
    PASS=$((PASS+1))
  else
    local rc=$?
    # echo -e "  결과:\n$(sed 's/^/    /' <<<"$output")"
    # echo -e "  ${RED}✘ FAIL${NC} (rc=$rc)\n"
    FAIL=$((FAIL+1))
  fi
}

# ---------- 여기부터: 사용자가 올린 원본 테스트들을 최대한 유지 ----------
# echo "================================================"
# echo "1. 기본 연결 및 버전 테스트"
# echo "================================================"
run_test "1.1" "PING 테스트" "PING"
run_test "1.2" "서버 정보" "INFO server"
run_test "1.3" "# echo 테스트" "# echo 'Hello Redis'"

# echo "================================================"
# echo "2. 데이터베이스 관리"
# echo "================================================"
run_test "2.1" "DB 선택" "SELECT 1"
run_test "2.2" "DB 크기 확인" "DBSIZE"
run_test "2.3" "모든 키 조회" "KEYS *"
run_test "2.4" "현재 DB 정보" "INFO keyspace"
_run_redis "SELECT 0\nFLUSHDB" >/dev/null

# echo "================================================"
# echo "3. String 데이터 타입"
# echo "================================================"
run_test "3.1" "SET/GET" "SET user:1:name 'Alice'\nGET user:1:name"
run_test "3.3" "APPEND" "APPEND user:1:name ' Smith'"
run_test "3.4" "STRLEN" "STRLEN user:1:name"
run_test "3.5" "GETRANGE" "GETRANGE user:1:name 0 4"
run_test "3.6" "SETRANGE" "SETRANGE user:1:name 0 'Bob'"
run_test "3.7" "MSET 다중 설정" "MSET key1 'value1' key2 'value2' key3 'value3'"
run_test "3.8" "MGET 다중 조회" "MGET key1 key2 key3"
run_test "3.9" "SETNX" "SETNX newkey 'newvalue'"
run_test "3.10" "SETEX" "SETEX tempkey 10 'temporary'"
run_test "3.11" "INCR" "SET counter 10\nINCR counter"
run_test "3.12" "INCRBY" "INCRBY counter 5"
run_test "3.13" "DECR" "DECR counter"
run_test "3.14" "DECRBY" "DECRBY counter 3"
run_test "3.15" "INCRBYFLOAT" "SET score 10.5\nINCRBYFLOAT score 2.3"

# echo "================================================"
# echo "4. List 데이터 타입"
# echo "================================================"
run_test "4.1" "LPUSH" "LPUSH mylist 'third' 'second' 'first'"
run_test "4.2" "RPUSH" "RPUSH mylist 'fourth' 'fifth'"
run_test "4.3" "LRANGE" "LRANGE mylist 0 -1"
run_test "4.4" "LLEN" "LLEN mylist"
run_test "4.5" "LINDEX" "LINDEX mylist 0"
run_test "4.6" "LPOP" "LPOP mylist"
run_test "4.7" "RPOP" "RPOP mylist"
run_test "4.8" "LSET" "LSET mylist 0 'updated'"
run_test "4.9" "LINSERT" "LINSERT mylist BEFORE 'updated' 'new'"
run_test "4.10" "LTRIM" "LTRIM mylist 0 2"
run_test "4.11" "RPOPLPUSH" "RPUSH list1 'a' 'b' 'c'\nRPOPLPUSH list1 list2"

# echo "================================================"
# echo "5. Set 데이터 타입"
# echo "================================================"
run_test "5.1" "SADD" "SADD myset 'apple' 'banana' 'orange'"
run_test "5.2" "SMEMBERS" "SMEMBERS myset"
run_test "5.3" "SCARD" "SCARD myset"
run_test "5.4" "SISMEMBER" "SISMEMBER myset 'apple'"
run_test "5.5" "SREM" "SREM myset 'banana'"
run_test "5.6" "SPOP" "SPOP myset"
run_test "5.7" "SRANDMEMBER" "SRANDMEMBER myset"
run_test "5.8" "집합 연산 준비" "SADD set1 'a' 'b' 'c'\nSADD set2 'b' 'c' 'd'"
run_test "5.9" "SUNION" "SUNION set1 set2"
run_test "5.10" "SINTER" "SINTER set1 set2"
run_test "5.11" "SDIFF" "SDIFF set1 set2"
run_test "5.12" "SUNIONSTORE" "SUNIONSTORE set3 set1 set2\nSMEMBERS set3"

# echo "================================================"
# echo "6. Hash 데이터 타입"
# echo "================================================"
run_test "6.1" "HSET" "HSET user:1 name 'Alice' age '25' email 'alice@example.com'"
run_test "6.2" "HGET" "HGET user:1 name"
run_test "6.3" "HGETALL" "HGETALL user:1"
run_test "6.4" "HMSET" "HMSET user:2 name 'Bob' age '30' email 'bob@example.com'"
run_test "6.5" "HMGET" "HMGET user:2 name age"
run_test "6.6" "HKEYS" "HKEYS user:1"
run_test "6.7" "HVALS" "HVALS user:1"
run_test "6.8" "HLEN" "HLEN user:1"
run_test "6.9" "HEXISTS" "HEXISTS user:1 name"
run_test "6.10" "HDEL" "HDEL user:1 email"
run_test "6.11" "HINCRBY" "HINCRBY user:1 age 1"
run_test "6.12" "HINCRBYFLOAT" "HSET product:1 price 19.99\nHINCRBYFLOAT product:1 price 5.01"

# echo "================================================"
# echo "7. Sorted Set 데이터 타입"
# echo "================================================"
run_test "7.1" "ZADD" "ZADD leaderboard 100 'Alice' 85 'Bob' 92 'Charlie'"
run_test "7.2" "ZRANGE" "ZRANGE leaderboard 0 -1"
run_test "7.3" "ZRANGE WITHSCORES" "ZRANGE leaderboard 0 -1 WITHSCORES"
run_test "7.4" "ZREVRANGE" "ZREVRANGE leaderboard 0 -1 WITHSCORES"
run_test "7.5" "ZRANK" "ZRANK leaderboard 'Bob'"
run_test "7.6" "ZREVRANK" "ZREVRANK leaderboard 'Bob'"
run_test "7.7" "ZSCORE" "ZSCORE leaderboard 'Alice'"
run_test "7.8" "ZCARD" "ZCARD leaderboard"
run_test "7.9" "ZCOUNT" "ZCOUNT leaderboard 85 100"
run_test "7.10" "ZINCRBY" "ZINCRBY leaderboard 10 'Bob'"
run_test "7.11" "ZREM" "ZREM leaderboard 'Charlie'"
run_test "7.12" "ZRANGEBYSCORE" "ZADD ages 25 'Alice' 30 'Bob' 22 'Charlie'\nZRANGEBYSCORE ages 20 28"

# echo "================================================"
# echo "8. 키 관리 및 만료"
# echo "================================================"
run_test "8.1" "EXISTS" "EXISTS user:1"
run_test "8.2" "TYPE" "TYPE user:1"
run_test "8.3" "EXPIRE" "SET tempkey 'value'\nEXPIRE tempkey 60"
run_test "8.4" "TTL" "TTL tempkey"
run_test "8.5" "PERSIST" "PERSIST tempkey"
run_test "8.6" "RENAME" "SET oldkey 'value'\nRENAME oldkey newkey"
run_test "8.7" "RENAMENX" "RENAMENX newkey anotherkey"
run_test "8.8" "DEL" "DEL anotherkey"
run_test "8.9" "KEYS 패턴" "SET user:1:name 'A'\nSET user:2:name 'B'\nKEYS 'user:*'"
run_test "8.10" "SCAN" "SCAN 0 MATCH user:* COUNT 10"
run_test "8.11" "RANDOMKEY" "RANDOMKEY"

# echo "================================================"
# echo "9. 트랜잭션"
# echo "================================================"
# MULTI/EXEC는 별도로 처리
_run_redis "MULTI\nSET tx:key1 value1\nSET tx:key2 value2\nINCR tx:counter\nEXEC" >/dev/null && \
  # echo -e "${YELLOW}[9.1]${NC} MULTI/EXEC 트랜잭션  ${GREEN}✔ PASS${NC}" || \
  # echo -e "${YELLOW}[9.1]${NC} MULTI/EXEC 트랜잭션  ${RED}✘ FAIL${NC}"
run_test "9.2" "트랜잭션 결과 확인" "MGET tx:key1 tx:key2 tx:counter"

_run_redis "MULTI\nSET discard:key value\nDISCARD" >/dev/null && \
  # echo -e "${YELLOW}[9.3]${NC} DISCARD (취소)         ${GREEN}✔ PASS${NC}" || \
  # echo -e "${YELLOW}[9.3]${NC} DISCARD (취소)         ${RED}✘ FAIL${NC}"
run_test "9.4" "DISCARD 결과 확인" "GET discard:key"

# echo "================================================"
# echo "10. Pub/Sub"
# echo "================================================"
run_test "10.1" "PUBLISH 메시지" "PUBLISH mychannel 'Hello Redis'"
run_test "10.2" "PUBSUB CHANNELS" "PUBSUB CHANNELS"
run_test "10.3" "PUBSUB NUMSUB" "PUBSUB NUMSUB mychannel"

# echo "================================================"
# echo "11. Lua 스크립팅"
# echo "================================================"
run_test "11.1" "EVAL 기본" "EVAL 'return {KEYS[1], ARGV[1]}' 1 mykey myvalue"
run_test "11.2" "EVAL 연산" "EVAL 'return 1 + 1' 0"
run_test "11.3" "EVAL Redis 명령" "EVAL \"redis.call('SET','lua:key','lua:value'); return redis.call('GET','lua:key')\" 0"
run_test "11.4" "SCRIPT LOAD" "SCRIPT LOAD 'return redis.call(\"GET\", KEYS[1])'"

# echo "================================================"
# echo "12. HyperLogLog"
# echo "================================================"
run_test "12.1" "PFADD" "PFADD visitors 'user1' 'user2' 'user3'"
run_test "12.2" "PFCOUNT" "PFCOUNT visitors"
run_test "12.3" "PFADD 더 추가" "PFADD visitors 'user4' 'user5'"
run_test "12.4" "PFCOUNT 재확인" "PFCOUNT visitors"
run_test "12.5" "PFMERGE" "PFADD hll1 'a' 'b'\nPFADD hll2 'b' 'c'\nPFMERGE hll3 hll1 hll2\nPFCOUNT hll3"

# echo "================================================"
# echo "13. Bitmap"
# echo "================================================"
run_test "13.1" "SETBIT" "SETBIT mybitmap 0 1"
run_test "13.2" "GETBIT" "GETBIT mybitmap 0"
run_test "13.3" "SETBIT 여러 개" "SETBIT mybitmap 1 1\nSETBIT mybitmap 3 1\nSETBIT mybitmap 5 1"
run_test "13.4" "BITCOUNT" "BITCOUNT mybitmap"
run_test "13.5" "BITPOS" "BITPOS mybitmap 1"
run_test "13.6" "BITOP AND" "SETBIT bm1 0 1\nSETBIT bm2 0 1\nBITOP AND result bm1 bm2"

# echo "================================================"
# echo "14. Geospatial"
# echo "================================================"
run_test "14.1" "GEOADD" "GEOADD cities 126.9780 37.5665 Seoul 139.6917 35.6895 Tokyo"
run_test "14.2" "GEOPOS" "GEOPOS cities Seoul"
run_test "14.3" "GEODIST" "GEODIST cities Seoul Tokyo km"
run_test "14.4" "GEORADIUS" "GEORADIUS cities 127 37 500 km"
run_test "14.5" "GEOHASH" "GEOHASH cities Seoul Tokyo"

# echo "================================================"
# echo "15. Stream"
# echo "================================================"
run_test "15.1" "XADD" "XADD mystream * field1 value1 field2 value2"
run_test "15.2" "XLEN" "XLEN mystream"
run_test "15.3" "XRANGE" "XRANGE mystream - +"
run_test "15.4" "XADD 더 추가" "XADD mystream * sensor temp temperature 25.5"
run_test "15.5" "XREAD" "XREAD COUNT 2 STREAMS mystream 0"

# echo "================================================"
# echo "16. 서버 정보 및 통계"
# echo "================================================"
run_test "16.1" "INFO stats" "INFO stats"
run_test "16.2" "INFO memory" "INFO memory"
run_test "16.3" "INFO cpu" "INFO cpu"
run_test "16.4" "INFO replication" "INFO replication"
run_test "16.5" "INFO clients" "INFO clients"
run_test "16.6" "DBSIZE" "DBSIZE"
run_test "16.7" "LASTSAVE" "LASTSAVE"
run_test "16.8" "TIME" "TIME"

# echo "================================================"
# echo "17. 설정 관리"
# echo "================================================"
run_test "17.1" "CONFIG GET maxmemory" "CONFIG GET maxmemory"
run_test "17.2" "CONFIG GET timeout" "CONFIG GET timeout"
run_test "17.3" "CONFIG SET" "CONFIG SET timeout 300"
run_test "17.4" "CONFIG RESETSTAT" "CONFIG RESETSTAT"

# echo "================================================"
# echo "18. 슬로우 로그"
# echo "================================================"
run_test "18.1" "SLOWLOG GET" "SLOWLOG GET 10"
run_test "18.2" "SLOWLOG LEN" "SLOWLOG LEN"
run_test "18.3" "SLOWLOG RESET" "SLOWLOG RESET"

# echo "================================================"
# echo "19. 클라이언트 관리"
# echo "================================================"
run_test "19.1" "CLIENT LIST" "CLIENT LIST"
run_test "19.2" "CLIENT GETNAME" "CLIENT GETNAME"
run_test "19.3" "CLIENT SETNAME" "CLIENT SETNAME test_client"
run_test "19.4" "CLIENT ID" "CLIENT ID"

# echo "================================================"
# echo "20. 영속성 제어"
# echo "================================================"
run_test "20.1" "SAVE" "SAVE"
run_test "20.2" "BGSAVE" "BGSAVE"
run_test "20.3" "LASTSAVE" "LASTSAVE"
run_test "20.4" "BGREWRITEAOF" "BGREWRITEAOF"

# echo "================================================"
# echo "21. 고급 명령어"
# echo "================================================"
run_test "21.1" "SORT" "LPUSH numbers 3 1 2\nSORT numbers"
run_test "21.2" "SORT DESC" "SORT numbers DESC"
run_test "21.3" "SORT ALPHA" "LPUSH names 'charlie' 'alice' 'bob'\nSORT names ALPHA"
run_test "21.4" "SORT BY 패턴" "MSET weight_1 50 weight_2 30 weight_3 40\nLPUSH items 1 2 3\nSORT items BY weight_*"
run_test "21.5" "OBJECT ENCODING" "OBJECT ENCODING user:1"
run_test "21.6" "OBJECT REFCOUNT" "OBJECT REFCOUNT user:1"
run_test "21.7" "OBJECT IDLETIME" "OBJECT IDLETIME user:1"

# echo "================================================"
# echo "22. 메모리 분석"
# echo "================================================"
run_test "22.1" "MEMORY USAGE" "MEMORY USAGE user:1"
run_test "22.2" "MEMORY STATS" "MEMORY STATS"
run_test "22.3" "MEMORY DOCTOR" "MEMORY DOCTOR"

# echo "================================================"
# echo "23. 복제 관련"
# echo "================================================"
run_test "23.1" "ROLE" "ROLE"
run_test "23.2" "INFO replication" "INFO replication"

# echo "================================================"
# echo "24. 디버그 및 진단"
# echo "================================================"
run_test "24.1" "PING" "PING"
run_test "24.2" "# echo" "# echo 'test message'"
run_test "24.3" "COMMAND COUNT" "COMMAND COUNT"
run_test "24.4" "COMMAND INFO GET" "COMMAND INFO GET"

# echo "================================================"
# echo "25. 정리"
# echo "================================================"
run_test "25.1" "FLUSHDB" "FLUSHDB"
run_test "25.2" "DBSIZE 확인" "DBSIZE"

# ---------- 요약 & 서버 종료 ----------
# echo ""
# echo "================================================"
# echo "테스트 요약"
# echo "================================================"
# echo -e "총계: $TOTAL  ${GREEN}성공: $PASS${NC}  ${RED}실패: $FAIL${NC}"
# echo "로그 파일: $LOG_FILE"
# echo ""

# 정상 종료
"$REDIS_CLI" -p "$PORT" SHUTDOWN NOSAVE >/dev/null 2>&1 || true
sleep 0.2
# echo -e "${GREEN}모든 작업 완료.${NC}"
