<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--任务属性选择-->
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'center',border:false">
		<table class="easyui-datagrid" id="dom_datagridfarmwormurlfilter">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="PCONTENT" data-options="sortable:true" width="80">
						备注
					</th>
					<th field="PATENSTR" data-options="sortable:true" width="80">
						正则表达式
					</th>
					<th field="PTYPE" data-options="sortable:true" width="80">
						类型
					</th>
					<th field="FUNTYPE" data-options="sortable:true" width="80">
						作用对象
					</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
	var url_delActionfarmwormurlfilter = "admin/FarmWormUrlfilterdeleteCommit.do";//删除URL
	var url_formActionfarmwormurlfilter = "admin/FarmWormUrlfiltershow.do";//增加、修改、查看URL
	var url_searchActionfarmwormurlfilter = "admin/FarmWormUrlfilterqueryAll.do?proid=${proid}";//查询URL
	var title_windowfarmwormurlfilter = "URL过滤器";//功能名称
	var gridfarmwormurlfilter;//数据表格对象
	var searchfarmwormurlfilter;//条件查询组件对象
	var TOOL_BARfarmwormurlfilter = [ {
		id : 'view',
		text : '查看',
		iconCls : 'icon-tip',
		handler : viewDatafarmwormurlfilter
	}, {
		id : 'add',
		text : '新增',
		iconCls : 'icon-add',
		handler : addDatafarmwormurlfilter
	}, {
		id : 'edit',
		text : '修改',
		iconCls : 'icon-edit',
		handler : editDatafarmwormurlfilter
	}, {
		id : 'del',
		text : '删除',
		iconCls : 'icon-remove',
		handler : delDatafarmwormurlfilter
	} ];
	$(function() {
		//初始化数据表格
		gridfarmwormurlfilter = $('#dom_datagridfarmwormurlfilter').datagrid( {
			url : url_searchActionfarmwormurlfilter,
			fit : true,
			fitColumns : true,
			'toolbar' : TOOL_BARfarmwormurlfilter,
			pagination : true,
			closable : true,
			checkOnSelect : true,
			striped : true,
			rownumbers : true,
			ctrlSelect : true,
			fitColumns : true
		});
		//初始化条件查询
		searchfarmwormurlfilter = $('#dom_searchfarmwormurlfilter').searchForm(
				{
					gridObj : gridfarmwormurlfilter
				});
	});
	//查看
	function viewDatafarmwormurlfilter() {
		var selectedArray = $(gridfarmwormurlfilter).datagrid('getSelections');
		if (selectedArray.length > 0) {
			var url = url_formActionfarmwormurlfilter + '?pageset.pageType='
					+ PAGETYPE.VIEW + '&ids=' + selectedArray[0].ID;
			$.farm.openWindow( {
				id : 'winfarmwormurlfilter',
				width : 600,
				height : 300,
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
	function addDatafarmwormurlfilter() {
		var url = url_formActionfarmwormurlfilter
				+ '?proid=${proid}&pageset.pageType=' + PAGETYPE.ADD;
		$.farm.openWindow( {
			id : 'winfarmwormurlfilter',
			width : 600,
			height : 300,
			modal : true,
			url : url,
			title : '新增'
		});
	}
	//修改
	function editDatafarmwormurlfilter() {
		var selectedArray = $(gridfarmwormurlfilter).datagrid('getSelections');
		if (selectedArray.length > 0) {
			var url = url_formActionfarmwormurlfilter + '?pageset.pageType='
					+ PAGETYPE.EDIT + '&ids=' + selectedArray[0].ID;
			;
			$.farm.openWindow( {
				id : 'winfarmwormurlfilter',
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
	//删除
	function delDatafarmwormurlfilter() {
		var selectedArray = $(gridfarmwormurlfilter).datagrid('getSelections');
		if (selectedArray.length > 0) {
			// 有数据执行操作
			var str = selectedArray.length + MESSAGE_PLAT.SUCCESS_DEL_NEXT_IS;
			$.messager
					.confirm(
							MESSAGE_PLAT.PROMPT,
							str,
							function(flag) {
								if (flag) {
									$
											.post(
													url_delActionfarmwormurlfilter
															+ '?ids='
															+ $.farm
																	.getCheckedIds(gridfarmwormurlfilter),
													{},
													function(flag) {
														if (flag.pageset.commitType == 0) {
															$(
																	gridfarmwormurlfilter)
																	.datagrid(
																			'reload');
														} else {
															var str = MESSAGE_PLAT.ERROR_SUBMIT
																	+ flag.pageset.message;
															$.messager
																	.alert(
																			MESSAGE_PLAT.ERROR,
																			str,
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