<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>동으로 검색하기</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
    <link href="css/styles.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/apt.css">
    <!-- 추가 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

  </head>
  <body class="sb-nav-fixed">
    <%@ include file="/WEB-INF/views/include/navbar.jsp" %>
    <div id="layoutSidenav">
      <div id="layoutSidenav_nav">
        <%@ include file="/WEB-INF/views/include/sidebar.jsp" %>
      </div>
      <!-- 중앙 부분 시작 -->
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4" style="font-weight: bolder">지역별 아파트 거래정보</h1>
            <div>
              <div class="card mb-4" style="margin-top: 20px">
                <div class="text-center mb-2">
                 	<div class="dropdown" style="padding-top: 20px">
	                  <select id="sido" style="width:100px">
	                    <option value="0">시/도</option>
	                  </select>
	                  <select id="gugun">
	                    <option value="0">군/구</option>
	                  </select>
	                  <select id="dong">
	                    <option value="0">동</option>
	                  </select>
	                  <button class="aptSearchBtn"> API 테스트 버튼(미구현)</button>
                  	</div>
                </div>
                <div class="row">
                  <div class="card col-lg-3 scroll" style="margin-left: 30px; margin-bottom: 20px; min-height: max-content">
			          <div class="list-group mt-3 apt-list" style="min-height: max-content"></div>
                  </div>
                  <div class="card-body col-lg-5">
                    <div id="map" style="width: 1000px; height: 700px; margin: auto" class="mb-3"></div>
                    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=df446ee7ef097f438f13b1dc33338d49&libraries=services"></script>
				<script type="text/javascript" src="js/map.js"></script>
				<script type="text/javascript">
				let colorArr = ['table-primary','table-success','table-danger'];
				$(document).ready(function(){					
					$.get(root + "/map/sido"
						,function(data, status){
							$.each(data, function(index, vo) {
								$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
							});
						}
						, "json"
					);
				});
				$(document).on("change", "#sido", function() {
					$.get(root + "/map/gugun"
							,{sido: $("#sido").val()}
							,function(data, status){
								$("#gugun").empty();
								$("#gugun").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#gugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
								});
							}
							, "json"
					);
				});
				$(document).on("change", "#gugun", function() {
					$.get(root + "/map/dong"
							,{gugun: $("#gugun").val()}
							,function(data, status){
								$("#dong").empty();
								$("#dong").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#dong").append("<option value='"+vo.dongCode+"'>"+vo.dongName+"</option>");
								});
							}
							, "json"
					);
				});
		        
				$(document).on("change", "#dong", function() {
					$.get(root + "/map/apt"
							,{dong: $("#dong").val()}
							,function(data, status){
								 $(".apt-list").empty();
					              $.each(data, function (index, vo) {
					              	let str = `<button class="list-group-item list-group-item-action apt-list-item">`
					        		+ `<h4>` + vo.aptName + `</h4>`
					        		+ `<span class="marker_num" style="display:none">` + index + `</span>`
					        		+ `<span class="apt_code" style="display:none">` + vo.aptCode + `</span>`
					        		+ `<div>건설년도 : ` + vo.buildYear + `<br />지번 : ` + vo.jibun + `</div></button>`;
					                $(".apt-list").append(str);
					              }); //each
								displayMarkers(data);
							}
							, "json"
					);
				});
				
				$(document).on("click", ".show_deal", function(){
					var apt_name = $(".overlaybox").find(".boxtitle").text();
					$.get(root + "/map/deal"
							,{apt_code: $(".overlaybox").find(".apt_code").text()}
							,function(data, status){
								 $(".apt-list").empty();
								 $.each(data, function (index, vo) {
									 	let deal_date = vo.dealYear + '.' + vo.dealMonth + '.' + vo.dealDay;
					                	
						                let str = `<button class="list-group-item list-group-item-action">`
						          		+ `<h5>` + apt_name + `</h5>`
						          		+ `<div>금액 : ` + vo.dealAmount + `<br />면적 : ` + vo.area + `</div>`
						          		+ `<div>층 : ` + vo.floor + `<br />거래날짜 : ` + deal_date + `</div>`
						          		+ `</button>`
					                  	$(".apt-list").append(str);
					                }); //each
							}
							, "json"
					);
				});
				
				$(document).on("mouseenter", ".apt-list-item", function(event) {
					var index = $(this).find(".marker_num").text();
					displayInfowindowByResult(index);
				});
		        
				$(document).on("click", ".apt-list-item", function() {
					var index = $(this).find(".marker_num").text();
					displayInfowindowByResult(index);
					var apt_name = $(this).find("h4").text();
					$.get(root + "/map/deal"
							,{apt_code: $(this).find("span").text()}
							,function(data, status){
								 $(".apt-list").empty();
								 $.each(data, function (index, vo) {
									 	let deal_date = vo.dealYear + '.' + vo.dealMonth + '.' + vo.dealDay;
					                	
						                let str = `<button class="list-group-item list-group-item-action">`
						          		+ `<h5>` + apt_name + `</h5>`
						          		+ `<div>금액 : ` + vo.dealAmount + `<br />면적 : ` + vo.area + `</div>`
						          		+ `<div>층 : ` + vo.floor + `<br />거래날짜 : ` + deal_date + `</div>`
						          		+ `</button>`
					                  	$(".apt-list").append(str);
					                }); //each
							}
							, "json"
					);
				});
				
				$(document).on("click", "#aptSearchBtn", function() {
					var param = {
							serviceKey:'xRLYN22mJkn9QQy8uH/NVlsbM5rYBp912TmwtLR1y0IWXu37wxnUBspI+MrFmtraCRXWXypdu3cLkKy8pniNoA==',
							pageNo:encodeURIComponent('1'),
							numOfRows:encodeURIComponent('10'),
							LAWD_CD:encodeURIComponent($("#gugun").val()),
							DEAL_YMD:encodeURIComponent('202110')
					};
					$.get('http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev'
							,param
							,function(data, status){
								var items = $(data).find('item');
								var jsonArray = new Array();
								items.each(function() {
									var jsonObj	= new Object();
									jsonObj.aptCode = $(this).find('일련번호').text();
									jsonObj.aptName = $(this).find('아파트').text();
									jsonObj.dongCode = $(this).find('법정동읍면동코드').text();
									//jsonObj.dongName = $(this).find('').text();
									//jsonObj.sidoName = $(this).find('').text();
									//jsonObj.gugunName = $(this).find('').text();
									jsonObj.buildYear = $(this).find('건축년도').text();
									jsonObj.jibun = $(this).find('지번').text();
									jsonObj.recentPirce = $(this).find('거래금액').text();
										
									jsonObj = JSON.stringify(jsonObj);
									//String 형태로 파싱한 객체를 다시 json으로 변환
									jsonArray.push(JSON.parse(jsonObj));
								});
								console.log(jsonArray);
								//displayMarkers(jsonArray);
							}
							, "xml"
					);
					/* var xhr = new XMLHttpRequest();
					var url = 'http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev';
					var queryParams = '?' + encodeURIComponent('serviceKey') + '='+encodeURIComponent(' API KEY ');
					queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); 
					queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); 
					queryParams += '&' + encodeURIComponent('LAWD_CD') + '=' + encodeURIComponent($("#gugun").val()); 
					queryParams += '&' + encodeURIComponent('DEAL_YMD') + '=' + encodeURIComponent('202110'); 
					xhr.open('GET', url + queryParams);
					xhr.onreadystatechange = function () {
					    if (this.readyState == 4) {
					    	console.log(this.responseXML);
					        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
					    }
					};

					xhr.send(''); */
				});
				</script>
                  </div>
                </div>
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
      <!-- 중앙부분 끝 -->
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
  </body>
</html>
