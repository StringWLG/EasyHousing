<%@page import="com.easyhousing.model.RentHouse"%>
<%@page import="java.util.*"%>
<%@page import="java.lang.Math"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <%
  HttpSession s = request.getSession(); 
  String strtemp;
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
  %>
  
    <meta charset="UTF-8">
    <title>地图找房</title>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=IzuDNWzXS4qfBqXxSEMsISl6Pc1Ga8Kr"></script>
   <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
  <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
    body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, form, fieldset, input, textarea, p, blockquote, th, td {
      margin: 0;
      padding: 0;
    }
    body {
      height: 100%;
      font-size: 12px;
      color: #333;
      background: #f2f2f2;
      min-width: 1220px;
    }
    .listhead {
      height: 60px;
      background:  #1a4563;
    }
    .headerbg {
      width: 100%;
      height: 40px;
      position: relative;
    }
    .listhead .header {
      height: 60px;
      padding: 0;
      line-height: 60px;
    }
    .header {
      width: 1220px;
      height: 50px;
      line-height: 50px;
      font-size: 14px;
      color: #fff;
      margin: auto;
      padding-top: 20px;
      position: relative;
    }
    /*logo CSS*/
    .listhead .header .logo {
      width: 120px;
      margin-top: -1px;
      margin-left: 60px;
    }
    .header .logo {
      width: 120px;
      height:50px;
      margin-top: 0px;
      float: left;
    }
    .listhead .header .nav {
      height: 60px;
      font-size: 15px;

    }
    /* .header .nav {
       width: 850px;
       height: 50px;
       float: left;
       font-size: 18px;
       font-weight: bold;
       margin-left: 100px;
     }*/
    /*顶上字体CSS*/
    .header .nav {
      width: 600px;
      height: 30px;
      float: right;
      font-size: 15px;
      font-weight:bold;
      margin-right: 350px;
      margin-top: -30px;
    }
    /*登录注册字体CSS*/
    .header .nav1 {
      width: 100px;
      height: 30px;
      float: right;
      font-size: 12px;
      font-weight: bold;
      margin-top: -7px;
      margin-right: -5px;
    }
    /*搜索框大小CSS*/
    .listhead .header .nav span {
      height: 160px;
      margin: 0;
    }
    .listhead .header .nav span .hrf {
      height: 60px;
      line-height: 60px;
      margin: 0;
      padding: 0 18px;
      border: 0;
    }
    .header a {
      color: #fff;
    }
    /*搜索栏灰色底框距离底部的距离*/
    .wsrrent {
      width: 100%;
      border-bottom: 1px solid #ddd;
      background: #fff;
      margin-bottom: 30px;
      box-shadow: 0 1px 1px #e1e1e1;
    }

    /*搜索栏白色底框CSS*/
    .wsrrent .container {
      width: 100%;
      height:110px;
      margin-top: 70px;             /*搜索底框的上边距离顶栏的距离*/
      background:#faf7fa;
    }

    /*范围栏*/
    .container {
      width: 1200px;
      margin: auto;
    }
    .subsh {
      height: 35px;
      padding: 10px 0;
    }
    /*搜索框边线*/
    .subsh_l {
      width: 388px;
      height: 33px;
      border: 1px solid #bbb;
      position: relative;
      background: #fff;
      margin-left: 110px;
      margin-top:20px;
    }
    .fl {
      float: left;
    }
    /*搜索小框内文字*/
    .subsh_l .sd_sel {
      width: 60px;
      height: 33px;
      font-size: 14px;
      padding-left: 5px;
      position: relative;
      margin-right: 5px;
    }
    .subsh_l .sd_sel span {
      width: 50px;
      padding-right: 8px;
      text-align: center;
      height: 33px;
      line-height: 33px;
      background: url(${pageContext.request.contextPath}/jsp/images/rentWindow/djimg23.png) no-repeat right center;
      display: block;
      white-space: nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
      cursor: pointer;
    }
    .subsh_l .sd_sel ul {
      width: 50px;
      position: absolute;
      top: 33px;
      left: 0;
      z-index: 99;
      background: #fff;
      border: 1px solid #888;
      padding: 5px;
      display: none;
    }
    .subsh_l .sd_sel ul li {
      line-height: 24px;
      white-space: nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
      cursor: pointer;
    }
    ol, ul, li {
      list-style: none;
    }
    .subsh_l .text {
      width: 260px;
      height: 18px;
      line-height: 18px;
      padding: 0 10px;
      float: left;
      margin-top: 7px;
      border: 0;
      background: 0;
      color: #888;
    }
    input[type="text"], input[type="passwrod"] {
      outline: none;
    }
    input {
      -webkit-appearance: textfield;
      background-color: white;
      -webkit-rtl-ordering: logical;
      user-select: text;
      cursor: auto;
      padding: 1px;
      border-width: 2px;
      border-style: inset;
      border-color: initial;
      border-image: initial;
    }
    .subsh_l #autoSearchItem {
      width: 100%;
      top: 34px;
      left: -1px;
      z-index: 9999;
    }
    #autoSearchItem {
      width: 600px;
      background: #fff;
      border: 1px solid #ddd;
      position: absolute;
      top: 50px;
      left: 0;
      visibility: hidden;
    }
    .subsh_l .submit {
      width: 35px;
      height: 33px;
      float: right;
      font-size: 0;
      background: url(${pageContext.request.contextPath}/jsp/images/rentWindow/djimg24.png) no-repeat center center;
      border: none;
    }
    input[type="button"], input[type="file"], input[type="submit"], input[type="reset"] {
      -webkit-appearance: none;
      border: none;
      cursor: pointer;
      outline: none;
      border: 0;
    }
    .subsh_r {
      width: 158px;
      height: 35px;
      border-radius: 5px;
      font-size: 14px;
      font-weight: bold;
      overflow: hidden;
    }
    .fr {
      float: right;
    }
    .subsh_r .al {
      width: 85px;
      height: 31px;
      line-height: 31px;

      /*border: 2px solid #ddd;*/
      /*border-right: none;*/
      /*border-top-left-radius: 5px;
      border-bottom-left-radius: 5px;*/

      color: #333;
    }
    .subsh_r a {
      height: 35px;
      line-height: 35px;
      text-align: center;
      float: left;
      overflow: hidden;
      display: block;
    }
    a {
      text-decoration: none;
      color: #333;
      outline: none;
    }
    .subsh_r .al span {
      padding-left: 15px;
      background: url(${pageContext.request.contextPath}/jsp/images/rentWindow/djimg25.png) no-repeat left center;


    }
    .subsh_r a span {
      display: inline-block;
    }
    strong, b {
      font-weight: bold;
      font-size: 16px;

    }
    .subsh_r .al span i {
      display: none;


    }
    i, em {
      font-style: normal;
    }
    .bodywhitew {
      width: 1220px;
      margin-bottom: 10px;
    }
    .container {
      width: 1200px;
      margin: auto;
    }
    .current {
      width: 1205px;
      /*margin: auto;*/
      margin-left: 30px;
      font-size: 14px;
      height: 32px;
      line-height: 32px;
      color: #666;
      padding-left: 15px;
      background: url(${pageContext.request.contextPath}/jsp/images/rentWindow/djimg25.png) no-repeat left center;
      overflow: hidden;
    }
    .current a {
      color: #666;
    }
    .nv_list {
      position: relative;
    }
    .nv_list .nvtit {
      width: 1020px;
      height: 40px;
      border-bottom: 1px solid #ddd;
      overflow: hidden;
      background: #fff;
    }
    ol, ul, li {
      list-style: none;
    }
    .nv_list .nvtit li.active {
      color: #c00000;
    }
    .nv_list .nvtit li {
      height: 40px;
      line-height: 40px;
      padding: 0 15px;
      float: left;
      font-size: 16px;
      color: #666;
      font-weight: bold;
      cursor: pointer;
    }
    .nv_list .nvtit li.active span {
      background: url(${pageContext.request.contextPath}/jsp/images/rentWindow/ppimg15-1.png) no-repeat center center;
      display: none;
    }
    .nv_list .nvtit li span {
      width: 14px;
      height: 40px;
      vertical-align: middle;
      display: inline-block;
      background: url(${pageContext.request.contextPath}/jsp/images/rentWindow/ppimg15.png) no-repeat center center;
      margin-left: 2px;
      font-size: 0;
    }
    .nv_menu {
      border-top: none;
      display: none;
      background: #fff;
      margin-left: 30px;
      margin-right: 20px;

    }
    .nv_menu ul {
      padding: 10px 20px 0 20px;

    }
    .nv_menu li {
      padding: 6px 0;
      font-size: 14px;
      line-height: 24px;
    }
    .nv_menu li strong {
      font-weight: bold;
    }
    .nv_menu li .on {
      color: #C00000;
      font-weight: bold;
    }
    .nv_menu li a {
      display: inline-block;
      cursor: pointer;
      margin-right: 20px;
    }
    a {
      text-decoration: none;
      color: #333;
      outline: none;
    }
    .nv_menu li .ipt1 {
      width: 40px;
      height: 18px;
      border: 1px solid #ccc;
      text-align: center;
      margin-right: 3px;
    }
    input[type="text"], input[type="passwrod"] {
      outline: none;
    }
    .list_tit {
      width: 100%;
      height: 35px;
      line-height: 35px;
      font-size: 14px;
      margin-top: 10px;
      border-bottom: 1px solid #ccc;
      overflow: hidden;
    }
    .list_tit .cenl {
      width: 500px;
      height: 35px;
      overflow: hidden;
      margin-left: 30px;
    }
    .fl {
      float: left;
    }
    .list_tit .cenl strong {
      color: #c00000;
      font-weight: bold;
    }
    i, em {
      font-style: normal;
    }
    .list_tit .cenr {
      width: 600px;
      height: 35px;
      text-align: right;
      overflow: hidden;
      margin-right: 20px;
    }
    .fr {
      float: right;
    }
    .list_tit a.first {
      margin: 0;
    }
    .list_tit .active {
      font-weight: bold;
      color: #c00000;
    }
    .list_tit a {
      margin-left: 10px;
    }
    a {
      text-decoration: none;
      color: #333;
      outline: none;
    }
    .list_tit .hovs {
      background: url(${pageContext.request.contextPath}/jsp/images/rentWindow/djimg80.png) no-repeat right center;
    }
    .list_tit .hovs, .list_tit .hovx {
      padding-right: 10px;
    }
    .list_tit a {
      margin-left: 10px;
    }
    a {
      text-decoration: none;
      color: #333;
      outline: none;
    }
    .list_tit .hovx {
      background: url(${pageContext.request.contextPath}/jsp/images/rentWindow/djimg81.png) no-repeat right center;
    }
    .list_tit .hovs, .list_tit .hovx {
      padding-right: 10px;
    }
    .list_tit a {
      margin-left: 10px;
    }
    a {
      text-decoration: none;
      color: #333;
      outline: none;
    }
    ol, ul, li {
      list-style: none;
    }
    ul, menu, dir {
      display: block;
      list-style-type: disc;
      -webkit-margin-before: 1em;
      -webkit-margin-after: 1em;
      -webkit-margin-start: 0px;
      -webkit-margin-end: 0px;

      margin-left: 30px;
      margin-right: 20px;


    }
    .mor_list li {
      height: 190px;
      padding: 20px 10px 20px 195px;
      background: #fff;
      border-bottom: 1px solid #eee;
      overflow: hidden;
      cursor: pointer;
      position: relative;

    }
    .data_link {
      width: 100%;
      height: 100%;
      position: absolute;
      top: 0;
      left: 0;
      z-index: 200;
      display: block;

    }
    a {
      text-decoration: none;
      color: #333;
      outline: none;
    }
    .mor_list li .mor_img {
      width: 185px;
      height: 150px;
      overflow: hidden;
      background: #ccc;
      position: absolute;
      top: 20px;
      left: 10px;
      z-index: 1;
      font-size: 14px;
      font-weight: bold;
    }
    a {
      text-decoration: none;
      color: #333;
      outline: none;
    }
    .mor_list li .mor_img img {
      width: 100%;
      height: 100%;
    }
    fieldset, img {
      border: 0;
    }
    .mor_list li .mor_txt {
      width: 100%;
      height: 150px;
      margin-left: 10px;
      position: relative;
      left:50px;
    }
    .mor_list li .mor_txt h3 {
      font-family: "Hiragino Sans GB", 微软雅黑, "Microsoft YaHei", SimHei, Tahoma, 宋体b8b体, SimSun, sans-serif;
      color: rgb(51, 51, 51);
      font-size: 20px;
      font-weight: 700;
      vertical-align: middle;
    }
    .mor_list li .mor_txt .dot {
      width: 100%;
      height: 48px;
    }
    .mor_list li .mor_txt p {
      width: 100%;
      height: 24px;
      margin-top: 10px;
      line-height: 24px;
      font-size: 14px;
      color: #666;
      overflow: hidden;
    }
    .mor_list li .mor_txt .dor {
      height: 24px;
      padding-left: 15px;
      background: url(${pageContext.request.contextPath}/jsp/images/rentWindow/djimg25.png) no-repeat left center;
      white-space: nowrap;
      text-overflow: ellipsis;
    }
    p {
      display: block;
      -webkit-margin-before: 1em;
      -webkit-margin-after: 1em;
      -webkit-margin-start: 0px;
      -webkit-margin-end: 0px;
    }
    .mor_list li .mor_txt a {
      height: 22px;
      line-height: 22px;
      display: block;
      float: left;
      margin-right: 5px;
      border: 1px solid;
      padding: 0 5px;
      cursor: default;

    }
    .bq_cor_1, .bq_cor_11, .bq_cor_21, .bq_cor_31, .bq_cor_41, .bq_cor_51, .bq_cor_61, .bq_cor_71, .bq_cor_81, .bq_cor_91, .bq_cor_101, .bq_cor_111, .bq_cor_121, .bq_cor_131, .bq_cor_141, .bq_cor_151, .bq_cor_161, .bq_cor_171, .bq_cor_181, .bq_cor_191 {
      color: #ff943e;
      border-color: #ff943e;
    }
    .bq_cor_2, .bq_cor_12, .bq_cor_22, .bq_cor_32, .bq_cor_42, .bq_cor_52, .bq_cor_62, .bq_cor_72, .bq_cor_82, .bq_cor_92, .bq_cor_102, .bq_cor_112, .bq_cor_122, .bq_cor_132, .bq_cor_142, .bq_cor_152, .bq_cor_162, .bq_cor_172, .bq_cor_182, .bq_cor_192 {
      color: #9a89b9;
      border-color: #9a89b9;
    }
    .bq_cor_3, .bq_cor_13, .bq_cor_23, .bq_cor_33, .bq_cor_43, .bq_cor_53, .bq_cor_63, .bq_cor_73, .bq_cor_83, .bq_cor_93, .bq_cor_103, .bq_cor_113, .bq_cor_123, .bq_cor_133, .bq_cor_143, .bq_cor_153, .bq_cor_163, .bq_cor_173, .bq_cor_183, .bq_cor_193 {
      color: #47a8d9;
      border-color: #47a8d9;
    }
    a {
      text-decoration: none;
      color: #333;
      outline: none;
    }
    .mor_list li .mor_tip:last-child {
      right: 0;
    }
    .mor_list li .mor_w {
      width: 240px;
    }

    .mor_list li .mor_tip p {
      height: 30px;
      line-height: 30px;
      color:#003300;
      font-size: 16px;
    }
    .mor_list li .mor_tip strong {

      color: #f15044;
      font-size: 30px;

      font-family: "Tahoma";
      vertical-align: -2px;
    }
    .mor_list li .mor_tip:last-child {
      right: 0;
    }
    .mor_list li .mor_w {
      width: 240px;
    }
    .mor_list li .mor_tip {
      width: 180px;
      text-align: center;
      font-size: 14px;
      line-height: 18px;
      overflow: hidden;
      position: absolute;
      top: 65px;
      right: 170px;
      z-index: 1;
      margin-right: 40px;
    }

    #pagination {
      width: 1120px;
      font-size: 16px;
      text-align: center;
      padding: 10px 0;
      clear: both;
      background: #fff;
      overflow: hidden;
      margin-left: 30px;

    }
    .pagination .sel.next, .pagination .sel.prev {
      color: #333;
      border-color: #666;


    }
    .pagination .sel {
      color: #c00000;
      border-color: #c00000;

    }
    .pagination a, .pagination span {
      min-width: 16px;
      height: 32px;
      line-height: 32px;
      border: 1px solid #666;
      text-align: center;
      margin: 5px 2px;
      padding: 0 8px;
      display: inline-block;
      vertical-align: top;
      cursor: pointer;
    }
    * {
      font-family: "Microsoft YaHei",Helvetica,sans-serif;
      font-family: "宋体", Helvetica, Arial, sans-serif;
      word-break: break-all;
    }
  </style>
  
    <script type="text/javascript">
      function showall(){
        var temp = document.getElementById("serchar");
        temp.style.display = "block";
      }
      function hideall(){
        var temp = document.getElementById("serchar");
        temp.style.display = "none";
      }
      $(function(){
        $("ul .sel").click(function(){
        	var temp = document.getElementById("keyword");
            temp.value = $(this).text();
          $("span#searchName").text($(this).text());
        });
      });
    </script>
    
    
