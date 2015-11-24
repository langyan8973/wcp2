<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- 分类下的知识列表，大的列表页面 -->
<div class="row">
	<div class="col-sm-12" id="newTypeBoxId">
		Loading...
		<script type="text/javascript">
	$(function() {
		$("#newTypeBoxId").load("index/FPTypeDocShow.htm?typeid=${typeid}");
	});
	function typeBoxGoPage(page) {
		$("#newTypeBoxId").load(
				"index/FPTypeDocShow.htm?typeid=${typeid}&query.currentPage="
						+ page);
	}
</script>
	</div>
</div>