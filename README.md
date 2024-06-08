# K-Degital Academy First-Project

## 주제
#### 게임 플랫폼 개발
- 어쩌고 저쩌고한 게임들을 플레이 할 수 있는 플랫폼 개발

## Member & work
- 게시판 담당 개발
    - 양하람 (leader)
    - 전은미

- 마이페이지 및 관리자 콘솔 담당 개발
    - 노시온
    - 송유나

- 회원 기능 담당 개발
    - 서상혁
    
## 개발 환경
- Java : 11
- jsp
- Tomcat 9.0
- DB : oracle


## Library
- OJDBC
- JSTL


## Start setting
```bash
/** Clone Project **/
// git bash (Windows), Terminal(macOS)
$ git clone https://github.com/K-Degital-Academy-First-team/First-Project.git


/** Eclipse UTF-8 **/
window → Preferences → encoding(검색)
→ General → Content Types → Text → Java Source File → Default encoding : utf8 입력 후 update
→ Web
    → CSS Files → Encoding : ISO 10646/Unicode(UTF-8)
    → HTML Files → Encoding : ISO 10646/Unicode(UTF-8)
    → JSP Files → Encoding : ISO 10646/Unicode(UTF-8)


/** Template 설정 **/
window → Preferences → template(검색)
→ Web → JSP File → Name: New JSP File (html 5) 에서 아래 적용

// JSTL core
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

// jQuery
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>


/** Tomcat v9.0 setting **/
server.xml
   <Context docBase="First-Project" path="" reloadable="true" source="org.eclipse.jst.jee.server:First-Project"/>

context.xml
    <Resource 
    	name="jdbc/oracle"
    	auth="Container"
    	type="javax.sql.DataSource"
    	username="user_id"
    	password="user_pw"
    	url="jdbc:oracle:thin:@localhost:1521:xe"
    	driverClassName="oracle.jdbc.driver.OracleDriver"
    />
    - user_id, user_pw → dev private account 문서 확인

```

## 산출물
#### 회의록
#### 요구사항 정의서 및 명세서
#### 화면 설계 ( 와이어 프레임 )
#### 데이터베이스 설계 및 ERD
#### 테스트 케이스

## 참고자료
#### https://pixabay.com/ko/ ( 무료이미지 )
