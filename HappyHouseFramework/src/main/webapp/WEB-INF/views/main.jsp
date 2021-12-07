<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

    <title>Happy Home</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet"/>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
  
  <script type="text/javascript">
  $(document).ready(function() {
  	
	  	//글 목록
	  	$.ajax({
	  		url:'${root}/admin/notice',
	  		type:'GET',
	  		contentType:'application/json;charset=utf-8',
		dataType:'json',
	  		success:function(notices) {
			makeList(notices);
		},
		error:function(xhr, status, error){
			console.log("상태값 : " + xhr.status + "\tHttp 에러메시지 : " + xhr.responseText);
		},
		
		statusCode: {
			500: function() {
				alert("서버에러.");
				// location.href = "/error/e500";
			},
			404: function() {
				alert("페이지없다.");
				// location.href = "/error/e404";
			}
		}	
	});
  });	
  function makeList(notices){
	$("#noticelist").empty();
	$(notices).each(function(index, notice){
		let str = `
			<tr id="view_${'${notice.user_id}'}" class="view" data-id=${'${notice.user_id}'}">
               <td style='text-align: center'>${'${notice.noticeno}'}</td>
               <td style="text-align: center">${'${notice.title}'} <span class="badge badge-danger">New</span></td>
               <td style="text-align: center">${'${notice.content}'}</td>
               <td style="text-align: center">${'${notice.user_id}'}</td>
             </tr>
             `;
             $("#noticelist").append(str);
 		});
 	}
  </script>
  <style>
  table { 
		border-collapse: collapse; 
		border-spacing: 0;		
		width: 100%; 
		table-layout: fixed;
	}
	td { 
		vertical-align: middle; 
		padding:5px;
		border: 1px solid #000;
		overflow:hidden;
		white-space : nowrap;
		text-overflow: ellipsis;
	 }
  </style>
  </head>
  <body class="sb-nav-fixed">
    <%@ include file="/WEB-INF/views/include/navbar.jsp" %>
    <div id="layoutSidenav">
      <div id="layoutSidenav_nav">
        <!-- 좌측 메뉴 -->
        <%@ include file="/WEB-INF/views/include/sidebar.jsp" %>
        <!-- 좌측메뉴 끝 -->
      </div>
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4" style="font-weight: bold;"><i class="fas fa-home"></i>Main</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item active">
                김윤하 김명섭 박찬혁의 happy home 사이트에 오신걸 환영합니다.
              </li>
            </ol>
            <!-- 메인이미지 시작 -->
                  <!-- banner start -->
      <!-- ================ -->

<div class="banner dark-translucent-bg" style="background-image:url('/img/apartment.jpg'); background-position: 50% 32%;">
    <!-- breadcrumb end -->
    <div class="container">
      <div class="row justify-content-lg-center">
        <div class="col-lg-8 text-center pv-20">
          <h2 class="title hc-element-invisible" data-animation-effect="fadeIn" data-effect-delay="100"><strong>Happy Home</strong></h2>
          <div class="separator hc-element-invisible mt-10" data-animation-effect="fadeIn" data-effect-delay="100"></div>
          <p class="text-center hc-element-invisible" data-animation-effect="fadeIn" data-effect-delay="100">내집마련을 향한 꿈</p>
        </div>
      </div>
    </div>
  </div>
            <div class="row" style="margin-top: 30px;">
              <div class="col-xl-6">
                <div class="card mb-4">
                  <div class="card-header">
                    <i class="fas fa-columns"></i>
                    최신글
                  </div>
                  <!-- 최신글 table 시작 -->
                  <div class="container">
                    <table class="table table-hover banner_table">
                      <thead>
                        <tr>
                          <th style="text-align: center">번호</th>
                          <th style="text-align: center">글제목</th>
                          <th style="text-align: center">작성자</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td style="text-align: center">1</td>
                          <td>요즘 집값 너무 비싸요 <span class="badge badge-primary">New</span></td>
                          <td style="text-align: center">민정</td>
                        </tr>
                        <tr>
                          <td style="text-align: center">2</td>
                          <td>좋은 매물 찾고있나요?</td>
                          <td style="text-align: center">뭉뭉</td>
                        </tr>
                        <tr>
                          <td style="text-align: center">3</td>
                          <td>사이트가 예뻐요</td>
                          <td style="text-align: center">윤하</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <!-- 최신글 table 끝 -->
                </div>
              </div>
              <div class="col-xl-6">
                <div class="card mb-4">
                  <div class="card-header">
                    <i class="fas fa-exclamation"></i>
                    공지사항
                  </div>
                  <!-- 공지사항 table 시작 -->
                  <div class="container">
                    <table class="table table-hover">
                      <thead>
                        <tr>
                          <th style="text-align: center">번호</th>
                        <th style="text-align: center">글제목</th>
                        <th style="text-align: center">글내용</th>
                        <th style="text-align: center">작성자</th>
                        </tr>
                      </thead>
                      <tbody id="noticelist">
                      </tbody>
                    </table>
                  </div>
                  <!-- 공지사항 table 끝 -->
                </div>
              </div>
            </div>
            
        </main>
        <footer class="py-4 bg-light mt-auto">
          <div class="container-fluid px-4">
            <div class="d-flex align-items-center justify-content-between small">
              <div class="text-muted">Copyright &copy; Your Website 2021</div>
              <div>
                <a href="#">Privacy Policy</a>
                &middot;
                <a href="#">Terms &amp; Conditions</a>
              </div>
            </div>
          </div>
        </footer>
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
  </body>
</html>