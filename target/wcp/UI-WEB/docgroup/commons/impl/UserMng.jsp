<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div class="row">
	<div class="col-md-12">
		<div class="table table-condensed table-bordered">
			<table class="table">
				<tr>
					<th>
						用户
					</th>
					<th>
						是否有编辑权限
					</th>
					<th>
						操作
					</th>
				</tr>
				<c:forEach items="${result.resultList}" var="node">
					<tr>
						<td>
							${node.NAME}
						</td>
						<td>
							${node.EDITISTITLE}
						</td>
						<td>

							<a href="javascript:setGroupAdminUser('${node.ID}')"
								class="btn btn-primary btn-xs"> 设置为管理员 </a>
							<c:if test="${node.EDITIS=='0'}">
								<a href="javascript:setGroupEditorUser('${node.ID}')"
									class="btn btn-primary btn-xs"> 授予编辑权限 </a>
							</c:if>
							<c:if test="${node.EDITIS=='1'}">
								<a href="javascript:wipeGroupEditorUser('${node.ID}')"
									class="btn btn-warning btn-xs"> 取消编辑权限 </a>
							</c:if>
							<a href="javascript:quitGourp('${node.ID}')"
								class="btn btn-danger btn-xs"> 退出小组 </a>
							<a class="btn btn btn-default btn-xs"
								href="index/SendMessage.htm?userid=${node.USERID}"><span
								class="glyphicon glyphicon-envelope"></span>&nbsp;发送消息</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<ul class="pagination pagination-sm">
			<c:forEach var="page" begin="${result.startPage}"
				end="${result.endPage}" step="1">
				<c:if test="${page==result.currentPage}">
					<li class="active">
						<a>${page} </a>
					</li>
				</c:if>
				<c:if test="${page!=result.currentPage}">
					<li>
						<a href="javascript:loadGroupUser(${page})">${page} </a>
					</li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</div>
<script type="text/javascript">
	function setGroupAdminUser(groupUserId) {
		if (confirm('是否将该用户设置为小组管理员？')) {
			$.post('index/GroupSetAdmin.htm', {
				id : groupUserId
			}, function(flag) {
				if (flag.pageset.commitType == '0') {
					loadGroupAdministrator(1);
					loadGroupUser(1);
				} else {
					alert(flag.pageset.message);
				}
			});
		}
	}
	function setGroupEditorUser(groupUserId) {
		if (confirm('是否允许该用户编辑小组文档？')) {
			$.post('index/GroupSetEditor.htm', {
				id : groupUserId
			}, function(flag) {
				if (flag.pageset.commitType == '0') {
					loadGroupUser(1);
				} else {
					alert(flag.pageset.message);
				}
			});
		}
	}
	function wipeGroupEditorUser(groupUserId) {
		if (confirm('是否取消该用户小组文档编辑权限？')) {
			$.post('index/GroupWipeEditor.htm', {
				id : groupUserId
			}, function(flag) {
				if (flag.pageset.commitType == '0') {
					loadGroupUser(1);
				} else {
					alert(flag.pageset.message);
				}
			});
		}
	}
</script>