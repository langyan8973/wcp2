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
		<input type="hidden" name="entity.id" value="${entity.id}">
		<table class="editTable">
			<tr>
				<td class="title">
					项目名称:
				</td>
				<td colspan="2">
					${entity.name}
				</td>
				<td class="title">
					种子:
				</td>
				<td colspan="2">
					${entity.seedurl}
				</td>
				<td class="title">
					当前状态
				</td>
				<td id="proStaId">
					loading...
				</td>
			</tr>
			<tr>
				<td class="title">
					种子任务数:
				</td>
				<td id="seeds">
					loading...
				</td>
				<td class="title">
					种子扫描完成数:
				</td>
				<td id="scaneds">
					loading...
				</td>
				<td class="title">
					文档任务数:
				</td>
				<td id="docs">
					loading...
				</td>
				<td class="title">
					文档下载完成数:
				</td>
				<td id="downloads">
					loading...
				</td>
			</tr>
			<tr>
				<td colspan="8"
					style="background-color: black; height: 250px; overflow: hidden; color: white; vertical-align: top;">
					<div id="consoleId" style="height: 240px; overflow: auto;">
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div data-options="region:'south',border:false,height: 50">
		<div class="div_button" style="text-align: center; padding: 4px;height: 30px;">
			<div id="dom_controlBox1" style="float: left;">
				<a id="dom_edit_control1" href="javascript:void(0)"
					iconCls="icon-control-play" class="easyui-linkbutton">启动URL扫描任务</a>
			</div>
			<div id="dom_controlBox2" style="float: left;">
				<a id="dom_edit_control2" href="javascript:void(0)"
					iconCls="icon-control-play" class="easyui-linkbutton">启动文档下载任务</a>
			</div>
			<div id="dom_controlBox3" style="float: left;">
				<a id="dom_edit_control3" href="javascript:void(0)"
					iconCls="icon-control-stop" class="easyui-linkbutton">停止任务</a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(function() {
		getRemote = true;
		$('#consoleId').prepend('<p>控制台请求远程数据...</p>');
		hideAllbutton();
		//关闭窗口
		$('#dom_cancle_runtime_closeId').bind('click', function() {
			getRemote = false;
			$('#winfarmwormproject').window('close');
		});
		//初始化任务
		$('#dom_edit_control1').bind('click', function() {
			hideAllbutton();
			$.post("index/FarmWormProjectUrlInit.do", {
				ids : '${ids}'
			}, function() {
			});
			$('#consoleId').prepend('<p><span class="demo-tip icon-user" style="color: white;"></span>' + "启动URL扫描任务..." + "</p>");
		});
		//下载
		$('#dom_edit_control2').bind('click', function() {
			hideAllbutton();
			$.post("index/FarmWormProjectStart.do", {
				ids : '${ids}'
			}, function() {
			});
			$('#consoleId').prepend('<p><span class="demo-tip icon-user" style="color: white;"></span>' + "启动文档下载任务..." + "</p>");
		});
		//停止任务
		$('#dom_edit_control3').bind('click', function() {
			hideAllbutton();
			$.post("index/FarmWormProjectWait.do", {
				ids : '${ids}'
			}, function() {
			});
			$('#consoleId').prepend('<p><span class="demo-tip icon-user" style="color: white;"></span>' + "停止任务..." + "</p>");
		});
		loadRemoteInfo();
	});
	function hideAllbutton() {
		$('#dom_controlBox1').hide();
		$('#dom_controlBox2').hide();
		$('#dom_controlBox3').hide();
	}
	function loadRemoteInfo() {
		$.post("index/FarmWormProjectLoadStat.do", {
			ids : '${ids}'
		}, function(flag) {
			$('#seeds').text(flag.SEEDS);
			$('#scaneds').text(flag.SCANEDS);
			$('#docs').text(flag.DOCS);
			$('#downloads').text(flag.DOWNLOADS);
			if (flag.STA == '1') {
				$('#dom_edit_control1').show();
				$('#proStaId').text("运行中");
				hideAllbutton();
				$('#dom_controlBox3').show();
			}
			if (flag.STA == '2') {
				hideAllbutton();
				$('#dom_edit_control4').show();
				$('#proStaId').text("正在停止中...");
			}
			if (flag.STA == '0') {
				hideAllbutton();
				$('#dom_edit_control4').show();
				$('#proStaId').text("停止");
				hideAllbutton();
				$('#dom_controlBox1').show();
				$('#dom_controlBox2').show();
			}
			$(flag.MESSAGE).each(function(index, obj) {
				obj=obj.replace("INFO8220",'<span class="demo-tip icon-tip" style="color: white;"></span>');
				obj=obj.replace("ERROR2692",'<span class="demo-tip icon-exclamation-red-frame" style="color: white;"></span>');
				obj=obj.replace("WARN4086",'<span class="demo-tip icon-error" style="color: white;"></span>');
				$('#consoleId').prepend('<p>' + obj + '</p>');
			});
			if (getRemote) {
				clearTimeout(timeOutId);
				timeOutId = setTimeout("loadRemoteInfo()", "5000");
			}
		});
	}
	//-->
</script>