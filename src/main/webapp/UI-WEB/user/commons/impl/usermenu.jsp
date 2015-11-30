<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<ul class="nav nav-pills nav-stacked nav-sm">
	<li class="dropdown">
		<a href="index/FPuserHome.do"><span
			class="glyphicon glyphicon-home"></span>&nbsp;个人首页</a>
	</li>
	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#"><span
			class="glyphicon glyphicon-user"></span>&nbsp;基本信息<span class="caret"></span>
		</a>
		<ul class="dropdown-menu">
			<li>
				<a href="index/FLeditUser.htm"><span
					class="glyphicon glyphicon-pencil"></span>&nbsp;修改个人信息</a>
			</li>
			<li>
				<a href="index/FPeditPassword.htm"><span
					class="glyphicon glyphicon glyphicon-lock"></span>&nbsp;修改密码</a>
			</li>
		</ul>
	</li>
	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#"><span
			class="glyphicon glyphicon-book"></span>&nbsp;知识<span class="caret"></span>
		</a>
		<ul class="dropdown-menu">
			<jsp:include page="/UI-WEB/user/commons/userMenu/userKnowMenu.jsp"></jsp:include>
		</ul>
	</li>
	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#"><span
			class="glyphicon glyphicon-star"></span>&nbsp;收藏<span
			style="color: #D9534F;">(${fn:length(result.resultList)} )</span> <c:if
				test="${fn:length(result.resultList)>0}">
				<span class="caret"></span>
			</c:if> </a>
		<c:if test="${fn:length(result.resultList)>0}">
			<ul class="dropdown-menu">
				<c:forEach items="${result.resultList}" var="node">
					<li>
						<a href="index/FPDocShow.htm?id=${node.ID}">${node.TITLE}</a>
					</li>
				</c:forEach>
			</ul>
		</c:if>
	</li>
	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#"><span
			class="glyphicon glyphicon-envelope"></span>&nbsp;留言<span
			style="color: #D9534F;">(${messagenum} )</span> <span
			style="color: #D9534F;"></span> <span class="caret"></span> </a>
		<ul class="dropdown-menu">
			<li>
				<a href="index/FLMyMessageList.htm"><span
					class="glyphicon glyphicon-envelope"></span>&nbsp;已收到<span
					style="color: #D9534F;">(${messagenum} )</span> </a>
				<a href="index/FLMySendMessageList.htm"><span
					class="glyphicon glyphicon-new-window"></span>&nbsp;我发表</a>
			</li>
		</ul>
	</li>
</ul>