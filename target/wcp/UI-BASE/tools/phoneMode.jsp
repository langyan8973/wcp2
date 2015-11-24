<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>模拟器-<PF:ParameterValue key="config.sys.title" />
		</title>
		<meta name="viewport"
			content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<style>
<!--
.mobile-width {
	height: 703px !important;
	margin: 0 auto;
	padding: 165px 115px 100px 100px;
	width: 1041px;
	margin-top: 4px;
	background: url(bg-mob.png) no-repeat 0 -1249px
}

.mobile-width iframe {
	height: 704px !important
}

.mobile-width-2 {
	height: 417px !important;
	margin: 0 auto;
	padding: 125px 25px 159px 25px;
	width: 337px;
	margin-top: 4px;
	background: url(bg-mob.png) no-repeat 0 -2217px
}

.mobile-width-2 iframe {
	height: 416px !important
}

.mobile-width-3 {
	height: 256px !important;
	margin: 0 auto;
	padding: 45px 115px 69px 105px;
	width: 497px;
	margin-top: 40px;
	background: url(bg-mob.png) no-repeat -387px -2217px
}

.mobile-width-3 iframe {
	height: 256px !important
}
-->
</style>
	</head>
	<body>
		<div class="mobile-width-2">
			<iframe id="iframe" src="<PF:basePath/>" frameborder="0" width="100%"
				height="567px"></iframe>
		</div>
		<div class="mobile-width-3">
			<iframe id="iframe" src="<PF:basePath/>" frameborder="0" width="100%"
				height="567px"></iframe>
		</div>
		<div class="mobile-width">
			<iframe id="iframe" src="<PF:basePath/>" frameborder="0" width="100%"
				height="567px"></iframe>
		</div>
	</body>
</html>