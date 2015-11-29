<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.farm.web.constant.FarmConstant"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%@ taglib uri="/WEB-TAG/farmdoc.tld" prefix="DOC"%>
<div class="navbar navbar-inverse" role="navigation"
	style="margin: 0px;">
	<!-- Brand and toggle get grouped for better mobile display -->
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target="#bs-example-navbar-collapse-1">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
		<%-- <a class="navbar-brand"
			style="color: #ffffff; font-weight: bold; padding: 5px;"
			href="index/FPwcp.htm"> <img
				src="<PF:basePath/>WEB-FACE/img/style/logo.png" height="40"
				alt="WCP" title="WCP" align="middle" /> </a> --%>
	</div>
	<!-- Collect the nav links, forms, and other content for toggling -->
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li class="active">
				<a href="index/FPwcp.htm"><span class="glyphicon glyphicon-home"></span>&nbsp;首页</a>
			</li>
			<li class="active">
				<a href="index/FPtype.htm"><span class="glyphicon glyphicon-th"></span>&nbsp;分类</a>
			</li>
			<li class="active">
				<a href="index/FPDocGroupMng.htm"><span
					class="glyphicon glyphicon-tree-conifer"></span>&nbsp;小组</a>
			</li>
			<li class="active">
				<a href="index/FPimgWall.htm"><span
					class="glyphicon glyphicon-picture"></span>&nbsp;图片墙</a>
			</li>
			<!-- <li class="active">
				<a href="index/FPstatis.htm"><span
					class="glyphicon glyphicon-stats"></span>&nbsp;荣誉</a>
			</li> -->
		</ul>
		<form action="index/FPluceneSearch.do" method="post"
			id="lucenesearchFormId" class="navbar-form navbar-left" role="search">
			<div class="form-group">
				<input type="text" name="word" id="wordId" value="${word}"
					class="form-control" placeholder="查询公开资源">
				<input type="hidden" id="pageNumId" name="pagenum">
			</div>
			<button type="submit" class="btn btn-default">
				检索
			</button>
		</form>
		<p class="navbar-title">北京市城乡规划知识库</p>
		
		<ul class="nav navbar-nav navbar-right">
			<%-- <c:if test="${USEROBJ!=null}">
				<li class="active">
					<a href="index/authInfo.htm"><span
						class="glyphicon glyphicon-exclamation-sign"></span>&nbsp;授权信息</a>
				</li>
			</c:if> --%>
			<c:if test="${USEROBJ==null}">
				<li class="active">
					<a href="index/FPlogin.htm"><span
						class="glyphicon glyphicon glyphicon-user"></span>&nbsp;登录</a>
				</li>
			</c:if>
			<c:if test="${USEROBJ!=null}">
				<li class="active">
					<a href="index/FLuserManage.htm"><span
						class="glyphicon glyphicon-user"></span>&nbsp;${USEROBJ.name}</a>
				</li>
				<li class="active">
					<a href="index/FLlogout.htm"><span
						class="glyphicon glyphicon-off"></span>&nbsp;注销</a>
				</li>
			</c:if>
		</ul>
	</div>
	<!-- /.navbar-collapse -->
</div>
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