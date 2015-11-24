<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%@ taglib uri="/WEB-TAG/farmdoc.tld" prefix="DOC"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>荣誉-<PF:ParameterValue key="config.sys.title" /></title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="../commons/head.jsp"></jsp:include>
		<div class="containerbox">
			<div class="container ">
				<div class="row">
					<c:if test="${USEROBJ!=null}">
						<div class="col-md-12">
							<jsp:include page="commons/includeMyStatis.jsp"></jsp:include>
						</div>
					</c:if>
				</div>
				<div class="row">
					<div class="col-md-4">
						<jsp:include page="commons/includeGoodUser.jsp"></jsp:include>
					</div>

					<div class="col-md-4">
						<jsp:include page="commons/includeGoodGroup.jsp"></jsp:include>
					</div>

					<div class="col-md-4">
						<jsp:include page="commons/includeManyDocUser.jsp"></jsp:include>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<jsp:include page="commons/includeGoodDoc.jsp"></jsp:include>
					</div>
					<div class="col-md-6">
						<jsp:include page="commons/includeBadDoc.jsp"></jsp:include>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<jsp:include page="commons/includeTimeLine.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../commons/foot.jsp"></jsp:include>
	</body>
</html>