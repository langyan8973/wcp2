<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div id="userInfoBoxId">
	loading...
	<script type="text/javascript">
	$(function() {
		$("#userInfoBoxId").load("index/FLuserInfo.htm");
	});
</script>
</div>