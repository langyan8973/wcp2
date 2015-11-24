<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div id="myStatisDivId">Loading...</div>
<script type="text/javascript">
	$(function() {
		loadmyStatisDiv(1);
	});
	function loadmyStatisDiv(pagenum) {
		var private_userId = null;
		if ("undefined" != typeof userid) {
			private_userId = userid;
		}
		$('#myStatisDivId').load("index/FPloadmyStatis.htm", {
			id : private_userId,
			'query.currentPage' : pagenum
		});
	}
</script>