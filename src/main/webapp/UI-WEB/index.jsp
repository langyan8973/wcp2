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
		<title>首页<%-- -<PF:ParameterValue key="config.sys.title" /> --%></title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="commons/head.jsp"></jsp:include>
		<jsp:include page="know/commons/includeNewImages.jsp"></jsp:include>
		<div class="containerbox" >
			<div class="container " style="margin-top:20px;">
				<c:if test="${ids!=null&&ids!='NONE'}">
					<div class="jumbotron"
						style="background-color: white; padding: 0px; margin: 0px;">
						<DOC:docContent id="${ids}" />
					</div>
				</c:if>
				<div class="row">
					<div class="col-sm-3">
<%-- 						<jsp:include page="commons/includeTowDCode.jsp"></jsp:include> --%>
<!-- 						<div class="visible-lg visible-md"> -->
<%-- 							<c:if test="${USEROBJ!=null}"><jsp:include --%>
<%-- 									page="docgroup/commons/includeMyGroupMin.jsp"></jsp:include> --%>
<%-- 							</c:if> --%>
<!-- 						</div>  -->
						<jsp:include page="know/commons/includeTopTags.jsp"></jsp:include>
					</div>
					<div class="col-sm-9">
<%--  						<c:if test="${USEROBJ!=null}"> --%>
<%-- 							<jsp:include page="docgroup/commons/includeHomeMyGroup.jsp"></jsp:include> --%>
<%-- 						</c:if>  --%>
						<jsp:include page="know/commons/includeNewKnows.jsp"></jsp:include>
<%-- 						<jsp:include page="docgroup/commons/includeHomePubGroup.jsp"></jsp:include> --%>
						<div class="row">
							<div class="col-sm-12">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="commons/foot.jsp"></jsp:include>
	</body>
</html>