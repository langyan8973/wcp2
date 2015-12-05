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
		<div class="bs-docs-header">
			<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
			  <!-- Indicators -->
			  <ol class="carousel-indicators">
			    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
			    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
			  </ol>		
			  <!-- Wrapper for slides -->
			  <div class="carousel-inner" role="listbox">
			    <div class="item active" style="height:300px; background:url(<PF:basePath/>WEB-FACE/img/resource/gh1.jpg); background-size:cover;">
			      <div class="carousel-caption">
			        建议加强经济适用房项目经营性质配套用房工作衔接
			      </div>
			    </div>
			    <div class="item" style="height:300px; background:url(<PF:basePath/>WEB-FACE/img/resource/gh2.jpg); background-size:cover;">
			      <div class="carousel-caption">
			        明确畸零地的处理原则
			      </div>
			    </div>
			  </div>
			
			  <!-- Controls -->
			  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
			    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			    <span class="sr-only">Previous</span>
			  </a>
			  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
			    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			    <span class="sr-only">Next</span>
			  </a>
			</div>
		</div>
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