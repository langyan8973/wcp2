<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- 查询和文档内容相关的知识列表，传入文档id -->
<div class="row">
	<div class="col-sm-12" id="luceneResultMinId">
		<script type="text/javascript">
	$(function() {
		$("#luceneResultMinId").load("index/FPDocRelationLuneneSearch.htm?id=${doc.id}");
	});
</script>
	</div>
</div>