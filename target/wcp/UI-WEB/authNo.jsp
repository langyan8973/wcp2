<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>权限受限-<PF:ParameterValue key="config.sys.title"/>
		</title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
	</head>
	<body>
		<div class="modal fade bs-example-modal-lg" tabindex="-1"
			data-backdrop="true" data-show="true" data-keyboard="false"
			id="authNoModalId" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content" style="padding: 20px;">
					<div class="alert alert-danger" role="alert">
						${pageset.message}
					</div>
					<p style="text-align: center;">
						<a href="<PF:basePath/>" class="btn btn-primary btn-xs">
							返回首页... </a>
					</p>
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript">
	$(function() {
		$('#authNoModalId').modal('show');
		$('#authNoModalId').on('hidden.bs.modal', function(e) {
			window.location = "<PF:basePath/>";
		})
	});
	//-->
</script>
</html>