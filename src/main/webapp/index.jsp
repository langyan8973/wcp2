<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title><PF:ParameterValue key="config.sys.title" /></title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	</head>
	<script type="text/javascript">
	window.location = '<PF:ParameterValue key="config.index.homepage"/>';
</script>
	<body>
		Loading...
		<br>
	</body>
</html>
