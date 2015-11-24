<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div id="groupUserLoadDivId">
	<!-- 普通用户管理 -->
</div>
<script type="text/javascript">
	$(function() {
		loadGroupUser(1);
	});
	function loadGroupUser(pagenum) {
		$('#groupUserLoadDivId').load("index/GroupUserMng.htm", {
			id : '${group.id}',
			'query.currentPage' : pagenum
		});
	}
</script>