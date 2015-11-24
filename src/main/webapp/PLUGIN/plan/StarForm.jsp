<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--任务描述表单-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
		<form id="dom_formwinStar">
			<input type="hidden" name="ids" value="${ids}">
			<table class="editTable">
				<tr style="height: 70px;">
					<td class="title">
						满意度:
					</td>
					<td colspan="3">
						<input class="easyui-slider" value="3" style="width: 160px"
							name="handler.compval"
							data-options="showTip:true,rule:[1,'|',2,'|',3,'|',4,'|',5],max:5,min:1" />
					</td>
				</tr>
				<tr>
					<td class="title">
						确认描述:
					</td>
					<td colspan="3">
						<textarea style="width: 160px; height: 80px;"
							class="easyui-validatebox"
							data-options="required:true,validType:['maxLength[1024]']"
							id="handler_pcontent" name="handler.compnote"></textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false">
		<div class="div_button" style="text-align: center; padding: 4px;">
			<a id="dom_Ok_entitywinStar" href="javascript:void(0)"
				iconCls="icon-ok" class="easyui-linkbutton">确认</a>
			<a id="dom_back_entitywinStar" href="javascript:void(0)"
				iconCls="icon-back" class="easyui-linkbutton">打回</a>
			<a id="dom_cancle_formwinStar" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionwinStar = 'admin/FarmPlanNoteaddCommit.do';
	var submitEditActionwinStar = 'admin/FarmPlanNoteeditCommit.do';
	var currentPageTypewinStar = '${pageset.pageType}';
	var submitFormwinStar;
	$(function() {
		//表单组件对象
		submitFormwinStar = $('#dom_formwinStar').SubmitForm( {
			pageType : currentPageTypewinStar,
			currentWindowId : 'winStar'
		});
		//关闭窗口
		$('#dom_cancle_formwinStar').bind('click', function() {
			$('#winStar').window('close');
		});
		//确认
		$('#dom_Ok_entitywinStar').bind(
				'click',
				function() {
					submitFormwinStar.postSubmit("admin/FarmPlanTaskStarOK.do",
							function(flag) {
								if (flag.pageset.commitType == '0') {
									taskCallback();
									$.messager.alert('信息', '操作已经提交！');
									$('#winStar').window('close');
									$('#winTask').window('refresh');
									$(gridTask).datagrid('reload');
								} else {
									$.messager.alert('错误',
											flag.pageset.message, 'error');
								}
							});
				});
		//打回
		$('#dom_back_entitywinStar').bind(
				'click',
				function() {
					submitFormwinStar.postSubmit(
							"admin/FarmPlanTaskStarBack.do", function(flag) {
								if (flag.pageset.commitType == '0') {
									taskCallback();
									$.messager.alert('信息', '操作已经提交！');
									$('#winStar').window('close');
									$('#winTask').window('refresh');
									$(gridTask).datagrid('reload');
								} else {
									$.messager.alert('错误',
											flag.pageset.message, 'error');
								}
							});
				});
	});
	//-->
</script>