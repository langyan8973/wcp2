<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<PF:basePath/>">
		<title>文档小组数据管理</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<jsp:include page="/WEB-FACE/conf/includeH.jsp"></jsp:include>
		<link rel="stylesheet" type="text/css"
			href="WEB-FACE/model/kindeditor/themes/default/default.css">
		<script type="text/javascript"
			src="WEB-FACE/model/kindeditor/kindeditor-all-min.js"></script>
		<script type="text/javascript"
			src="WEB-FACE/model/kindeditor/zh_CN.js"></script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north',border:false">
			<form id="searchDocgroupForm">
				<table class="editTable">
					<tr>
						<td class="title">
							小组名称:
						</td>
						<td>
							<input name="GROUPNAME:like" type="text">
						</td>
						<td class="title"></td>
						<td></td>
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
			<table id="dataDocgroupGrid">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="GROUPNAME" data-options="sortable:true" width="80">
							小组名称
						</th>
						<th field="GROUPNOTE" data-options="sortable:true" width="80">
							小组介绍
						</th>
						<th field="GROUPTAG" data-options="sortable:true" width="80">
							小组标签
						</th>
						<th field="JOINCHECK" data-options="sortable:true" width="80">
							加入时验证
						</th>
						<th field="USERNUM" data-options="sortable:true" width="80">
							小组人数
						</th>
						<th field="PSTATE" data-options="sortable:true" width="80">
							状态
						</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
	<script type="text/javascript">
	var url_delActionDocgroup = "admin/FarmDocgroupdeleteCommit.do";//删除URL
	var url_formActionDocgroup = "admin/FarmDocgroupshow.do";//增加、修改、查看URL
	var url_searchActionDocgroup = "admin/FarmDocgroupqueryAll.do";//查询URL
	var title_windowDocgroup = "文档小组管理";//功能名称
	var gridDocgroup;//数据表格对象
	var searchDocgroup;//条件查询组件对象
	var toolBarDocgroup = [ {
		id : 'view',
		text : '查看',
		iconCls : 'icon-tip',
		handler : viewDataDocgroup
	}, {
		id : 'add',
		text : '新增',
		iconCls : 'icon-add',
		handler : addDataDocgroup
	}, {
		id : 'edit',
		text : '修改',
		iconCls : 'icon-edit',
		handler : editDataDocgroup
	}, {
		id : 'groupUser',
		text : '小组成员',
		iconCls : 'icon-group_green_edit',
		handler : editDocgroupUser
	}, {
		id : 'del',
		text : '删除',
		iconCls : 'icon-remove',
		handler : delDataDocgroup
	} ];
	$(function() {
		//初始化数据表格
		gridDocgroup = $('#dataDocgroupGrid').datagrid( {
			url : url_searchActionDocgroup,
			fit : true,
			fitColumns : true,
			'toolbar' : toolBarDocgroup,
			pagination : true,
			closable : true,
			checkOnSelect : true,
			striped : true,
			border : false,
			rownumbers : true,
			ctrlSelect : true
		});
		//初始化条件查询
		searchDocgroup = $('#searchDocgroupForm').searchForm( {
			gridObj : gridDocgroup
		});
	});
	//查看
	function viewDataDocgroup() {
		var selectedArray = $(gridDocgroup).datagrid('getSelections');
		if (selectedArray.length == 1) {
			var url = url_formActionDocgroup + '?pageset.pageType='
					+ PAGETYPE.VIEW + '&ids=' + selectedArray[0].ID;
			$.farm.openWindow( {
				id : 'winDocgroup',
				width : 800,
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
	//维护成员
	function editDocgroupUser() {
		var selectedArray = $(gridDocgroup).datagrid('getSelections');
		if (selectedArray.length == 1) {
			$.farm.openWindow( {
				id : 'chooseDocgroupuserWin',
				width : 800,
				height : 300,
				modal : true,
				url : 'admin/DocgroupuserGridPage.do?ids=' + selectedArray[0].ID,
				title : '小组用户管理'
			});
		} else {
			$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE_ONLY,
					'info');
		}
	}
	//新增
	function addDataDocgroup() {
		var url = url_formActionDocgroup + '?pageset.pageType=' + PAGETYPE.ADD;
		$.farm.openWindow( {
			id : 'winDocgroup',
			width : 800,
			height : 300,
			modal : true,
			url : url,
			title : '新增'
		});
	}
	//修改
	function editDataDocgroup() {
		var selectedArray = $(gridDocgroup).datagrid('getSelections');
		if (selectedArray.length == 1) {
			var url = url_formActionDocgroup + '?pageset.pageType='
					+ PAGETYPE.EDIT + '&ids=' + selectedArray[0].ID;
			$.farm.openWindow( {
				id : 'winDocgroup',
				width : 800,
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
	function delDataDocgroup() {
		var selectedArray = $(gridDocgroup).datagrid('getSelections');
		if (selectedArray.length > 0) {
			// 有数据执行操作
			var str = selectedArray.length + MESSAGE_PLAT.SUCCESS_DEL_NEXT_IS;
			$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
				if (flag) {
					$(gridDocgroup).datagrid('loading');
					$.post(url_delActionDocgroup + '?ids='
							+ $.farm.getCheckedIds(gridDocgroup, 'ID'), {},
							function(flag) {
								$(gridDocgroup).datagrid('loaded');
								if (flag.pageset.commitType == 0) {
									$(gridDocgroup).datagrid('reload');
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