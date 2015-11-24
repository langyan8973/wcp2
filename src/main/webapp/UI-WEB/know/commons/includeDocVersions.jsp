<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<span style="color: #D9534F;"
	class="glyphicon glyphicon-time wcp_columnTitle">历史版本</span>
<hr />
<div id="DocVersionsBoxId">
	<script type="text/javascript">
	$(function() {
		$("#DocVersionsBoxId").load("index/FPDocVersions.htm?id=${doc.id}");
	});
</script>
</div>
