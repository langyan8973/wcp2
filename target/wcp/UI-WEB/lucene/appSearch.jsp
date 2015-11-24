<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.farm.web.constant.FarmConstant"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%@ taglib uri="/WEB-TAG/farmdoc.tld" prefix="DOC"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>知识检索-<PF:ParameterValue key="config.sys.title" /></title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
	</head>
	<body>
		<div class="navbar navbar-inverse" role="navigation"
			style="margin: 0px;">
			<div class="navbar-header">
				<a class="navbar-brand" target="_black"
					style="color: #ffffff; font-weight: bold; padding: 5px;"
					href="index/FPwcp.htm"> <img
						src="<PF:basePath/>WEB-FACE/img/style/logo.png" height="40"
						alt="WCP" title="WCP" align="middle" /> </a>
			</div>
		</div>
		<div class="containerbox">
			<div class="container ">
				<div class="row">
					<div class="col-lg-12">
						<form action="index/FPAppSearch.do" method="post"
							id="lucenesearchFormId" role="search">
							<div class="input-group">
								<input type="text" name="word" id="wordId" value="${word}"
									class="form-control" placeholder="查询公开资源">
								<input type="hidden" id="pageNumId" name="pagenum">
								<span class="input-group-btn">
									<button class="btn btn-default" type="submit">
										查询
									</button> </span>
							</div>
						</form>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-12" style="margin-bottom: 8px;">
								<span style="color: #D9534F;"
									class="glyphicon glyphicon-search wcp_columnTitle">检索:${word}</span>
								<c:forEach items="${hotCase}" var="node">
									<span class="label label-danger" style="cursor: pointer;"
										onclick="javascript:luceneSearch('${node}')">${node}</span>
								</c:forEach>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<ol class="breadcrumb">
									<li>
										共检索到${result.totalSize}条记录(${result.runtime}ms):
									</li>
								</ol>
							</div>
						</div>
						<jsp:include page="../know/commons/impl/docs.jsp"></jsp:include>
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
												<a href="javascript:luceneSearchGo(${page})">${page} </a>
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
		<div
			style="text-align: center; color: #FFFFFF; background-color: #1F1F1F; padding: 8px;">
			WCP开源版,禁止用于商业用途 macplus@126.com
		</div>
	</body>
	<script type="text/javascript">
	function luceneSearch(key) {
		$('#wordId').val(key);
		$('#lucenesearchFormId').submit();
	}
	function luceneSearchGo(page) {
		$('#pageNumId').val(page);
		$('#lucenesearchFormId').submit();
	}
	//-->
</script>
</html>
