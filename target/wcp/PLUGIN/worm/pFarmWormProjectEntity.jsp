<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--下载项目-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
		<form id="dom_formfarmwormproject">
			<input type="hidden" name="entity.id" value="${entity.id}">
			<table class="editTable">
				<tr>
					<td class="title">
						名称:
					</td>
					<td colspan="3">
						<input type="text" style="width: 560px;"
							class="easyui-validatebox"
							data-options="required:true,validType:',maxLength[64]'"
							id="entity_name" name="entity.name" value="${entity.name}">

					</td>
				</tr>
				<tr>
					<td class="title">
						种子页面:
					</td>
					<td colspan="3">
						如：http://baike.baidu.com/
						<br />
						<input type="text" style="width: 560px;"
							class="easyui-validatebox"
							data-options="required:true,validType:',maxLength[256]'"
							id="entity_seedurl" name="entity.seedurl"
							value="${entity.seedurl}">
					</td>
				</tr>
				<tr>
					<td class="title">
						timeout:
					</td>
					<td>
						毫秒，如：3000
						<br />
						<input type="text" style="width: 160px;"
							class="easyui-validatebox"
							data-options="required:true,validType:',maxLength[8]'"
							id="entity_timeout" name="entity.timeout"
							value="${entity.timeout}">

					</td>
					<td class="title">
						抓取延时:
					</td>
					<td>
						（避免被主站封IP）毫秒，如：5000
						<br />
						<input type="text" style="width: 160px;"
							class="easyui-validatebox"
							data-options="required:true,validType:',maxLength[8]'"
							id="entity_waittime" name="entity.waittime"
							value="${entity.waittime}">

					</td>
				</tr>
				<tr>
					<td class="title">
						相对路径URL（baseUrl）:
					</td>
					<td colspan="3">
						(如果网站有设置BASE标签或用到相对路径请配置该内容)
						<br />
						<input type="text" style="width: 560px;"
							class="easyui-validatebox"
							data-options="required:false,validType:',maxLength[128]'"
							id="entity_baseUrl" name="entity.baseurl"
							value="${entity.baseurl}">
					</td>
				</tr>
				<tr>
					<td class="title">
						agent:
					</td>
					<td colspan="3">
						如：Mozilla/5.0 (Windows NT 5.1; rv:32.0) Gecko/20100101
						Firefox/32.0
						<input type="text" style="width: 560px;"
							class="easyui-validatebox"
							data-options="required:true,validType:',maxLength[256]'"
							id="entity_agent" name="entity.agent" value="${entity.agent}">
					</td>
				</tr>
				<tr>
					<td class="title">
						下载接口实现CLASS:
					</td>
					<td colspan="3">
						如:com.farm.worm.test.WormHandle该接口会在下载每一篇文档时调用，并由该类实现对下载下来的文档的具体处理过程,为空时也可以在当前任务中查看下载到的文档
						<br />
						<input type="text" style="width: 560px;"
							class="easyui-validatebox"
							data-options="required:false,validType:',maxLength[256]'"
							id="entity_handleclass" name="entity.handleclass"
							value="${entity.handleclass}">
					</td>
				</tr>
				<c:if test="${pageset.pageType==2}">
					<tr>
						<td class="title">
							下载接口参数:
						</td>
						<td colspan="3">
							如："GROUPID:4028812a491d311901491d37316d0000,LOGINNAME:sysadmin,TYPEID:402894ca49178b80014917d26f0f0033"
							<br />
							<textarea rows="2" style="width: 560px;"
								class="easyui-validatebox"
								data-options="required:false,validType:',maxLength[256]'"
								id="entity_handlepara" name="entity.handlepara">${entity.handlepara}</textarea>
							<br />
							<a id="dom_checkPara_entityfarmwormproject"
								href="javascript:void(0)" iconCls="icon-eye"
								class="easyui-linkbutton">验证参数</a>
						</td>
					</tr>
				</c:if>
				<tr>
					<td class="title">
						备注:
					</td>
					<td colspan="3">
						<input type="text" style="width: 560px;"
							class="easyui-validatebox"
							data-options="required:false,validType:',maxLength[128]'"
							id="entity_pcontent" name="entity.pcontent"
							value="${entity.pcontent}">
					</td>
				</tr>
				<c:if test="${pageset.pageType==1}">
					<!--新增-->
				</c:if>
				<c:if test="${pageset.pageType==2}">
					<!--修改-->
				</c:if>
				<c:if test="${pageset.pageType==0}">
					<!--浏览-->
				</c:if>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false">
		<div class="div_button" style="text-align: center; padding: 4px;">
			<c:if test="${pageset.pageType==1}">
				<a id="dom_add_entityfarmwormproject" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">增加</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
				<a id="dom_edit_entityfarmwormproject" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">修改</a>
				<a id="dom_init_entityfarmwormproject" href="javascript:void(0)"
					iconCls="icon-arrow_refresh" class="easyui-linkbutton">初始化状态</a>
			</c:if>
			<a id="dom_cancle_formfarmwormproject" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionfarmwormproject = 'admin/FarmWormProjectaddCommit.do';
	var submitEditActionfarmwormproject = 'admin/FarmWormProjecteditCommit.do';
	var currentPageTypefarmwormproject = '${pageset.pageType}';
	var submitFormfarmwormproject;
	$(function() {
		//表单组件对象
		submitFormfarmwormproject = $('#dom_formfarmwormproject').SubmitForm( {
			pageType : currentPageTypefarmwormproject,
			grid : gridfarmwormproject,
			currentWindowId : 'winfarmwormproject'
		});
		//关闭窗口
		$('#dom_cancle_formfarmwormproject').bind('click', function() {
			$('#winfarmwormproject').window('close');
		});
		//提交新增数据
		$('#dom_add_entityfarmwormproject').bind(
				'click',
				function() {
					submitFormfarmwormproject
							.postSubmit(submitAddActionfarmwormproject);
				});
		//提交修改数据
		$('#dom_edit_entityfarmwormproject').bind(
				'click',
				function() {
					submitFormfarmwormproject
							.postSubmit(submitEditActionfarmwormproject);
				});
		//验证参数
		$('#dom_checkPara_entityfarmwormproject').bind('click', function() {
			$.post('index/FarmWormProjectCheckPara.do', {
				ids : $('#entity_handlepara').val()
			}, function(flag) {
				$.messager.alert('请检查', '确认参数是否解析正确:' + flag.ids);
			});
		});

		//初始化项目状态
		$('#dom_init_entityfarmwormproject').bind('click', function() {
			$.post('index/FarmWormProjectInit.do', {
				ids : '${entity.id}'
			}, function() {
				$(gridfarmwormproject).datagrid('reload');
				$.messager.alert('完成', '初始化项目状态完成');
			});
		});

	});
	//-->
</script>