<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<style>
	a {
    text-decoration: none;
    color: #222;
    }

    .sb-sidenav-menu-heading {
    list-style: none;
    padding: 0;
    padding: 0;
    width: 600px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    padding: 50px 30px;
    display: flex;
    }
    .sb-sidenav-menu-heading li {
    /*box-sizing: border-box;
    float: left;
    width: 120px;
    text-align: center;*/
    flex: 1;
    text-align: center;
    }
    .sb-sidenav-menu-heading li a {
    font-size: 14px;
    position: relative;
    }
    .sb-sidenav-menu-heading li a:before {
    content: '';
    position: absolute;
    background-color: dodgerblue;
    height: 2px;
    width: 0;
    bottom: -10px;
    transition: 0.5s;
    left: 50%;
    transform: translateX(-50%);
    }
    .gnb li a:hover:before {
    width: 100%;
    }
  </style>
  
<!-- 좌측 메뉴 -->
        <nav class="sb-sidenav accordion sb-sidenav-light" id="sidenavAccordion" style="box-shadow: 0px 5px 5px gray;">
          <div class="sb-sidenav-menu">
            <div class="nav">
              <div class="sb-sidenav-menu-heading">홈</div>
              <a class="nav-link" href="/main">
                <div class="sb-nav-link-icon"><i class="fas fa-home"></i></div>
                 Main
              </a>
              <div class="sb-sidenav-menu-heading">매물 둘러보기</div>
              <a
                class="nav-link collapsed"
                href="#"
                data-bs-toggle="collapse"
                data-bs-target="#collapseLayouts"
                aria-expanded="false"
                aria-controls="collapseLayouts"
              >
                <div class="sb-nav-link-icon"><i class="far fa-map"></i></div>
                지도로 보기
                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
              </a>
              <div
                class="collapse"
                id="collapseLayouts"
                aria-labelledby="headingOne"
                data-bs-parent="#sidenavAccordion"
              >
                <nav class="sb-sidenav-menu-nested nav">
                  <a class="nav-link" href="/aptMap">아파트 거래 정보</a>
                </nav>
              </div>
              
              <div class="sb-sidenav-menu-heading">게시판</div>
              <a class="nav-link" href="/notice">
                <div class="sb-nav-link-icon"><i class="fas fa-exclamation"></i></div>
                공지사항
              </a>
              <a class="nav-link" onclick="location.href='http://localhost:8080/qna/list'">
                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                QnA
              </a>

              <div class="sb-sidenav-menu-heading">관리자 기능</div>
              <a
                class="nav-link collapsed"
                href="#"
                data-bs-toggle="collapse"
                data-bs-target="#collapsePages"
                aria-expanded="false"
                aria-controls="collapsePages"
              >
                <div class="sb-nav-link-icon"><i class="fas fa-cog"></i></div>
                설정 
                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
              </a>
              <div
                class="collapse"
                id="collapsePages"
                aria-labelledby="headingTwo"
                data-bs-parent="#sidenavAccordion"
              >
                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                  <a
                    class="nav-link collapsed"
                    href="#"
                    data-bs-toggle="collapse"
                    data-bs-target="#pagesCollapseAuth"
                    aria-expanded="false"
                    aria-controls="pagesCollapseAuth"
                  >
                    개인정보관리
                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                  </a>
                  <div
                    class="collapse"
                    id="pagesCollapseAuth"
                    aria-labelledby="headingOne"
                    data-bs-parent="#sidenavAccordionPages"
                  >
                    <nav class="sb-sidenav-menu-nested nav">
                      <c:if test="${empty userinfo}">
                      <a class="nav-link" href="${root}/user/login">로그인</a>
                      <a class="nav-link" href="${root}/user/signup">회원가입</a>
                      </c:if>
                      <c:if test="${!empty userinfo}">
                      <a class="nav-link" href="password.html">비밀번호 찾기</a>
                      <a class="nav-link" href="/user/userinfo">내 정보 확인</a>
                      </c:if>
                    </nav>
                  </div>
                  <a
                    class="nav-link collapsed"
                    href="#"
                    data-bs-toggle="collapse"
                    data-bs-target="#pagesCollapseError"
                    aria-expanded="false"
                    aria-controls="pagesCollapseError"
                  >
                    에러페이지
                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                  </a>
                  <div
                    class="collapse"
                    id="pagesCollapseError"
                    aria-labelledby="headingOne"
                    data-bs-parent="#sidenavAccordionPages"
                  >
                    <nav class="sb-sidenav-menu-nested nav">
                      <a class="nav-link" href="401.html">401 Page</a>
                      <a class="nav-link" href="404.html">404 Page</a>
                      <a class="nav-link" href="500.html">500 Page</a>
                    </nav>
                  </div>
                </nav>
              </div>
            </div>
          </div>
          

          <div class="sb-sidenav-footer">
          	<c:if test="${empty userinfo}">
          	 <p align="center">
	         	<a href="${root}/user/signup">회원가입</a><br />
	         	<a href="${root}/user/login">로그인</a>
	         </p>
      		</c:if>
      		
      		<c:if test="${!empty userinfo}">
      		<h5 align="center">로그인 정보</h5>
         	<p align="center">
      			<span class="container"><strong>${userinfo.userNickname}</strong>님 환영합니다.</span><br/>
         		<a href="${root}/user/logout">로그아웃</a><br />
         	</p>
      		</c:if>
          </div>
        </nav>
        <!-- 좌측메뉴 끝 -->