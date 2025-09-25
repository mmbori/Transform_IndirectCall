#!/usr/bin/env python3
"""
fpNameDecl 파일들을 검사하여 선언이 완전히 찾아진 함수 포인터들만 추출
"// 선언을 찾을 수 없음:" 구문이 없는 fpName들을 target_fpNames.txt로 출력
"""

import os
import glob
import re

def check_fpname_declarations():
    """
    fpNameDecl 디렉토리의 파일들을 검사하여 
    선언이 완전히 찾아진 함수 포인터들만 추출
    """
    
    # fpNameDecl 디렉토리 존재 확인
    if not os.path.exists("fpNameDecl"):
        print("[ERROR] fpNameDecl 디렉토리가 존재하지 않습니다.")
        return []
    
    # fpNameDecl 디렉토리의 모든 .txt 파일 찾기
    decl_files = glob.glob("fpNameDecl/*.txt")
    
    if not decl_files:
        print("[ERROR] fpNameDecl 디렉토리에 .txt 파일이 없습니다.")
        return []
    
    complete_fp_names = []
    incomplete_fp_names = []
    
    print(f"[INFO] {len(decl_files)}개의 fpNameDecl 파일 검사 중...")
    
    for decl_file in decl_files:
        # 파일명에서 함수 포인터 이름 추출
        fp_name = os.path.splitext(os.path.basename(decl_file))[0]
        
        try:
            with open(decl_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # "// 선언을 찾을 수 없음:" 패턴 검색
            missing_pattern = re.compile(r'// 선언을 찾을 수 없음:', re.IGNORECASE)
            
            if missing_pattern.search(content):
                # 누락된 선언이 있는 경우
                incomplete_fp_names.append(fp_name)
                print(f"[INCOMPLETE] {fp_name}: 일부 선언 누락")
            else:
                # 모든 선언이 완전한 경우
                complete_fp_names.append(fp_name)
                print(f"[COMPLETE] {fp_name}: 모든 선언 완료")
                
        except Exception as e:
            print(f"[ERROR] 파일 읽기 실패 {decl_file}: {e}")
            continue
    
    print(f"\n[요약]")
    print(f"  완전한 선언: {len(complete_fp_names)}개")
    print(f"  불완전한 선언: {len(incomplete_fp_names)}개")
    
    return complete_fp_names

def save_target_fpnames(complete_fp_names):
    """
    완전한 함수 포인터 이름들을 target_fpNames.txt로 저장
    """
    if not complete_fp_names:
        print("[WARNING] 저장할 완전한 함수 포인터가 없습니다.")
        return
    
    try:
        with open("target_fpNames.txt", 'w', encoding='utf-8') as f:
            # f.write("# 선언이 완전히 찾아진 함수 포인터들\n")
            # f.write(f"# 총 {len(complete_fp_names)}개\n")
            # f.write(f"# 생성일시: {__import__('datetime').datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
            
            for fp_name in sorted(complete_fp_names):
                f.write(f"{fp_name}\n")
        
        print(f"[SUCCESS] target_fpNames.txt 생성 완료 ({len(complete_fp_names)}개 함수 포인터)")
        
    except Exception as e:
        print(f"[ERROR] target_fpNames.txt 저장 실패: {e}")

def show_detailed_analysis():
    """
    상세 분석 결과 표시
    """
    if not os.path.exists("fpNameDecl"):
        return
    
    decl_files = glob.glob("fpNameDecl/*.txt")
    total_fps = 0
    total_functions = 0
    missing_functions = 0
    
    print(f"\n=== 상세 분석 ===")
    
    for decl_file in decl_files:
        fp_name = os.path.splitext(os.path.basename(decl_file))[0]
        
        try:
            with open(decl_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # 선언 라인 수 계산 (주석 제외)
            lines = [line.strip() for line in content.split('\n') 
                    if line.strip() and not line.strip().startswith('#') 
                    and not line.strip().startswith('//')]
            
            # 함수 선언과 누락 선언 분리
            function_lines = [line for line in lines if line.endswith(';')]
            missing_lines = [line for line in lines if '선언을 찾을 수 없음:' in line]
            
            total_fps += 1
            total_functions += len(function_lines)
            missing_functions += len(missing_lines)
            
            if len(missing_lines) > 0:
                print(f"  {fp_name}: {len(function_lines)}개 완료, {len(missing_lines)}개 누락")
            
        except Exception as e:
            continue
    
    print(f"\n전체 통계:")
    print(f"  함수 포인터: {total_fps}개")
    print(f"  총 함수: {total_functions}개")
    print(f"  누락 함수: {missing_functions}개")
    print(f"  완성률: {((total_functions) / (total_functions + missing_functions) * 100):.1f}%")

def verify_fpname_files(complete_fp_names):
    """
    완전한 함수 포인터들의 fpName 파일도 존재하는지 확인
    """
    if not os.path.exists("fpName"):
        print("[WARNING] fpName 디렉토리가 존재하지 않습니다.")
        return
    
    print(f"\n=== fpName 파일 존재 확인 ===")
    
    missing_fpname_files = []
    
    for fp_name in complete_fp_names:
        fpname_file = f"fpName/{fp_name}.txt"
        if os.path.exists(fpname_file):
            try:
                with open(fpname_file, 'r', encoding='utf-8') as f:
                    functions = [line.strip() for line in f if line.strip()]
                print(f"  ✓ {fp_name}: {len(functions)}개 함수")
            except Exception as e:
                print(f"  ✗ {fp_name}: 파일 읽기 오류")
        else:
            missing_fpname_files.append(fp_name)
            print(f"  ✗ {fp_name}: fpName 파일 없음")
    
    if missing_fpname_files:
        print(f"\n[WARNING] {len(missing_fpname_files)}개 함수 포인터의 fpName 파일이 없습니다:")
        for fp_name in missing_fpname_files:
            print(f"  - {fp_name}")

def main():
    print("=== fpNameDecl 완성도 검사 및 target_fpNames.txt 생성 ===")
    
    # 1. fpNameDecl 파일들 검사
    complete_fp_names = check_fpname_declarations()
    
    # 2. target_fpNames.txt 저장
    save_target_fpnames(complete_fp_names)
    
    # 3. 상세 분석 표시
    show_detailed_analysis()
    
    # 4. fpName 파일 존재 확인
    if complete_fp_names:
        verify_fpname_files(complete_fp_names)
    
    print(f"\n=== 완료 ===")
    if complete_fp_names:
        print(f"target_fpNames.txt에 {len(complete_fp_names)}개의 완전한 함수 포인터가 저장되었습니다.")
        print("이 함수 포인터들은 변환 작업에 사용할 수 있습니다.")
    else:
        print("완전한 선언을 가진 함수 포인터가 없습니다.")
        print("먼저 함수 포인터 추적을 완료해야 합니다.")

if __name__ == "__main__":
    main()