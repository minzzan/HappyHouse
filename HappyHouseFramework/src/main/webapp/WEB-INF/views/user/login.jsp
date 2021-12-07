<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<c:if test="${cookie.happyhouse_id.value ne null }">
	<c:set var="idck" value=" checked"/>
	<c:set var="saveid" value="${cookie.happyhouse_id.value}"/>
</c:if>

<script type="text/javascript">
$(document).ready(function () {
	$("#userpwd").keydown(function(key) {
        if (key.keyCode == 13) {
            login();
        }
    });
	$("#pwdsearchBtn").click(function() {
		var userId = $("#usersid").val();
		var email = $("#email").val();
		$.ajax({
			url:'${root}/user/searchpwd',
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			data: {'userId': userId,
					'email': email},
			success:function(users) {
				$(".pw").empty();
				let str = `당신의 비밀번호는 ${'${users.userPw}'}입니다`;
				$(".pw").append(str);
			},
			error:function(xhr,status,msg){
				console.log("상태값 : " + status + " Http에러메시지 : "+msg);
			}
		});
	});

    $("#loginBtn").click(function () {
        login();
    });
    $("#signupBtn").click(function () {
        location.href = "${root}/user/signup";
    });
    
});

function login() {
	if (!$("#userid").val()) {
        alert("아이디 입력!!!");
        return;
    } else if (!$("#userpwd").val()) {
        alert("비밀번호 입력!!!");
        return;
    } else {
        $("#loginform").attr("action", "${root}/user/login").submit();
    }
}
</script>
<body id="page-top">
	<!-- Notice 공지사항 -->
	<section class="content-section bg-light" id="notice">
		<div class="container w-75">
			<div class="position-absolute">
				<h1>HAPPYHOUSE</h1>
			</div>
			<div class="content-section-heading text-center mb-5">
				<h2 class="mb-4">로그인</h2>
			</div>

			<div>
				<!-- Header -->
				<div>
					<h4>로그인</h4>
				</div>

				<!-- body -->
				<div>
					<form id="loginform" method="post" action="">
						<input type="hidden" name="act" id="act" value="login">					    
						<div class="form-group row">
							<div class="mt-3">
								<label for="signId">ID</label> <i class="fa fa-user"></i></label>
							  	<input type="text" class="form-control" id="userid" name="userId" value="${saveid}" autofocus />
							</div>
							
							<div class="mt-3">
								<label for="signPw">PassWord <i class="fa fa-key"></i></label> 
							 	<input type="password" class="form-control" id="userpwd" name="userPw" />
							</div>
							
							<div class="text-danger mb-2">${msg}</div>
							
							<p>
								<label> <input type="checkbox" id="idsave" name="idsave" value="saveok"${idck} /> Remember Id</label><br>
							</p>
							<div>
								<button type="button" id="searchpwdBtn" data-toggle="modal" data-target="#searchpwdModal" class="btn btn-info mt-4">비밀번호 찾기</button>
							</div>
						</div>
						
						<div>
							<button type="button" id="loginBtn" class="btn btn-danger mt-4">로그인</button>
							<button type="button" id="signupBtn" class="btn btn-primary mt-4">회원가입</button>
						</div>
					</form>
				</div>
				
		<div class="modal" id="searchpwdModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">비밀번호 찾기</h4>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		        <form id="memberform" method="post" action="">
					<div class="form-group" align="left">
						<label for="">아이디</label>
						<input type="text" class="form-control" id="usersid" name="userSId" placeholder="">
						
						<label for="">이메일</label>
						<input type="text" class="form-control" id="email" name="email" placeholder="">
						<div class ="pw">
							
						</div>
					</div>
					<div class="form-group" align="center">
						<button type="button" class="btn btn-primary" id="pwdsearchBtn">비밀번호 찾기</button>
						<button type="reset" class="btn btn-warning">초기화</button>
					</div>
				</form>
		      </div>
		    </div>
		  </div>
		</div>
				<!-- footer -->
				<div>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>