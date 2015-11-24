<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div id="LoadHomeMyGroupDivId">
	<!-- 首页我的小组 -->
	Loading...
</div>
<script type="text/javascript">
	var isRoll = false;
	$(function() {
		LoadHomeMyGroupDiv(1);
	});
	function LoadHomeMyGroupDiv(page) {
		$('#LoadHomeMyGroupDivId').load("index/LoadHomeMyGroup.htm", {
			'query.currentPage' : page
		}, function() {
			if (isRoll) {
				$('html,body').animate( {
					scrollTop : $("#LoadHomeMyGroupDivId").offset().top - 50
				}, 1000);
			}
			isRoll = true;
		});
	}
</script>