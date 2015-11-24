<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div id="groupAdministratorLoadDivId">
<!-- 管理员管理 -->

</div>
<script type="text/javascript">
	$(function() {
		loadGroupAdministrator(1);
	});
	function loadGroupAdministrator(pagenum) {
		$('#groupAdministratorLoadDivId').load(
				"index/GroupAdministratorMng.htm", {
					id : '${group.id}',
					'query.currentPage' : pagenum
				});
	}
</script>