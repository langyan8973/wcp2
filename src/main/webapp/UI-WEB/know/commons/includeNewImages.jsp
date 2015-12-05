<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- 最新图片列表 -->
<div class="row">
	<div class="col-sm-12" id="newImagesBoxId">
	Loading...
		<script type="text/javascript">
			$(function() {
				$("#newImagesBoxId").load("index/FPNewImageShow.htm");
			});
		</script>
	</div>
</div>