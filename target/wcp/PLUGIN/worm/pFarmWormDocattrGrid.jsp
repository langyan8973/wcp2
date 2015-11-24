<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--下载内容选择-->
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false">
		<form id="dom_chooseSearchfarmwormdocattr">
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
		<table class="easyui-datagrid" id="dom_choosegridfarmwormdocattr">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="PCONTENT" data-options="sortable:true" width="80"> 内容 </th>
					<th field="ATTRPARSEID" data-options="sortable:true" width="80"> 属性ID </th>
					<th field="TASKID" data-options="sortable:true" width="80"> 任务ID </th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
	var choosegridfarmwormdocattr;
	var chooseSearchfarmwormdocattr;
	var toolbar_choosefarmwormdocattr = [ {
		text : '选择',
		iconCls : 'icon-ok',
		handler : function() {
			var selectedArray = $('#dom_choosegridfarmwormdocattr').datagrid(
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
		choosegridfarmwormdocattr = $('#dom_choosegridfarmwormdocattr').datagrid( {
			url : 'admin/FarmWormDocattrqueryAll.do',
			fit : true,
			fitColumns : true,
			'toolbar' : toolbar_choosefarmwormdocattr,
			pagination : true,
			closable : true,
			checkOnSelect : true,
			striped : true,
			rownumbers : true,
			ctrlSelect : true,
			fitColumns : true
		});
		chooseSearchfarmwormdocattr = $('#dom_chooseSearchfarmwormdocattr').searchForm( {
			gridObj : choosegridfarmwormdocattr
		});
	});
	//-->
</script>
<!-- 
<a id="form_farmwormdocattr_a_Choose" href="javascript:void(0)" class="easyui-linkbutton" style="color: #000000;">选择</a>
<script type="text/javascript">
	$(function() {
		$('#form_farmwormdocattr_a_Choose').bindChooseWindow('chooseWinfarmwormdocattr', {
			width : 600,
			height : 300,
			modal : true,
			url : 'admin/FarmWormDocattr_ACTION_ALERT.do',
			title : '选择',
			callback : function(rows) {
				//$('#NAME_like').val(rows[0].NAME);
			}
		});
	});
</script>
 -->








