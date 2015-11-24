<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--任务-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
		<form id="dom_formfarmwormtask">
			<input type="hidden" name="entity.id" value="${entity.id}">
			<table class="editTable">
				<tr>
					<td class="title">
						URL:
					</td>
					<td colspan="3">
						<textarea rows="3" style="width: 360px;"
							class="easyui-validatebox"
							data-options="required:true,validType:',maxLength[256]'"
							id="entity_url" name="entity.url">${entity.url}</textarea>
					</td>
				</tr>
				<tr>
					<td class="title">
						标题:
					</td>
					<td colspan="3">
						<input type="text" style="width: 360px;"
							class="easyui-validatebox"
							data-options="required:true,validType:',maxLength[64]'"
							id="entity_title" name="entity.title" value="${entity.title}">

					</td>
				</tr>
				<tr>
					<td class="title">
						类型:
					</td>
					<td colspan="3">
						<select name="entity.type" id="entity_type" val="${entity.type}">
							<option value="1">
								种子
							</option>
							<option value="2">
								文档
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="title">
						状态:
					</td>
					<td colspan="3">
						<select name="entity.pstate" id="entity_pstate"
							val="${entity.pstate}">
							<option value="1">
								未开始
							</option>
							<option value="2">
								正在
							</option>
							<option value="3">
								完成
							</option>
							<option value="4">
								异常
							</option>
						</select>
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
				<a id="dom_add_entityfarmwormtask" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">增加</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
				<a id="dom_edit_entityfarmwormtask" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">修改</a>
			</c:if>
			<a id="dom_cancle_formfarmwormtask" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionfarmwormtask = 'admin/FarmWormTaskaddCommit.do';
	var submitEditActionfarmwormtask = 'admin/FarmWormTaskeditCommit.do';
	var currentPageTypefarmwormtask = '${pageset.pageType}';
	var submitFormfarmwormtask;
	$(function() {
		//表单组件对象
		submitFormfarmwormtask = $('#dom_formfarmwormtask').SubmitForm( {
			pageType : currentPageTypefarmwormtask,
			grid : gridfarmwormtask,
			currentWindowId : 'winfarmwormtask'
		});
		//关闭窗口
		$('#dom_cancle_formfarmwormtask').bind('click', function() {
			$('#winfarmwormtask').window('close');
		});
		//提交新增数据
		$('#dom_add_entityfarmwormtask').bind('click', function() {
			submitFormfarmwormtask.postSubmit(submitAddActionfarmwormtask);
		});
		//提交修改数据
		$('#dom_edit_entityfarmwormtask').bind('click', function() {
			submitFormfarmwormtask.postSubmit(submitEditActionfarmwormtask);
		});
	});
	//-->
</script>