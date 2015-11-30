<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<base href="<PF:basePath/>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>个人信息<%-- -<PF:ParameterValue key="config.sys.title" /> --%></title>
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
		<div class="container" style="margin-top:30px;">
			<div class="row">
				<div class="col-sm-3  ">
					<div class="panel panel-default userbox">
						<div class="panel-body">
							<jsp:include page="/UI-WEB/commons/includeUserPanel.jsp"></jsp:include>
						</div>
					</div>
				</div>
				<div class="col-sm-9">
					<div class="row">
						<div class="col-sm-12">
							<!-- ID,TITLE,DOCDESCRIBE,AUTHOR,PUBTIME,TAGKEY ,IMGID,VISITNUM,PRAISEYES,PRAISENO,HOTNUM,TYPENAME -->
							<div class="row">
								<div class="col-sm-12 mytitlebar" style="margin-bottom: 8px;">
									<span style="color: #FFFFFF;"
										class="glyphicon glyphicon-tag wcp_columnTitle">我的知识</span>
										<!-- <a class="pull-right btn btn-default btn-sm" href="index/FPuserHome.do?id=40288b854a329988014a329a12f30002">个人首页</a> -->
								</div>
							</div>
							<jsp:include
								page="/UI-WEB/docgroup/commons/impl/docsMinNoPage.jsp"></jsp:include>
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
		</div>
	</div>
	<jsp:include page="../commons/foot.jsp"></jsp:include>
</body>
<script type="text/javascript">
	function knowBoxGoPage(page) {
		window.location = "index/FLuserManage.htm?query.currentPage=" + page;
	}
</script>
</html>