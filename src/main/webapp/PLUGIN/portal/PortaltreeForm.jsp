<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--门户配置表单-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
		<form id="dom_formPortaltree">
			<input type="hidden" id="entity_id" name="entity.id"
				value="${entity.id}">
			<table class="editTable">
				<tr>
					<td class="title">
						上级分类:
					</td>
					<td>
						<c:if test="${parent!=null&&parent.id!=null}">
        ${parent.name}
        <input type="hidden" name='entity.parentid' value="${parent.id}" />
						</c:if>
						<c:if test="${parent==null||parent.id==null}">
        无
      </c:if>
					</td>
					<td class="title">
						类型:
					</td>
					<td>
						<c:if test="${parent==null||parent.id==null}">
							<select id="entity_type" name="entity.type" style="width: 120px;">
								<option value="1">
									分类
								</option>
							</select>
						</c:if>
						<c:if test="${parent!=null&&parent.id!=null}">
							<c:if test="${parent.type=='1'}">
								<select id="entity_type" name="entity.type"
									style="width: 120px;">
									<option value="2">
										门户
									</option>
								</select>
							</c:if>
							<c:if test="${parent.type=='2'}">
								<select id="entity_type" name="entity.type"
									style="width: 120px;">
									<option value="3">
										组件
									</option>
								</select>
							</c:if>
							<c:if test="${parent.type=='3'}">
								<select id="entity_type" name="entity.type"
									style="width: 120px;" class="easyui-validatebox"
									data-options="required:true">
									<option value="">
										组件下无法再增加数据
									</option>
								</select>
							</c:if>
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
							data-options="required:true,validType:[,'maxLength[16]']"
							id="entity_name" name="entity.name" value="${entity.name}">
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
				<c:if test="${parent!=null&&parent.id!=null}">
					<c:if test="${parent.type=='1'}">
						<!-- 门户 -->
						<tr>
							<td class="title">
								关键字:
							</td>
							<td>
								<input type="text" style="width: 120px;"
									class="easyui-validatebox"
									data-options="required:true,validType:['maxLength[64]']"
									id="portal_keystr" name="portal.keystr"
									value="${portal.keystr}">
							</td>
							<td class="title">
								列数:
							</td>
							<td>
								<input type="text" style="width: 120px;"
									class="easyui-validatebox"
									data-options="required:true,validType:['integer','maxLength[5]']"
									id="portal_colnum" name="portal.colnum"
									value="${portal.colnum}">
							</td>
						</tr>
						<tr>
							<td class="title">
								列宽度（百分数）:
							</td>
							<td colspan="3">
								<input type="text" style="width: 360px;"
									class="easyui-validatebox"
									data-options="required:true,validType:[,'maxLength[64]']"
									id="portal_colwidth" name="portal.colwidth"
									value="${portal.colwidth}">
							</td>
						</tr>
					</c:if>
					<c:if test="${parent.type=='2'}">
						<!--组件 -->
						<tr>
							<td class="title">
								选择组件:
							</td>
							<td>
								<input type="text" style="width: 120px;"
									class="easyui-validatebox" readonly="readonly"
									data-options="required:true" id="component_title"
									value="${component.title}">
								<input type="hidden" id="componentDef_componentid"
									name="componentDef.componentid"
									value="${componentDef.componentid}">
								<a id="buttonChoosecomponentChoose" href="javascript:void(0)"
									class="easyui-linkbutton" style="color: #000000;">选择</a>
							</td>
							<td class="title">
								默认显示:
							</td>
							<td>
								<select name="componentDef.openable" style="width: 120px;"
									id="componentDef_openable" val="${componentDef.openable}">
									<option value="1">
										显示
									</option>
									<option value="0">
										隐藏
									</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="title">
								是否可关闭:
							</td>
							<td>
								<select name="componentDef.closable" id="componentDef_closable"
									style="width: 120px;" val="${componentDef.closable}">
									<option value="1">
										可关闭
									</option>
									<option value="0">
										不可关闭
									</option>
								</select>
							</td>
							<td class="title">
								是否可折叠:
							</td>
							<td>
								<select name="componentDef.collapsible" style="width: 120px;"
									id="componentDef_collapsible" val="${componentDef.collapsible}">
									<option value="1">
										可折叠
									</option>
									<option value="0">
										不可折叠
									</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="title">
								组件宽%:
							</td>
							<td>
								<input type="text" style="width: 120px;"
									class="easyui-validatebox"
									data-options="validType:[,'maxLength[5]']"
									id="componentDef_width" name="componentDef.width"
									value="${componentDef.width==null?'100':componentDef.width}">
							</td>
							<td class="title">
								组件高px:
							</td>
							<td>
								<input type="text" style="width: 120px;"
									class="easyui-validatebox"
									data-options="required:true,validType:[,'maxLength[5]']"
									id="componentDef_heitgh" name="componentDef.heitgh"
									value="${componentDef.heitgh}">
							</td>
						</tr>
					</c:if>
				</c:if>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false">
		<div class="div_button" style="text-align: center; padding: 4px;">
			<c:if test="${pageset.pageType==1}">
				<a id="dom_add_entityPortaltree" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">增加</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
				<a id="dom_edit_entityPortaltree" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">修改</a>
			</c:if>
			<a id="dom_cancle_formPortaltree" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionPortaltree = 'admin/FarmPortalPortaltreeAddCommit.do';
	var submitEditActionPortaltree = 'admin/FarmPortalPortaltreeEditCommit.do';
	var currentPageTypePortaltree = '${pageset.pageType}';
	var submitFormPortaltree;
	$(function() {
		//表单组件对象
		submitFormPortaltree = $('#dom_formPortaltree').SubmitForm( {
			pageType : currentPageTypePortaltree,
			grid : gridPortaltree,
			currentWindowId : 'winPortaltree'
		});
		//关闭窗口
		$('#dom_cancle_formPortaltree').bind('click', function() {
			$('#winPortaltree').window('close');
		});
		//提交新增数据
		$('#dom_add_entityPortaltree').bind('click', function() {
			submitFormPortaltree.postSubmit(submitAddActionPortaltree);
		});
		//提交修改数据
		$('#dom_edit_entityPortaltree').bind('click', function() {
			submitFormPortaltree.postSubmit(submitEditActionPortaltree);
		});
		//门户列的事件
		$('#portal_colnum')
				.bind(
						'change',
						function() {
							for (i = 0; i < $('#portal_colnum').val(); i++) {
								var persont = parseInt(100 / $('#portal_colnum')
										.val());
								if (i == 0) {
									$('#portal_colwidth').val(
											'' + persont + '%');
								} else {
									$('#portal_colwidth').val(
											$('#portal_colwidth').val() + ','
													+ persont + '%');
								}
							}
						});
		$('#buttonChoosecomponentChoose').bindChooseWindow(
				'chooseChoosecomponentWin', {
					width : 600,
					height : 300,
					modal : true,
					url : 'admin/ChoosecomponentChooseGridPage.do',
					title : '选择组件',
					callback : function(rows) {
						$('#component_title').val(rows[0].TITLE);
						$('#componentDef_componentid').val(rows[0].ID);
						if (!$('#entity_name').val()) {
							$('#entity_name').val(rows[0].TITLE);
						}
					}
				});
	});
	//-->
</script>