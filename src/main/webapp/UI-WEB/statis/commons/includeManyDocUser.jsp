<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div id="manyDocUserDivId">

</div>
<script type="text/javascript">
	$(function() {
		loadmanyDocUserDiv(1);
	});
	function loadmanyDocUserDiv(pagenum) {
		$('#manyDocUserDivId').load("index/FPloadmanyDocUserStatis.htm", {
			'query.currentPage' : pagenum
		});
	}
</script>