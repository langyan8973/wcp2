<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div id="goodGroupDivId">

</div>
<script type="text/javascript">
	$(function() {
		loadgoodGroupDiv(1);
	});
	function loadgoodGroupDiv(pagenum) {
		$('#goodGroupDivId').load("index/FPloadgoodGroupStatis.htm", {
			'query.currentPage' : pagenum
		});
	}
</script>