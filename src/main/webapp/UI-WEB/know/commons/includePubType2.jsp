<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- 显示公共分类 样式横向排列-->
<div class="row">
	<div class="col-sm-12" id="pubTypeBoxId2">
	Loading...
		<script type="text/javascript">
			$(function() {
				$("#pubTypeBoxId2").load("index/FPPubTypeShow2.htm?id=${id}");
			});
		</script>
	</div>
</div>