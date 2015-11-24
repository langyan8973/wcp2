<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div class="row">
	<div class="col-md-12">
		<ol class="breadcrumb">
			<li>
				<a>WCP</a>
			</li>
			<li>
				<a>小组</a>
			</li>
			<li class="active">
				审请加入"${group.groupname}"小组
			</li>
		</ol>
	</div>
</div>
<form role="form" action="index/joinGroup.htm" id="knowSubmitFormId"
	method="post">
	<input type="hidden" name="id" id="group_id" value="${group.id}" />
	<div class="row">
		<div class="col-md-12">
			<div class="form-group">
				<label for="exampleInputEmail1">
					申请说明
					<span class="alertMsgClass">*</span>
				</label>
				<textarea name="usergroup.applynote" id="usergroup_applynote"
					class="form-control" rows="3">${usergroup.applynote}</textarea>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-2">
			<button type="button" id="knowSubmitButtonId" class="btn btn-primary">
				提交申请
			</button>
		</div>
		<div class="col-md-10">
			<span class="alertMsgClass" id="errormessageShowboxId"></span>
		</div>
	</div>
</form>
<script>
	$(function() {
		$('#knowSubmitButtonId').bind('click', function() {
			if (!validate('knowSubmitFormId')) {
				$('#errormessageShowboxId').text('信息录入有误，请检查！');
			} else {
				if (confirm("是否提交?")) {
					$('#knowSubmitFormId').submit();
					$('#knowSubmitButtonId').hide();
					$('#knowSubmitButtonId').before("<h2><span class='label label-info glyphicon glyphicon-link'>提交中...</span></h2>");
				}
			}
		});
		// 小组名称
		validateInput('usergroup_applynote', function(id, val, obj) {
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
	});
</script>