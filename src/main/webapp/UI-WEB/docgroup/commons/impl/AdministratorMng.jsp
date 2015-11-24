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
						操作
					</th>
				</tr>
				<c:forEach items="${result.resultList}" var="node">
					<tr>
						<td>
							${node.NAME}
						</td>
						<td>
							<a href="javascript:wipeManagePop('${node.ID}')"
								class="btn btn-warning btn-xs"> 取消管理权限 </a>
							<a href="javascript:quitGourp('${node.ID}')"
								class="btn btn-danger btn-xs"> 退出小组 </a>
							<c:if test="${USEROBJ.id!=node.USERID}">
								<a class="btn btn btn-default btn-xs"
									href="index/SendMessage.htm?userid=${node.USERID}"><span
									class="glyphicon glyphicon-envelope"></span>&nbsp;发送消息</a>
							</c:if>
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
						<a href="javascript:loadGroupAdministrator(${page})">${page} </a>
					</li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</div>
<script type="text/javascript">
	function wipeManagePop(groupUserId) {
		if (confirm('是否取消该用户小组管理员权限？')) {
			$.post('index/GroupWipeAdmin.htm', {
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
	//-->
</script>