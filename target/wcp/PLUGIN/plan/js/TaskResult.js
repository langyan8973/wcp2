// 查看
function viewDataTask() {
	var selectedArray = $(gridTask).datagrid('getSelections');
	if (selectedArray.length == 1) {
		var url = url_formActionTask + '?pageset.pageType=' + PAGETYPE.VIEW
				+ '&ids=' + selectedArray[0].ID;
		$.farm.openWindow( {
			id : 'winTask',
			width : 600,
			height : 300,
			modal : true,
			url : url,
			title : '浏览'
		});
	} else {
		$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE_ONLY,
				'info');
	}
}
// 新增
function addDataTask() {
	var url = "admin/FarmPlanTaskAddShow.do" + '?pageset.pageType='
			+ PAGETYPE.ADD;
	$.farm.openWindow( {
		id : 'winTask',
		width : 600,
		height : 300,
		modal : true,
		url : url,
		title : '新增'
	});
}
// 格式化主题为超链接
function funcformatter(value, row, index) {
	if(row.PSTATEFLAG=='3'){
		return "<div class='demo-tip icon-control-pause'></div><span style='color:gray'>"+value+"</span>";
	}
	return value;
}
// 修改
function editDataTask() {
	var selectedArray = $(gridTask).datagrid('getSelections');
	if (selectedArray.length == 1) {
		openEditWindow(selectedArray[0].ID);
	} else {
		$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE_ONLY,
				'info');
	}
}
function openEditWindow(id) {
	var url = url_formActionTask + '?pageset.pageType=' + PAGETYPE.EDIT
			+ '&ids=' + id;
	$.farm.openWindow( {
		id : 'winTask',
		width : 600,
		height : 450,
		modal : true,
		url : url,
		title : '任务详情'
	});
}
// 删除
function delDataTask() {
	var selectedArray = $(gridTask).datagrid('getSelections');
	if (selectedArray.length > 0) {
		// 有数据执行操作
		var str = selectedArray.length + MESSAGE_PLAT.SUCCESS_DEL_NEXT_IS;
		$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
			if (flag) {
				$(gridTask).datagrid('loading');
				$.post(url_delActionTask + '?ids='
						+ $.farm.getCheckedIds(gridTask, 'ID'), {}, function(
						flag) {
					$(gridTask).datagrid('loaded');
					if (flag.pageset.commitType == 0) {
						$(gridTask).datagrid('reload');
					} else {
						var str = MESSAGE_PLAT.ERROR_SUBMIT
								+ flag.pageset.message;
						$.messager.alert(MESSAGE_PLAT.ERROR, str, 'error');
					}
				});
			}
		});
	} else {
		$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE, 'info');
	}
}
//当选择计划开始时间时触发
function selectPlanStart() {
	try {
		var vStart = $('#entity_planstarttime').datetimebox('getValue');
		var vEnd = $('#entity_plancomptime').datetimebox('getValue');
		if (vStart > vEnd&&(vEnd.length>12&&vStart.length>12)) {
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
		if (vStart > vEnd&&(vEnd.length>12&&vStart.length>12)) {
			$('#entity_planstarttime').datetimebox('setValue', vEnd);
		}
	} catch (e) {
	}
}
// 完成任务
function completeTask(taskId) {
	$.messager.confirm(MESSAGE_PLAT.PROMPT, "确定完成该任务？", function(flag) {
		if (flag) {
			$.post('admin/FarmPlanTaskCompleteCommit.do?ids=' + taskId, {},
					function(flag) {
						if (flag.pageset.commitType == 0) {
							taskCallback();
							$(gridTask).datagrid('reload');
							$.messager.confirm(MESSAGE_PLAT.PROMPT,
									"任务已经完成是否关闭本窗口？", function(flag) {
										if (flag) {
											$('#winTask').window('close');
										}else{
											$('#winTask').window('refresh');
										}
									});
						} else {
							var str = MESSAGE_PLAT.ERROR_SUBMIT
									+ flag.pageset.message;
							$.messager.alert(MESSAGE_PLAT.ERROR, str, 'error');
						}
					});
		}
	});
}
//添加备注
function addnote() {
	var url = 'admin/FarmPlanNoteShow.do?ids='+taskId+'&pageset.pageType=' + PAGETYPE.ADD;
	$.farm.openWindow( {
		id : 'winNote',
		width : 600,
		height : 200,
		modal : true,
		url : url,
		title : '新增描述'
	});
}
//编辑备注
function editnote() {
	var selectedArray = $(gridNote).datagrid('getSelections');
	if (selectedArray.length == 1) {
		var url = 'admin/FarmPlanNoteShow.do?pageset.pageType='
				+ PAGETYPE.EDIT + '&ids=' + selectedArray[0].ID;
		$.farm.openWindow( {
			id : 'winNote',
			width : 600,
			height : 200,
			modal : true,
			url : url,
			title : '修改描述'
		});
	} else {
		$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE_ONLY,
				'info');
	}
}
//删除备注
function delnote() {
	var selectedArray = $(gridNote).datagrid('getSelections');
	if (selectedArray.length > 0) {
		// 有数据执行操作
		var str = selectedArray.length + MESSAGE_PLAT.SUCCESS_DEL_NEXT_IS;
		$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
			if (flag) {
				$(gridNote).datagrid('loading');
				$.post('admin/FarmPlanNotedeleteCommit.do?ids=' + $.farm
						.getCheckedIds(gridNote, 'ID'), {}, function(flag) {
					$(gridNote).datagrid('loaded');
					if (flag.pageset.commitType == 0) {
						$(gridNote).datagrid('reload');
					} else {
						var str = MESSAGE_PLAT.ERROR_SUBMIT
								+ flag.pageset.message;
						$.messager.alert(MESSAGE_PLAT.ERROR, str, 'error');
					}
				});
			}
		});
	} else {
		$.messager.alert(MESSAGE_PLAT.PROMPT, "请选择一条任务描述!", 'info');
	}
}
function sendTask() {
	var selectedArray = $(gridTask).datagrid('getSelections');
	if (selectedArray.length >= 1) {
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
			$.messager.confirm(MESSAGE_PLAT.PROMPT, "是否将选择任务分配给该用户？",
					function(flag) {
						if (flag) {
							$.post('admin/FarmPlanTaskSendUser.do', {
								userId : row[0].ID,
								ids : $.farm.getCheckedIds(gridTask, 'ID')
							}, function(flag) {
								if (flag.pageset.commitType == 0) {
									$(gridTask).datagrid('reload');
									$('#chooseUserWin').window('close');
								} else {
									var str = MESSAGE_PLAT.ERROR_SUBMIT
											+ flag.pageset.message;
									$.messager.alert(MESSAGE_PLAT.ERROR,
											str, 'error');
								}
							});
						}
					});
		};
	} else {
		$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE,
				'info');
	}
}
function suspendTask() {
	var selectedArray = $(gridTask).datagrid('getSelections');
	if (selectedArray.length == 1) {
		// 有数据执行操作
		$.messager.confirm(MESSAGE_PLAT.PROMPT, "确定要挂起该任务吗？",
				function(flag) {
					if (flag) {
						$(gridTask).datagrid('loading');
						$.post("admin/FarmPlanTaskSuspend.do" + '?ids='
								+ $.farm.getCheckedIds(gridTask, 'ID'), {},
								function(flag) {
									$(gridTask).datagrid('loaded');
									if (flag.pageset.commitType == 0) {
										$(gridTask).datagrid('reload');
										$.messager.alert("成功", "该任务已经挂起","info");
									} else {
										var str = MESSAGE_PLAT.ERROR_SUBMIT
												+ flag.pageset.message;
										$.messager.alert(
												MESSAGE_PLAT.ERROR, str,
												'error');
									}
								});
					}
				});
	} else {
		$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE_ONLY,
				'info');
	}
}
function unSuspendTask() {
	var selectedArray = $(gridTask).datagrid('getSelections');
	if (selectedArray.length == 1) {
		// 有数据执行操作
		$(gridTask).datagrid('loading');
		$.post("admin/FarmPlanTaskUnSuspend.do" + '?ids='
				+ $.farm.getCheckedIds(gridTask, 'ID'), {}, function(flag) {
			$(gridTask).datagrid('loaded');
			if (flag.pageset.commitType == 0) {
				$(gridTask).datagrid('reload');
				$.messager.alert("成功", "该任务已被取消挂起","info");
			} else {
				var str = MESSAGE_PLAT.ERROR_SUBMIT + flag.pageset.message;
				$.messager.alert(MESSAGE_PLAT.ERROR, str, 'error');
			}
		});
	} else {
		$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE_ONLY,
				'info');
	}
}