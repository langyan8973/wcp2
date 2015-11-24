<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--计划任务表单-->
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'center'">
		<div>
			<div class="demo-info"
				style="padding: 4px; border: 0px; padding-top: 8px;">
				<div class="demo-tip icon-tip"></div>
				<div>
					任务计划
				</div>
			</div>
			<form id="dom_formTask">
				<input type="hidden" id="entity_id" name="entity.id"
					value="${entity.id}">
				<table class="editTable">
					<tr>
						<td class="title">
							任务主题:
						</td>
						<td colspan="3">
							<input type="text" style="width: 455px;"
								class="easyui-validatebox"
								data-options="required:true,validType:[,'maxLength[32]']"
								id="entity_name" name="entity.name" value="${entity.name}">
						</td>
					</tr>
					<tr>
						<td class="title">
							类型标签:
						</td>
						<td colspan="3">
							<input id="tag_ids" style="width: 355px; height: 24px;"
								type="text" name="tagval" value="${tagval}">
							<c:if test="${createIs=='true'&&entity.handler.dstate!=8}">
								<a id="dom_add_tag" href="javascript:void(0)" iconCls="icon-tag"
									class="easyui-linkbutton"></a>
							</c:if>
						</td>
					</tr>
					<tr>
						<td class="title">
							计划开始时间:
						</td>
						<td>
							<input type="text" style="width: 140px;"
								class="easyui-datetimebox"
								data-options="required:true,editable:false,onChange:selectPlanStart,showSeconds:false"
								id="entity_planstarttime" name="entity.planstarttime"
								value="${entity.planstarttime}">
						</td>
						<td class="title">
							计划完成时间:
						</td>
						<td>
							<input type="text" style="width: 140px;"
								class="easyui-datetimebox"
								data-options="required:true,editable:false,onChange:selectPlanComplete,showSeconds:false"
								id="entity_plancomptime" name="entity.plancomptime"
								value="${entity.plancomptime}">
						</td>
					</tr>
					<tr>
						<td class="title">
							工期（小时）:
						</td>
						<td>
							<input type="text" style="width: 140px;" class="easyui-numberbox"
								data-options="validType:[,'maxLength[5]']" id="entity_duration"
								name="entity.duration" value="${entity.duration}">
						</td>
						<td class="title">
							排序:
						</td>
						<td>
							<input type="text" style="width: 140px;" class="easyui-numberbox"
								data-options="required:true,validType:[,'maxLength[5]']"
								id="entity_sort" name="entity.sort"
								value="${entity.sort==null?'50':entity.sort}">
						</td>
					</tr>
					<tr>
						<td class="title">
							优先级:
						</td>
						<td>
							<input type="text" style="width: 140px;"
								class="easyui-numberspinner"
								data-options="required:true,min:1,max:5,editable:false"
								id="entity_weightval" name="entity.weightval"
								value="${entity.weightval==null?'1':entity.weightval}">
						</td>
						<td class="title">
						</td>
						<td>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<c:if test="${entity.handler.userid!=entity.myHandler.userid}">
			<div>
				<div class="demo-info"
					style="padding: 4px; border: 0px; padding-top: 8px; height: 24px;">
					<div class="demo-tip icon-tip"></div>
					<div>
						当前执行情况
					</div>
				</div>
				<!-- 当前执行状态 -->
				<form id="dom_current">
					<table class="editTable">
						<tr>
							<td class="title">
								阅读:
							</td>
							<td>
								${entity.handler.rstate=='1'?'阅读':'未读'}
							</td>
							<td class="title">
								处理:
							</td>
							<td>
								<PF:runDictionaryByConstantKey
									key="farm.constant.plan.task.state"
									val="${entity.handler.dstate}" />
							</td>
						</tr>
						<tr>
							<td class="title">
								执行人:
							</td>
							<td>
								${entity.handler.username}
							</td>
							<td class="title">
							</td>
							<td>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</c:if>
		<div>
			<div class="demo-info"
				style="padding: 4px; border: 0px; padding-top: 8px; height: 24px;">
				<div class="demo-tip icon-my-account"></div>
				<div>
					我的执行情况
				</div>
			</div>
			<!-- 当前执行状态 -->
			<form id="dom_my">
				<table class="editTable">
					<tr>
						<td class="title">
							阅读:
						</td>
						<td>
							${entity.myHandler.rstate=='1'?'阅读':'未读'}
						</td>
						<td class="title">
							处理:
						</td>
						<td>
							<PF:runDictionaryByConstantKey
								key="farm.constant.plan.task.state"
								val="${entity.myHandler.dstate}" />
						</td>
					</tr>
					<tr>
						<td class="title">
							执行人:
						</td>
						<td>
							${entity.myHandler.username}
						</td>
						<td class="title">
						</td>
						<td>
						</td>
					</tr>
					<c:if
						test="${entity.handler.id==entity.myHandler.id&&entity.myHandler.compnote!=null}">
						<tr>
							<td class="title">
								确认描述:
							</td>
							<td colspan="3">
								${entity.myHandler.compnote}
							</td>
						</tr>
					</c:if>
				</table>
			</form>
			<div style="width: 100%; overflow: hidden;">
				<div class="demo-info"
					style="padding: 4px; border: 0px; padding-top: 8px; height: 24px;">
					<div class="demo-tip icon-administrative-docs"></div>
					<div>
						任务描述
					</div>
				</div>
				<table id="dataNoteGrid">
					<thead>
						<tr>
							<th field="CTIME" data-options="sortable:true" width="40">
								描述时间
							</th>
							<th field="PCONTENT" data-options="sortable:true" width="60">
								内容
							</th>
						</tr>
					</thead>
				</table>
			</div>
			<div>
				<div class="demo-info"
					style="padding: 4px; border: 0px; padding-top: 8px; height: 24px;">
					<div class="demo-tip icon-future-projects"></div>
					<div>
						任务日志
					</div>
					<div>
						<c:forEach items="${entity.logs}" var="node">
							<p>
								<PF:FormatTime date="${node.ctime}"
									yyyyMMddHHmmss="yyyy-MM-dd HH:mm" />
								${node.cusername}&nbsp;:&nbsp; ${node.pcontent};
							</p>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div data-options="region:'south',border:false">
		<div class="div_button" style="text-align: center; padding: 4px;">
			<c:if test="${entity.myHandler.dstate==1}">
				<!-- 待处理的任务可以完成 -->
				<a id="dom_complete_formTask" href="javascript:void(0)"
					iconCls="icon-ok" class="easyui-linkbutton" style="color: #000000;">完成</a>
			</c:if>
			<c:if test="${entity.myHandler.dstate==4}">
				<!-- 待确认的任务可以确认和打回 -->
				<a id="dom_star_formTask" href="javascript:void(0)"
					iconCls="icon-star" class="easyui-linkbutton"
					style="color: #000000;">确认</a>
			</c:if>
			<c:if test="${createIs=='true'&&entity.handler.dstate!=8}">
				<a id="dom_edit_entityTask" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton"
					style="color: #000000;">保存基本信息</a>
			</c:if>
			<a id="dom_cancle_formTask" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">关闭</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionTask = 'admin/FarmPlanTaskaddCommit.do';
	var submitEditActionTask = 'admin/FarmPlanTaskeditCommit.do';
	var currentPageTypeTask = '${pageset.pageType}';
	var submitFormTask;
	var createIs = '${createIs}';
	var taskHandleState = '${entity.handler.dstate}';
	var hanlerId = '${entity.handler.userid}';
	var handleState = '${entity.handler.dstate}';
	var taskId = "${entity.id}";
	var gridNote;
	var toolBarNote = [ {
		id : 'add',
		text : '添加描述',
		iconCls : 'icon-add',
		handler : addnote
	}, {
		id : 'edit',
		text : '修改描述',
		iconCls : 'icon-report_edit',
		handler : editnote
	}, {
		id : 'del',
		text : '删除描述',
		iconCls : 'icon-remove',
		handler : delnote
	} ];
	$(function() {
		//表单组件对象
		if (createIs == 'true' && handleState != '8') {
			currentPageTypeTask = '1';
		} else {
			currentPageTypeTask = '0';
		}
		submitFormTask = $('#dom_formTask').SubmitForm( {
			pageType : currentPageTypeTask,
			grid : gridTask,
			currentWindowId : 'winTask'
		});
		$('#dom_current').SubmitForm( {
			pageType : 0
		});
		$('#dom_my').SubmitForm( {
			pageType : 0
		});
		// 初始化数据表格
		gridNote = $('#dataNoteGrid').datagrid( {
			url : 'admin/FarmPlanTaskNoteQuery.do?ids=${entity.id}',
			fitColumns : true,
			nowrap : false,
			striped : true,
			border : false,
			ctrlSelect : true
		});
		if (createIs == 'true' && handleState != '8') {
			$('#dataNoteGrid').datagrid( {
				toolbar : toolBarNote
			});
		}
		//关闭窗口
		$('#dom_cancle_formTask').bind('click', function() {
			$('#winTask').window('close');
		});
		//提交修改数据
		$('#dom_edit_entityTask').bind('click', function() {
			submitFormTask.postSubmit(submitEditActionTask, function(flag) {
				taskCallback();
				return true;
			});
		});
		//完成任务
		$('#dom_complete_formTask').bind('click', function() {
			completeTask('${entity.id}');
		});
		//确认任务
		$('#dom_star_formTask').bind('click', function() {
			startTask('${entity.id}');
		});
		$('#dom_add_tag').bind('click', function() {
			var url = 'admin/FarmPlanTagsPage.do';
			$.farm.openWindow( {
				id : 'winTag',
				width : 200,
				iconCls : 'icon-save',
				height : 200,
				modal : true,
				url : url,
				title : '选择标签'
			});
		});
	});
	//确认任务
	function startTask(taskId) {
		var url = 'admin/FarmPlanStarPage.do?ids=${entity.id}&pageset.pageType=' + PAGETYPE.ADD;
		$.farm.openWindow( {
			id : 'winStar',
			width : 400,
			height : 300,
			modal : true,
			url : url,
			title : '确认'
		});
	}
	//用于其它组件的回调函数(确认，完成，修改基本信息)
	function taskCallback(flag) {
		try {
			if (flag) {
				editSuccess(flag);
			} else {
				editSuccess();
			}
		} catch (e) {

		}
	}
	//-->
</script>