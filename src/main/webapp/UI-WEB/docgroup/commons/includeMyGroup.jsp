<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div id="mygroupLoadDivId" >

</div>
<script type="text/javascript">
	$(function() {
		loadMyGroupList(1);
	});
	function loadMyGroupList(pagenum) {
		$('#mygroupLoadDivId').load("index/loadMyDocGroup.htm", {
			id : '${group.id}',
			'query.currentPage' : pagenum
		});
	}
</script>