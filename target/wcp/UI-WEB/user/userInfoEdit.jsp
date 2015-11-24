<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>个人信息-<PF:ParameterValue key="config.sys.title" /></title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
		<script charset="utf-8"
			src="<PF:basePath/>WEB-FACE/model/supervilidate/validate.js"></script>
		<script charset="utf-8"
			src="<PF:basePath/>WEB-FACE/model/kindeditor/kindeditor-all-min.js"></script>
		<link rel="stylesheet"
			href="<PF:basePath/>WEB-FACE/model/kindeditor/themes/default/default.css" />
	</head>
	<body>
		<jsp:include page="../commons/head.jsp"></jsp:include>
		<div class="containerbox">
			<div class="container ">
				<div class="row">
					<div class="col-sm-3  visible-lg visible-md">
						<div class="panel panel-default userbox">
							<div class="panel-body">
								<jsp:include page="/UI-WEB/commons/includeUserPanel.jsp"></jsp:include>
							</div>
						</div>
					</div>
					<div class="col-sm-9">
						<div class="row">
							<div class="col-sm-12" style="margin-bottom: 8px;">
								<span style="color: #D9534F;"
									class="glyphicon glyphicon-user wcp_columnTitle">个人信息修改</span>
								<hr />
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<c:if test="${pageset.commitType=='1'}">
									<div class="alert alert-danger">
										${pageset.message}
									</div>
								</c:if>
								<c:if test="${pageset.commitType=='0'}">
									<div class="alert alert-success">
										修改成功
									</div>
								</c:if>
								<form role="form" action="index/FLeditUserCommit.htm"
									id="registSubmitFormId" method="post">
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label for="exampleInputEmail1">
													头像
													<span class="alertMsgClass">*</span>
												</label>
												<div class="row">
													<div class="col-md-9">
														<c:if test="${photourl!=null}">
															<img id="imgEditBoxId" src="${photourl}" alt="..."
																class="img-thumbnail" />
														</c:if>
														<c:if test="${photourl==null}">
															<img id="imgEditBoxId"
																src="<PF:basePath/>WEB-FACE/img/style/photo.png"
																alt="..." class="img-thumbnail" />
														</c:if>
														<input type="hidden" name="photoid" id="photoid"
															value="${photoid}" />
														<input type="button" id="uploadButton" value="上传头像" />
													</div>
													<div class="col-md-3">

													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label for="exampleInputEmail1">
													姓名
													<span class="alertMsgClass">*</span>
												</label>
												<div class="row">
													<div class="col-md-9">
														<input type="text" class="form-control" name="name"
															id="nameid" placeholder="输入真实姓名" value="${name}" />
													</div>
													<div class="col-md-3">
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- <div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label for="exampleInputEmail1">
													组织机构
													<span class="alertMsgClass">*</span>
												</label>
												<div class="row">
													<div class="col-md-9">
														<input type="text" class="form-control" id="orgnameId"
															readonly="readonly" name="orgname" placeholder="选择组织机构"
															value="${orgname}" />

														<input type="hidden" name="orgid" id="orgid"
															value="${orgid}" />
													</div>
													<div class="col-md-3">
														<button class="btn btn-primary btn-sm" data-toggle="modal"
															id="openChooseTypeButtonId" data-target="#myModal">
															选择
														</button>
													</div>
												</div>
											</div>
										</div>
									</div> -->
									<div class="row">
										<div class="col-md-5">
											<button type="button" id="registSubmitButtonId"
												class="btn btn-primary">
												提交用户信息
											</button>
										</div>
										<div class="col-md-5">
											<span class="alertMsgClass" id="errormessageShowboxId"></span>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../commons/foot.jsp"></jsp:include>
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">
							选择组织机构
						</h4>
					</div>
					<div class="modal-body">
						<jsp:include page="/UI-WEB/user/commons/includePubOrg.jsp"></jsp:include>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							关闭
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<script type="text/javascript">
	$(function() {
		$('#registSubmitButtonId').bind('click', function() {
			if (!validate('registSubmitFormId')) {
				$('#errormessageShowboxId').text('信息录入有误，请检查！');
			} else {
				$('#registSubmitFormId').submit();
			}
		});
		KindEditor.ready(function(K) {
			var uploadbutton = K.uploadbutton( {
				button : K('#uploadButton'),
				fieldName : 'imgFile',
				url : basePath + 'admin/FPupload.do',
				afterUpload : function(data) {
					if (data.error === 0) {
						$('#imgEditBoxId').attr('src', data.url);
						$('#photoid').val(data.id);
					} else {
						alert(data.message);
					}
				},
				afterError : function(str) {
					alert('自定义错误信息: ' + str);
				}
			});
			uploadbutton.fileBox.change(function(e) {
				uploadbutton.submit();
			});
		});
		validateInput('nameid', function(id, val, obj) {
			// 用户名
				if (valid_isNull(val)) {
					return {
						valid : false,
						msg : '不能为空'
					};
				}
				if (!valid_maxLength(val, 2 - 1)) {
					return {
						valid : false,
						msg : '不能小于2个字符'
					};
				}
				if (valid_maxLength(val, 16)) {
					return {
						valid : false,
						msg : '不能大于16个字符'
					};
				}
				return {
					valid : true,
					msg : '正确'
				};
			});
		validateInput('orgnameId', function(id, val, obj) {
			// 组织机构
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
	function clickDocType(id, text) {
		$('#orgnameId').val(text);
		$('#orgid').val(id);
		$('#myModal').modal('hide');
	}
</script>
	</body>
</html>