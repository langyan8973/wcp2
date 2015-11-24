<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--任务属性选择-->
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'center',border:false">
		<table class="easyui-datagrid" id="dom_datagridfarmwormattrparse">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="ATTRNAME" data-options="sortable:true" width="80">
						属性名称
					</th>
					<th field="ATTRKEY" data-options="sortable:true" width="80">
						属性KEY
					</th>
					<th field="ATTRSELECT" data-options="sortable:true" width="80">
						属性适配Selector标记
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
		var url_delActionfarmwormattrparse = "admin/FarmWormAttrparsedeleteCommit.do";//删除URL
		var url_formActionfarmwormattrparse = "admin/FarmWormAttrparseshow.do";//增加、修改、查看URL
		var url_searchActionfarmwormattrparse = "admin/FarmWormAttrparsequeryAll.do?proid=${proid}";//查询URL
		var title_windowfarmwormattrparse = "任务属性";//功能名称
		var gridfarmwormattrparse;//数据表格对象
		var searchfarmwormattrparse;//条件查询组件对象
		var TOOL_BARfarmwormattrparse = [ {
			id : 'view',
			text : '查看',
			iconCls : 'icon-tip',
			handler : viewDatafarmwormattrparse
		}, {
			id : 'add',
			text : '新增',
			iconCls : 'icon-add',
			handler : addDatafarmwormattrparse
		}, {
			id : 'edit',
			text : '修改',
			iconCls : 'icon-edit',
			handler : editDatafarmwormattrparse
		}, {
			id : 'del',
			text : '删除',
			iconCls : 'icon-remove',
			handler : delDatafarmwormattrparse
		} ];
		$(function() {
			//初始化数据表格
			gridfarmwormattrparse = $('#dom_datagridfarmwormattrparse').datagrid( {
				url : url_searchActionfarmwormattrparse,
				fit : true,
				fitColumns : true,
				'toolbar' : TOOL_BARfarmwormattrparse,
				pagination : true,
				closable : true,
				checkOnSelect : true,
				striped : true,
				rownumbers : true,
				ctrlSelect : true,
				fitColumns : true
			});
		});
		//查看
		function viewDatafarmwormattrparse() {
			var selectedArray = $(gridfarmwormattrparse).datagrid('getSelections');
			if (selectedArray.length > 0) {
				var url = url_formActionfarmwormattrparse + '?pageset.pageType='+PAGETYPE.VIEW+'&ids='
						+ selectedArray[0].ID;
				$.farm.openWindow( {
					id : 'winfarmwormattrparse',
					width : 600,
					height : 400,
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
		function addDatafarmwormattrparse() {
			var url = url_formActionfarmwormattrparse + '?proid=${proid}&pageset.pageType='+PAGETYPE.ADD;
			$.farm.openWindow( {
				id : 'winfarmwormattrparse',
				width : 600,
				height : 400,
				modal : true,
				url : url,
				title : '新增'
			});
		}
		//修改
		function editDatafarmwormattrparse() {
			var selectedArray = $(gridfarmwormattrparse).datagrid('getSelections');
			if (selectedArray.length > 0) {
				var url = url_formActionfarmwormattrparse + '?pageset.pageType='+PAGETYPE.EDIT+ '&ids=' + selectedArray[0].ID;;
				$.farm.openWindow( {
					id : 'winfarmwormattrparse',
					width : 600,
					height : 400,
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
		function delDatafarmwormattrparse() {
			var selectedArray = $(gridfarmwormattrparse).datagrid('getSelections');
			if (selectedArray.length > 0) {
				// 有数据执行操作
				var str = selectedArray.length + MESSAGE_PLAT.SUCCESS_DEL_NEXT_IS;
				$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
					if (flag) {
						$.post(url_delActionfarmwormattrparse + '?ids=' + $.farm.getCheckedIds(gridfarmwormattrparse), {},
								function(flag) {
									if (flag.pageset.commitType == 0) {
										$(gridfarmwormattrparse).datagrid('reload');
							} else {
								var str = MESSAGE_PLAT.ERROR_SUBMIT
										+ flag.pageset.message;
								$.messager.alert(MESSAGE_PLAT.ERROR, str, 'error');
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