<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--40 <span style="font-size: 14px; font-weight: bold;margin: 20px;"> 系统管理控制台2.0.0</span> -->
<div>
	<div style="float: left; color: #777777;">
		<div style="margin: 4px; font-size: 16px;">
		<a href="<PF:basePath/>">
			<img alt="<PF:ParameterValue key="config.sys.title" />" style="height: 50px;" src="WEB-FACE/img/style/logo.png"/></a>
		</div>
	</div>
	<div style="float: right; padding-top: 8px;">
		<b><c:forEach var="node" varStatus="index"
				items="${sessionScope.LOGINROLES}">
				<c:if test="${index.count!=1}">,</c:if>
						${node.name}
						</c:forEach> </b> 欢迎你,
		<span style="color: green; font-weight: bold;">${sessionScope.USEROBJ.name}</span>&nbsp;&nbsp;&nbsp;&nbsp;
		<div class="demo-tip icon-tip"></div>
	</div>
	<div style="padding-top: 32px; margin-left: 160px; float: left;">
		<div style="float: left;">
			<c:forEach items="${menus}" var="node">
				<c:if test="${node.parentid=='NONE'}">
					<a href="#" class="easyui-menubutton"
						data-options="menu:'#mm${node.id}',iconCls:'${node.icon}'">${node.name}</a>
					<div id="mm${node.id}" style="width: 150px;">
						<c:forEach items="${menus}" var="node2">
							<c:if test="${node2.parentid==node.id}">
								<div class="frame_menulink" url="${node2.url}" id="${node2.id}"
									text="${node2.name}" data-options="iconCls:'${node2.icon}'"
									params="${node2.params}">
									<span>${node2.name}</span>
									<c:set var="isDiv" value="0"></c:set>
									<c:forEach items="${menus}" var="node3">
										<c:if test="${node3.parentid==node2.id}">
											<c:set var="isDiv" value="1"></c:set>
										</c:if>
									</c:forEach>
									<c:if test="${isDiv==1}">
										<div style="width: 150px;">
											<c:forEach items="${menus}" var="node3">
												<c:if test="${node3.parentid==node2.id}">
													<div class="frame_menulink" url="${node3.url}"
														params="${node3.params}" id="${node3.id}"
														text="${node3.name}"
														data-options="iconCls:'${node3.icon}'">
														<span>${node3.name}</span>
													</div>
												</c:if>
											</c:forEach>
										</div>
									</c:if>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</c:if>
			</c:forEach>
			<a href="#" class="easyui-menubutton"
				data-options="menu:'#mm2',iconCls:'icon-suppliers'">用户</a>
			<div id="mm2" style="width: 100px;">
				<div id="editPW_a" data-options="iconCls:'icon-login'">
					修改密码
				</div>
				<div id="logout_a" data-options="iconCls:'icon-sign-out'">
					<span>退出系统</span>
				</div>
			</div>
		</div>
	</div>
	<div id="DIV_EDIT_PASSWORD_WINDOW"></div>
</div>
<script type="text/javascript">
	$('#logout_a').bind('click', function() {
		$.messager.confirm('退出系统', '确定要注销此用户并退出系统吗？', function(r) {
			if (r) {
				window.location = "admin/ALONEFRAME_LOGOUT_COMMIT.do";
			}
		});
	});
	$('#editPW_a').bind('click', function() {
		$('#DIV_EDIT_PASSWORD_WINDOW').dialog( {
			title : '修改用户密码',
			width : 300,
			height : 200,
			closed : false,
			cache : false,
			href : 'admin/LoginUser_UpdataPassWord.do',
			modal : true
		});
	});
	$('.frame_menulink').bind(
			'click',
			function() {
				if ($(this).attr('url')) {
					if ($(this).attr("params")) {
						openUrlAtIfram("admin/" + $(this).attr("url") + ".do?"
								+ $(this).attr("params"), $(this).attr('id'),
								$(this).attr('text'), true);
					} else {
						openUrlAtIfram($(this).attr("url"), $(this).attr('id'),
								$(this).attr('text'));
					}
				}
			});
	/**在选项卡中打开一个菜单
	 *address:地址默认为action的index
	 *id：识别是否已经打开的标签用的
	 *text:显示的中文标题
	 *isURI:是否是URL，默认false即系统会自动拼admin/和.do
	 **/
	function openUrlAtIfram(address, id, text, isURI) {
		var URL = '';
		if (!isURI) {
			isURI == false;
			URL = 'admin/' + address + '.do';
		} else {
			URL = address;
		}
		//打开一个选项卡在选项卡中加载页面
		var exist_tab = $('#frame_tabs').tabs('getTab', text);
		//是否已经打开该选项卡
		if (exist_tab && $(exist_tab).attr('id') == 'tab' + id) {
			$('#frame_tabs').tabs('select', text);
			return;
		} else {
			$('#frame_tabs')
					.tabs(
							'add',
							{
								'id' : 'tab' + id,
								title : text,
								fit : true,
								tools : [ {
									id : 'refresh',
									text : '刷新',
									iconCls : 'icon-mini-refresh',
									handler : function(flag) {
										var index = $(this).parent().parent()
												.prevAll().length;
										openAndRefreshTab(index);
									}
								} ],
								content : '<div id="load'
										+ id
										+ '"  style="vertical-align:middle; text-align: center; padding-top: 25px;"><img style="margin-top: 50px;" alt="" src="WEB-FACE/img/style/loading.gif"><br/>页面加载中...</div><iframe id="frametab'
										+ id
										+ '" onload="loadLaberOver(\'load'
										+ id
										+ '\');" scrolling="auto" frameborder="0"  src="'
										+ URL
										+ '" style="width:100%;height:100%;"></iframe>',
								closable : true
							});
			$('#frame_tabs').tabs('getSelected').css('overflow', 'hidden');
		}
	}
	function loadLaberOver(id) {
		$('#' + id).remove();
	}
	//-->
</script>