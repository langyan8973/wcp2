<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>分类知识<%-- -<PF:ParameterValue key="config.sys.title" /> --%>
		</title>
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
			<div class="container " style="margin-top:30px;">
				<div class="row">
					<div class="col-md-3  visible-lg visible-md">
						<div class="panel panel-default userbox">
							<div class="panel-body">
								<jsp:include page="commons/includePubType.jsp"></jsp:include>
							</div>
						</div>
					</div>
					<div class="col-md-9">
						<div class="row">
							<div class="col-sm-12 mytitlebar">
								<span style="color: #FFFFFF;"
									class="glyphicon glyphicon-tag wcp_columnTitle">上级分类<c:if
										test="${knowtype!=null}">:${knowtype}</c:if> </span>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<form id="typeFormId" action="index/FLtypeSaveCommit.htm"
									method="post">
									<input type="hidden" name="id" value="${id}">
									<input type="hidden" name="pageset.pageType" value="${pageset.pageType}">
									<div class="form-group">
										<label for="exampleInputEmail1">
											分类名称
											<span class="alertMsgClass">*</span>
										</label>
										<input type="text" class="form-control" id="typeNameId"
											name="doctype.name" placeholder="分类名称" value="${doctype.name}">
									</div>
									<div class="form-group">
										<label for="exampleInputPassword1">
											排序
											<span class="alertMsgClass">*</span>
										</label>
										<input type="text" class="form-control" id="typeSortId"
											name="doctype.sort" placeholder="排序值" value="${doctype.sort}">
									</div>
									<button type="button" id="submitButtonId"
										class="btn btn-default">
										提交
									</button>
									<c:if test="${pageset.message!=null&&pageset.message!=''}">
										<div class="form-group">
											<div class="alert alert-danger" role="alert"
												style="margin-top: 8px;">
												<span class="alertMsgClass" id="errormessageShowboxId">${pageset.message}</span>
											</div>
										</div>
									</c:if>
								</form>
							</div>
							<div class="row">
								<div class="col-sm-12">

								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../commons/foot.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
	$(function() {
		validateInput('typeNameId', function(id, val, obj) {
			// 分类名称
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
		validateInput('typeSortId', function(id, val, obj) {
			// 分类排序
				if (valid_isNull(val)) {
					return {
						valid : false,
						msg : '不能为空'
					};
				}
				if (!valid_isNumber(val)) {
					return {
						valid : false,
						msg : '必须为整数'
					};
				}
				return {
					valid : true,
					msg : '正确'
				};
			});
		$('#submitButtonId').bind('click', function() {
			//进行全体表单的验证
				if (validate('typeFormId')) {
					$('#typeFormId').submit();
				}
			});
	});
</script>
</html>