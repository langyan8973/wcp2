<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--任务属性-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
		<form id="dom_formfarmwormattrparse">
			<input type="hidden" name="entity.id" value="${entity.id}">
			<input type="hidden" name="entity.projectid" value="${proid}">
			<table class="editTable">
				<tr>
					<td class="title">
						属性名称:
					</td>
					<td colspan="3">
						<input type="text" style="width: 360px;"
							class="easyui-validatebox"
							data-options="required:true,validType:',maxLength[64]'"
							id="entity_attrname" name="entity.attrname"
							value="${entity.attrname}">

					</td>
				</tr>
				<tr>
					<td class="title">
						属性KEY:
					</td>
					<td colspan="3">
						<input type="text" style="width: 360px;"
							class="easyui-validatebox"
							data-options="required:true,validType:',maxLength[64]'"
							id="entity_attrkey" name="entity.attrkey"
							value="${entity.attrkey}">
					</td>
				</tr>
				<tr>
					<td class="title">
						属性适配Selector标记:
					</td>
					<td colspan="3">
						<input type="text" style="width: 360px;"
							class="easyui-validatebox"
							data-options="required:true,validType:',maxLength[64]'"
							id="entity_attrselect" name="entity.attrselect"
							value="${entity.attrselect}">

					</td>
				</tr>


				<tr>
					<td colspan="4" style="padding: 8px;">
						<div style="height: 100px; overflow: scroll;">
							<div style="width: 100px; float: left;">
								tagname:
							</div>
							通过标签查找元素，比如：a
							<br />
							<div style="width: 100px; float: left;">
								ns|tag:
							</div>
							通过标签在命名空间查找元素，比如：可以用 fb|name 语法来查找 fb:name 元素
							<br />
							<div style="width: 100px; float: left;">
								#id:
							</div>
							通过ID查找元素，比如：#logo
							<br />
							<div style="width: 100px; float: left;">
								.class:
							</div>
							通过class名称查找元素，比如：.masthead
							<br />
							<div style="width: 100px; float: left;">
								[attribute]:
							</div>
							利用属性查找元素，比如：[href]
							<br />
							<div style="width: 100px; float: left;">
								[^attr]:
							</div>
							利用属性名前缀查找元素如：用[^data-] 查找HTML5 Dataset属性元素
							<br />
							<div style="width: 100px; float: left;">
								[attr=value]:
							</div>
							利用属性值来查找元素，比如：[width=500] [attr^=value], [attr$=value],
							<br />
							<div style="width: 100px; float: left;">
								[attr*=value]:
							</div>
							利用匹配属性值开头、结尾或包含属性值来查找元素，比如：[href*=/path/]
							<br />
							<div style="width: 100px; float: left;">
								[attr~=regex]:
							</div>
							利用属性值匹配正则表达式来查找元素，比如： img[src~=(?i)\.(png|jpe?g)]
							<br />
							<div style="width: 100px; float: left;">
								*:
							</div>
							这个符号将匹配所有元素
							<br />
							组合使用 比如： div#logo, div.masthead , a[href] ,a[href].highlight
							,parent > child,div.content > p ...
						</div>
					</td>
				</tr>
				<tr>
					<td class="title">
						适配内容类型:
					</td>
					<td>
						<select name="entity.attrselecttype" id="entity_attrselecttype"
							val="${entity.attrselecttype}">
							<option value="4">
								内部HTML
							</option>
							<option value="1">
								内部文本
							</option>
							<option value="2">
								含适配元素
							</option>
							<option value="3">
								适配元素value
							</option>
						</select>
					</td>
					<td class="title">
						状态:
					</td>
					<td>
						<select name="entity.pstate" id="entity_pstate"
							val="${entity.pstate}">
							<option value="1">
								启用
							</option>
							<option value="0">
								禁用
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="title">
						装饰类型:
					</td>
					<td colspan="3">
						<select name="entity.handletype" id="entity_handletype"
							val="${entity.handletype}">
							<option value="1">
								精简模式（去掉js和各种url标签）
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
				<a id="dom_add_entityfarmwormattrparse" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">增加</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
				<a id="dom_edit_entityfarmwormattrparse" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">修改</a>
			</c:if>
			<a id="dom_cancle_formfarmwormattrparse" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionfarmwormattrparse = 'admin/FarmWormAttrparseaddCommit.do';
	var submitEditActionfarmwormattrparse = 'admin/FarmWormAttrparseeditCommit.do';
	var currentPageTypefarmwormattrparse = '${pageset.pageType}';
	var submitFormfarmwormattrparse;
	$(function() {
		//表单组件对象
		submitFormfarmwormattrparse = $('#dom_formfarmwormattrparse')
				.SubmitForm( {
					pageType : currentPageTypefarmwormattrparse,
					grid : gridfarmwormattrparse,
					currentWindowId : 'winfarmwormattrparse'
				});
		//关闭窗口
		$('#dom_cancle_formfarmwormattrparse').bind('click', function() {
			$('#winfarmwormattrparse').window('close');
		});
		//提交新增数据
		$('#dom_add_entityfarmwormattrparse').bind(
				'click',
				function() {
					submitFormfarmwormattrparse
							.postSubmit(submitAddActionfarmwormattrparse);
				});
		//提交修改数据
		$('#dom_edit_entityfarmwormattrparse').bind(
				'click',
				function() {
					submitFormfarmwormattrparse
							.postSubmit(submitEditActionfarmwormattrparse);
				});
	});
	//-->
</script>