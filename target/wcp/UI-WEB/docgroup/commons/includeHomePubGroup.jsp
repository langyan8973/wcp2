<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div id="FPLoadHomePubGroupDivId">
	<!-- 首页公共小组 -->
</div>
<script type="text/javascript">
	$(function() {
		LoadHomePubGroupDiv();
	});
	function LoadHomePubGroupDiv() {
		$('#FPLoadHomePubGroupDivId').load("index/FPLoadHomePubGroup.htm", {});
	}
</script>