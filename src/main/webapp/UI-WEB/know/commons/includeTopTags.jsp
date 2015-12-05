<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- tag列表 -->
<div class="row  visible-lg visible-md">
	<div class="col-sm-12" id="hotKnowsBoxId">
		正在加载...
		<script type="text/javascript">
			$(function() {
				$("#hotKnowsBoxId").load("index/FPTopTagList.htm");
			});
		</script>
	</div>
</div>