<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>New Happy House</title>
    <link href="/css/style.css" rel="stylesheet" />

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
    
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
		overflow:hidden;
		white-space : nowrap;
		text-overflow: ellipsis;
	 }
  </style>
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
					alert("500 Page Error.");
					// location.href = "/error/e500";
				},
				404: function() {
					alert("404 Page Error.");
					// location.href = "/error/e404";
				}
			}	
		});
    	
    	// 글 삭제
    	$(document).on("click", ".delBtn", function() {
    		if(confirm("공지사항을 삭제하시겠습니까?")) {
    			let delno = $(this).parents("tr").attr("data-id");
				$.ajax({
					url:'${root}/admin/notice/' + delno,  
					type:'DELETE',
					contentType:'application/json;charset=utf-8',
					dataType:'json',
					success:function(notices) {
						makeList(notices);
					},
					error:function(xhr,status,msg){
						console.log("상태값 : " + status + " Http에러메시지 : "+msg);
					}
				});
    		}
    	});
    	
    	// 글 수정
    	$(document).on("click", ".modiBtn", function() {
    		let mid = $(this).parents("tr").attr("data-id");
			$("#view_" + mid).css("display", "none");
			$("#mview_" + mid).css("display", "");
    	});
    	
    	// 수정 ajax
    	$(document).on("click", ".modifyBtn", function() {
    		let mid = $(this).parents("tr").attr("data-id");
    		let modifyinfo = JSON.stringify({
    			"title" : $("#modiTitle"+mid).val(),
    			"content" : $("#modiContent"+mid).val(),
    			"noticeno" : mid
    		});
    		$.ajax({
    			url:'${root}/admin/notice',
    			type:'PUT',
    			contentType:'application/json;charset=utf-8',
				dataType:'json',
				data: modifyinfo,
				success:function(notices) {
					makeList(notices);
				},
				error:function(xhr,status,msg){
					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
				}
    		});
    	});
    	
    	// 회워 정보 수정 취소.
		$(document).on("click", ".cancelBtn", function() {
			let mid = $(this).parents("tr").attr("data-id");
			$("#view_" + mid).css("display", "");
			$("#mview_" + mid).css("display", "none");
		});
    	
    	// 글 등록
    	$("#registerBtn").click(function() {
    		if($("#title").val() == ''){
    			alert("제목을 입력해주세요.");
    			return;
    		}
    		else if($("#content").val() == ''){
    			alert("내용을 입력해주세요.");
    			return;
    		}
    		else{
    			let registerinfo = JSON.stringify({
    				"title": $("#title").val(), 
    				"user_id": $("#author").val(),
    				"content": $("#content").val()
    			   });
    			$.ajax({
    				url:'${root}/admin/notice',  
    				type:'POST',
    				contentType:'application/json;charset=utf-8',
    				dataType:'json',
    				data: registerinfo,
    				success:function(notices) {
    					$("#title").val('');
    					$("#content").val('');
    					$('#noticeViewModal').modal("hide");
    					makeList(notices);
    				},
    				error:function(xhr,status,msg){
    					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
    				}
    			});
    		}		
    	});
    	
    });
    
   	function makeList(notices){
   		$("#noticelist").empty();
   		$(notices).each(function(index, notice){
   			let str = `
   				 <tr id="view_${'${notice.noticeno}'}" class="view" data-id="${'${notice.noticeno}'}">
                   <td style='text-align: center'>${'${notice.noticeno}'}</td>
                   <td style="text-align: center">${'${notice.title}'} <span class="badge badge-danger">New</span></td>
                   <td style="text-align: center">${'${notice.content}'}</td>
                   <td style="text-align: center">${'${notice.user_id}'}</td>
                   <td style="text-align: center">
                   	  <button type="button" class="modiBtn btn btn-outline-primary btn-sm">수정</button>
					  <button type="button" class="delBtn btn btn-outline-danger btn-sm">삭제</button>
                   </td>
                 </tr>
                 <tr id="mview_${'${notice.noticeno}'}" data-id="${'${notice.noticeno}'}" style="display: none;">
                   <td style='text-align: center'>${'${notice.noticeno}'}</td>
                   <td style="text-align: center"><input type="text" value="${'${notice.title}'}" id="modiTitle${'${notice.noticeno}'}"></td>
                   <td style="text-align: center"><input type="text" value="${'${notice.content}'}" id="modiContent${'${notice.noticeno}'}"></td>
                   <td style="text-align: center">${'${notice.user_id}'}</td>
                   <td style="text-align: center">
                 	  <button type="button" class="modifyBtn btn btn-outline-primary btn-sm">수정</button>
					  <button type="button" class="cancelBtn btn btn-outline-danger btn-sm">취소</button>
                   </td>
               	</tr>
                 `;
                 $("#noticelist").append(str);
   		});
   	};
  </script>
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
            <h1 class="mt-4">공지사항</h1>
            <!-- <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
              <li class="breadcrumb-item active">Charts</li>
            </ol> -->
            <div class="card mb-5">
              <div class="card-body">
                <!-- 공지사항 table 시작 -->
                <div class="container justify-content-lg-center" style="float: left; width: 100%">
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th style="text-align: center">번호</th>
                        <th style="text-align: center">글제목</th>
                        <th style="text-align: center">글내용</th>
                        <th style="text-align: center">작성자</th>
                        <th style="text-align: center">비고</th>
                      </tr>
                    </thead>
                    <tbody id="noticelist">
                    </tbody>
                  </table>
                  <button class="btn btn-outline-primary float-right" data-toggle="modal" data-target="#noticeViewModal">등록</button>
                </div>
                <!-- 공지사항 table 끝 -->
              </div>
            </div>
          </div>
        </main>
        
        <!-- 공지사항 모달 -->
        <div class="modal" id="noticeViewModal">
          <div class="modal-dialog">
         	<div class="modal-content">
         	
	         	<!-- Modal Header -->
	         	<div class="modal-header">
	         		<h5 class="modal-title">공지사항 등록</h5>
	         		<button type="button" class="btn-close" aria-label="Close" data-dismiss="modal"></button>
	         	</div>
	         	
	         	<!-- Modal Body -->
	         	<div class="modal-body">
	         		<form id="noticeform" class="form-horizontal" role="form" method="post" action="">
	         			<div class="form-group" align="left">
	         				<label for="title" class="col-lg-4 control-label">글 제목</label>
	         				<div class="col-lg-12">
	         					<input type="text" class="form-control" id="title" name="title" placeholder="">
	         				</div>
	         			</div>
	         			<div class="form-group" align="left">
	         				<label for="title" class="col-lg-4 control-label">글 내용</label>
	         				<div class="col-lg-12">
	         					<textarea class="form-control col-lg-12" rows="8" name="content" id="content"></textarea>
	         				</div>
	         			</div>
	         			<div class="form-group" align="left">
	         				<label for="title" class="col-lg-4 control-label">작성자</label>
	         				<div class="col-lg-12">
	         					<input type="text" class="form-control" id="author" name="author" value="admin" disabled>
	         				</div>
	         			</div>
	         			
	         			<div class="form-group" align="left">
							<button type="button" class="btn btn-outline-primary ml-3 mr-1" id="registerBtn">등 록</button>
							<button type="reset" class="btn btn-outline-danger">초기화</button>
						</div>
	         		</form>
	         	</div>
	        </div>
          </div>
        </div>
        
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/js/script.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
    <script src="/assets/demo/chart-area-demo.js"></script>
    <script src="/assets/demo/chart-bar-demo.js"></script>
    <script src="/assets/demo/chart-pie-demo.js"></script>
  </body>
</html>