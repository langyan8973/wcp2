<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--组织机构表单-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
	</div>
	<div data-options="region:'center'">
		<form id="dom_formOrganization">
			<input type="hidden" id="entity_id" name="entity.id"
				value="${entity.id}">
			<table class="editTable">
				<tr>
					<td class="title">
						上级机构:
					</td>
					<td colspan="3">
						<c:if test="${parent!=null&&parent.id!=null}">
        ${parent.name}
        <input type="hidden" name='entity.parentid' value="${parent.id}" />
						</c:if>
						<c:if test="${parent==null||parent.id==null}">
        无
      </c:if>
					</td>
				</tr>
				<tr>
					<td class="title">
						名称:
					</td>
					<td>
						<input type="text" style="width: 120px;"
							class="easyui-validatebox"
							data-options="required:true,validType:[,'maxLength[32]']"
							id="entity_name" name="entity.name" value="${entity.name}">
					</td>
					<td class="title">
						状态:
					</td>
					<td>
						<select name="entity.state" id="entity_state"
							style="width: 120px;" val="${entity.state}">
							<option value="1">
								可用
							</option>
							<option value="0">
								禁用
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="title">
						组织类型:
					</td>
					<td>
						<select name="entity.type" id="entity_type" val="${entity.type}"
							style="width: 120px;">
							<option value="1">
								标准
							</option>
						</select>
					</td>
					<td class="title">
						排序:
					</td>
					<td>
						<input type="text" style="width: 120px;"
							class="easyui-validatebox"
							data-options="required:true,validType:[,'maxLength[5]']"
							id="entity_sort" name="entity.sort" value="${entity.sort}">
					</td>
				</tr>
				<tr>
					<td class="title">
						备注:
					</td>
					<td colspan="3">
						<textarea rows="2" style="width: 360px;"
							class="easyui-validatebox"
							data-options="validType:[,'maxLength[64]']" id="entity_comments"
							name="entity.comments">${entity.comments}</textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false">
		<div class="div_button" style="text-align: center; padding: 4px;">
			<c:if test="${pageset.pageType==1}">
				<a id="dom_add_entityOrganization" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">保存</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
				<a id="dom_edit_entityOrganization" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">修改</a>
			</c:if>
			<a id="dom_cancle_formOrganization" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionOrganization = 'admin/FarmAuthorityOrganizationAddCommit.do';
	var submitEditActionOrganization = 'admin/FarmAuthorityOrganizationEditCommit.do';
	var currentPageTypeOrganization = '${pageset.pageType}';
	var submitFormOrganization;
	$(function() {
		//表单组件对象
		submitFormOrganization = $('#dom_formOrganization').SubmitForm( {
			pageType : currentPageTypeOrganization,
			grid : gridOrganization,
			currentWindowId : 'winOrganization'
		});
		//关闭窗口
		$('#dom_cancle_formOrganization').bind('click', function() {
			$('#winOrganization').window('close');
		});
		//提交新增数据
		$('#dom_add_entityOrganization').bind(
				'click',
				function() {
					submitFormOrganization.postSubmit(
							submitAddActionOrganization, function(flag) {
								$('#orgtabsId').tabs('enableTab', 1);
								$('#orgtabsId').tabs('enableTab', 2);
								$('#domTabsId').val(flag.entity.id);
								$('#entity_id').val(flag.entity.id);
							});
				});
		//提交修改数据
		$('#dom_edit_entityOrganization').bind('click', function() {
			submitFormOrganization.postSubmit(submitEditActionOrganization);
		});
	});
	//-->
</script>