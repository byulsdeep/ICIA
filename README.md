# Expert Exchange (Two-Ex) – (Spring MVC) 프로젝트

## 프로젝트 개요
Expert Exchange (Two-Ex)는 전문기술 쇼핑몰과 학습관리시스템 서비스를 제공하는 웹사이트입니다. 이 프로젝트는 인천일보아카데미에서 2022년 8월 8일부터 2022년 9월 23일까지 진행되었습니다.

전문가 회원은 교육, 트레이닝 등의 서비스를 상품으로 사이트에 등록하고 제공할 수 있으며, 고객회원은 상품을 구매하고 학습관리시스템에 참여할 수 있습니다. 학습관리시스템을 통해 고객과 전문가, 그리고 다른 고객들과의 교류가 가능합니다.

## 팀 구성 및 역할
- 팀장: 프로젝트 총괄, 팀원들의 출석 및 회의 관리, 데일리 리포트 작성, 팀원들의 작업 진행 현황 확인 및 코드 관리
- 엔지니어: job 리스트 관리, job 분담, 프론트 프로토타입 제작
- 공통 역할: 회의 참여, 팀 의사 결정, 프로젝트 기획 및 설계, 개발, 마스터코드 작성, API 조사

## 프로젝트 규모
- JOB: 78개
- 페이지: 34개
- 테이블: 21개
- 클래스: 68개

## 개발 도구 및 환경
- DB 설계: eXERD, Oracle SQL Developer
- IDE 도구: Eclipse
- 웹 서버: Apache Tomcat 9.0
- 언어: Java, JavaScript, HTML, SQL
- 주요 라이브러리: Gson (JSON), MyBatis
- 프레임워크: Spring

## 프로젝트 소개
Expert Exchange (Two-Ex)는 전문기술 쇼핑 플랫폼과 학습관리시스템의 합체된 서비스입니다. 이 프로젝트의 목표는 전문기술 쇼핑몰과 학습관리시스템을 하나의 통합된 웹사이트로 제공하는 것입니다.

Expert Exchange (Two-Ex)의 기본 프로세스는 다음과 같습니다:
1. 회원가입
2. 로그인
3. 구매자: 상품 구매 -> 클래스룸 상품일 경우 클래스룸 서비스 이용
4. 판매자: 상품 등록 -> 상품

 판매 -> 클래스룸 상품일 경우 클래스룸 서비스 관리

주요 기능은 다음과 같습니다:
- 구매자: 마이페이지, 계정정보, 주문, 찜 목록, 팔로우 목록, 클래스룸 이동
- 판매자: 마이샵, 샵 정보, 상품 관리, 판매 실적 통계, 클래스룸 이동
- 공통: 클래스룸, 커리큘럼, 과제, 일정, 공지, 채팅

프로젝트에서 사용된 주요 기술 및 API는 다음과 같습니다:
- 카카오로그인: 구매자 로그인
- 카카오페이: 결제
- FullCalendar: 클래스룸 일정
- Chart.js: 판매 실적 통계
- WebSocket: 채팅
- Multipart files: 상품 이미지 업로드, 과제 파일 업로드 및 삭제