</head>
<body>
  <div class="fotpof">
    <div class="pofcons pofsoll pofcont">
      <span></span>
      <div>
      </div>
    </div>
    <div class="headerbg listhead">
      <div class="header">
        <a href=${pageContext.request.contextPath}/jsp/html/homepage.jsp>
          <img src=${pageContext.request.contextPath}/jsp/images/rentWindow/logo1.png class="logo" >
        </a>
        <div class="nav1 navml">
        <span>
              <%
              if (s.getAttribute("user") == null) {
            	  out.println("<a href=/EasyHousing/jsp/html/logIn.jsp class=\"href\">登录</a>");
              }
              else {
            	  out.println("<a href=/EasyHousing/userCenter.do class=\"href\">个人中心</a>");
              } %>
          </span>
          /
          <span>
          
          	<%
              if (s.getAttribute("user") == null) {
            	  out.println("<a href=/EasyHousing/jsp/html/register.jsp class=\"href\">注册</a>");
              }
              else {
            	  out.println("<a href=/EasyHousing/logout.do class=\"href\">注销</a>");
              }
          	%>
          </span>
	  </div>
	        <div class="nav navml">
	          <span>
	            <a href=${pageContext.request.contextPath}/jsp/html/homepage.jsp class="href">首页</a>&nbsp&nbsp&nbsp
	          </span>
	          <span>
	            <a href=${pageContext.request.contextPath}/jsp/html/homepage.jsp class="href">二手房</a>&nbsp&nbsp&nbsp
	          </span>
	          <span>
	            <a href=${pageContext.request.contextPath}/buildingSelect.do class="href">新房</a>&nbsp&nbsp&nbsp
	          </span>
	          <span>
	            <a href=${pageContext.request.contextPath}/rentHouseSelect.do class="href">租房</a>
	          </span>
	
	        </div>
	      </div>
	    </div>
    <div class="wsrrent">
      <div class="container">
        <div class="subsh subsher">
         <form action=${pageContext.request.contextPath}/mapSearch.do method="post" id="searchForm">
          <div class="subsh_l fl">
            <div class="sd_sel fl">
            <input hidden=true id="keyword" value="新房" name="which"></input>
              <span id="searchName" onclick="showall()">新房</span>
				<ul id="serchar" onmouseleave="hideall()">
					<li class="sel">新房</li>
					<li class="sel">租房</li>
				</ul>
            </div>
            <input type="text" name="content" placeholder="请输入小区、地铁、区域开始找房" class="text" id="autoSearchText" maxlength="20" autocomplete="off">
            <div id="autoSearchItem" style="height: 285px; visibility: hidden;">
              <ul class="menu_v"></ul>
            </div>
            <input type="button" value class="submit" id="btnSearch" onclick="document.getElementById('searchForm').submit();">
            <input type="hidden" value="1" id="pageIndex">
          </div>
          </form>
          <div class="subsh_r fr">
            <!--<a href="#" class="al">-->
                <!--<span>-->
                  <!--<b>地图找房</b>-->
                  <!--<i>地图</i>-->
                <!--</span>-->
            <!--</a>-->
          </div>
        </div>
      </div>
    </div>
  </div>
  <div  id="allmap" style="width:100%;height:1000px;">
  </div>
</body>
</html>
<script type="text/javascript">
  // 百度地图API功能
  var map = new BMap.Map("allmap");    // 创建Map实例
  map.centerAndZoom(new BMap.Point(106.33,29.34), 12);  // 初始化地图,设置中心点坐标和地图级别
  map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
  map.addControl(new BMap.NavigationControl({enableGeolocation:true}));
  map.addControl(new BMap.OverviewMapControl());
  map.setCurrentCity("重庆");          // 设置地图显示的城市 此项是必须设置的
  map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
</script>
