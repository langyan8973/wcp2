<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--岗位表单-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
		<form id="dom_formPost">
			<input type="hidden" id="entity_id" name="entity.id"
				value="${entity.id}">
			<input type="hidden" id="org_id" name="ids"
				value="${ids}">
			<table class="editTable">
				<tr>
					<td class="title">
						类型:
					</td>
					<td>
						<select name="entity.type" id="entity_type" val="${entity.type}"
							style="width: 120px;">
							<option value="1">
								标准岗位
							</option>
							<option value="2">
								临时岗位
							</option>
						</select>
					</td>
					<td class="title">
						岗位名称:
					</td>
					<td>
						<input type="text" style="width: 120px;"
							class="easyui-validatebox"
							data-options="required:true,validType:[,'maxLength[32]']"
							id="entity_name" name="entity.name" value="${entity.name}">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false">
		<div class="div_button" style="text-align: center; padding: 4px;">
			<c:if test="${pageset.pageType==1}">
				<a id="dom_add_entityPost" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">增加</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
				<a id="dom_edit_entityPost" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">修改</a>
			</c:if>
			<a id="dom_cancle_formPost" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionPost = 'admin/FarmAuthorityPostaddCommit.do';
	var submitEditActionPost = 'admin/FarmAuthorityPosteditCommit.do';
	var currentPageTypePost = '${pageset.pageType}';
	var submitFormPost;
	$(function() {
		//表单组件对象
		submitFormPost = $('#dom_formPost').SubmitForm( {
			pageType : currentPageTypePost,
			grid : gridPost,
			currentWindowId : 'winPostForm'
		});
		//关闭窗口
		$('#dom_cancle_formPost').bind('click', function() {
			$('#winPostForm').window('close');
		});
		//提交新增数据
		$('#dom_add_entityPost').bind('click', function() {
			submitFormPost.postSubmit(submitAddActionPost);
		});
		//提交修改数据
		$('#dom_edit_entityPost').bind('click', function() {
			submitFormPost.postSubmit(submitEditActionPost);
		});
	});
	//-->
</script>