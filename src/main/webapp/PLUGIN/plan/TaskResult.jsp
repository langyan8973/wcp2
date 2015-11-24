<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<PF:basePath/>">
		<title>计划任务数据管理</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<jsp:include page="/WEB-FACE/conf/includeH.jsp"></jsp:include>
		<script type="text/javascript" src="PLUGIN/plan/js/TaskResult.js"></script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north',border:false">
			<form id="searchTaskForm">
				<table class="editTable">
					<tr>
						<td class="title">
							类型标签:
						</td>
						<td>
							<select name="h.TAG:like">
								<option>
								</option>
								<PF:OptionDictionary index="PLAN_TAGS" isTextValue="1" />
							</select>
						</td>
						<td class="title">
							任务主题:
						</td>
						<td>
							<input name="e.NAME:like" type="text">
						</td>
						<td class="title">
							父任务ID:
						</td>
						<td>
							<input name="e.PARENTID:=" type="text">
						</td>
					</tr>
					<tr style="text-align: center;">
						<td colspan="6">
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
			<table id="dataTaskGrid">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th field="NAME"
							data-options="sortable:true,formatter:funcformatter" width="200">
							任务主题
						</th>
						<th field="DSTATE" data-options="sortable:true" width="100">
							处理状态
						</th>
						<th field="USERNAME" data-options="sortable:true" width="100">
							处理人
						</th>
						<th field="PLANSTARTTIME" data-options="sortable:true" width="150">
							计划开始时间
						</th>
						<th field="PLANCOMPTIME" data-options="sortable:true" width="150">
							计划完成时间
						</th>
						<th field="COMPTIME" data-options="sortable:true" width="150">
							实际完成时间
						</th>
						<th field="PARENTID" data-options="sortable:true" width="100">
							父任务
						</th>
						<th field="PUBUSERNAME" data-options="sortable:true" width="100">
							发布人
						</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
	<script type="text/javascript">
	var url_delActionTask = "admin/FarmPlanTaskdeleteCommit.do";// 删除URL
	var url_formActionTask = "admin/FarmPlanTaskShow.do";// 增加、修改、查看URL
	var url_searchActionTask = "admin/FarmPlanTaskQuery.do";// 查询URL
	var title_windowTask = "计划任务管理";// 功能名称
	var gridTask;// 数据表格对象
	var searchTask;// 条件查询组件对象
	var toolBarTask = [ {
		id : 'add',
		text : '创建新任务',
		iconCls : 'icon-add',
		handler : addDataTask
	}, {
		id : 'edit',
		text : '任务详情',
		iconCls : 'icon-report_edit',
		handler : editDataTask
	}, {
		id : 'del',
		text : '分配执行人',
		iconCls : 'icon-group_green_edit',
		handler : sendTask
	}, {
		id : 'del',
		text : '挂起',
		iconCls : 'icon-control-pause',
		handler : suspendTask
	}, {
		id : 'del',
		text : '取消挂起',
		iconCls : 'icon-control-play',
		handler : unSuspendTask
	}, {
		id : 'del',
		text : '删除',
		iconCls : 'icon-remove',
		handler : delDataTask
	} ];
	$(function() {
		// 初始化数据表格
		gridTask = $('#dataTaskGrid').datagrid( {
			url : url_searchActionTask,
			fit : true,
			'toolbar' : toolBarTask,
			fitColumns : true,
			pagination : true,
			closable : true,
			checkOnSelect : true,
			striped : true,
			border : false,
			rownumbers : true,
			ctrlSelect : true
		});
		// 初始化条件查询
		searchTask = $('#searchTaskForm').searchForm( {
			gridObj : gridTask
		});
	});
</script>
</html>