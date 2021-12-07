<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script type="text/javascript">
$(document).ready(function () {
   	var isId = false;
   	// 아이디 중복검사
   	$("#id").keyup(function () {
   		var ckid = $("#id").val();
   		if(ckid.length < 5 || ckid.length > 16) {
   			$("#idresult").text("아이디는 5자이상 16자이하만 가능합니다.").removeClass('text-primary').removeClass('text-danger').addClass('text-dark');
   			isId = false;
   		} else {
            $.ajax({
            	url: '${root}/user/idcheck',
            	data: {'ckid': ckid},
              	type: 'GET',
              	dataType: 'json',
              	success: function (response) {
              		console.log(response);
                	var cnt = response.idcount;
                	if(cnt == 0) {
                		$("#idresult").text(ckid + "는 사용 가능한 아이디입니다.").removeClass('text-dark').removeClass('text-danger').addClass('text-primary');
                		isId = true;
                	} else {
                		$("#idresult").text(ckid + "는 사용 불가능한 아이디입니다.").removeClass('text-dark').removeClass('text-primary').addClass('text-danger');
                		isId = false;
                	}
              	},
              	error: function(request, status, error) {
              		console.log("status : " + request.status + "\tmsg : " + error);
              	}
			});
   		}
	});
      	
  	// 회원가입
    $("#signupBtn").click(function () {
        if (!isId) {
            alert("아이디를 입력해주세요.");
            return;
        } else if (!$("#password").val()) {
            alert("비밀번호를 입력해주세요.");
            return;
        } else if (!$("#name").val()) {
            alert("이름을 입력해주세요.");
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
        } else {
            $("#userform").attr("action", "${root}/user/signup").submit();
        }
    });
  	
    $("#cancelBtn").click(function (){
    	location.href = "${root}/main";
    });

      // $('#zipcode').focusin(function () {
      //     $('#zipModal').modal();
      // });
});
</script>
<body id="page-top">
	<!-- Notice 공지사항 -->
	<section class="content-section bg-light" id="notice">
		<div class="container w-75">
			<div class="position-absolute">
				<h1>HAPPYHOUSE</h1>
			</div>
			<div class="content-section-heading text-center mb-5">
				<h2 class="mb-4">회원가입</h2>
			</div>
			
		 	<!-- 회원 가입 시작 -->
            <div class="tab-content">
                <div class="tab-pane active" id="home">
                    <form class="form" id="userform" method="post" action="">
    
                    	<div class="form-group ">
                           <div class="col-xs-6">
                               <label for="id"><h5>아이디</h5></label> <i class="fa fa-id-badge"></i>
                               <input type="text" class="form-control w-50" name="userId" id="id" placeholder="ID" autofocus>
                               <div id="idresult" class="mt-1"></div><br>
                           </div>
                       </div>

                       <div class="form-group ">
                           <div class="col-xs-6">
                               <label for="password"><h5>비밀번호</h5></label> <i class="fa fa-key"></i>
                               <input type="password" class="form-control w-50" name="userPw" id="password" placeholder="Password"><br>
                           </div>
                       </div>
                       
                        <div class="form-group">
                           <div class="col-xs-6">
                               <label for="nickname"><h5>닉네임</h5></label> <i class="fa fa-user"></i>
                               <input type="text" class="form-control w-50" name="userNickname" id="nickname" placeholder="Your NickName"><br>
                           </div>
                       </div>
                       
                        <div class="form-group">
                           <div class="col-xs-6">
                               <label for="name"><h5>이름</h5></label> <i class="fa fa-user"></i>
                               <input type="text" class="form-control w-50" name="userName" id="name" placeholder="Your Name"><br>
                           </div>
                       </div>

                       <div class="form-group ">
                           <div class="col-xs-6">
                             	<label for="email"><h5>이메일</h5></label> <i class="fa fa-envelope"></i>
                               <input type="email" class="form-control w-50" name="email" id="email" placeholder="Email"><br>
                           </div>
                       </div>

                       <div class="form-group">
                           <div class="col-xs-6">
                               <label for="mobile"><h5>연락처</h5></label> <i class="fa fa-phone"></i>
                               <input type="text" class="form-control w-50" name="tel" id="mobile" placeholder="Phone Number"><br>
                           </div>
                       </div>

                       <div class="form-group">
                           <div class="col-xs-6">
                               <label for="address"><h5>주소</h5></label> <i class="fa fa-address-card"></i>
                               <input type="text" class="form-control w-50" name="userAddress" id="address" placeholder="Address"><br>
                           </div>
                       </div>

                       <div class="form-group">
                           <div class="col-xs-12">
                               <br>
                               <button class="btn btn-danger mt-2" type="button" id="signupBtn">가입</button>
                               <button class="btn btn-primary mt-2" type="button" id="cancelBtn">취소</button>
                           </div>
                       </div>
                    </form>
					
                </div>
                <!-- 회원 가입 끝 -->
			</div>
		</div>
	</section>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>