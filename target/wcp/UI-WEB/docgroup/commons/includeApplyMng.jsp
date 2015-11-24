<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div id="groupApplyLoadDivId">
<!-- 申请人管理 -->
</div>
<script type="text/javascript">
	$(function() {
		loadGroupApply(1);
	});
	function loadGroupApply(pagenum) {
		$('#groupApplyLoadDivId').load("index/GroupApplyMng.htm", {
			id : '${group.id}',
			'query.currentPage' : pagenum
		});
	}
</script>