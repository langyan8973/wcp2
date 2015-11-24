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
						申请留言
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
							${node.APPLYNOTE}
						</td>
						<td>
							<a href="javascript:agreeApply('${node.ID}')" type="button"
								class="btn btn-primary btn-xs"> 同意 </a>
							<a href="javascript:refuseApply('${node.ID}')" type="button"
								class="btn btn-warning btn-xs"> 拒绝 </a>
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
						<a href="javascript:loadGroupApply(${page})">${page} </a>
					</li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</div>
<script type="text/javascript">
	function agreeApply(groupUserId) {
		if (confirm('是否同意该用户加入小组？')) {
			$.post('index/GroupAgreeApply.htm', {
				id : groupUserId
			}, function(flag) {
				if (flag.pageset.commitType == '0') {
					loadGroupApply(1);
					loadGroupUser(1);
				} else {
					alert(flag.pageset.message);
				}
			});
		}
	}
	function refuseApply(groupUserId) {
		if (confirm('是否拒绝该用户加入小组？')) {
			$.post('index/GroupRefuseApply.htm', {
				id : groupUserId
			}, function(flag) {
				if (flag.pageset.commitType == '0') {
					loadGroupApply(1);
				} else {
					alert(flag.pageset.message);
				}
			});
		}
	}
	//-->
</script>