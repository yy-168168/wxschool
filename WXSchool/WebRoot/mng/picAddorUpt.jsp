<%@ page language="java" import="java.util.*,com.wxschool.entity.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String token = request.getParameter("token");
	String ac = request.getParameter("ac");
	String keyword = "", title = "", desc = "", picUrl = "", picId = "-1";
	Pic pic = (Pic) request.getAttribute("pic");
	if (pic != null) {
		keyword = pic.getKeyword();
		title = pic.getTitle();
		picUrl = pic.getPicUrl();
		desc = pic.getDesc();
		picId = pic.getPicId() + "";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>微接口 - 自定义图片回复</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="shortcut icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link rel="icon" href="static_/favicon.ico" type="imagend.microsoft.icon">
		<link href="static_/mng.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="static_/jquery-1.8.2.min.js">
</script>
		<script type="text/javascript" src="static_/mng.js">
</script>

		<script type="text/javascript">
function check() {
	var keyword = document.getElementsByName("keyword")[0].value;
	var title = document.getElementsByName("title")[0].value;
	var picUrl = document.getElementsByName("picUrl")[0].value;
	var desc = document.getElementsByName("desc")[0].value;

	if ($.trim(keyword) == "" || $.trim(title) == "" || $.trim(picUrl) == "") {
		showNotice("不能为空！");
		return false;
	}

	if (keyword.length > 100 || title.length > 200 || picUrl.length > 300 || desc.length > 500) {
		showNotice("数据过长！");
		return false;
	}

	$(":button").attr("disabled", true);
	$(":button").val("提交中...");

	var url = "/mngs/pic?ac=<%=ac%>&token=<%=token%>";
	$.post(url, {
		picId : '<%=picId%>',
		keyword : keyword,
		title : title,
		picUrl : picUrl,
		desc : desc
	}, function(msg) {
		if (msg == "uptfalse" || msg == "addfalse") {
			showNotice("操作失败，请重试！");
			$(":button").attr("disabled", false);
			$(":button").val("保存");
		} else {
			if ('<%=ac%>'.indexOf("add") >= 0) {
				isGoonUpt();
			} else {
				window.location.href = document.referrer;
			}
		}
	});
}
</script>
	</head>
	<body>
		<jsp:include page="head.jsp"></jsp:include>

		<div class="content">
			<div class="left">
				<jsp:include page="/mng/menuLeft.jsp">
					<jsp:param value="" name="id" />
				</jsp:include>
			</div>

			<div class="right">
				<div class="title">
					添加/更新图片回复
					<div style="float: right">
						<a href="javascript:history.go(-1);">返回</a>
					</div>
				</div>
				<div style="padding: 20px;">

					<form method="post">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td class="form_title">
									关键字
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="keyword" value="<%=keyword%>"
										class="input_text" size="30">
									<span class="textSpan">多个关键字之间用|隔开</span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									标题
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="title" value="<%=title%>"
										class="input_text" size="50">
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
									图片外链地址
									<span class="myrequired">*</span>
								</td>
								<td>
									<input type="text" name="picUrl" value="<%=picUrl%>"
										class="input_text" size="50">
									<br />
									<span class="textSpan">图片大小：宽度最多不要超过800px，高度不限，图片太大会加载过慢</span>
									<a href="javascript:tuchuang();" style="font-size: 13px">获取外链</a>
								</td>
							</tr>
							<%
								if (picUrl != null && !picUrl.equals("")) {
							%>
							<tr>
								<td></td>
								<td>
									<img alt="" src="<%=picUrl%>" width="260px"
										style="border: 1px solid #EEE">
								</td>
							</tr>
							<%
								}
							%>
							<tr>
								<td class="form_title">
									描述
								</td>
								<td>
									<textarea name="desc" class="textarea" cols="50" rows="3"
										style="resize: none;"><%=desc%></textarea>
									<span class="textSpan"></span>
								</td>
							</tr>
							<tr>
								<td class="form_title">
								</td>
								<td>
									<input type="button" value="保存" class="input_button"
										onclick="check();">
									<div id="erromsg" style="display: inline;"></div>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>

		<%@ include file="../common/foot.html"%>
		<%@ include file="../common/tongji.html"%>
	</body>
</html>
