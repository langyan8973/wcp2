<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<PF:basePath/>">
		<title>组件库数据管理</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<jsp:include page="/WEB-FACE/conf/includeH.jsp"></jsp:include>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north',border:false">
			<form id="searchComponentForm">
				<table class="editTable">
					<tr>
						<td class="title">
							标题:
						</td>
						<td>
							<input name="TITLE:like" type="text">
						</td>
						<td class="title">
							备注:
						</td>
						<td>
							<input name="PCONTENT:like" type="text">
						</td>
					</tr>
					<tr style="text-align: center;">
						<td colspan="4">
							<a id="a_search" href="javascript:void(0)"
								class="easyui-linkbutton" iconCls="icon-search">查询</a>
							<a id="a_reset" href="javascript:void(0)"
								class="easyui-linkbutton" iconCls="icon-reload">清除条件</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataComponentGrid">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="TITLE"
							data-options="sortable:true,formatter:ImgClassformatter"
							width="40">
							标题
						</th>
						<th field="URL" data-options="sortable:true" width="70">
							URL
						</th>
						<th field="PCONTENT" data-options="sortable:true" width="70">
							备注
						</th>
						<th field="PSTATE" data-options="sortable:true" width="20">
							状态
						</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
	<script type="text/javascript">
	var url_delActionComponent = "admin/FarmPortalComponentdeleteCommit.do";//删除URL
	var url_formActionComponent = "admin/FarmPortalComponentShow.do";//增加、修改、查看URL
	var url_searchActionComponent = "admin/FarmPortalComponentQuery.do";//查询URL
	var title_windowComponent = "组件库管理";//功能名称
	var gridComponent;//数据表格对象
	var searchComponent;//条件查询组件对象
	var toolBarComponent = [ {
		id : 'view',
		text : '查看',
		iconCls : 'icon-tip',
		handler : viewDataComponent
	}, {
		id : 'add',
		text : '新增',
		iconCls : 'icon-add',
		handler : addDataComponent
	}, {
		id : 'edit',
		text : '修改',
		iconCls : 'icon-edit',
		handler : editDataComponent
	}, {
		id : 'del',
		text : '删除',
		iconCls : 'icon-remove',
		handler : delDataComponent
	} ];
	$(function() {
		//初始化数据表格
		gridComponent = $('#dataComponentGrid').datagrid( {
			url : url_searchActionComponent,
			fit : true,
			fitColumns : true,
			'toolbar' : toolBarComponent,
			pagination : true,
			closable : true,
			checkOnSelect : true,
			striped : true,
			rownumbers : true,
			ctrlSelect : true
		});
		//初始化条件查询
		searchComponent = $('#searchComponentForm').searchForm( {
			gridObj : gridComponent
		});
	});
	//格式化结果
	function ImgClassformatter(value, row, index) {
		return "<span class='" + row.ICONCLASS
				+ "'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>" + value;
	}
	//查看
	function viewDataComponent() {
		var selectedArray = $(gridComponent).datagrid('getSelections');
		if (selectedArray.length == 1) {
			var url = url_formActionComponent + '?pageset.pageType='
					+ PAGETYPE.VIEW + '&ids=' + selectedArray[0].ID;
			$.farm.openWindow( {
				id : 'winComponent',
				width : 600,
				height : 300,
				modal : true,
				url : url,
				title : '浏览'
			});
		} else {
			$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE_ONLY,
					'info');
		}
	}
	//新增
	function addDataComponent() {
		var url = url_formActionComponent + '?pageset.pageType=' + PAGETYPE.ADD;
		$.farm.openWindow( {
			id : 'winComponent',
			width : 600,
			height : 300,
			modal : true,
			url : url,
			title : '新增'
		});
	}
	//修改
	function editDataComponent() {
		var selectedArray = $(gridComponent).datagrid('getSelections');
		if (selectedArray.length == 1) {
			var url = url_formActionComponent + '?pageset.pageType='
					+ PAGETYPE.EDIT + '&ids=' + selectedArray[0].ID;
			$.farm.openWindow( {
				id : 'winComponent',
				width : 600,
				height : 300,
				modal : true,
				url : url,
				title : '修改'
			});
		} else {
			$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE_ONLY,
					'info');
		}
	}
	//删除
	function delDataComponent() {
		var selectedArray = $(gridComponent).datagrid('getSelections');
		if (selectedArray.length > 0) {
			// 有数据执行操作
			var str = selectedArray.length + MESSAGE_PLAT.SUCCESS_DEL_NEXT_IS;
			$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
				if (flag) {
					$(gridComponent).datagrid('loading');
					$.post(url_delActionComponent + '?ids='
							+ $.farm.getCheckedIds(gridComponent, 'ID'), {},
							function(flag) {
								$(gridComponent).datagrid('loaded');
								if (flag.pageset.commitType == 0) {
									$(gridComponent).datagrid('reload');
								} else {
									var str = MESSAGE_PLAT.ERROR_SUBMIT
											+ flag.pageset.message;
									$.messager.alert(MESSAGE_PLAT.ERROR, str,
											'error');
								}
							});
				}
			});
		} else {
			$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE,
					'info');
		}
	}
</script>
</html>