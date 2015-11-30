<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/farmdoc.tld" prefix="DOC"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<base href="<PF:basePath/>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>上传资源文件<%-- -<PF:ParameterValue key="config.sys.title" /> --%></title>
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
							<jsp:include page="/UI-WEB/commons/includeUserPanel.jsp"></jsp:include>
							<jsp:include page="../commons/loginbox.jsp"></jsp:include>
						</div>
					</div>
				</div>
				<div class="col-md-9">
					<div class="row">
						<div class="col-md-12">
							<ol class="breadcrumb mytitlebar">
								<li class="active" style="color:#FFFFFF">WCP</li>
								<li class="active" style="color:#FFFFFF">创建资源文件</li>
							</ol>
						</div>
					</div>
					<form role="form" action="index/FLcreatSubmitWebFile.htm"
						id="knowSubmitFormId" method="post">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label for="exampleInputEmail1"> 上传资源 <span
										class="alertMsgClass">*</span>
									</label>
									<div>
										<input type="hidden" name="fileId" id="uploadfileId"
											value="${fileId}" /> <input type="button"
											id="uploadButton" value="上传" /> <span id="uploadMarkId">${fileName}</span>
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="exampleInputEmail1"> 栏目分类<span
										class="alertMsgClass">*</span>
									</label>
									<div class="row">
										<div class="col-md-9">
											<input type="text" class="form-control" id="knowtypeTitleId"
												readonly="readonly" placeholder="选择栏目分类"
												value="${doc.types[0].name}" /> <input type="hidden"
												name="knowtype" id="knowtypeId" value="${doc.types[0].id}" />
										</div>
										<div class="col-md-3">
											<button class="btn btn-primary btn-sm" data-toggle="modal"
												id="openChooseTypeButtonId" data-target="#myModal">
												选择</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label for="exampleInputEmail1"> 标题 <span
										class="alertMsgClass">*</span>
									</label> <input type="text" class="form-control" name="knowtitle"
										value="${doc.title}" id="knowtitleId" placeholder="输入知识标题" />
								</div>

							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="exampleInputEmail1"> tag </label> <input
										type="text" class="form-control" id="knowtagId"
										value="${doc.tagkey}" name="knowtag"
										placeholder="输入类别标签(如果没有系统将自动创建)" />
								</div>

							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<div class="form-group">
									<label for="exampleInputEmail1"> 是否发布到小组 </label> <select
										class="form-control" name="docgroup" id="docgroupId"
										val="${doc.docgroupid!=null?(doc.docgroupid):docgroup}">
										<option value="0">否</option>
										<DOC:docGroupOption aroundS="[工作小组]:" />
									</select>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="exampleInputEmail1"> 编辑权限 <span
										class="alertMsgClass">*</span>
									</label> <select class="form-control" name="writetype" id="writetypeId"
										val="0">
										<option value="">~请选择~</option>
										<option value="0">创建人</option>
										<option value="1">公开</option>
										<option value="2">小组</option>
									</select>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label for="exampleInputEmail1"> 阅读权限 <span
										class="alertMsgClass">*</span>
									</label> <select class="form-control" name="readtype" id="readtypeId"
										val="1">
										<option value="">~请选择~</option>
										<option value="0">创建人</option>
										<option value="1">公开</option>
										<option value="2">小组</option>
									</select>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<label for="exampleInputEmail1"> 摘要 </label>
								<textarea name="text" id="contentId"
									style="height: 50px; width: 100%;">${text}</textarea>
							</div>
						</div>
						<br/><br/>
						<div class="row">
							<div class="col-md-2">
								<button type="button" id="knowSubmitButtonId"
									class="btn btn-primary">提交</button>
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
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">选择分类</h4>
				</div>
				<div class="modal-body" id="treeChooseTypeBoxId"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">
						关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<jsp:include page="../commons/foot.jsp"></jsp:include>
