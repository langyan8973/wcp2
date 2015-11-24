<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>小组首页-<PF:ParameterValue key="config.sys.title"/>
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
			<div class="container "><jsp:include
					page="commons/includeSearch.jsp"></jsp:include>
				<div class="row">
					<c:if test="${USEROBJ!=null}">
						<div class="col-md-5  ">
							<jsp:include page="commons/includeMyGroup.jsp"></jsp:include>
						</div>
						<div class="col-md-7">
							<c:if
								test="${pageset!=null&&pageset.message!=null&&pageset.commitType=='1'}">
								<div class="alert alert-danger " role="alert">
									<span class="glyphicon glyphicon-info-sign"></span>
									${pageset.message}
								</div>
							</c:if>
							<c:if
								test="${pageset!=null&&pageset.message!=null&&pageset.commitType=='0'}">
								<div class="alert alert-success" role="alert">
									<span class=" glyphicon glyphicon-ok-sign"></span>
									${pageset.message}
								</div>
							</c:if>
							<h3 class="panel-title">
								<span style="color: blue; font-weight: bold;"
									class="glyphicon glyphicon glyphicon-tree-conifer">在小组内搜索文档<c:if
										test="${searchGroupKey!=null&&searchGroupKey!=''}">(过滤条件:${searchDocKey })</c:if>
								</span>&nbsp;
							</h3>
							<ol class="breadcrumb">
								<li>
									共检索到${result.totalSize}条记录:
								</li>
								<c:forEach items="${result.resultList}" var="node">
									<li>
										<a href="index/FPDocShow.htm?id=${node.ID}">${node.TITLE}</a>
									</li>
								</c:forEach>
							</ol>
							<jsp:include page="commons/impl/docs.jsp"></jsp:include>
						</div>
					</c:if>
					<c:if test="${USEROBJ==null}">
						<div class="col-md-3  ">
							<div class="panel panel-default userbox">
								<div class="panel-body">
									<jsp:include page="/UI-WEB/commons/includeUserPanel.jsp"></jsp:include>
									<jsp:include page="../commons/loginbox.jsp"></jsp:include>
								</div>
							</div>
							<div class="panel panel-default userbox  visible-lg visible-md">
								<div class="panel-body">
									<jsp:include page="../know/commons/includeHotKnowsMin.jsp"></jsp:include>
								</div>
							</div>
						</div>
						<div class="col-md-9">
							<jsp:include page="commons/includePublicGroup.jsp"></jsp:include>
						</div>
					</c:if>
				</div>
			</div>
		</div>
		<!-- /.modal -->
		<jsp:include page="../commons/foot.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
	
</script>
</html>