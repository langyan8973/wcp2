<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div id="goodDocDivId">

</div>
<script type="text/javascript">
	$(function() {
		loadGoodDocDiv(1);
	});
	function loadGoodDocDiv(pagenum) {
		$('#goodDocDivId').load("index/FPloadgoodDocStatis.htm", {
			id : '${group.id}',
			'query.currentPage' : pagenum
		});
	}
</script>