</body>
<script>
	KindEditor
			.ready(function(K) {
				var uploadbutton = K
						.uploadbutton({
							button : K('#uploadButton')[0],
							fieldName : 'imgFile',
							url : basePath + 'admin/FPupload.do',
							afterUpload : function(data) {
								if (data.error === 0) {
									$('#uploadfileId').val(data.id);
									$('#uploadMarkId')
											.html(
													'<span style="color:green" class="glyphicon glyphicon-ok">上传成功</span>');
									//自动带入标题 message,error,url,id,imgFileFileName
									$('#knowtitleId').val(data.imgFileFileName);
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
</script>
<script type="text/javascript">
	var editor = null;
	$(function() {
		editor = KindEditor.create('textarea[id="contentId"]', {
			resizeType : 1,
			afterChange : function() {

			},
			cssPath : '<PF:basePath/>WEB-FACE/model/kindeditor/editInner.css',
			uploadJson : basePath + 'admin/FPupload.do',
			allowPreviewEmoticons : false,
			allowImageUpload : true,
			items : [ 'source', 'fullscreen', '|', 'fontsize', 'forecolor',
					'bold', 'italic', 'underline', 'removeformat', '|',
					'justifyleft', 'justifycenter', 'justifyright', 'image' ]
		});
		$('#openChooseTypeButtonId').bind('click', function() {
			$('#myModal').modal({
				keyboard : false
			})
		});
		$('select', '#knowSubmitFormId').each(function(i, obj) {
			var val = $(obj).attr('val');
			$(obj).val(val);
		});
		$('#treeChooseTypeBoxId').load('index/FPDoctypeTreeShow.htm');
		$('#knowSubmitButtonId')
				.bind(
						'click',
						function() {
							editor.sync();
							if (!validate('knowSubmitFormId')) {
								$('#errormessageShowboxId').text('信息录入有误，请检查！');
							} else {
								if ($('#contentId').val().length > 1000000) {
									$('#errormessageShowboxId')
											.text(
													'文档内容超长（'
															+ $('#contentId')
																	.val().length
															+ '>1000000)');
									return false;
								}
								//判断附件是否上传
								if(!$('#uploadfileId').val()){
									$('#errormessageShowboxId')
									.text(
											'请上传文件');
									return false;
								}
								if (confirm("是否提交数据?")) {
									$('#knowSubmitFormId').submit();
									$('#knowSubmitButtonId').hide();
									$('#knowSubmitButtonId')
											.before(
													"<h2><span class='label label-info glyphicon glyphicon-link'>提交中...</span></h2>");
								}
							}
						});
		validateInput('knowtypeTitleId', function(id, val, obj) {
			// 分类
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
		//绑定一个表单的验证事件
		validateInput('knowtitleId', function(id, val, obj) {
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
		//绑定一个表单的验证事件
		validateInput('knowtagId', function(id, val, obj) {
			// 学生姓名
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
		//编辑权限
		validateInput('writetypeId', function(id, val, obj) {
			if (valid_isNull(val)) {
				return {
					valid : false,
					msg : '不能为空'
				};
			}
			if (val == '2' && $('#docgroupId').val() == '0') {
				return {
					valid : false,
					msg : '请选择工作小组'
				};
			}
			return {
				valid : true,
				msg : '正确'
			};
		});
		//阅读权限
		validateInput('readtypeId', function(id, val, obj) {
			if (valid_isNull(val)) {
				return {
					valid : false,
					msg : '不能为空'
				};
			}
			if (val == '2' && $('#docgroupId').val() == '0') {
				return {
					valid : false,
					msg : '请选择工作小组'
				};
			}
			if ($('#docgroupId').val() != '0') {
				if (val == '0') {
					return {
						valid : false,
						msg : '阅读权限至少是小组'
					};
				}
			}
			return {
				valid : true,
				msg : '正确'
			};
		});
		//工作小组
		validateInput('docgroupId', function(id, val, obj) {
			return {
				valid : true,
				msg : '正确'
			};
		});
	});
	function clickDocType(id, text) {
		$('#knowtypeTitleId').val(text);
		$('#knowtypeId').val(id);
		$('#myModal').modal('hide');
	}
</script>
</html>