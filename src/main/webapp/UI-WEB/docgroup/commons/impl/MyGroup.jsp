<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%@ taglib uri="/WEB-TAG/farmdoc.tld" prefix="DOC"%>
<div class="panel panel-default">
	<div class="panel-body" style="background-color: #FCFCFA;">
		<span style="color: green;"
			class="glyphicon glyphicon-leaf wcp_columnTitle">我的小组</span>&nbsp;
		<a style="color: white; float: right;" href="index/DocGroupEdit.do"
			class="btn btn-primary " role="button">创建小组</a>
		<c:forEach items="${result.resultList}" var="node">
			<div class="row">
				<hr />
				<div class="col-xs-6">
					<a href="index/FPGroupInfo.htm?id=${node.ID}" >
						<c:if test="${node.GROUPIMG==null}">
							<img src="UI-WEB/docgroup/commons/imgDemo.png"
								style="max-height: 100px; max-width: 100px;" class="thumbnail" alt="...">
						</c:if> <c:if test="${node.GROUPIMG!=null}">
							<img src="${node.GROUPIMG}"
								style="max-height: 100px; max-width: 100px;" class="thumbnail" alt="...">
						</c:if> </a>
				</div>
				<div class="col-xs-6" class="caption">
					<a href="index/FPGroupInfo.htm?id=${node.ID}">
						<p style="font-weight: bold;">
							${node.GROUPNAME}
						</p>
						<p style="font-size: 12px;">
							<DOC:Describe maxnum="64" text="${node.GROUPNOTE}"></DOC:Describe>
						</p> </a>
					<p>
						<c:if test="${node.SHOWHOME=='1'}">
							<a href="javascript:hideAtHome('${node.ID}')"
								class="btn btn-warning btn-xs" role="button">取消首页推送</a>
						</c:if>
						<c:if test="${node.SHOWHOME=='0'}">
							<a href="javascript:showAtHome('${node.ID}')"
								class="btn btn-success btn-xs" role="button">设置为首页推送</a>
						</c:if>
						<a href="javascript:sortUpAtList('${node.ID}')"
							class="btn btn-default btn-xs" role="button">上移</a>
					</p>
				</div>
			</div>
		</c:forEach>
		<div class="row">
			<div class="col-xs-12">
				<ul class="pagination pagination-sm" style="margin: 0px; padding: 0px;">
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