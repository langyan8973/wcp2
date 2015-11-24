<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/farmdoc.tld" prefix="DOC"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>编辑小组首页-<PF:ParameterValue key="config.sys.title" />
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
		<link rel="stylesheet"
			href="<PF:basePath/>WEB-FACE/model/kindeditor/wcpplug/wcp-kindeditor.css" />
		<script charset="utf-8"
			src="<PF:basePath/>WEB-FACE/model/kindeditor/wcpplug/wcp-kindeditor.js"></script>
	</head>
	<body>
		<jsp:include page="../commons/head.jsp"></jsp:include>
		<div class="containerbox">
			<div class="container ">
				<div class="row">
					<div class="col-md-3  visible-lg visible-md">
						<div class="panel panel-default userbox">
							<div class="panel-body">
								<p>
									<c:forEach items="${group.tags}" var="tag">
										<span class="label label-info tagsearch" title="${tag}"
											style="font-weight: lighter; font-size: 12px; cursor: pointer;">${tag}</span>
									</c:forEach>
								</p>
								<h3 style="text-align: center; font-weight: bold;">
									<c:if test="${group.joincheck=='1'}">
										<span class="glyphicon glyphicon-lock">&nbsp;${group.groupname}&nbsp;</span>
									</c:if>
									<c:if test="${group.joincheck=='0'}">
								${group.groupname}
							</c:if>
								</h3>
								<a class="thumbnail"> <c:if test="${group.groupimg==null}">
										<img src="UI-WEB/docgroup/commons/imgDemo.png" alt="...">
									</c:if> <c:if test="${group.groupimg!=null}">
										<img src="${group.imgurl}" alt="...">
									</c:if> </a>
								<p>
									${group.groupnote}
								</p>
							</div>
						</div>
					</div>
					<div class="col-md-9">
						<div class="row">
							<div class="col-md-12">
								<ol class="breadcrumb">
									<li class="active">
										WCP
									</li>
									<li class="active">
										${group.groupname}
									</li>
									<li class="active">
										编辑小组首页
									</li>
								</ol>
							</div>
						</div>
						<form role="form" action="index/FLEditGroupHomeCommit.htm"
							id="knowSubmitFormId" method="post">
							<input type="hidden" name="id" value="${id}" />
							<input type="hidden" name="doc.id" value="${doc.id}" />
							<div class="row">
								<div class="col-md-12">
									<textarea name="text" id="contentId"
										style="height: 500px; width: 100%;">${doc.texts.text1}</textarea>
								</div>
							</div>
							<!-- 修改 -->
							<c:if test="${doc!=null&&doc.id!=null}">
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label for="exampleInputEmail1">
												修改原因
												<span class="alertMsgClass">*</span>
											</label>
											<input type="text" class="form-control" id="knowEditNoteId"
												name="editNote" placeholder="修改原因将被记录在版本备注中" />
										</div>
									</div>
								</div>
								</script>
							</c:if>
							<div class="row">
								<div class="col-md-2">
									<button type="button" id="knowSubmitButtonId"
										class="btn btn-primary">
										提交
									</button>
									<button type="button" id="knowCancelButtonId"
										class="btn btn-default">
										取消
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
		editor = KindEditor.create('textarea[id="contentId"]', {
			resizeType : 1,
			cssPath : '<PF:basePath/>WEB-FACE/model/kindeditor/editInner.css',
			uploadJson : basePath + 'admin/FPupload.do',
			allowPreviewEmoticons : false,
			allowImageUpload : true,
			items : [ 'source', 'fullscreen', '|', 'fontsize', 'forecolor',
					'bold', 'italic', 'underline', 'removeformat', '|',
					'justifyleft', 'justifycenter', 'justifyright',
					'insertorderedlist', 'insertunorderedlist', 'lineheight',
					'|', 'formatblock', 'quickformat', 'table', 'hr',
					'pagebreak', '|', 'link', 'image', 'code', 'insertfile',
					'wcpknow' ]
		});
		$('#openChooseTypeButtonId').bind('click', function() {
			$('#myModal').modal( {
				keyboard : false
			})
		});
		$('select', '#knowSubmitFormId').each(function(i, obj) {
			var val = $(obj).attr('val');
			$(obj).val(val);
		});
		$('#treeChooseTypeBoxId').load('index/FPDoctypeTreeShow.htm');
		$('#knowCancelButtonId').bind('click', function() {
			window.location="index/FPGroupInfo.htm?id=${group.id}";
		});
		$('#knowSubmitButtonId')
				.bind(
						'click',
						function() {
							editor.sync();
							if (!validate('knowSubmitFormId')) {
								$('#errormessageShowboxId').text('信息录入有误，请检查！');
							} else {
								if ($('#contentId').val() == null
										|| $('#contentId').val() == '') {
									$('#errormessageShowboxId')
											.text('请录入文档内容！');
									return false;
								}
								if ($('#contentId').val().length > 1000000) {
									$('#errormessageShowboxId')
											.text(
													'文档内容超长（' + $('#contentId')
															.val().length + '>1000000)');
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
		//阅读权限
		validateInput('knowEditNoteId', function(id, val, obj) {
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