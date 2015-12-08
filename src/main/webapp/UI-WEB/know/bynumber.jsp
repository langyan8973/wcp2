<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>检索-文号</title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="../commons/head.jsp"></jsp:include>
		<div class="containerbox">
			<div class="container "  style="margin-top:30px;">
				<div class="row">
					<div class="col-sm-12 mytitlebar" >
						<span class="glyphicon glyphicon-star wcp_columnTitle"
							style="color: #FFFFFF;">${id} </span>
					</div>
					<%-- <div class="col-sm-12">
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
									<c:forEach items="${result.resultList}" var="node">
										<li>
											<a href="index/FPDocShow.htm?id=${node.ID}">${node.TITLE}</a>
										</li>
									</c:forEach>
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
						<jsp:include page="../know/commons/includeHotKnowsMax.jsp"></jsp:include>
					</div>
				</div> --%>
			</div>
			<div class="row" style="padding:4px;">
				<div class="col-sm-12 thumbnail" >
					<div class="row">
						<div class="col-sm-7" style="padding-right:2px;">
							<div class="mytabletitle" style="min-height: 30px;    text-align: center; padding-top:4px;">
								标题
							</div>
						</div>
						<div class="col-sm-2" style="padding-right:2px;padding-left:2px;">
							<div class="mytabletitle" style="min-height: 30px;    text-align: center; padding-top:4px;">
								发布者
							</div>
						</div>
						<div class="col-sm-3" style="padding-left:2px;">
							<div class="mytabletitle" style="min-height: 30px;    text-align: center; padding-top:4px;">
								时间
							</div>
						</div>
					</div>
					<c:forEach items="${result.resultList}" var="node">
						<hr style="margin: 10px;"/>
						<div class="row">
							<div class="col-xs-7 ">
								<a style="color:#406ea2"
													href="index/FPDocShow.htm?id=${node.ID}">${node.TITLE}</a>
							</div>
							<div class="col-xs-2" style="color:#406ea2;    text-align: center;">
								<span>${node.AUTHOR}</span>
							</div>
							<div class="col-xs-3" style="color:#406ea2;    text-align: center;">
								<span><PF:FormatTime date="${node.ETIME}" yyyyMMddHHmmss="yyyy-MM-dd HH:mm" /></span>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<jsp:include page="../commons/foot.jsp"></jsp:include>
	</body>
</html>