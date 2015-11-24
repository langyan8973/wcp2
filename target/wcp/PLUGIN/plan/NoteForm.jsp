<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--任务描述表单-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
		<form id="dom_formNote">
			<input type="hidden" name="ids" value="${ids}">
			<input type="hidden" name="entity.id" value="${entity.id}">
			<table class="editTable">
				<tr>
					<td class="title">
						任务描述:
					</td>
					<td colspan="3">
						<textarea style="width: 360px; height: 80px;"
							class="easyui-validatebox"
							data-options="required:true,validType:['maxLength[1024]']"
							id="entity_pcontent" name="entity.pcontent">${entity.pcontent}</textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false">
		<div class="div_button" style="text-align: center; padding: 4px;">
			<c:if test="${pageset.pageType==1}">
				<a id="dom_add_entityNote" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">增加</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
				<a id="dom_edit_entityNote" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">修改</a>
			</c:if>
			<a id="dom_cancle_formNote" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionNote = 'admin/FarmPlanNoteaddCommit.do';
	var submitEditActionNote = 'admin/FarmPlanNoteeditCommit.do';
	var currentPageTypeNote = '${pageset.pageType}';
	var submitFormNote;
	$(function() {
		//表单组件对象
		submitFormNote = $('#dom_formNote').SubmitForm( {
			pageType : currentPageTypeNote,
			grid : gridNote,
			currentWindowId : 'winNote'
		});
		//关闭窗口
		$('#dom_cancle_formNote').bind('click', function() {
			$('#winNote').window('close');
		});
		//提交新增数据
		$('#dom_add_entityNote').bind('click', function() {
			submitFormNote.postSubmit(submitAddActionNote);
		});
		//提交修改数据
		$('#dom_edit_entityNote').bind('click', function() {
			submitFormNote.postSubmit(submitEditActionNote);
		});
	});
	//-->
</script>