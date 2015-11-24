<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div id="badDocDivId">

</div>
<script type="text/javascript">
	$(function() {
		loadbadDocDiv(1);
	});
	function loadbadDocDiv(pagenum) {
		$('#badDocDivId').load("index/FPloadbadDocStatis.htm", {
			'query.currentPage' : pagenum
		});
	}
</script>