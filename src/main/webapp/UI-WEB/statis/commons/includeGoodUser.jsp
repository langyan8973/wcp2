<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div id="goodUserDivId">

</div>
<script type="text/javascript">
	$(function() {
		loadgoodUserDiv(1);
	});
	function loadgoodUserDiv(pagenum) {
		$('#goodUserDivId').load("index/FPloadgoodUserStatis.htm", {
			'query.currentPage' : pagenum
		});
	}
</script>