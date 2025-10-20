-- SQLite 포괄적 테스트 SQL 스크립트
-- Pin으로 SQLite 함수 호출 추적을 위한 종합 테스트

-- ===========================================
-- 1. 기본 연결 및 버전 테스트
-- ===========================================
SELECT 'Hello SQLite' AS greeting;

-- ===========================================
-- 2. DDL (Data Definition Language) 테스트
-- ===========================================

-- 2.1 테이블 생성
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    age INTEGER CHECK (age > 0)
);

-- 2.2 인덱스 생성
CREATE INDEX idx_users_email ON users(email);
CREATE UNIQUE INDEX idx_users_username ON users(username);

-- 2.3 뷰 생성
CREATE VIEW user_summary AS 
SELECT username, email, 
       datetime(created_at, 'localtime') as local_created_at
FROM users;

-- ===========================================
-- 3. DML (Data Manipulation Language) 테스트
-- ===========================================

-- 3.1 데이터 삽입
INSERT INTO users (username, email, age) VALUES 
('alice', 'alice@example.com', 25),
('bob', 'bob@example.com', 30),
('charlie', 'charlie@example.com', 22);

-- 3.2 조건부 삽입
INSERT OR IGNORE INTO users (username, email, age) VALUES 
('alice', 'alice2@example.com', 26);

-- 3.3 데이터 조회
SELECT COUNT(*) as user_count FROM users;

SELECT username FROM users WHERE age > 25 ORDER BY username;

-- 3.4 데이터 업데이트
UPDATE users SET age = 26 WHERE username = 'alice';
SELECT age FROM users WHERE username = 'alice';

-- 3.5 데이터 삭제
DELETE FROM users WHERE username = 'charlie';
SELECT COUNT(*) FROM users;

-- ===========================================
-- 4. 고급 SQL 기능 테스트
-- ===========================================

