<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${doc.title}-<PF:ParameterValue key="config.sys.title"/>
		</title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
		<script src="<PF:basePath/>WEB-FACE/model/syntax-highlighter/brush.js"></script>
		<link
			href="<PF:basePath/>WEB-FACE/model/syntax-highlighter/shCore.css"
			rel="stylesheet" />
		<link
			href="<PF:basePath/>WEB-FACE/model/syntax-highlighter/shThemeDefault.css"
			rel="stylesheet" />
	</head>
	<style type="text/css">
html,body {
	margin: 0px 0px;
	width: 100%;
	height: 100%;
}

iframe {
	margin: 0px 0px;
	width: 100%;
	height: 100%;
}
</style>
	<body>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%">
			<tr>
				<td height="50px"><jsp:include page="../commons/head.jsp"></jsp:include>
				</td>
			</tr>
			<tr>
				<td style="height: 100%;">
					<iframe id="iframeId" frameborder="0" 
						style="width: 100%; height: 100%" src="${doc.indexUrl}" />
					</iframe>
				</td>
			</tr>
		</table>
	</body>
</html>