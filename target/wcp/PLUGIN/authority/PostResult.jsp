<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<table id="dataPostGrid">
	<thead>
		<tr>
			<th data-options="field:'ck',checkbox:true"></th>
			<th field="TYPE" data-options="sortable:true" width="20">
				类型
			</th>
			<th field="NAME" data-options="sortable:true" width="40">
				岗位名称
			</th>
		</tr>
	</thead>
</table>
<script type="text/javascript">
	var url_delActionPost = "admin/FarmAuthorityPostdeleteCommit.do";//删除URL
	var url_formActionPost = "admin/FarmAuthorityPostShow.do";//增加、修改、查看URL
	var url_searchActionPost = "admin/FarmAuthorityPostQuery.do?ids="
			+ $('#domTabsId').val();//查询URL
	var title_windowPost = "岗位管理";//功能名称
	var gridPost;//数据表格对象
	var pageType = '${pageset.pageType}';
	var toolBarPost = [ {
		id : 'add',
		text : '新增',
		iconCls : 'icon-add',
		handler : addDataPost
	}, {
		id : 'edit',
		text : '修改',
		iconCls : 'icon-edit',
		handler : editDataPost
	}, {
		id : 'del',
		text : '删除',
		iconCls : 'icon-remove',
		handler : delDataPost
	}, {
		id : 'lock',
		text : '设置权限',
		iconCls : 'icon-lock',
		handler : setActions
	}, {
		id : 'customers',
		text : '导入用户',
		iconCls : 'icon-customers',
		handler : importUser
	} ];
	$(function() {
		if (pageType == '0') {
			toolBarPost = [];
		}
		//初始化数据表格
		gridPost = $('#dataPostGrid').datagrid( {
			url : url_searchActionPost,
			fit : true,
			fitColumns : true,
			'toolbar' : toolBarPost,
			pagination : true,
			closable : true,
			checkOnSelect : true,
			striped : true,
			rownumbers : true,
			ctrlSelect : true
		});
	});
	//查看
	function viewDataPost() {
		var selectedArray = $(gridPost).datagrid('getSelections');
		if (selectedArray.length == 1) {
			var url = url_formActionPost + '?pageset.pageType=' + PAGETYPE.VIEW
					+ '&ids=' + selectedArray[0].ID;
			$.farm.openWindow( {
				id : 'winPostForm',
				width : 600,
				height : 100,
				modal : true,
				url : url,
				title : '浏览岗位'
			});
		} else {
			$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE_ONLY,
					'info');
		}
	}
	//新增
	function addDataPost() {
		if (!$('#domTabsId').val()) {
			$.messager.alert(MESSAGE_PLAT.PROMPT, "无法获得组织机构ID", 'info');
		}
		var url = url_formActionPost + '?ids=' + $('#domTabsId').val()
				+ '&pageset.pageType=' + PAGETYPE.ADD;
		$.farm.openWindow( {
			id : 'winPostForm',
			width : 600,
			height : 150,
			modal : true,
			url : url,
			title : '新增岗位'
		});
	}
	//修改
	function editDataPost() {
		var selectedArray = $(gridPost).datagrid('getSelections');
		if (selectedArray.length == 1) {
			var url = url_formActionPost + '?pageset.pageType=' + PAGETYPE.EDIT
					+ '&ids=' + selectedArray[0].ID;
			$.farm.openWindow( {
				id : 'winPostForm',
				width : 600,
				height : 150,
				modal : true,
				url : url,
				title : '修改岗位'
			});
		} else {
			$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE_ONLY,
					'info');
		}
	}
	//设置岗位权限
	function setActions() {
		var selectedArray = $(gridPost).datagrid('getSelections');
		if (selectedArray.length == 1) {
			$.farm.openWindow( {
				id : 'winPostActionsChoose',
				width : 300,
				height : 400,
				modal : true,
				url : "admin/FarmAuthorityPostActions.do?ids="
						+ selectedArray[0].ID,
				title : '设置权限'
			});
		} else {
			$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE_ONLY,
					'info');
		}
	}
	//导入用户
	function importUser() {
		var selectedArray = $(gridPost).datagrid('getSelections');
		if (selectedArray.length == 1) {
			var url = "admin/FarmAuthorityUserChoose.do";
			$.farm.openWindow( {
				id : 'chooseUserWin',
				width : 600,
				height : 300,
				modal : true,
				url : url,
				title : '导入用户'
			});
			chooseWindowCallBackHandle = function(row) {
				$.messager.confirm(MESSAGE_PLAT.PROMPT,
						"设置标准岗位时会删除已有标准岗位，设置临时岗位则为用户添加临时岗位。确定继续？", function(
								flag) {
							if (flag) {
								var userids;
								$(row).each(function(i, obj) {
									if (userids) {
										userids = userids + ',' + obj.ID;
									} else {
										userids = obj.ID;
									}
								});
								$.post("admin/farmAuthorityUserORGSubmit.do", {
									ids : userids,
									id : selectedArray[0].ID
								}, function(flag) {
									if (flag.pageset.commitType == 0) {
										$('#chooseUserWin').window('close');
									} else {
										$.messager.alert(MESSAGE_PLAT.ERROR,
												flag.pageset.message, 'error');
									}
								});
							}
						});
			};
		} else {
			$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE_ONLY,
					'info');
		}
	}

	//删除
	function delDataPost() {
		var selectedArray = $(gridPost).datagrid('getSelections');
		if (selectedArray.length > 0) {
			// 有数据执行操作
			var str = selectedArray.length + MESSAGE_PLAT.SUCCESS_DEL_NEXT_IS;
			$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
				if (flag) {
					$(gridPost).datagrid('loading');
					$.post(url_delActionPost + '?ids='
							+ $.farm.getCheckedIds(gridPost, 'ID'), {},
							function(flag) {
								$(gridPost).datagrid('loaded');
								if (flag.pageset.commitType == 0) {
									$(gridPost).datagrid('reload');
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