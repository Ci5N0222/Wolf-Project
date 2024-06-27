# K-Degital Academy First-Project

## 주제
#### 게임 플랫폼 개발
- 게임 플레이 및 커뮤니티 플랫 폼 개발

### 호스팅
- 도메인

## Member & work
- 게시판 담당 개발
    - 양하람 (leader)
    
- 관리자 콘솔 담당 및 개임 관련 개발
    - 노시온

- 전체 UI 담당 및 게임 관련 개발
    - 전은미

- 마이페이지 담당 개발
    - 송유나

- 회원 기능 담당 및 랭킹 개발
    - 서상혁
    
## 개발 환경
- Java: 11
- JavaScript: 1.0
- Dynamic Web Module: 4.0
- View: jsp
- Server runtime: Tomcat 9.0
- Database : oracle


## Library
### Jar
- OJDBC ( Oracle DB 라이브러리 )
- JSTL ( JSP 라이브러리 )
- COS
- GSON ( 직렬화 라이브러리 )
- JSoup
- Jakarta

### CDN
- jQuery
- Phaser3 ( 게임 개발 라이브러리 )
- tinymce ( 게시판 에디터 라이브러리 )
- sweetalert2 ( 알림 창 라이브러리 )
- chart.js ( 차트 관련 라이브러리 )


## Start setting
```bash

/** Tomcat v9.0 setting **/
context.xml
    <Resource 
    	name="jdbc/oracle"
    	auth="Container"
    	type="javax.sql.DataSource"
    	username="<user_id>"
    	password="<user_pw>"
    	url="jdbc:oracle:thin:@<db_ip>:1521:xe"
    	driverClassName="oracle.jdbc.driver.OracleDriver"
    />
    - user_id, user_pw, db_ip → dev private account 문서 확인
```

## 산출물
#### 회의록
#### 요구사항 정의서 및 명세서
#### 화면 설계 ( 와이어 프레임 )
#### 데이터베이스 설계 및 ERD

## 참고자료
#### https://pixabay.com/ko/ ( 무료이미지 )
