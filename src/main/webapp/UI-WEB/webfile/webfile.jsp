<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<base href="<PF:basePath/>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${doc.title}-<PF:ParameterValue key="config.sys.title" /></title>
<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../commons/head.jsp"></jsp:include>
	<div class="containerbox">
		<div class="container">
			<div class="row">
				<div class="col-md-3  visible-lg visible-md">
					<!-- 需要特殊显示的文件_开始 -->
					<p style="text-align: center;">
						<c:forEach var="node" items="${fileTypes}">
							<img style="max-height: 128px; max-width: 128px;" alt="${node}"
								src="WEB-FACE/img/fileicon/${node}.png" />
						</c:forEach>
					</p> 
					<!-- 需要特殊显示的文件_结束 -->
					<jsp:include page="/UI-WEB/know/commons/includeOnlyPraiseDoc.jsp"></jsp:include>
				</div>
				<div class="col-md-9">
					<jsp:include page="doc.jsp"></jsp:include>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../commons/foot.jsp"></jsp:include>
	<script type="text/javascript">
		$(function() {
			$('img', '#docContentsId').addClass("img-thumbnail");
		});
	</script>
</body>
</html>