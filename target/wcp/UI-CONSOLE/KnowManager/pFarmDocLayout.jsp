<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<PF:basePath/>">
		<title>知识管理</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<jsp:include page="/WEB-FACE/conf/includeH.jsp"></jsp:include>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north',border:false">
			<form id="dom_searchfarmdoc">
				<table class="editTable">
					<tr>
						<td class="title">
							标题:
						</td>
						<td>
							<input name="TITLE:like" type="text">
						</td>
						<td class="title">
							建立时间：
						</td>
						<td>
							<input name="CTIME:>=" type="text">
							至
							<input name="CTIME:<=" type="text">
						</td>
					</tr>
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
			<table class="easyui-datagrid" id="dom_datagridfarmdoc">
				<thead data-options="frozen:true,autoRowHeight:true,nowrap:false">
					<tr>
						<th field="TITLE" data-options="sortable:true" width="200">
							标题
						</th>
						<th field="DOMTYPE" data-options="sortable:true" width="80">
							文档类型
						</th>
					</tr>
				</thead>
				<thead>
					<tr>
						<th field="READPOP" data-options="sortable:true" width="80">
							浏览权限
						</th>
						<th field="WRITEPOP" data-options="sortable:true" width="80">
							修改权限
						</th>
						<th field="AUTHOR" data-options="sortable:true" width="200">
							作者
						</th>
						<th field="PUBTIME" data-options="sortable:true" width="80">
							发布时间
						</th>

						<th field="SHORTTITLE" data-options="sortable:true" width="80">
							短标题
						</th>
						<th field="TAGKEY" data-options="sortable:true" width="200">
							tagkey
						</th>
						<th field="SOURCE" data-options="sortable:true" width="80">
							来源
						</th>
						<th field="TOPLEVE" data-options="sortable:true" width="80">
							置顶等级
						</th>
						<th field="STATE" data-options="sortable:true" width="80">
							状态
						</th>
						<th field="CTIME" data-options="sortable:true" width="80">
							建立时间
						</th>
						<th field="ETIME" data-options="sortable:true" width="80">
							修改时间
						</th>
						<th field="PCONTENT" data-options="sortable:true" width="200">
							备注
						</th>
						<th field="DOCDESCRIBE" data-options="sortable:true" width="200">
							描述
						</th>
					</tr>
				</thead>
			</table>
		</div>
	</body>
	<script type="text/javascript">
	var url_delActionfarmdoc = "admin/FarmDocdeleteCommit.do";//删除URL
	var url_formActionfarmdoc = "admin/FarmDocshow.do";//增加、修改、查看URL
	var url_searchActionfarmdoc = "admin/WcpDocqueryAll.do";//查询URL
	var title_windowfarmdoc = "知识管理";//功能名称
	var gridfarmdoc;//数据表格对象
	var searchfarmdoc;//条件查询组件对象
	var isLoadSta=false;
	var TOOL_BARfarmdoc = [ {
		id : 'view',
		text : '对所查询文档重建索引',
		iconCls : 'icon-invoice',
		handler : reIndexDoc
	} ];
	$(function() {
		//初始化数据表格
		gridfarmdoc = $('#dom_datagridfarmdoc').datagrid( {
			url : url_searchActionfarmdoc,
			'toolbar' : TOOL_BARfarmdoc,
			fit : true,
			fitColumns : false,
			pagination : true,
			closable : true,
			checkOnSelect : true,
			striped : true,
			rownumbers : true,
			ctrlSelect : true
		});
		//初始化条件查询
		searchfarmdoc = $('#dom_searchfarmdoc').searchForm( {
			gridObj : gridfarmdoc
		});
	});
	//建立索引
	function reIndexDoc() {
		// 有数据执行操作
		$.messager.confirm(MESSAGE_PLAT.PROMPT, "是否对所查询文档进行索引?",
				function(flag) {
					if (flag) {
						var limitStr = searchfarmdoc.arrayStr();
						var limitObj = {};
						if (limitStr != 'RESET') {
							limitObj = {
								'query.ruleText' : limitStr
							};
						}
						var pro = $.messager.progress( {
							msg : '正在后台建立索引，请等待...',
							interval : 300,
							text : '完成后系统会自动关闭该窗口'
						});
						isLoadSta=true;
						loadproSta();
						$.post("index/WcpReIndex.do", limitObj, function(flag) {
							$.messager.progress('close');
							isLoadSta=false;
							if (flag.pageset.commitType == 0) {
								$.messager.alert(MESSAGE_PLAT.PROMPT, "操作成功:"
										+ flag.pageset.message, 'info');
							} else {
								var str = MESSAGE_PLAT.ERROR_SUBMIT
										+ flag.pageset.message;
								$.messager.alert(MESSAGE_PLAT.ERROR, str,
										'error');
							}
						});
					}
				});
	}
	function loadproSta() {
		if (isLoadSta) {
			$.post("index/WcpLoadIndexSta.do", {}, function(flag) {
				$(".messager-p-msg").text("已经索引文档:" + flag.cdocs);
				setTimeout(loadproSta(), 1000);//延时3秒 
				});
		}
	}
</script>
</html>




