<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<PF:basePath/>">
		<title>门户配置数据管理</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<jsp:include page="/WEB-FACE/conf/includeH.jsp"></jsp:include>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'west',split:true,border:false"
			style="width: 250px;">
			<div class="TREE_COMMON_BOX_SPLIT_DIV">
				<a id="PortaltreeTreeReload" href="javascript:void(0)"
					class="easyui-linkbutton" data-options="plain:true"
					iconCls="icon-reload">刷新菜单</a>
				<a id="PortaltreeTreeOpenAll" href="javascript:void(0)"
					class="easyui-linkbutton" data-options="plain:true"
					iconCls="icon-sitemap">全部展开</a>
			</div>
			<ul id="PortaltreeTree"></ul>
		</div>
		<div class="easyui-layout" data-options="region:'center',border:false">
			<div data-options="region:'north',border:false">
				<form id="searchPortaltreeForm">
					<table class="editTable">
						<tr>
							<td class="title">
								上级节点:
							</td>
							<td>
								<input id="PARENTTITLE_RULE" type="text" readonly="readonly"
									style="background: #F3F3E8">
								<input id="PARENTID_RULE" name="PARENTID:=" type="hidden">
							</td>
							<td class="title">
								名称:
							</td>
							<td>
								<input name="NAME:like" type="text">
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
				<table id="dataPortaltreeGrid">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th field="TYPE" data-options="sortable:true" width="20">
								类型
							</th>
							<th field="NAME" data-options="sortable:true" width="80">
								名称
							</th>
							<th field="SORT" data-options="sortable:true" width="80">
								排序
							</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</body>
	<script type="text/javascript">
	var url_delActionPortaltree = "admin/FarmPortalPortaltreeDeleteCommit.do";//删除URL
	var url_formActionPortaltree = "admin/FarmPortalPortaltreeShow.do";//增加、修改、查看URL
	var url_searchActionPortaltree = "admin/FarmPortalPortaltreeQuery.do";//查询URL
	var title_windowPortaltree = "门户配置管理";//功能名称
	var gridPortaltree;//数据表格对象
	var searchPortaltree;//条件查询组件对象
	var currentType, currentTypeName;
	var toolBarPortaltree = [ {
		id : 'view',
		text : '查看',
		iconCls : 'icon-tip',
		handler : viewDataPortaltree
	}, {
		id : 'add',
		text : '新增',
		iconCls : 'icon-add',
		handler : addDataPortaltree
	}, {
		id : 'edit',
		text : '修改',
		iconCls : 'icon-edit',
		handler : editDataPortaltree
	}, {
		id : 'del',
		text : '删除',
		iconCls : 'icon-remove',
		handler : delDataPortaltree
	} ];
	$(function() {
		//初始化数据表格
		gridPortaltree = $('#dataPortaltreeGrid').datagrid( {
			url : url_searchActionPortaltree,
			fit : true,
			fitColumns : true,
			'toolbar' : toolBarPortaltree,
			pagination : true,
			closable : true,
			checkOnSelect : true,
			striped : true,
			rownumbers : true,
			ctrlSelect : true
		});
		//初始化条件查询
		searchPortaltree = $('#searchPortaltreeForm').searchForm( {
			gridObj : gridPortaltree
		});
		$('#PortaltreeTree').tree( {
			url : 'admin/FarmPortalPortaltreeloadTree.do',
			onSelect : function(node) {
				$('#PARENTID_RULE').val(node.id);
				$('#PARENTTITLE_RULE').val(node.text);
				searchPortaltree.dosearch( {
					'query.ruleText' : searchPortaltree.arrayStr()
				});
			}
		});
		$('#PortaltreeTreeReload').bind('click', function() {
			$('#PortaltreeTree').tree('reload');
		});
		$('#PortaltreeTreeOpenAll').bind('click', function() {
			$('#PortaltreeTree').tree('expandAll');
		});
	});
	//查看
	function viewDataPortaltree() {
		var selectedArray = $(gridPortaltree).datagrid('getSelections');
		if (selectedArray.length == 1) {
			var url = url_formActionPortaltree + '?pageset.pageType='
					+ PAGETYPE.VIEW + '&ids=' + selectedArray[0].ID;
			$.farm.openWindow( {
				id : 'winPortaltree',
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
	function addDataPortaltree() {
		var url = url_formActionPortaltree + '?parent.id='
				+ $('#PARENTID_RULE').val() + '&pageset.pageType='
				+ PAGETYPE.ADD;
		$.farm.openWindow( {
			id : 'winPortaltree',
			width : 600,
			height : 300,
			modal : true,
			url : url,
			title : '新增'
		});
	}
	//修改
	function editDataPortaltree() {
		var selectedArray = $(gridPortaltree).datagrid('getSelections');
		if (selectedArray.length == 1) {
			var url = url_formActionPortaltree + '?pageset.pageType='
					+ PAGETYPE.EDIT + '&ids=' + selectedArray[0].ID;
			$.farm.openWindow( {
				id : 'winPortaltree',
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
	function delDataPortaltree() {
		var selectedArray = $(gridPortaltree).datagrid('getSelections');
		if (selectedArray.length > 0) {
			// 有数据执行操作
			var str = selectedArray.length + MESSAGE_PLAT.SUCCESS_DEL_NEXT_IS;
			$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
				if (flag) {
					$(gridPortaltree).datagrid('loading');
					$.post(url_delActionPortaltree + '?ids='
							+ $.farm.getCheckedIds(gridPortaltree, 'ID'), {},
							function(flag) {
								$(gridPortaltree).datagrid('loaded');
								if (flag.pageset.commitType == 0) {
									$(gridPortaltree).datagrid('reload');
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