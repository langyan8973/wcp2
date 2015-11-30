<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>图片墙-<PF:ParameterValue key="config.sys.title" />
		</title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="../commons/head.jsp"></jsp:include>
		<div class="containerbox">
			<div class="container " style="margin-top:30px;">
				<div class="row">
					<div class="col-md-3">
						<img style="max-height: 50px;" src="WEB-FACE/img/style/logo.png" />
						<span style="font-size: 32px; font-weight: bold;">图片墙</span>
					</div>
					<div class="col-md-6">
						<form action="" id="imgwallFormId" method="post">
							<div class="input-group" style="margin-top: 4px;">
								<input type="text" class="form-control" id="searchDocKeyId"
									name="name" value="${name}" placeholder="输入关键字" />
								<span class="input-group-btn">
									<button id="submitSearchImg" class="btn btn-default"
										type="button">
										<span class="glyphicon glyphicon-search"></span> 查询
									</button> </span>
								<input type="hidden" id="imgWallpageNumId"
									name="query.currentPage" value="${query.currentPage}" />
							</div>
						</form>
					</div>
				</div>
				<div class="row" style="margin-top: 4px;">
					<div class="col-sm-12">
						<ol class="breadcrumb mytitlebar">
							<li style="color:#FFFFFF">
								共检索到${result.totalSize}条记录:
							</li>
						</ol>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<c:forEach var="node" items="${result.resultList}"
							varStatus="status">
							<div class="img-thumbnail"
								style="float: left; height: 200px; margin: 4px; overflow: hidden; vertical-align: middle;">
								<a href="index/FPDocShow.htm?id=${node.DOCID}"><img
										style="max-height: 192px; max-height: 150px; max-width: 400px; margin: 2px;"
										src="${node.URL}" alt="${node.TITLE}" title="${node.TITLE}" />
								</a>
							</div>
						</c:forEach>
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
										<a href="javascript:searchImgWall('${page}')">${page} </a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../commons/foot.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
	$(function() {
		$('#submitSearchImg').bind('click', function() {
			searchImgWall('1');
		})
	});
	function searchImgWall(page) {
		$('#imgWallpageNumId').attr('value', page);
		$('#imgwallFormId').submit();
	}
</script>
</html>