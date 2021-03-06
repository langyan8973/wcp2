<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<PF:basePath/>">
		<title>系统参数用户界面</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<jsp:include page="/WEB-FACE/conf/includeH.jsp"></jsp:include>
	</head>
	<body>
		<div class="demo-info">
			<div class="demo-tip icon-tip"></div>
			<div>
				系统运行参数配置，修改后请保存。
			</div>
		</div>
		<div style="padding: 4px;">
			<div style="border-bottom: 1px solid #ddd;">
				<a id="a_tree_save" href="javascript:void(0)"
					class="easyui-linkbutton" data-options="plain:true"
					iconCls="icon-save">保存</a>
			</div>
			<div style="margin: 8px;">
				<table id="propertyTable_ID" class="easyui-propertygrid"
					style="width: 600px"
					data-options="url: 'admin/AloneParameterqueryForEasyUi.do',showGroup: true,scrollbarSize: 0,columns: mycolumns">
				</table>
			</div>
			<div class="demo-info">
				<div class="demo-tip icon-tip"></div>
				<div>
					properties文件参数，只读模式。配置文件在：(部署路径\WEB-INF\classes\)目录下
					<br />
					双击值表格，可以再弹出框中查看值
				</div>
			</div>
			<div style="margin: 8px;">
				<table class="easyui-datagrid" style="width: 600px"
					data-options="fitColumns:true,singleSelect:true,onDblClickCell:showValue">
					<thead>
						<tr>
							<th data-options="field:'code'" width="50">
								key
							</th>
							<th data-options="field:'name'" width="50">
								值
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="node" items="${filePropertys}">
							<tr>
								<td>
									${node.key}
								</td>
								<td>
									${node.value}
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="demo-info">
				<div class="demo-tip icon-tip"></div>
				<div>
					常量参数，只读模式。(com.farm.parameter.FarmParameterService中定义)
					<br />
					双击值表格，可以再弹出框中查看值
				</div>
			</div>
			<div style="margin: 8px;">
				<table class="easyui-datagrid" style="width: 600px"
					data-options="fitColumns:true,singleSelect:true,onDblClickCell:showValue">
					<thead>
						<tr>
							<th data-options="field:'code'" width="50">
								key
							</th>
							<th data-options="field:'name'" width="50">
								值
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="node" items="${constantPropertys}">
							<tr>
								<td>
									${node.key}
								</td>
								<td>
									${node.value}
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div style="">
			<div id="win" title="查看值" style="text-align: center;"
				data-options="iconCls:'icon-save',modal:false,minimizable:false,maximizable:false,resizable:false">
				<textarea id="winTextBox"
					style="width: 90%; height: 90%; border: 0px;margin: auto;"></textarea>
			</div>
		</div>
	</body>
	<script>
	var mycolumns = [ [ {
		field : 'name',
		title : '系统选项',
		width : 100,
		sortable : true
	}, {
		field : 'value',
		title : '值',
		width : 100,
		resizable : false
	} ] ];
	$('#a_tree_save').bind(
			'click',
			function() {
				var paraArray = $('#propertyTable_ID').propertygrid('getRows');
				var paraSubmitVar;
				$(paraArray).each(
						function(index, obj) {
							if (index == 0) {
								paraSubmitVar = paraArray[index].id + '&2581&'
										+ paraArray[index].value;
							} else {
								paraSubmitVar = paraSubmitVar + '&2582&'
										+ paraArray[index].id + '&2581&'
										+ paraArray[index].value;
							}
						});
				$('#a_tree_save').linkbutton('disable');
				$.post(
						'admin/AloneParam_editSubmitByPValue.do',
						{
							ids : paraSubmitVar
						},
						function(flag) {
							if (flag.pageset.commitType == '0') {
								$.messager.alert(MESSAGE_PLAT.PROMPT,
										MESSAGE_PLAT.SUCCESS, 'info');
							} else {
								var str = MESSAGE_PLAT.ERROR_SUBMIT
										+ flag.pageset.message;
								$.messager.alert(MESSAGE_PLAT.ERROR, str,
										'error');
							}
							$('#a_tree_save').linkbutton('enable');
						}).error(
						function() {
							$.messager.alert(MESSAGE_PLAT.ERROR,
									MESSAGE_PLAT.ERROR_SUBMIT_NO_MESSAGE,
									'error');
							$('#a_tree_save').linkbutton('enable');
						});
			});
	function showValue(rowIndex, field, value) {
		$('#win').window( {
			width : 400,
			height : 200,
			top : $(this).offset().top
		});
		$('#winTextBox').val(value);
	}
</script>
</html>




