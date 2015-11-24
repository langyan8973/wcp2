<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<PF:basePath/>">
		<title>下载项目</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<jsp:include page="/WEB-FACE/conf/includeH.jsp"></jsp:include>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'center',border:false">
			<table class="easyui-datagrid" id="dom_datagridfarmwormproject">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="NAME" data-options="sortable:true" width="80">
							名称
						</th>
						<th field="SEEDURL" data-options="sortable:true" width="80">
							种子页面
						</th>
						<th field="PSTATE" data-options="sortable:true" width="80">
							状态
						</th>
						<th field="PCONTENT" data-options="sortable:true" width="160">
							备注
						</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
	<script type="text/javascript">
	var timeOutId;
	var url_delActionfarmwormproject = "admin/FarmWormProjectdeleteCommit.do";//删除URL
	var url_formActionfarmwormproject = "admin/FarmWormProjectshow.do";//增加、修改、查看URL
	var url_searchActionfarmwormproject = "admin/FarmWormProjectqueryAll.do";//查询URL
	var title_windowfarmwormproject = "下载项目";//功能名称
	var gridfarmwormproject;//数据表格对象
	var searchfarmwormproject;//条件查询组件对象
	var getRemote = false;
	var TOOL_BARfarmwormproject = [ {
		id : 'add',
		text : '新增项目',
		iconCls : 'icon-add',
		handler : addDatafarmwormproject
	}, {
		id : 'edit',
		text : '项目设置',
		iconCls : 'icon-edit',
		handler : editDatafarmwormproject
	}, {
		id : 'del',
		text : '删除项目',
		iconCls : 'icon-remove',
		handler : delDatafarmwormproject
	}, {
		id : 'runtask',
		text : '运行',
		iconCls : 'icon-ok',
		handler : runtask
	} ];
	$(function() {
		//初始化数据表格
		gridfarmwormproject = $('#dom_datagridfarmwormproject').datagrid( {
			url : url_searchActionfarmwormproject,
			fit : true,
			fitColumns : true,
			'toolbar' : TOOL_BARfarmwormproject,
			pagination : true,
			closable : true,
			checkOnSelect : true,
			striped : true,
			rownumbers : true,
			ctrlSelect : true,
			fitColumns : true
		});
	});
	//启动项目
	function runtask() {
		var selectedArray = $(gridfarmwormproject).datagrid('getSelections');
		if (selectedArray.length > 0) {
			var url = "admin/FarmWormProject_ACTION_Runtime.do"
					+ '?pageset.pageType=' + PAGETYPE.VIEW + '&ids='
					+ selectedArray[0].ID;
			$.farm.openWindow( {
				id : 'winfarmwormproject',
				width : 800,
				height : 450,
				modal : true,
				url : url,
				title : '运行任务'
			});
			$('#winfarmwormproject').panel( {
				onBeforeClose : function() {
					getRemote = false;
				}
			});
		} else {
			$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE,
					'info');
		}
	}
	//查看
	function viewDatafarmwormproject() {
		var selectedArray = $(gridfarmwormproject).datagrid('getSelections');
		if (selectedArray.length > 0) {
			var url = url_formActionfarmwormproject + '?pageset.pageType='
					+ PAGETYPE.VIEW + '&ids=' + selectedArray[0].ID;
			$.farm.openWindow( {
				id : 'winfarmwormproject',
				width : 600,
				height : 600,
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
	function addDatafarmwormproject() {
		var url = url_formActionfarmwormproject + '?pageset.pageType='
				+ PAGETYPE.ADD;
		$.farm.openWindow( {
			id : 'winfarmwormproject',
			width : 800,
			height : 400,
			modal : true,
			url : url,
			title : '新增'
		});
	}
	//修改
	function editDatafarmwormproject() {
		var selectedArray = $(gridfarmwormproject).datagrid('getSelections');
		if (selectedArray.length > 0) {
			var url = "index/FarmWormProjectSeting.do" + '?pageset.pageType='
					+ PAGETYPE.EDIT + '&ids=' + selectedArray[0].ID;
			;
			$.farm.openWindow( {
				id : 'winfarmwormproject',
				width : 800,
				height : 400,
				modal : true,
				url : url,
				title : '设置'
			});
		} else {
			$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE,
					'info');
		}
	}
	//删除
	function delDatafarmwormproject() {
		var selectedArray = $(gridfarmwormproject).datagrid('getSelections');
		if (selectedArray.length > 0) {
			// 有数据执行操作
			var str = selectedArray.length + MESSAGE_PLAT.SUCCESS_DEL_NEXT_IS;
			$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
				if (flag) {
					$.post(url_delActionfarmwormproject + '?ids='
							+ $.farm.getCheckedIds(gridfarmwormproject), {},
							function(flag) {
								if (flag.pageset.commitType == 0) {
									$(gridfarmwormproject).datagrid('reload');
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




