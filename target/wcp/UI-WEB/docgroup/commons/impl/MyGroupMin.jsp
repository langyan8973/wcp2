<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fun"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%@ taglib uri="/WEB-TAG/farmdoc.tld" prefix="DOC"%>
<c:if test="${fun:length(result.resultList) > 0}">
	<p style="margin-bottom: 16px;">
		<span style="color: green;"
			class="glyphicon glyphicon-leaf wcp_columnTitle">已加入小组</span>
	</p>
	<div class="panel panel-default">
		<div class="panel-body" style="background-color: #FCFCFA;">
			<c:forEach items="${result.resultList}" var="node">
				<div class="row">
					<div class="col-xs-4">
						<a href="index/FPGroupInfo.htm?id=${node.ID}" class="thumbnail">
							<c:if test="${node.GROUPIMG==null}">
								<img src="UI-WEB/docgroup/commons/imgDemo.png" alt="...">
							</c:if> <c:if test="${node.GROUPIMG!=null}">
								<img src="${node.GROUPIMG}" alt="...">
							</c:if> </a>
					</div>
					<div class="col-xs-8" class="caption">
						<a href="index/FPGroupInfo.htm?id=${node.ID}">
							<p style="font-weight: bold;">
								${node.GROUPNAME}
							</p>
							<p style="font-size: 12px;">
								<DOC:Describe maxnum="64" text="${node.GROUPNOTE}"></DOC:Describe>
							</p> </a>
					</div>
				</div>
			</c:forEach>
			<c:if test="${result.endPage>1}">
				<div class="row">
					<div class="col-xs-12">
						<ul class="pagination pagination-sm"
							style="margin: 0px; padding: 0px;">
							<c:forEach var="page" begin="${result.startPage}"
								end="${result.endPage}" step="1">
								<c:if test="${page==result.currentPage}">
									<li class="active">
										<a>${page} </a>
									</li>
								</c:if>
								<c:if test="${page!=result.currentPage}">
									<li>
										<a href="javascript:loadMyGroupList(${page})">${page} </a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<script type="text/javascript">
	function showAtHome(groupUserId) {
		if (confirm('设置推送后该小组文档将显示在首页中？')) {
			$.post('index/GroupHomeShow.htm', {
				id : groupUserId
			}, function(flag) {
				if (flag.pageset.commitType == '0') {
					loadMyGroupList(1);
				} else {
					alert(flag.pageset.message);
				}
			});
		}
	}
	function hideAtHome(groupUserId) {
		if (confirm('取消推送后该小组文档将不被显示在首页中？')) {
			$.post('index/GroupHomeHide.htm', {
				id : groupUserId
			}, function(flag) {
				if (flag.pageset.commitType == '0') {
					loadMyGroupList(1);
				} else {
					alert(flag.pageset.message);
				}
			});
		}
	}
	function sortUpAtList(groupUserId) {
		$.post('index/GroupSortUp.htm', {
			id : groupUserId
		}, function(flag) {
			if (flag.pageset.commitType == '0') {
				loadMyGroupList(${result.currentPage});
			} else {
				alert(flag.pageset.message);
			}
		});
	}
	//-->
</script>
</c:if>