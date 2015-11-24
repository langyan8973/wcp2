<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<base href="<PF:basePath/>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${user.name}-<PF:ParameterValue key="config.sys.title" /></title>
<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
<script charset="utf-8"
	src="<PF:basePath/>WEB-FACE/model/supervilidate/validate.js"></script>
<script charset="utf-8"
	src="<PF:basePath/>WEB-FACE/model/kindeditor/kindeditor-all-min.js"></script>
<link rel="stylesheet"
	href="<PF:basePath/>WEB-FACE/model/kindeditor/themes/default/default.css" />
</head>
<body>
	<jsp:include page="../commons/head.jsp"></jsp:include>
	<div class="containerbox">
		<div class="container ">
			<div class="row">
				<div class="col-sm-12">
					<!-- ID,TITLE,DOCDESCRIBE,AUTHOR,PUBTIME,TAGKEY ,IMGID,VISITNUM,PRAISEYES,PRAISENO,HOTNUM,TYPENAME -->
					<div class="row">
						<div class="col-md-12">
						    <script type="text/javascript">var userid='${id}';</script>
							<jsp:include page="/UI-WEB/statis/commons/includeMyStatis.jsp"></jsp:include>
						</div>
					</div>
					<div id="mygroupLoadDivId" >
					</div>
					<script type="text/javascript">
						$(function() {
							loadMyGroupList(1);
						});
						function loadMyGroupList(pagenum) {
							$('#mygroupLoadDivId').load("index/FPloadUserGroups.htm", {
								id : '${id}',
								'query.currentPage' : pagenum
							});
						}
					</script>
					<jsp:include page="/UI-WEB/docgroup/commons/impl/docsMinNoPage.jsp"></jsp:include>
					<div class="row">
						<div class="col-xs-12">
							<ul class="pagination pagination-sm">
								<c:forEach var="page" begin="${result.startPage}"
									end="${result.endPage}" step="1">
									<c:if test="${page==result.currentPage}">
										<li class="active"><a>${page} </a></li>
									</c:if>
									<c:if test="${page!=result.currentPage}">
										<li><a href="javascript:knowBoxGoPage(${page})">${page}
										</a></li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../commons/foot.jsp"></jsp:include>
</body>
<script type="text/javascript">
	function knowBoxGoPage(page) {
		window.location = "index/FPuserHome.htm?id=${id}&query.currentPage=" + page;
	}
</script>
</html>