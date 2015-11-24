<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--用户表单-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
		<form id="dom_formUser">
			<input type="hidden" id="entity_id" name="entity.id"
				value="${entity.id}">
			<table class="editTable">
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
						登陆名:
					</td>
					<td>
						<input type="text" style="width: 120px;"
							class="easyui-validatebox"
							data-options="required:true,validType:[,'maxLength[32]']"
							id="entity_loginname" name="entity.loginname"
							value="${entity.loginname}">
					</td>
				</tr>
				<tr>
					<td class="title">
						类型:
					</td>
					<td>
						<select name="entity.type" id="entity_type" val="${entity.type}"
							style="width: 120px;">
							<option value="1">
								系统用户
							</option>
							<option value="2">
								其他
							</option>
							<option value="3">
								超级用户
							</option>
						</select>
					</td>
					<td class="title">
						状态:
					</td>
					<td>
						<select name="entity.state" id="entity_state"
							val="${entity.state}" style="width: 120px;">
							<option value="1">
								可用
							</option>
							<option value="0">
								禁用
							</option>
						</select>
					</td>
				</tr>
				<c:if test="${pageset.pageType==0}">
					<tr>
						<td class="title">
							用户机构:
						</td>
						<td colspan="3">
							${organization.name}
						</td>
					</tr>
					<tr>
						<td class="title">
							用户岗位:
						</td>
						<td colspan="3">
							<c:forEach items="${posts}" var="node">
								<c:if test="${node.type=='2'}">	[${node.name}]</c:if>
								<c:if test="${node.type=='1'}">
									<span style="font-weight: bold;">[${node.name}]</span>
								</c:if>&nbsp;
							</c:forEach>
						</td>
					</tr>
				</c:if>
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
				<a id="dom_add_entityUser" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">增加</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
				<a id="dom_edit_entityUser" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">修改</a>
			</c:if>
			<a id="dom_cancle_formUser" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionUser = 'admin/FarmAuthorityUseraddCommit.do';
	var submitEditActionUser = 'admin/FarmAuthorityUsereditCommit.do';
	var currentPageTypeUser = '${pageset.pageType}';
	var submitFormUser;
	$(function() {
		//表单组件对象
		submitFormUser = $('#dom_formUser').SubmitForm( {
			pageType : currentPageTypeUser,
			grid : gridUser,
			currentWindowId : 'winUser'
		});
		//关闭窗口
		$('#dom_cancle_formUser').bind('click', function() {
			$('#winUser').window('close');
		});
		//提交新增数据
		$('#dom_add_entityUser').bind('click', function() {
			submitFormUser.postSubmit(submitAddActionUser);
		});
		//提交修改数据
		$('#dom_edit_entityUser').bind('click', function() {
			submitFormUser.postSubmit(submitEditActionUser);
		});
	});
	//-->
</script>