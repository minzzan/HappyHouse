<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script type="text/javascript">
$(document).ready(function () {
    $("#modifyBtn").click(function () {
    	var confrim = ""
    	if (!$("#password").val()) {
            alert("비밀번호를 입력해주세요.");
            return;
        } else if (!$("#name").val()) {
            alert("이름을 입력해주세요.");
            return;
        } else if (!$("#nickname").val()) {
            alert("닉네임을 입력해주세요.");
            return;
        } else if (!$("#email").val()) {
            alert("이메일을 입력해주세요.");
            return;
        } else if (!$("#mobile").val()) {
            alert("연락처를 입력해주세요.");
            return;
        } else if (!$("#address").val()) {
            alert("주소를 입력해주세요.");
            return;
        } else if (confirm("회원정보를 수정하시겠습니까?")){
            $("#modifyform").attr("action", "${root}/user/update").submit();
        }
    });
    
    $("#cancelBtn").click(function (){
    	location.href = "${root}/main";
    });
    $("#deleteBtn").click(function (){
    	var confrim = ""
    	if(confirm("정말 탈퇴하시겠습니까?")){
    		$("#deleteform").attr("action", "${root}/user/delete").submit();
    	}
    });
});
</script>

<body id="page-top">
    <!-- Notice 공지사항 -->
    <section class="content-section bg-light" id="notice">
        <div class="container w-75">
            <div class="position-absolute">
                <h1>HAPPYHOUSE</h1>
            </div>
            <div class="content-section-heading text-center">
                <h2 class="mb-4">회원정보</h2>
            </div>
            <!-- 게시판 -->
            <div class="container bootstrap snippet">
                
                <div class="row">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-10">
                        <h1>Profile</h1>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-lg-2"></div>
                    <div class="col-lg-3">
                        <!--left col-->
                        <div class="text-center">
                            <img src="${root}/assets/img/2426_park.jpg" class="avatar rounded-circle img-thumbnail" alt="avatar">
                            <label class="text-wrap" for="input-file">업로드</label>
                            <input type="file" id="input-file" style='display:none' />
                        </div>
                        <br>
                    </div>

                    <div class="col-lg-1"></div>
                    <div class="col-lg-6">

                        <!-- 기본 화면 -->
                        <div class="tab-content">
                            <div class="tab-pane active" id="home" method="post">
                            	<form class= "form" id="deleteform">
                            		<input type="hidden" name="userId" value="${userinfo.userId}">
                            	</form>
                            	
                                <form class="form" id="modifyform" method="post" action="">
                    	
			                    	<input type="hidden" name="act" id="act" value="modifyinfo">
			                 		
			                    	<div class="form-group ">
			                           <div class="col-xs-6">
			                               <label for="id"><h5>아이디</h5></label>
			                               <input type="text" class="form-control w-50" id="id" value="${userinfo.userId}" disabled><br>
			                               <input type="hidden" name="userId" id="act" value="${userinfo.userId}">
			                           </div>
			                       </div>
			
			                       <div class="form-group ">
			                           <div class="col-xs-6">
			                               <label for="password"><h5>비밀번호</h5></label>
			                               <input type="password" class="form-control w-50" name="userPw" id="password" value="${userinfo.userPw}" autofocus><br>
			                           </div>
			                       </div>
			                       
			                        <div class="form-group">
			                           <div class="col-xs-6">
			                               <label for="name"><h5>이름</h5></label>
			                               <input type="text" class="form-control w-50" name="userName" id="name" value="${userinfo.userName}"><br>
			                           </div>
			                       </div>
			                       
			                        <div class="form-group">
			                           <div class="col-xs-6">
			                               <label for="nickname"><h5>닉네임</h5></label>
			                               <input type="text" class="form-control w-50" name="userNickname" id="nickname" value="${userinfo.userNickname}"><br>
			                           </div>
			                       </div>
			
			                       <div class="form-group ">
			                           <div class="col-xs-6">
			                             	<label for="email"><h5>이메일</h5></label>
			                               <input type="email" class="form-control w-50" name="email" id="email" value="${userinfo.email}"><br>
			                           </div>
			                       </div>
			
			                       <div class="form-group">
			                           <div class="col-xs-6">
			                               <label for="mobile"><h5>연락처</h5></label>
			                       
			                               <input type="text" class="form-control w-50" name="tel" id="mobile" value="${userinfo.tel}"><br>
			                           </div>
			                       </div>
			
			                       <div class="form-group">
			                           <div class="col-xs-6">
			                               <label for="address"><h5>주소</h5></label>
			                               <input type="text" class="form-control w-50" name="userAddress" id="address" value="${userinfo.userAddress}"><br>
			                           </div>
			                       </div>
			
			                       <div class="form-group">
			                           <div class="col-xs-12">
			                               <br>
			                               <button type="button" id="modifyBtn" class="btn btn-danger mt-4">수정</button>
			                               <button type="button" id="cancelBtn" class="btn btn-primary mt-4">취소</button>
			                               <button type="button" id="deleteBtn" class="btn btn-secondary mt-4">탈퇴</button>
			                           </div>
			                       </div>

                                </form>

                            </div>
                            <!-- 기본 화면 끝 -->

                        </div>
                        <!--/tab-pane-->
                    </div>
                    <!--/tab-content-->

                </div>
                <!--/col-9-->
            </div>
        </div>
    </section>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top"><i class="fas fa-angle-up"></i></a>
    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="js/scripts.js"></script>
    <!-- Google Map -->
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkOvxySv598X5PE-IggBeeM32jh7lOk2g&callback=initMap"></script>
</body>

</html>