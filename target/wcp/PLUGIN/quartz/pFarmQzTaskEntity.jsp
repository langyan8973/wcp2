<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--任务定义-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
		<form id="dom_formfarmqztask">
			<input type="hidden" name="entity.id" value="${entity.id}">
			<table class="editTable">
				<tr>
					<td class="title">
						名称:
					</td>
					<td colspan="3">
						<input class="easyui-validatebox" style="width: 360px;"
							data-options="required:true,validType:',maxLength[64]'"
							id="entity_name" name="entity.name" value="${entity.name}">
					</td>
				</tr>
				<tr>
					<td class="title">
						类:
					</td>
					<td colspan="3">
						实现了org.quartz.Job接口的类（如：com.farm.quartz.test.MyJob）
						<br />
						<input class="easyui-validatebox" style="width: 360px;"
							data-options="required:true,validType:',maxLength[64]'"
							id="entity_jobclass" name="entity.jobclass"
							value="${entity.jobclass}">
					</td>
				</tr>
				<tr>
					<td class="title">
						备注:
					</td>
					<td colspan="3">
						<textarea rows="3" style="width: 360px;"
							class="easyui-validatebox"
							data-options="required:false,validType:',maxLength[64]'"
							id="entity_pcontent" name="entity.pcontent">${entity.pcontent}</textarea>
					</td>
				</tr>
				<c:if test="${pageset.pageType==1}">
					<!--新增-->
				</c:if>
				<c:if test="${pageset.pageType==2}">
					<!--修改-->
				</c:if>
				<c:if test="${pageset.pageType==0}">
					<!--浏览-->
				</c:if>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false">
		<div class="div_button" style="text-align: center; padding: 4px;">
			<c:if test="${pageset.pageType==1}">
				<a id="dom_add_entityfarmqztask" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">增加</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
				<a id="dom_edit_entityfarmqztask" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">修改</a>
			</c:if>
			<a id="dom_cancle_formfarmqztask" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionfarmqztask = 'admin/FarmQzTaskaddCommit.do';
	var submitEditActionfarmqztask = 'admin/FarmQzTaskeditCommit.do';
	var currentPageTypefarmqztask = '${pageset.pageType}';
	var submitFormfarmqztask;
	$(function() {
		submitFormfarmqztask = $('#dom_formfarmqztask').SubmitForm( {
			pageType : currentPageTypefarmqztask,
			grid : gridfarmqztask,
			currentWindowId : 'winfarmqztask'
		});
		$('#dom_cancle_formfarmqztask').bind('click', function() {
			$('#winfarmqztask').window('close');
		});
		$('#dom_add_entityfarmqztask').bind('click', function() {
			submitFormfarmqztask.postSubmit(submitAddActionfarmqztask);
		});
		$('#dom_edit_entityfarmqztask').bind('click', function() {
			submitFormfarmqztask.postSubmit(submitEditActionfarmqztask);
		});
	});
	//-->
</script>