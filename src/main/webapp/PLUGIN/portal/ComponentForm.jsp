<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--组件库表单-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
		<form id="dom_formComponent">
			<input type="hidden" id="entity_id" name="entity.id"
				value="${entity.id}">
			<table class="editTable">
				<tr>
					<td class="title">
						标题:
					</td>
					<td colspan="3">
						<input type="text" style="width: 360px;"
							class="easyui-validatebox"
							data-options="required:true,validType:[,'maxLength[64]']"
							id="entity_title" name="entity.title" value="${entity.title}">
					</td>
				</tr>
				<tr>
					<td class="title">
						备注:
					</td>
					<td colspan="3">
						<textarea rows="2" style="width: 360px;"
							class="easyui-validatebox"
							data-options="validType:[,'maxLength[64]']" id="entity_pcontent"
							name="entity.pcontent">${entity.pcontent}</textarea>
					</td>
				</tr>
				<tr>
					<td class="title">
						URL:
					</td>
					<td colspan="3">
						<input type="text" style="width: 360px;"
							class="easyui-validatebox"
							data-options="required:true,validType:[,'maxLength[256]']"
							id="entity_url" name="entity.url" value="${entity.url}">
					</td>
				</tr>
				<tr>
					<td class="title">
						状态:
					</td>
					<td>
						<select name="entity.pstate" id="entity_pstate"
							val="${entity.pstate}">
							<option value="1">
								可用
							</option>
							<option value="0">
								禁用
							</option>
						</select>
					</td>
					<td class="title">
						图表class:
					</td>
					<td>
						<input type="hidden" id="entity_img_id"
							name="entity.iconclass" value="${entity.iconclass}">
						<a id="chooseImg" class="easyui-linkbutton"
							data-options="iconCls:'${entity.iconclass}'">选择</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false">
		<div class="div_button" style="text-align: center; padding: 4px;">
			<c:if test="${pageset.pageType==1}">
				<a id="dom_add_entityComponent" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">增加</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
				<a id="dom_edit_entityComponent" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">修改</a>
			</c:if>
			<a id="dom_cancle_formComponent" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionComponent = 'admin/FarmPortalComponentaddCommit.do';
	var submitEditActionComponent = 'admin/FarmPortalComponenteditCommit.do';
	var currentPageTypeComponent = '${pageset.pageType}';
	var submitFormComponent;
	$(function() {
		//表单组件对象
		submitFormComponent = $('#dom_formComponent').SubmitForm( {
			pageType : currentPageTypeComponent,
			grid : gridComponent,
			currentWindowId : 'winComponent'
		});
		//关闭窗口
		$('#dom_cancle_formComponent').bind('click', function() {
			$('#winComponent').window('close');
		});
		//提交新增数据
		$('#dom_add_entityComponent').bind('click', function() {
			submitFormComponent.postSubmit(submitAddActionComponent);
		});
		//提交修改数据
		$('#dom_edit_entityComponent').bind('click', function() {
			submitFormComponent.postSubmit(submitEditActionComponent);
		});
		$('#chooseImg').bind(
				'click',
				function() {
					$.farm.openWindow( { id : 'windowChooseImg', width : 600, height :300,modal : true, url : "admin/ALONEMenu_ACTION_cssIcon.do", title : '选择图标' });
				});
	});
	//-->
</script>