-- 4.1 관계형 테이블 생성
CREATE TABLE posts (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    title TEXT NOT NULL,
    content TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO posts (user_id, title, content) VALUES
(1, 'First Post', 'Hello World'),
(1, 'Second Post', 'SQLite is great'),
(2, 'Bob Post', 'Testing joins');

-- 4.2 JOIN 테스트
SELECT u.username, p.title 
FROM users u 
INNER JOIN posts p ON u.id = p.user_id 
ORDER BY u.username, p.title;

-- 4.3 집계 함수
SELECT u.username, COUNT(p.id) as post_count
FROM users u 
LEFT JOIN posts p ON u.id = p.user_id
GROUP BY u.id, u.username
ORDER BY post_count DESC;

-- 4.4 서브쿼리
SELECT username FROM users 
WHERE id IN (SELECT user_id FROM posts WHERE title LIKE '%Post%');

-- ===========================================
-- 5. 트랜잭션 테스트
-- ===========================================

-- 5.1 커밋 트랜잭션
BEGIN TRANSACTION;
INSERT INTO users (username, email, age) VALUES ('david', 'david@example.com', 28);
COMMIT;
SELECT COUNT(*) FROM users;

-- 5.2 롤백 트랜잭션
BEGIN TRANSACTION;
INSERT INTO users (username, email, age) VALUES ('eve', 'eve@example.com', 24);
ROLLBACK;
SELECT COUNT(*) FROM users;

-- ===========================================
-- 6. SQLite 특수 기능 테스트
-- ===========================================

-- 6.1 JSON 기본 함수들
SELECT 
    json_object('name', 'Alice', 'age', 25, 'active', 1) as json_obj,
    json_array('apple', 'banana', 'cherry') as json_arr,
    json_type('123') as number_type,
    json_type('"hello"') as string_type;

-- 6.2 날짜/시간 함수들
SELECT 
    date('now') as current_date,
    time('now') as current_time,
    datetime('now') as current_datetime,
    strftime('%Y-%m-%d %H:%M', 'now') as formatted_time,
    julianday('now') as julian_day,
    date('now', '+1 month', '-1 day') as next_month_minus_day,
    unixepoch('now') as unix_timestamp;

-- 6.3 날짜 계산 및 변환
WITH test_dates AS (
    SELECT '2024-01-15' as start_date, '2024-03-20' as end_date
)
SELECT 
    julianday(end_date) - julianday(start_date) as days_between,
    date(start_date, '+45 days') as plus_45_days,
    strftime('%w', start_date) as day_of_week,
    strftime('%j', start_date) as day_of_year
FROM test_dates;

-- 6.4 문자열 함수들
SELECT 
    length('SQLite 함수 테스트') as str_length,
    upper('sqlite') as uppercase,
    lower('SQLITE') as lowercase,
    substr('SQLite Database', 1, 6) as substring,
    instr('SQLite Database', 'Data') as position,
    replace('Hello World', 'World', 'SQLite') as replaced,
    trim('  spaces  ') as trimmed,
    ltrim('  left spaces') as left_trimmed,
    rtrim('right spaces  ') as right_trimmed;

-- 6.5 고급 문자열 함수
SELECT 
    printf('Number: %d, String: %s', 42, 'test') as formatted,
    quote('It''s a test') as quoted,
    hex('SQLite') as hex_encoded,
    unhex('53514C697465') as hex_decoded,
    unicode('A') as unicode_value,
    char(65, 66, 67) as chars_from_codes;

-- 6.6 수학 함수들
SELECT 
    abs(-42.5) as absolute,
    round(3.14159) as rounded_default,
    round(3.14159, 3) as rounded_3_places,
    ceil(3.2) as ceiling,
    floor(3.8) as floor_val,
    sign(-15) as sign_negative,
    sign(0) as sign_zero,
    sign(15) as sign_positive,
    sqrt(16) as square_root,
    pow(2, 3) as power;

-- 6.7 삼각함수 및 로그
SELECT 
    sin(0) as sine_zero,
    cos(0) as cosine_zero,
    tan(0) as tangent_zero,
    asin(0) as arcsine_zero,
    acos(1) as arccosine_one,
    atan(0) as arctangent_zero,
    ln(2.718281828) as natural_log,
    log10(100) as log_base_10,
    exp(1) as exponential;

-- 6.8 집계 함수들
CREATE TEMP TABLE numbers (value INTEGER);
INSERT INTO numbers VALUES (1), (2), (3), (4), (5), (10), (15), (20);
SELECT 
    COUNT(*) as total_count,
    COUNT(DISTINCT value) as distinct_count,
    SUM(value) as sum_all,
    AVG(value) as average,
    MIN(value) as minimum,
    MAX(value) as maximum,
    total(value) as total_func,
    group_concat(value, ',') as concatenated
FROM numbers;

-- 6.9 윈도우 함수들 (SQLite 3.25+)
WITH sales_data AS (
    SELECT 'Jan' as month, 100 as amount UNION ALL
    SELECT 'Feb', 150 UNION ALL
    SELECT 'Mar', 120 UNION ALL
    SELECT 'Apr', 200 UNION ALL
    SELECT 'May', 180
)
SELECT 
    month,
    amount,
    row_number() OVER (ORDER BY amount) as row_num,
    rank() OVER (ORDER BY amount DESC) as rank_desc,
    dense_rank() OVER (ORDER BY amount DESC) as dense_rank_desc,
    lag(amount, 1) OVER (ORDER BY month) as prev_amount,
    lead(amount, 1) OVER (ORDER BY month) as next_amount,
    sum(amount) OVER (ORDER BY month ROWS UNBOUNDED PRECEDING) as running_sum
FROM sales_data;

-- 6.10 패턴 매칭 함수
SELECT 
    'test@example.com' LIKE '%@%.%' as email_like,
    'SQLite' GLOB 'SQL*' as glob_match,
    'Hello123World' GLOB '*[0-9]*' as contains_digit,
    'abc' BETWEEN 'a' AND 'z' as between_test;

-- 6.11 조건부 및 NULL 처리 함수
SELECT 
    CASE 
        WHEN 10 > 5 THEN 'Greater'
        WHEN 10 = 5 THEN 'Equal'
        ELSE 'Less'
    END as case_result,
    IIF(10 > 5, 'True', 'False') as iif_result,
    COALESCE(NULL, NULL, 'Default') as coalesce_result,
    IFNULL(NULL, 'Replacement') as ifnull_result,
    NULLIF('same', 'same') as nullif_same,
    NULLIF('different', 'other') as nullif_different;

-- 6.12 타입 변환 함수
SELECT 
    CAST('123' AS INTEGER) as string_to_int,
    CAST(123.456 AS INTEGER) as float_to_int,
    CAST(123 AS REAL) as int_to_float,
    CAST(123.456 AS TEXT) as float_to_text,
    typeof('123') as string_type,
    typeof(123) as integer_type,
    typeof(123.456) as real_type,
    typeof(NULL) as null_type;

-- 6.13 인코딩 함수
SELECT 
    hex('Hello') as hex_encoding,
    randomblob(8) as random_data,
    length('Hello 世界') as utf8_length;

-- 6.14 메타데이터 함수
SELECT 
    sqlite_version() as sqlite_version,
    sqlite_source_id() as source_id,
    last_insert_rowid() as last_rowid,
    changes() as last_changes,
    total_changes() as total_changes;

-- 6.15 FTS (Full Text Search) 테스트
CREATE VIRTUAL TABLE IF NOT EXISTS docs USING fts5(title, content);
INSERT INTO docs VALUES 
('SQLite Tutorial', 'Learning SQLite database basics'),
('Advanced SQL', 'Complex queries and optimization'),
('Database Design', 'Normalization and relationships');
SELECT title FROM docs WHERE docs MATCH 'SQLite';

-- ===========================================
-- 7. 성능 및 최적화 테스트
-- ===========================================

-- 7.1 쿼리 실행 계획
EXPLAIN QUERY PLAN SELECT * FROM users WHERE username = 'alice';

-- 7.2 통계 수집
ANALYZE;

-- 7.3 데이터베이스 최적화
VACUUM;

-- ===========================================
-- 8. 메타 정보 테스트
-- ===========================================

-- 8.1 스키마 정보
SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;

-- 8.2 인덱스 정보
SELECT name FROM sqlite_master WHERE type='index' ORDER BY name;

-- 8.3 데이터베이스 정보
PRAGMA database_list;
PRAGMA table_info(users);

-- ===========================================
-- 9. 제약조건 테스트 (의도적 오류)
-- ===========================================

-- 이 섹션의 쿼리들은 의도적으로 오류를 발생시켜 제약조건을 테스트합니다
-- 실제 실행 시 오류가 예상됩니다

-- UNIQUE 제약조건 위반 (주석 처리)
-- INSERT INTO users (username, email, age) VALUES ('alice', 'alice3@example.com', 27);

-- CHECK 제약조건 위반 (주석 처리)  
-- INSERT INTO users (username, email, age) VALUES ('frank', 'frank@example.com', -5);

-- NOT NULL 제약조건 위반 (주석 처리)
-- INSERT INTO users (username, email, age) VALUES (NULL, 'null@example.com', 25);

-- ===========================================
-- 10. 정리
-- ===========================================

-- 뷰 삭제
DROP VIEW IF EXISTS user_summary;

-- 인덱스 삭제
DROP INDEX IF EXISTS idx_users_email;

-- 테이블 삭제
DROP TABLE IF EXISTS docs;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS users;

-- 테스트 완료 메시지
SELECT 'SQLite 포괄적 테스트 완료!' as message;
