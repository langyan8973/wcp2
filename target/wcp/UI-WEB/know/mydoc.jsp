<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>我的知识-<PF:ParameterValue key="config.sys.title"/>
		</title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
		<link rel="stylesheet"
			href="<PF:basePath/>WEB-FACE/model/kindeditor/themes/default/default.css" />
		<script charset="utf-8"
			src="<PF:basePath/>WEB-FACE/model/kindeditor/kindeditor-all-min.js"></script>
		<script charset="utf-8"
			src="<PF:basePath/>WEB-FACE/model/kindeditor/zh_CN.js"></script>
		<script charset="utf-8"
			src="<PF:basePath/>WEB-FACE/model/supervilidate/validate.js"></script>
	</head>
	<body>
		<jsp:include page="../commons/head.jsp"></jsp:include>
		<div class="containerbox">
			<div class="container ">
				<div class="row">
					<div class="col-md-3  visible-lg visible-md">
						<div class="panel panel-default userbox">
							<div class="panel-body">
								<jsp:include page="/UI-WEB/commons/includeUserPanel.jsp"></jsp:include>
								<jsp:include page="../commons/loginbox.jsp"></jsp:include>
							</div>
						</div>
						<div class="panel panel-default userbox">
							<div class="panel-body">
								<jsp:include page="commons/includePubType.jsp"></jsp:include>
							</div>
						</div>
						<jsp:include page="commons/includeHotKnowsMin.jsp"></jsp:include>
					</div>
					<div class="col-md-9">
						<!-- ID,TITLE,DOCDESCRIBE,AUTHOR,PUBTIME,TAGKEY ,IMGID,VISITNUM,PRAISEYES,PRAISENO,HOTNUM,TYPENAME -->
						<div class="row">
							<div class="col-sm-12" style="margin-bottom: 8px;">
								<hr />
								<h3>
									<span style="color: #D9534F; font-weight: bold;"
										class="glyphicon glyphicon-tag">我的知识</span>
								</h3>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<ol class="breadcrumb">
									<c:forEach items="${result.resultList}" var="node">
										<li>
											<a href="index/FPDocShow.htm?id=${node.ID}">${node.TITLE}</a>
										</li>
									</c:forEach>
								</ol>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<ul class="pagination pagination-sm">
									<c:forEach var="page" begin="${result.startPage}"
										end="${result.endPage}" step="1">
										<c:if test="${page==result.currentPage}">
											<li class="active">
												<a>${page} </a>
											</li>
										</c:if>
										<c:if test="${page!=result.currentPage}">
											<li>
												<a href="javascript:knowBoxGoPage(${page})">${page} </a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</div>
						<jsp:include page="commons/impl/docs.jsp"></jsp:include>
						<div class="row">
							<div class="col-xs-12">
								<ul class="pagination pagination-sm">
									<c:forEach var="page" begin="${result.startPage}"
										end="${result.endPage}" step="1">
										<c:if test="${page==result.currentPage}">
											<li class="active">
												<a>${page} </a>
											</li>
										</c:if>
										<c:if test="${page!=result.currentPage}">
											<li>
												<a href="javascript:knowBoxGoPage(${page})">${page} </a>
											</li>
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
		<script type="text/javascript">
	function knowBoxGoPage(page) {
		window.location="index/FPMyDocShow.htm?query.currentPage="+ page;
	}
</script>
	</body>
</html>