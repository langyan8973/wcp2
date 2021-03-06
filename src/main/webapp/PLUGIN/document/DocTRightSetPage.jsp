<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--文档管理-->
<form id="dom_var_entity">
	<div class="TableTitle">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
		<input type="hidden" name="entity.id" value="${entity.id}">
	</div>
	<table class="editTable">
		<tr>
			<td class="title">
				编辑权限:
			</td>
			<td colspan="3">
				<select name="entity.writepop" id="entity_writepop"
					val="${entity.writepop}">
					<option value="1">
						公开
					</option>
					<option value="0">
						本人
					</option>
					<option value="2">
						小组
					</option>
					<option value="3">
						禁止
					</option>
				</select>
			</td>
			<td class="title">
				阅读权限:
			</td>
			<td colspan="3">
				<select name="entity.readpop" id="entity_readpop"
					val="${entity.readpop}">
					<option value="1">
						公开
					</option>
					<option value="0">
						本人
					</option>
					<option value="2">
						小组
					</option>
					<option value="3">
						禁止
					</option>
				</select>
			</td>
		</tr>
		<tr>
			<th colspan="8" class="title" style="text-align: left;">
				目标文档（下列文档将被修改）:
			</th>
		</tr>
		<tr>
			<td colspan="8">
				<div id="showDocsTextId"></div>
				<input type="hidden" name="ids" id="ids_id">
			</td>
		</tr>
		<tr>
			<th colspan="8">
				<div class="div_button">
					<c:if test="${pageset.pageType==2}">
						<a id="dom_var_edit_entity" href="javascript:void(0)"
							class="easyui-linkbutton">修改</a>
					</c:if>
					<a id="dom_var_cancle_form" href="javascript:void(0)"
						class="easyui-linkbutton" style="color: #000000;">取消</a>
				</div>
			</th>
		</tr>
	</table>
</form>
<script type="text/javascript">
	var submitEditActionDoctype = 'admin/FarmDocRighteditCommit.do';
	var currentPageTypeDoctype = '${pageset.pageType}';
	var submitFormDoctype;
	$(function() {
		//表单组件对象
		submitFormDoctype = $('#dom_var_entity').SubmitForm( {
			pageType : currentPageTypeDoctype,
			grid : gridFarmdoc,
			currentWindowId : 'winsettionFarmdoc'
		});
		//关闭窗口
		$('#dom_var_cancle_form').bind('click', function() {
			$('#winsettionFarmdoc').window('close');
		});
		//提交修改数据
		$('#dom_var_edit_entity').bind('click', function() {
			submitFormDoctype.postSubmit(submitEditActionDoctype);
		});
		var rows = $(gridFarmdoc).datagrid('getSelections');
		var ids;
		$(rows).each(function(index, obj) {
			$('#showDocsTextId').append(obj.TITLE + ",");
			if (ids) {
				ids = ids + "," + obj.ID;
			} else {
				ids = obj.ID;
			}
		});
		$('#ids_id').val(ids);
	});
	//-->
</script>