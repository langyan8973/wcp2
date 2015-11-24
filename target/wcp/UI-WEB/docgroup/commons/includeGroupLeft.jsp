<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<p>
	<c:forEach items="${group.tags}" var="tag">
		<span class="label label-info tagsearch" title="${tag}"
			style="font-weight: lighter; font-size: 12px; cursor: pointer;">${tag}</span>
	</c:forEach>
</p>
<h3 style="text-align: center; font-weight: bold;">
	<c:if test="${group.joincheck=='1'}">
		<span class="glyphicon glyphicon-lock">&nbsp;${group.groupname}&nbsp;</span>
	</c:if>
	<c:if test="${group.joincheck=='0'}">
								${group.groupname}
							</c:if>
</h3>
<a class="thumbnail"> <c:if test="${group.groupimg==null}">
		<img src="UI-WEB/docgroup/commons/imgDemo.png" alt="...">
	</c:if> <c:if test="${group.groupimg!=null}">
		<img src="${group.imgurl}" alt="...">
	</c:if> </a>
<c:if test="${USEROBJ!=null}">
	<div class="panel panel-default userbox">
		<div class="panel-body">

			<ul class="nav nav-pills nav-stacked nav-sm">
				<c:if test="${usergroup==null}">
					<li>
						<a href="index/joinGroup.htm?id=${group.id}">加入小组</a>
					</li>
				</c:if>
				<c:if test="${usergroup!=null}">
					<li class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#"><span
							class="glyphicon glyphicon-book"></span>&nbsp;知识<span
							class="caret"></span> </a>
						<ul class="dropdown-menu">
							<jsp:include
								page="/UI-WEB/user/commons/userMenu/userKnowMenu.jsp"></jsp:include>
						</ul>
					</li>
					<li>
						<a href="javascript:leaveGroupFunc('${group.id}')"><span
							class="glyphicon glyphicon-remove"></span>&nbsp;退出小组</a>
					</li>
				</c:if>
				<c:if test="${usergroup.leadis=='1'}">
					<li>
						<a href="index/DocGroupEdit.htm?id=${group.id}"><span
							class="glyphicon glyphicon-cog"></span>&nbsp;修改信息</a>
					</li>
					<li>
						<a href="index/groupAdministratorConsole.htm?id=${group.id}"><span
							class="glyphicon glyphicon-user"></span>&nbsp;成员管理</a>
					</li>
					<li>
						<a href="index/FLEditGroupHome.htm?id=${group.id}" ><span
							class="glyphicon glyphicon-home"></span>&nbsp;编辑首页</a>
					</li>
				</c:if>
				<c:if test="${usergroup.leadis!='1'}">
					<c:forEach items="${result.resultList}" var="note">
						<c:set var="adminIds" value="${adminIds},${note.USERID}"></c:set>
					</c:forEach>
					<li>
						<a href="index/SendMessage.htm?userid=${adminIds}"><span
							class="glyphicon glyphicon-envelope"></span>&nbsp;发送消息给管理员</a>
					</li>
				</c:if>
			</ul>

		</div>
	</div>
</c:if>
<hr />
<p>
	${group.groupnote}
</p>
<hr />
<p style="color: green; font-size: 12px;">
	小组管理员：
	<c:forEach items="${result.resultList}" var="note">
		<span title="${note.NAME}"
			style="font-weight: lighter; font-size: 12px; margin-left: 10px;">${note.NAME}</span>
	</c:forEach>
</p>
<script type="text/javascript">
	$(function() {
		//标签
		$('.tagsearch').bind('click', function() {
			luceneSearch('TYPE:' + $(this).attr('title'));
		});
	});
	function leaveGroupFunc(id) {
		//判断是否有别的管理员，没有的话提示用户
		if (confirm('是否确定退出小组？')) {
			if ('${usergroup.leadis}' != '1') {
				//如果用户非管理员则直接退出
				window.location = 'index/leaveGroup.htm?id=' + id;
				return false;
			}
			$.post('index/GroupIsHaveAdministrator.htm', {
				"id" : id
			}, function(flag) {
				if (flag.adminNum > 1) {
					window.location = 'index/leaveGroup.htm?id=' + id;
				} else {
					if (confirm('如果退出该小组，该小组将没有任何管理员。是否确定退出？')) {
						window.location = 'index/leaveGroup.htm?id=' + id;
					}
				}
			});
		}
	}
	//-->
</script>