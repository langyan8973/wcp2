<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--任务属性选择-->
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false">
		<form id="dom_searchfarmwormtask">
			<table class="editTable">
				<tr>
					<td class="title">
						类型:
					</td>
					<td>
						<select name="TYPE:=">
							<option value="">
								全部
							</option>
							<option value="1">
								种子
							</option>
							<option value="2">
								文档
							</option>
						</select>
					</td>
					<td class="title">
						状态:
					</td>
					<td>
						<select name="PSTATE:=">
							<option value="">
								全部
							</option>
							<option value="1">
								未开始
							</option>
							<option value="2">
								正在
							</option>
							<option value="3">
								完成
							</option>
							<option value="4">
								异常
							</option>
						</select>
					</td>
					<td>
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
		<table class="easyui-datagrid" id="dom_datagridfarmwormtask">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="TITLE" data-options="sortable:true" width="200">
						标题
					</th>
					<th field="URL" data-options="sortable:true" width="200">
						URL
					</th>
					<th field="TYPE" data-options="sortable:true" width="80">
						类型
					</th>
					<th field="PSTATE" data-options="sortable:true" width="80">
						状态
					</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
	var url_delActionfarmwormtask = "admin/FarmWormTaskdeleteCommit.do";//删除URL
	var url_formActionfarmwormtask = "admin/FarmWormTaskshow.do";//增加、修改、查看URL
	var url_searchActionfarmwormtask = "admin/FarmWormTaskqueryAll.do?proid=${proid}";//查询URL
	var title_windowfarmwormtask = "任务";//功能名称
	var gridfarmwormtask;//数据表格对象
	var searchfarmwormtask;//条件查询组件对象
	var TOOL_BARfarmwormtask = [ {
		id : 'view',
		text : '查看内容',
		iconCls : 'icon-tip',
		handler : viewDatafarmwormtask
	}, {
		id : 'edit',
		text : '修改',
		iconCls : 'icon-edit',
		handler : editDatafarmwormtask
	}, {
		id : 'del',
		text : '删除',
		iconCls : 'icon-remove',
		handler : delDatafarmwormtask
	}, {
		id : 'clear',
		text : '清空',
		iconCls : 'icon-mini-refresh',
		handler : clearDatafarmwormtask
	}, {
		id : 'initError',
		text : '初始化异常任务',
		iconCls : 'icon-mini-refresh',
		handler : initErrorDatafarmwormtask
	} ];
	$(function() {
		//初始化数据表格
		gridfarmwormtask = $('#dom_datagridfarmwormtask').datagrid( {
			url : url_searchActionfarmwormtask,
			fit : true,
			fitColumns : true,
			'toolbar' : TOOL_BARfarmwormtask,
			pagination : true,
			closable : true,
			checkOnSelect : true,
			striped : true,
			rownumbers : true,
			ctrlSelect : true,
			fitColumns : true
		});
		//初始化条件查询
		searchfarmwormtask = $('#dom_searchfarmwormtask').searchForm( {
			gridObj : gridfarmwormtask
		});
	});
	//查看
	function viewDatafarmwormtask() {
		var selectedArray = $(gridfarmwormtask).datagrid('getSelections');
		if (selectedArray.length > 0) {
			var url = "index/FarmWormTaskContent.do" + '?pageset.pageType='
					+ PAGETYPE.VIEW + '&ids=' + selectedArray[0].ID;
			$.farm.openWindow( {
				id : 'winfarmwormtask',
				width : 800,
				height : 500,
				modal : true,
				url : url,
				title : '浏览'
			});
		} else {
			$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE,
					'info');
		}
	}
	//新增
	function addDatafarmwormtask() {
		var url = url_formActionfarmwormtask + '?pageset.pageType='
				+ PAGETYPE.ADD;
		$.farm.openWindow( {
			id : 'winfarmwormtask',
			width : 600,
			height : 300,
			modal : true,
			url : url,
			title : '新增'
		});
	}
	//修改
	function editDatafarmwormtask() {
		var selectedArray = $(gridfarmwormtask).datagrid('getSelections');
		if (selectedArray.length > 0) {
			var url = url_formActionfarmwormtask + '?pageset.pageType='
					+ PAGETYPE.EDIT + '&ids=' + selectedArray[0].ID;
			;
			$.farm.openWindow( {
				id : 'winfarmwormtask',
				width : 600,
				height : 300,
				modal : true,
				url : url,
				title : '修改'
			});
		} else {
			$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE,
					'info');
		}
	}

	//清空
	function clearDatafarmwormtask() {
		// 有数据执行操作
		var str = "是否清空所有任务";
		$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
			if (flag) {
				$.post("index/FarmWormTaskClearCommit.do?proid=${proid}", {},
						function(flag) {
							if (flag.pageset.commitType == 0) {
								$(gridfarmwormtask).datagrid('reload');
							} else {
								var str = MESSAGE_PLAT.ERROR_SUBMIT
										+ flag.pageset.message;
								$.messager.alert(MESSAGE_PLAT.ERROR, str,
										'error');
							}
						});
			}
		});
	}
	//初始化异常任务
	function initErrorDatafarmwormtask() {
		// 有数据执行操作
		var str = "是否初始化所有异常任务";
		$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
			if (flag) {
				$.post("index/FarmWormTaskInitError.do?proid=${proid}", {},
						function(flag) {
							if (flag.pageset.commitType == 0) {
								$(gridfarmwormtask).datagrid('reload');
							} else {
								var str = MESSAGE_PLAT.ERROR_SUBMIT
										+ flag.pageset.message;
								$.messager.alert(MESSAGE_PLAT.ERROR, str,
										'error');
							}
						});
			}
		});
	}
	//删除
	function delDatafarmwormtask() {
		var selectedArray = $(gridfarmwormtask).datagrid('getSelections');
		if (selectedArray.length > 0) {
			// 有数据执行操作
			var str = selectedArray.length + MESSAGE_PLAT.SUCCESS_DEL_NEXT_IS;
			$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
				if (flag) {
					$.post(url_delActionfarmwormtask + '?ids='
							+ $.farm.getCheckedIds(gridfarmwormtask), {},
							function(flag) {
								if (flag.pageset.commitType == 0) {
									$(gridfarmwormtask).datagrid('reload');
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