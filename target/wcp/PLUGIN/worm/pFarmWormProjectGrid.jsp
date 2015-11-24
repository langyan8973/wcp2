<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--下载项目选择-->
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false">
		<form id="dom_chooseSearchfarmwormproject">
			<table class="editTable">
				<tr>
					<td class="title">
						<a id="a_search" href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-search">查询</a>
					</td>
					<td>
						<a id="a_reset" href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-reload">清除条件</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table class="easyui-datagrid" id="dom_choosegridfarmwormproject">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="PSTATE" data-options="sortable:true" width="80"> 状态 </th>
					<th field="PCONTENT" data-options="sortable:true" width="80"> 备注 </th>
					<th field="NAME" data-options="sortable:true" width="80"> 名称 </th>
					<th field="SEEDURL" data-options="sortable:true" width="80"> 种子页面 </th>
					<th field="URLFILTER" data-options="sortable:true" width="80"> url前缀 </th>
					<th field="AGENT" data-options="sortable:true" width="80"> agent </th>
					<th field="TIMEOUT" data-options="sortable:true" width="80"> timeout </th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
	var choosegridfarmwormproject;
	var chooseSearchfarmwormproject;
	var toolbar_choosefarmwormproject = [ {
		text : '选择',
		iconCls : 'icon-ok',
		handler : function() {
			var selectedArray = $('#dom_choosegridfarmwormproject').datagrid(
					'getSelections');
			if (selectedArray.length > 0) {
				chooseWindowCallBackHandle(selectedArray);
			} else {
				$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE,
						'info');
			}
		}
	} ];
	$(function() {
		choosegridfarmwormproject = $('#dom_choosegridfarmwormproject').datagrid( {
			url : 'admin/FarmWormProjectqueryAll.do',
			fit : true,
			fitColumns : true,
			'toolbar' : toolbar_choosefarmwormproject,
			pagination : true,
			closable : true,
			checkOnSelect : true,
			striped : true,
			rownumbers : true,
			ctrlSelect : true,
			fitColumns : true
		});
		chooseSearchfarmwormproject = $('#dom_chooseSearchfarmwormproject').searchForm( {
			gridObj : choosegridfarmwormproject
		});
	});
	//-->
</script>
<!-- 
<a id="form_farmwormproject_a_Choose" href="javascript:void(0)" class="easyui-linkbutton" style="color: #000000;">选择</a>
<script type="text/javascript">
	$(function() {
		$('#form_farmwormproject_a_Choose').bindChooseWindow('chooseWinfarmwormproject', {
			width : 600,
			height : 300,
			modal : true,
			url : 'admin/FarmWormProject_ACTION_ALERT.do',
			title : '选择',
			callback : function(rows) {
				//$('#NAME_like').val(rows[0].NAME);
			}
		});
	});
</script>
 -->








