<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
	String aId = request.getParameter("aId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>所有餐店</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport"
			content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>static_/favicon.ico" />
		<link href="<%=basePath %>static_/mycommon.css" type="text/css" rel="stylesheet">
		<link href="<%=basePath %>static_/myfont.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="<%=basePath %>static_/mycommon.js?v=487234783">
</script>
		<script type="text/javascript" src="<%=basePath %>static_/jquery-1.8.2.min.js">
</script>

		<style type="text/css">
.allres {
	padding: 10px 0;
}

.img {
	float: left;
	width: 33%
}

.img img {
	width: 95%;
	height: 65px;
	border-radius: 6px;
}

.allres_2 {
	float: right;
	width: 66%
}

.allres_2_1 {
	font-size: 20px;
	font-weight: 500;
}

.allres_2_2 {
	color: #666;
	font-size: 14px;
}
</style>
		<script type="text/javascript">
$(function() {
	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');

	//act();
});

function act() {
	$(".allres").each(
			function() {
				var resName = $(this).find(".allres_2_1").text();
				if (resName.match(".*咖喱.*")) {
					$(this).css("background-color", "#FFD5D5");
					$(this).find(".allres_2_1").append(
							"(<span style='color:red'>活动中</span>)");
					return false;
				}
			});
}

function updateVisitPerson(resId, locUrl) {
	$.get("/mobile/food?ac=updateVisitPerson&wxaccount=<%=wxaccount%>&resId=" + resId,
			function() {
				if (locUrl.indexOf("http") >= 0) {
					window.location.href = locUrl;
				} else {
					window.location.href = "/mobile/food?ac=getFoods&resId=" + resId
							+ "&wxaccount=<%=wxaccount%>";
				}
			});
}
</script>
	</head>

	<body onload="checkMM();">
		<div>
			<%
				List<Res> ress = (List<Res>) request.getAttribute("ress");

				for (int i = 0; i < ress.size(); i++) {
					Res res = ress.get(i);
			%>
			<div class="view_box_white"
				onclick="updateVisitPerson('<%=res.getResId()%>','<%=res.getLocUrl()%>');">
				<div class="img">
					<img alt="" src="<%=res.getPicPath()%>">
				</div>
				<div class="allres_2">
					<span class="allres_2_1"><%=res.getResName()%></span>
					<span style="float: right; font-size: 12px; color: #999"><%=res.getVisitPerson()%></span>
					<%--<img alt="" src="static_/vp2.png" height="14px" style="float: right; vertical-align: middle; opacity: 0.4;">--%>
					<span class='glyphicon glyphicon-user'
						style='color: #999; font-size: 12px; float: right;'></span>
					<br />
					<span class="allres_2_2">add：<%=res.getAddress()%></span>
					<br />
					<span class="allres_2_2">tel：<a href="tel:<%=res.getTel()%>"
						style="color: #666; text-decoration: none;"><%=res.getTel()%></a>
					</span>
				</div>
				<div style="clear: both;"></div>
			</div>
			<div class="fgx"></div>
			<%
				}
			%>
		</div>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
