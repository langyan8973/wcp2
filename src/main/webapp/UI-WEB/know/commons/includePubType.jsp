<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- 显示公共分类 样式1 纵排-->
<div class="row">
	<div class="col-sm-12" id="pubTypeBoxId">
		<script type="text/javascript">
			$(function() {
				$("#pubTypeBoxId").load("index/FPPubTypeShow.htm");
			});
		</script>
	</div>
</div>