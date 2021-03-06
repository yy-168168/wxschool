<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wxaccount = request.getParameter("wxaccount");
	String userwx = request.getParameter("userwx");
	String aId = request.getParameter("aId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>学费查询</title>

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
.score {
	border-top: 1px solid blue;
	border-bottom: 1px solid blue;
	margin-bottom: 8px;
}

.detail {
	border-top: 1px solid #ddd;
	display: none;
}

.main table {
	font-size: 16px;
}

.detail table {
	font-size: 14px;
}
</style>
		<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideOptionMenu');
	// WeixinJSBridge.call('hideToolbar');
	});

$(function() {
	setPersonIdAndPassword('<%=wxaccount%>', '<%=userwx%>');
	
	updateArticleVisitPerson('<%=wxaccount%>', '<%=aId%>');
});

function check() {
	var username = document.getElementsByName("username")[0].value;
	var password = document.getElementsByName("password")[0].value;
	var code = document.getElementsByName("code")[0].value;

	if ($.trim(username) == "" || $.trim(password) == "" || $.trim(code) == "") {
		$("#msg").text("不能为空");
		return false;
	}

	$("#submit").attr("disabled", true);
	$("#submit").val("提交中...");

	var url = "/mobile/edu?ac=fee_&wxaccount=<%=wxaccount%>&userwx=<%=userwx%>";
	$
			.post(
					url,
					{
						username : username,
						password : password,
						code : code
					},
					function(data) {
						var obj;
						try{
							obj = $.parseJSON(data);
						}catch(e){
							alert("出错啦");
						}
						
						if (obj == "wrong") {
							alert("网络连接出错");
						} else {
							alert(obj);
						}
						document.getElementsByName("code")[0].value = "";
						document.getElementById("validateCode").src = "/mobile/edu?ac=getValidateCode&wxaccount=<%=wxaccount%>&t="
								+ Math.random();

						$("#submit").attr("disabled", false);
						$("#submit").val("提  交");
					});
}
</script>
	</head>

	<body onload="checkMM();" onunload="resetAll();">

		<form method="post">
			<div class="html5yj">
				<div class="formhead_n">
					<div>
						<span class="glyphicon glyphicon-edit"></span>&nbsp;教务平台用户登录
					</div>
					<div>
						1.请避开高峰期时段查询
						<br />
						2.点击验证码图片可刷新
					</div>
				</div>
				<div style="padding: 10px 10px 3px 10px">
					<div class="text1">
						登录名(用户名/身份证号/邮箱)
					</div>
					<input type="text" name="username" value=""
						class="html5input_n" onclick="clearMsg();">
					<hr />
					<div class="text1">
						密码
					</div>
					<input type="password" name="password" value=""
						class="html5input_n" onclick="clearMsg();">
					<hr />
					<div class="text1">
						验证码
					</div>
					<input type="text" name="code" class="html5input_n"
						style="width: 50%" onclick="clearMsg();">
					<img id="validateCode" alt="点击刷新"
						src="/mobile/edu?ac=getValidateCode&wxaccount=<%=wxaccount%>&t=<%=Math.random()%>"
						onclick="javascript:this.src='/mobile/edu?ac=getValidateCode&wxaccount=<%=wxaccount%>&t='+Math.random();"
						style="max-width: 48%; vertical-align: bottom; color: blue; font-size: 13px;">
					<hr />
					<input id="submit" type="button" value="提 交" class="html5btn"
						onclick="check();">
					<div id="msg"></div>
				</div>
			</div>
		</form>

		<jsp:include page="../common/copyright.jsp" />
		<%@ include file="../common/toolbar.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
