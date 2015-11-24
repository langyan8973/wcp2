<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- 最新知识列表 -->
<div class="row">
	<div class="col-sm-12" id="newKnowsBoxId">
	Loading...
		<script type="text/javascript">
			$(function() {
				$("#newKnowsBoxId").load("index/FPNewDocShow.htm");
			});
		</script>
	</div>
</div>