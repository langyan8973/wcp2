<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>下载网络资源<%-- -<PF:ParameterValue key="config.sys.title"/> --%></title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
		<script charset="utf-8"
			src="<PF:basePath/>WEB-FACE/model/supervilidate/validate.js"></script>
	</head>
	<body>
		<jsp:include page="../commons/head.jsp"></jsp:include>
		<div class="containerbox">
			<div class="container " style="margin-top:30px;">
				<div class="row">
					<div class="col-md-3  visible-lg visible-md">
						<div class="panel panel-default userbox">
							<div class="panel-body">
								<jsp:include page="/UI-WEB/commons/includeUserPanel.jsp"></jsp:include>
								<jsp:include page="../commons/loginbox.jsp"></jsp:include>
							</div>
						</div>
						<jsp:include page="commons/includeHotKnowsMin.jsp"></jsp:include>
					</div>
					<div class="col-md-9">
						<div class="row">
							<div class="col-md-12">
								<ol class="breadcrumb mytitlebar">
									<li>
										<a style="color:#FFFFFF">WCP</a>
									</li>
									<li>
										<a style="color:#FFFFFF">创建知识</a>
									</li>
									<li class="active" style="color:#FFFFFF">
										下载网页
									</li>
								</ol>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<c:if test="${pageset.commitType=='1'}">
									<div class="alert alert-danger">
										${pageset.message}
									</div>
								</c:if>
								<form role="form" action="index/FLDownWebCommit.htm"
									id="knowSubmitFormId" method="post">
									<input type="hidden" name="typeid" value="${typeid}">
									<input type="hidden" name="docgroup" value="${docgroup}">
									<div class="form-group">
										<label for="exampleInputEmail1">
											URL
											<span class="alertMsgClass">*</span>
										</label>
										<input type="text" class="form-control" value="${url}" name="url"
											id="urlId" placeholder="输入网页url地址" />
									</div>
								</form>
							</div>
						</div>
						<div class="row">
							<div class="col-md-2">
								<button type="button" id="knowSubmitButtonId"
									class="btn btn-primary">
									提交
								</button>
							</div>
							<div class="col-md-10">
								<span class="alertMsgClass" id="errormessageShowboxId"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal -->
		<jsp:include page="../commons/foot.jsp"></jsp:include>
		<script type="text/javascript">
	$(function() {
		$('#knowSubmitButtonId')
				.bind(
						'click',
						function() {
							if (!validate('knowSubmitFormId')) {
								$('#errormessageShowboxId').text('信息录入有误，请检查！');
							} else {
								$('#knowSubmitFormId').submit();
								$('#knowSubmitButtonId').hide();
								$('#knowSubmitButtonId')
										.before(
												"<h2><span class='label label-info glyphicon glyphicon-link'>提交中...</span></h2>");
							}
						});
		validateInput('urlId', function(id, val, obj) {
			if (valid_isNull(val)) {
				return {
					valid : false,
					msg : '不能为空'
				};
			}
			return {
				valid : true,
				msg : '正确'
			};
		});
	});
</script>
	</body>
</html>