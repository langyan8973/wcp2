<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div class="row">
	<div class="col-md-12 ">
		<div class="panel panel-default" style="background-color: #FCFCFA;">
			<div class="panel-body">
				<div class="row">
					<form id="searchGroupFormId" action="index/FPDocGroupMng.htm"
						method="post">
						<div class="col-md-6">
							<div class="input-group" style="margin-top: 4px;">
								<input type="text" class="form-control" id="searchKeyId"
									name="searchGroupKey" value="${searchGroupKey}"
									placeholder="输入小组名称">
								<span class="input-group-btn">
									<button id="submitSearchGroupId" class="btn btn-default"
										type="button">
										<span class="glyphicon glyphicon-search"></span>查询小组
									</button> </span>
							</div>
						</div>
					</form>
					<form id="searchGroupDocFormId" action="index/queryMygroupDoc.htm"
						method="post">
						<div class="col-md-6">
							<c:if test="${USEROBJ!=null}">
								<div class="input-group" style="margin-top: 4px;">
									<input type="text" class="form-control" id="searchDocKeyId"
										name="searchDocKey" value="${searchDocKey}"
										placeholder="输入资源名称">
									<input type="hidden" id="searchGroupDocPageID"
										name="query.currentPage">
									<span class="input-group-btn">
										<button id="submitSearchGroupDocId" class="btn btn-default"
											type="button">
											<span class="glyphicon glyphicon-search"></span> 查询资源
										</button> </span>
								</div>
							</c:if>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(function() {
		$('#submitSearchGroupId').bind('click', function() {
			if ($('#searchKeyId').val()) {
				$('#searchGroupFormId').submit();
			}
		});
		$('#submitSearchGroupDocId').bind('click', function() {
			if ($('#searchDocKeyId').val()) {
				$('#searchGroupDocFormId').submit();
			}
		});
	});
	function loadDocs(page) {
		if ($('#searchDocKeyId').val()) {
			if (page) {
				$('#searchGroupDocPageID').val(page);
			}
			$('#searchGroupDocFormId').submit();
		}
	}
</script>