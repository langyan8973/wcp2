<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--下载内容-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
		<form id="dom_formfarmwormdocattr">
			<input type="hidden" name="entity.id" value="${entity.id}">
			<table class="editTable">
				<tr>
					<td class="title">
						内容:
					</td>
					<td colspan="3">
							<textarea rows="3" style="width: 360px;" class="easyui-validatebox" data-options="required:false,validType:',maxLength[64]'"
							id="entity_pcontent" name="entity.pcontent">${entity.pcontent}</textarea>
					</td>
				</tr>
				<tr>
					<td class="title">
						属性ID:
					</td>
					<td colspan="3">
							<input type="text" style="width: 360px;" class="easyui-validatebox" data-options="required:true,validType:',maxLength[16]'"
							id="entity_attrparseid" name="entity.attrparseid" value="${entity.attrparseid}">
							
					</td>
				</tr>
				<tr>
					<td class="title">
						任务ID:
					</td>
					<td colspan="3">
							<input type="text" style="width: 360px;" class="easyui-validatebox" data-options="required:true,validType:',maxLength[16]'"
							id="entity_taskid" name="entity.taskid" value="${entity.taskid}">
							
					</td>
				</tr>
			<c:if test="${pageset.pageType==1}"><!--新增-->
			</c:if>
			<c:if test="${pageset.pageType==2}"><!--修改-->
			</c:if>
			<c:if test="${pageset.pageType==0}"><!--浏览-->
			</c:if>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false">
		<div class="div_button" style="text-align: center; padding: 4px;">
			<c:if test="${pageset.pageType==1}">
			<a id="dom_add_entityfarmwormdocattr" href="javascript:void(0)"  iconCls="icon-save" class="easyui-linkbutton">增加</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
			<a id="dom_edit_entityfarmwormdocattr" href="javascript:void(0)" iconCls="icon-save" class="easyui-linkbutton">修改</a>
			</c:if>
			<a id="dom_cancle_formfarmwormdocattr" href="javascript:void(0)" iconCls="icon-cancel" class="easyui-linkbutton"   style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionfarmwormdocattr = 'admin/FarmWormDocattraddCommit.do';
	var submitEditActionfarmwormdocattr = 'admin/FarmWormDocattreditCommit.do';
	var currentPageTypefarmwormdocattr = '${pageset.pageType}';
	var submitFormfarmwormdocattr;
	$(function() {
		//表单组件对象
		submitFormfarmwormdocattr = $('#dom_formfarmwormdocattr').SubmitForm( {
			pageType : currentPageTypefarmwormdocattr,
			grid : gridfarmwormdocattr,
			currentWindowId : 'winfarmwormdocattr'
		});
		//关闭窗口
		$('#dom_cancle_formfarmwormdocattr').bind('click', function() {
			$('#winfarmwormdocattr').window('close');
		});
		//提交新增数据
		$('#dom_add_entityfarmwormdocattr').bind('click', function() {
			submitFormfarmwormdocattr.postSubmit(submitAddActionfarmwormdocattr);
		});
		//提交修改数据
		$('#dom_edit_entityfarmwormdocattr').bind('click', function() {
			submitFormfarmwormdocattr.postSubmit(submitEditActionfarmwormdocattr);
		});
	});
	//-->
</script>