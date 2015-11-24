<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- 分类下的知识列表，小的列表页面(缩写) -->
<div class="row">
	<div class="col-sm-12" id="newTypeBoxId">
		<script type="text/javascript">
	$(function() {
		$("#newTypeBoxId").load("index/FPTypeDocShow2.htm?typeid=${typeid}");
	});
</script>
	</div>
</div>