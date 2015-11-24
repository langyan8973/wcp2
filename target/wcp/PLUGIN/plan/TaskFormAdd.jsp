<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--计划任务表单-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
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
					<td>
						<input id="tag_ids" style="width: 100px; height: 24px;"
							type="text" name="tagval" value="${tagval}">
						<a id="dom_add_tag" href="javascript:void(0)" iconCls="icon-tag"
							class="easyui-linkbutton"></a>
					</td>
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
				<c:if test="${pageset.pageType==1}">
					<tr>
						<td class="title">
							描述:
						</td>
						<td colspan="3">
							<textarea style="width: 455px; height: 50px;"
								class="easyui-validatebox"
								data-options="validType:['maxLength[1024]']" id="note_pcontent"
								name="note.pcontent">${note.pcontent}</textarea>
						</td>
					</tr>
				</c:if>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false">
		<div class="div_button" style="text-align: center; padding: 4px;">
			<c:if test="${pageset.pageType==1}">
				<a id="dom_add_entityTask" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">增加</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
				<a id="dom_edit_entityTask" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">修改</a>
			</c:if>
			<a id="dom_cancle_formTask" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionTask = 'admin/FarmPlanTaskaddCommit.do';
	var submitEditActionTask = 'admin/FarmPlanTaskeditCommit.do';
	var currentPageTypeTask = '${pageset.pageType}';
	var submitFormTask;
	$(function() {
		//表单组件对象
		submitFormTask = $('#dom_formTask').SubmitForm( {
			pageType : currentPageTypeTask,
			grid : gridTask,
			currentWindowId : 'winTask'
		});
		//关闭窗口
		$('#dom_cancle_formTask').bind('click', function() {
			$('#winTask').window('close');
		});
		//提交新增数据
		$('#dom_add_entityTask').bind('click', function() {
			submitFormTask.postSubmit(submitAddActionTask, function(flag) {
				try {
					//公用回调方法
					addSuccess(flag);
				} catch (e) {

				}
				return true;
			});
		});
		//提交修改数据
		$('#dom_edit_entityTask').bind('click', function() {
			submitFormTask.postSubmit(submitEditActionTask);
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
	//当选择计划开始时间时触发
	function selectPlanStart() {
		try {
			var vStart = $('#entity_planstarttime').datetimebox('getValue');
			var vEnd = $('#entity_plancomptime').datetimebox('getValue');
			if (vStart > vEnd && (vEnd.length > 12 && vStart.length > 12)) {
				$('#entity_plancomptime').datetimebox('setValue', vStart);
			}
		} catch (e) {
		}
	}
	//当选择计划完成时间时触发
	function selectPlanComplete() {
		try {
			var vStart = $('#entity_planstarttime').datetimebox('getValue');
			var vEnd = $('#entity_plancomptime').datetimebox('getValue');
			if (vStart > vEnd && (vEnd.length > 12 && vStart.length > 12)) {
				$('#entity_planstarttime').datetimebox('setValue', vEnd);
			}
		} catch (e) {
		}
	}
	//-->
</script>