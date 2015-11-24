<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/farmdoc.tld" prefix="DOC"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>发送消息-<PF:ParameterValue key="config.sys.title"/></title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
		<link rel="stylesheet"
			href="<PF:basePath/>WEB-FACE/model/kindeditor/themes/default/default.css" />
		<script charset="utf-8"
			src="<PF:basePath/>WEB-FACE/model/kindeditor/kindeditor-all-min.js"></script>
		<script charset="utf-8"
			src="<PF:basePath/>WEB-FACE/model/kindeditor/zh_CN.js"></script>
		<script charset="utf-8"
			src="<PF:basePath/>WEB-FACE/model/supervilidate/validate.js"></script>
	</head>
	<body>
		<jsp:include page="../commons/head.jsp"></jsp:include>
		<div class="containerbox">
			<div class="container ">
				<div class="row">
					<div class="col-md-3  visible-lg visible-md">
						<div class="panel panel-default userbox">
							<div class="panel-body">
								<jsp:include page="/UI-WEB/commons/includeUserPanel.jsp"></jsp:include>
								<jsp:include page="../commons/loginbox.jsp"></jsp:include>
							</div>
						</div>
					</div>
					<div class="col-md-9">
						<div class="row">
							<div class="col-md-12">
								<ol class="breadcrumb">
									<li>
										<a>WCP</a>
									</li>
									<li class="active">
										<a>发送消息</a>
									</li>
								</ol>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<c:if test="${pageset.commitType=='1'}">
									<!-- 失败 -->
									<div class="alert alert-danger" role="alert">
										消息发送失败:${pageset.message}
									</div>
								</c:if>
								<c:if test="${showOk}">
									<!-- 成功 -->
									<div class="alert alert-success" role="alert">
										消息已经发送
									</div>
								</c:if>
							</div>
						</div>
						<form role="form" action="index/SendMessageCommit.htm"
							id="msgSubmitFormId" method="post">
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<label for="exampleInputEmail1">
											发送消息给:&nbsp;&nbsp;${name}
										</label>
										<input type="hidden" name="userid" value="${userid}" />
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<label for="exampleInputEmail1">
											主题
											<span class="alertMsgClass">*</span>
										</label>
										<input type="text" class="form-control" name="title"
											value="${title}" id="titleId" placeholder="输入消息主题" />
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<textarea name="text" id="textId" placeholder="输入消息内容"
										class="form-control" style="height: 80px; width: 100%;">${text}</textarea>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2">
									<button type="button" id="msgSubmitButtonId"
										style="margin-top: 4px;" class="btn btn-primary">
										提交
									</button>
								</div>
								<div class="col-md-10">
									<span class="alertMsgClass" id="errormessageShowboxId"></span>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal -->
		<jsp:include page="../commons/foot.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
	var editor = null;
	$(function() {
		$('#msgSubmitButtonId')
				.bind(
						'click',
						function() {
							if (!validate('msgSubmitFormId')) {
								$('#errormessageShowboxId').text('信息录入有误，请检查！');
							} else {
								if (confirm("是否发送消息给${name}?")) {
									$('#msgSubmitFormId').submit();
									$('#msgSubmitButtonId').hide();
									$('#msgSubmitButtonId')
											.before(
													"<h2><span class='label label-info glyphicon glyphicon-link'>提交中...</span></h2>");
								}
							}
						});
		//消息主题
		validateInput('titleId', function(id, val, obj) {
			// 标题
				if (valid_isNull(val)) {
					return {
						valid : false,
						msg : '不能为空'
					};
				}
				if (valid_maxLength(val, 64)) {
					return {
						valid : false,
						msg : '长度不能大于' + 64
					};
				}
				return {
					valid : true,
					msg : '正确'
				};
			});
		//消息内容
		validateInput('textId', function(id, val, obj) {
			// 标题
				if (valid_isNull(val)) {
					return {
						valid : false,
						msg : '不能为空'
					};
				}
				if (valid_maxLength(val, 128)) {
					return {
						valid : false,
						msg : '长度不能大于' + 128
					};
				}
				return {
					valid : true,
					msg : '正确'
				};
			});
	});
</script>
</html>