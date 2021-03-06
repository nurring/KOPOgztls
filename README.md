# TLS 디바이스 리포트 & 모니터링 프로그램

## 목차

+ 기본 사양
+ 설치하기
+ 프로그램 상세

## 기본 사양

이 프로그램은 ubuntu 16.04 에 맞추어 설계되었습니다.  
이하 버전에서는 충돌이 발생할 수 있으니 해당 운영체제 버전에 맞추어 설치하시길 권장 드립니다.

## 설치하기

1. 해당 패키지에 포함 된 tlsinstall.tar파일의 압축을 풉니다.

   ```bash
   tar -xvf tlsinstall.tar tlsinstall
   ```

2. 압축이 풀리면 디렉토리가 생성됩니다. 디렉토리로 이동합니다.

   ```bash
   cd tlsinstall
   ```

3. 디렉토리 내 tlsinstall.sh 파일을 관리자 권한으로 실행합니다.

   ```bash
   sudo sh tlsinstall.sh
   ```

4. 설치가 시작됩니다.  
설치가 진행되는 동안 몇 가지 입력 사항이 있으니, 주의하여 입력하시면 됩니다.  

## 프로그램 상세

1. 메인 페이지  
메인 페이지에서는 대시보드 형태로 정상 처리된 데이터의 통계 그래프들을 한 눈에 확인하실 수 있습니다.  
축적되는 데이터들을 실시간으로 모니터링하여 그래프에 반영합니다.


2. 정상 데이터 리포트
  - 실시간 데이터   
   기기를 선택하면 해당 기기의 최신 데이터를 보여줍니다.
  - 24시간 데이터 추이(기기별)  
   기기를 선택하면 해당 기기의 최근 24시간 내 데이터 추이를 보여줍니다.
  - 기간 별 평균  
   조건을 부여하여 기간 내 평균 데이터를 검색할 수 있습니다.
   첫 화면 또는 조건 없이 검색할 경우 해당 기기에 데이터가 기록 된 전체 기간의 데이터 평균이 제시됩니다.


3. 에러 데이터 리포트
  - 24시간 내 에러 발생 목록  
  24시간 내에 발생한 에러 내용과 기기 위치를 확인할 수 있습니다.
  - 기간 별 통계  
  연도를 선택하면 해당 연도 내 에러 발생 건수를 확인하실 수 있습니다. 월을 선택하면 연도 별 해당 월 에러 발생 건수를 비교하실 수 있습니다.
  - 에러 타입 별 통계  
  조건 조회 시 전체 또는 해당 기기의 기간 내 누적 에러 건수를 확인하실 수 있습니다. 날짜를 선택하지 않을 시 전체 기간으로 조회됩니다.
  - 에러 내용 별 통계  
  기기와 기간을 선택하여 조회 시 에러 타입별 누적 횟수를 확인할 수 있습니다.  
   첫 화면에는 데이터가 기록 된 전체 기간, 전체 기기의 누적 횟수가 제시됩니다.
