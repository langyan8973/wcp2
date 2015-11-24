<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<PF:basePath/>">
		<title>下载内容</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<jsp:include page="/WEB-FACE/conf/includeH.jsp"></jsp:include>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north',border:false">
			<form id="dom_searchfarmwormdocattr">
				<table class="editTable">
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
			<table class="easyui-datagrid" id="dom_datagridfarmwormdocattr">
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
	</body>
	<script type="text/javascript">
		var url_delActionfarmwormdocattr = "admin/FarmWormDocattrdeleteCommit.do";//删除URL
		var url_formActionfarmwormdocattr = "admin/FarmWormDocattrshow.do";//增加、修改、查看URL
		var url_searchActionfarmwormdocattr = "admin/FarmWormDocattrqueryAll.do";//查询URL
		var title_windowfarmwormdocattr = "下载内容";//功能名称
		var gridfarmwormdocattr;//数据表格对象
		var searchfarmwormdocattr;//条件查询组件对象
		var TOOL_BARfarmwormdocattr = [ {
			id : 'view',
			text : '查看',
			iconCls : 'icon-tip',
			handler : viewDatafarmwormdocattr
		}, {
			id : 'add',
			text : '新增',
			iconCls : 'icon-add',
			handler : addDatafarmwormdocattr
		}, {
			id : 'edit',
			text : '修改',
			iconCls : 'icon-edit',
			handler : editDatafarmwormdocattr
		}, {
			id : 'del',
			text : '删除',
			iconCls : 'icon-remove',
			handler : delDatafarmwormdocattr
		} ];
		$(function() {
			//初始化数据表格
			gridfarmwormdocattr = $('#dom_datagridfarmwormdocattr').datagrid( {
				url : url_searchActionfarmwormdocattr,
				fit : true,
				fitColumns : true,
				'toolbar' : TOOL_BARfarmwormdocattr,
				pagination : true,
				closable : true,
				checkOnSelect : true,
				striped : true,
				rownumbers : true,
				ctrlSelect : true,
				fitColumns : true
			});
			//初始化条件查询
			searchfarmwormdocattr = $('#dom_searchfarmwormdocattr').searchForm( {
				gridObj : gridfarmwormdocattr
			});
		});
		//查看
		function viewDatafarmwormdocattr() {
			var selectedArray = $(gridfarmwormdocattr).datagrid('getSelections');
			if (selectedArray.length > 0) {
				var url = url_formActionfarmwormdocattr + '?pageset.pageType='+PAGETYPE.VIEW+'&ids='
						+ selectedArray[0].ID;
				$.farm.openWindow( {
					id : 'winfarmwormdocattr',
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
		function addDatafarmwormdocattr() {
			var url = url_formActionfarmwormdocattr + '?pageset.pageType='+PAGETYPE.ADD;
			$.farm.openWindow( {
				id : 'winfarmwormdocattr',
				width : 600,
				height : 300,
				modal : true,
				url : url,
				title : '新增'
			});
		}
		//修改
		function editDatafarmwormdocattr() {
			var selectedArray = $(gridfarmwormdocattr).datagrid('getSelections');
			if (selectedArray.length > 0) {
				var url = url_formActionfarmwormdocattr + '?pageset.pageType='+PAGETYPE.EDIT+ '&ids=' + selectedArray[0].ID;;
				$.farm.openWindow( {
					id : 'winfarmwormdocattr',
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
		function delDatafarmwormdocattr() {
			var selectedArray = $(gridfarmwormdocattr).datagrid('getSelections');
			if (selectedArray.length > 0) {
				// 有数据执行操作
				var str = selectedArray.length + MESSAGE_PLAT.SUCCESS_DEL_NEXT_IS;
				$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
					if (flag) {
						$.post(url_delActionfarmwormdocattr + '?ids=' + $.farm.getCheckedIds(gridfarmwormdocattr), {},
								function(flag) {
									if (flag.pageset.commitType == 0) {
										$(gridfarmwormdocattr).datagrid('reload');
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
</html>
		
			
										
										
