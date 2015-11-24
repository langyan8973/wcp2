/** 2013年04月17日 王东 框架组件JS库*** */
/**
 * 用于控制grid表格的条件查询的相关方法
 */
//默认弹出窗口大小,可以在页面替换
var windowDefaultSize = {
	width : 600,
	height : 400
};
// var targetDomId;//当前弹出框对应的表单ID
var chooseWindowCallBackHandle;// 弹出选择框的回调方法
(function($, document) {
	$.fn.searchForm = function() {
		var searchFormVar = this;
		/**
		 * 获得表单序列化this.arrayStr()
		 */
		this.arrayStr = function() {
			var formValueStr = "";
			var formVar = $(this).serializeArray();
			$(formVar).each(
					function(index, value) {
						if (value.value != null && value.value != '') {
							formValueStr = formValueStr + value.name + ':'
									+ value.value + '_,_';
						}
					});
			if (formValueStr == "") {
				formValueStr = "RESET";
			}
			return formValueStr;
		}
		/**
		 * 重置查询表单this.reSet()
		 */
		this.reSet = function() {
			$("input[type='text']", searchFormVar).attr("value", "");
			$("input[type='hidden']", searchFormVar).attr("value", "");
			$("select", searchFormVar).each(function(i, o) {
				$("option", o).each(function(i, o) {
					if (i == 0) {
						$(o).attr("selected", true);
					}
				});
			});
			return;
		}
		return searchFormVar;
	};
})(jQuery, document);
/**
 * 初始化分页组件 init_pagination('#dom_pp', '#dom_dg','#dom_search_form');
 * 
 * @author macpluss
 * @param paginationId
 *            分页框id '#dom_pp'
 * @param gridId
 *            数据gridid '#dom_dg'
 * @param searchFormId
 *            查询formid '#dom_search_form'
 */
function init_pagination(paginationId, gridId, searchFormId) {
	// 设置当前页
	$(paginationId).pagination( {
		onSelectPage : function(pageNumber, pageSize) {
			var str;
			if (searchFormId) {
				str = $(searchFormId).searchForm().arrayStr();
			} else {
				str = '';
			}
			if (!$(gridId).data('DataQuery')) {
				$(gridId).data('DataQuery', {})
			}
			$(gridId).data('DataQuery')['query.ruleText'] = str;
			$(gridId).data('DataQuery')['query.pagesize'] = pageSize;
			$(gridId).data('DataQuery')['query.currentPage'] = pageNumber;
			$(gridId).datagrid('load', $(gridId).data('DataQuery'));
		}
	});
}
/**
 * 清除查询条件do_searchClear('#dom_search_form');
 * 
 * @author macpluss
 * @param searchFormId
 *            查询条件formid
 */
function do_searchClear(searchFormId) {
	$(searchFormId).searchForm().reSet();
}
/**
 * 初始化表格数据 init_grid('#dom_pp', '#dom_dg', url_searchAction);
 * 
 * @author macpluss
 * @param gridId
 *            数据gridid '#dom_dg'
 * @param paginationId
 *            分页框id '#dom_pp'
 * @param urlQuery
 *            查询数据的URL
 * @param shortMenuDivId
 *            快捷菜单DIV的id
 * @param menubarObj
 *            菜单栏的菜单对象
 * @param chooseOne
 *            true/false 是否只能选择单行
 */
function init_grid(paginationId, gridId, urlQuery, shortMenuDivId, menubarObj,
		chooseOne) {
	// 加载表格数据
	if (!$(gridId).data('DataQuery')) {
		$(gridId).data('DataQuery', {})
	}
	if (!chooseOne) {
		chooseOne = false;
	}
	$(gridId).datagrid(
			{
				url : urlQuery,
				closable : true,
				singleSelect : chooseOne,
				checkOnSelect : true,
				striped : true,
				rownumbers : true,
				fitColumns : true,
				'toolbar' : menubarObj,
				queryParams : $(gridId).data('DataQuery'),
				loadFilter : function(data) {
					try {
						if (data.result.message) {
							$.messager.alert(MESSAGE_PLAT.ERROR,
									data.result.message, 'error');
						}
						var data_ = {
							"rows" : data.result.resultList,
							"total" : data.result.totalSize
						}
						$(paginationId).pagination( {
							total : data.result.totalSize,
							pageNumber : data.result.currentPage
						});
					} catch (e) {
						$.messager.alert(MESSAGE_PLAT.ERROR,
								MESSAGE_PLAT.ERROR_SUBMIT_NO_MESSAGE + e,
								'error');
						return {
							"rows" : [],
							"total" : 0
						};
					}
					return data_;
				},
				onDblClickRow : function(rowIndex, rowData) {
					$(gridId).datagrid('unselectAll');
					$(gridId).datagrid('selectRow', rowIndex);
				},
				onLoadError : function(none) {
					$.messager.alert(MESSAGE_PLAT.ERROR,
							MESSAGE_PLAT.ERROR_SUBMIT_NO_MESSAGE, 'error');
				},
				onRowContextMenu : function(e, rowIndex, rowData) {
					e.preventDefault();
					if (shortMenuDivId) {
						$(shortMenuDivId).menu( {
							onClick : function(item) {
								try {
									shortMenuOpen_grid(rowIndex, item);
								} catch (e) {
									alert('请检查shortMenuOpen_grid方法');
								}
							}
						});
						$(shortMenuDivId).menu('show', {
							left : e.pageX,
							top : e.pageY
						});
					}
				}
			});

}
/**
 * 执行查询条件
 * 
 * @author macpluss
 * @param searchFormId
 *            查询formid '#dom_search_form'
 * @param gridId
 *            数据gridid '#dom_dg'
 * @param paginationId
 *            分页框id '#dom_pp'
 */
function do_search(searchFormId, gridId, paginationId) {
	var str = $(searchFormId).searchForm().arrayStr();
	if (!$(gridId).data('DataQuery')) {
		$(gridId).data('DataQuery', {})
	}
	$(gridId).data('DataQuery')['query.ruleText'] = str;
	$(gridId).data('DataQuery')['query.currentPage'] = 1;
	$(gridId).data('DataQuery')['query.pagesize'] = $(paginationId).pagination(
			'options').pageSize;
	$(gridId).datagrid( {
		queryParams : $(gridId).data('DataQuery')
	});
}
/**
 * 关闭窗口
 * 
 * @author macpluss
 * @windowsId cancel_fun('#win')
 */
function cancel_fun(windowsId) {
	$(windowsId).window('close');
}
/**
 * 初始化表单样式（行背景色变换）
 * 
 * @author macpluss
 * @tableId initEditTableStyle('.editTable');
 */
function initEditTableStyle(tableId) {
	$('tr', tableId).each(function(index, obj) {
		if (index % 2 == 0) {
			$(obj).css('background', '#f3f3e8');
		}
	})
}
/**
 * 打开一个ajax窗口
 * 
 * @author macpluss
 * @param divId
 *            窗口控件的id如#window
 * @param heightSize
 *            窗口高
 * @param widthSize
 *            窗口宽
 * @param modalType
 *            模态true 非模态false
 * @param url
 *            窗口将打开的远程代码地址
 * @param windowtitle
 *            窗口标题
 */
function openWindow(divId, heightSize, widthSize, modalType, url, windowTitle) {
	$(divId).window( {
		width : widthSize,
		height : heightSize,
		title : windowTitle,
		modal : modalType,
		minimizable : false,
		closed : true
	});
	$(divId).window('open');
	$(divId).window('refresh', url);
}

/**
 * 在弹出框中查看&修改数据的通用方法(grid)
 * 
 * @author macpluss
 * @param gridId
 *            表格控件的id如#gridId
 * @param rowIndex
 *            表格中行的索引 没有就传入空，为空时自动获取表中已选记录
 * @param windowsId
 *            窗口控件的id如#window
 * @param urlHandel(selectedArray)
 *            用于填入URL的回调函数selectedArray行对象数组，返回值为URL 如：return
 *            'admin/ALONEACTION_VIEW_SUBMIT.do?pageset.pageType=0&ids='
 *            +selectedArray[0].ID;
 * @param windowtitle
 *            窗口标题
 */
function row_ViewAndEditFun(gridId, rowIndex, windowsId, urlHandel, windowTitle) {
	var selectedArray;
	if (rowIndex != null) {
		selectedArray = [ $(gridId).datagrid('getRows')[rowIndex] ];
	} else {
		selectedArray = $(gridId).datagrid('getSelections');
	}
	if (selectedArray.length > 0) {
		var url = urlHandel(selectedArray);
		openWindow(windowsId, windowDefaultSize.height, windowDefaultSize.width, true, url, windowTitle);
	} else {
		$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE, 'info');
	}
}
/**
 * 在弹出框中查看&修改数据的通用方法(id)
 * 
 * @author macpluss
 * @param id
 *            业务主键
 * @param windowsId
 *            窗口控件的id如#window
 * @param urlHandel(selectedArray)
 *            用于填入URL的回调函数selectedArray行对象数组，返回值为URL 如：return
 *            'admin/ALONEACTION_VIEW_SUBMIT.do?pageset.pageType=0&ids='
 *            +selectedArray[0].ID;
 * @param windowtitle
 *            窗口标题
 */
function ID_ViewAndEditFun(dataId, windowsId, urlHandel, windowTitle) {
	var url = urlHandel(dataId);
	openWindow(windowsId, 400, 600, true, url, windowTitle);
}
/**
 * 对表格中选中行的迭代器
 * 
 * @author macpluss
 * @param gridId
 *            表格控件的id如#gridId
 * @param funcHandle(obj)
 *            表格控件中被选中行的处理回调函数obj为行对象，无返回值
 */
function iteratorGridRow(gridId, funcHandle) {
	var selectedArray = $(gridId).datagrid('getSelections');
	$(selectedArray).each(function(index, obj) {
		funcHandle(obj);
	});
}
/**
 * 获得表格被选中的ID的字符串，多个间用逗号分隔
 * 
 * @author macpluss
 * @param gridId
 *            表格控件的id如#gridId
 */
function getGridCheckedIds(gridId) {
	var selectedArray = $(gridId).datagrid('getSelections');
	var ids;
	$(selectedArray).each(function(index, obj) {
		if (index == 0) {
			ids = obj.ID;
		} else {
			ids = ids + ',' + obj.ID;
		}
	});
	return ids;
}
/**
 * 操作表单ajax提交时，和初始化的相关操作
 */
(function($, document) {
	$.fn.SubmitForm = function(option) {
		var form = this;// formId
		var debug = false;// 调试模式不提交
		var _pageType = option.pageType;// 当前页面状态位
		var _viewType = 0;// 浏览状态位
		var messagerBox = null;
		var comiitHandleFun = null;// 自定义提交结束后执行的脚本
		var datagrid = null;
		var _currentWindow = null;
		if (option.currentWindow) {
			_currentWindow = option.currentWindow;
		}
		// -----------
		if (option.messager) {
			messagerBox = option.messager;
		}
		if (option.debug) {
			debug = option.debug;
		}
		if (option.gridId) {
			datagrid = option.gridId;// 提交结果后需要刷新的数据表格
		}
		if (option.comiitHandle) {
			comiitHandleFun = option.comiitHandle;
		}
		/**
		 * 获得Struts格式的URLthis.StrutsUrl()
		 */
		this.StrutsUrl = function() {
			var formObj = $(form).serialize();
			var parmArray = formObj.split("&");
			var parmStringNew = "";
			$.each(parmArray, function(index, data) {
				var li_pos = data.indexOf("=");
				if (li_pos > 0) {
					var name = data.substring(0, li_pos);
					var value = decodeURIComponent(data.substr(li_pos + 1));
					var parm = name + "=" + value;
					parmStringNew = parmStringNew == "" ? parm : parmStringNew
							+ '&' + parm;
				}
			});
			return '' + parmStringNew;
		}
		this.reSet = function() {
			$("input[type='text']", form).attr("value", "");
			$("select", form).each(function(i, o) {
				$("option", o).each(function(i, o) {
					if (i == 0) {
						$(o).attr("selected", true);
					}
				});
			});
			$("textarea", form).text('');
			return;
		}
		/**
		 * 获得对象格式的参数this.StrutsPara()
		 */
		this.StrutsPara = function() {
			var parmArray = $(form).serializeArray();
			var parmStringNew = {};
			$.each(parmArray, function(index, data) {
				var name = data.name;
				var value = data.value;
				parmStringNew[name] = value;
			});
			return parmStringNew;
		}
		/**
		 * 验证表单this.validate()
		 */
		this.validate = function() {
			return $(form).form('validate');
		}
		/**
		 * 不知道做什么的(忘了)
		 */
		this.submitReset = function() {
			$('.button', form).show();
			$('span', 'th', form).remove();
		}
		/**
		 * 请求提交表单this.postSubmit(url,function(flag){//flag代表返回值 return
		 * true显示提交成功框})
		 */
		this.postSubmit = function(url, func) {
			$(':text', form).each(function(index, value) {
				$(value).val($.trim($(value).val()));
			});
			// 验证表单
			if (form.validate()) {
				$.messager.confirm(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.COMMIT_IS,
						function(r) {
							if (r) {
								submit_do(url, func);
							}
						});
			}
			return;
		}

		/**
		 * 执行提交表单 被this.postSubmit调用参数参照该方法
		 */
		function submit_do(url, func) {
			$('a', '.div_button', form).each(function(index, obj) {
				$(obj).linkbutton('disable');
			});
			// post提交
			if (comiitHandleFun) {
				jQuery.post(url, form.StrutsPara(), comiitHandleFun);
			} else {
				jQuery.post(url,
						form.StrutsPara(),
						function(flag) {
							if (flag.pageset.commitType == '0') {
								// 刷新表单
						if (datagrid) {
							$(datagrid).datagrid('reload');
						}
						var isSuccess = true;
						if (func) {
							isSuccess = func(flag);
						}
						if (_currentWindow) {
							$.messager.confirm(MESSAGE_PLAT.PROMPT,
									MESSAGE_PLAT.SUCCESS_CLOSE_WINDOW,
									function(r) {
										if (r) {
											cancel_fun(_currentWindow);
										}
									});
						} else {
							$.messager.alert(MESSAGE_PLAT.PROMPT,
									MESSAGE_PLAT.SUCCESS, 'info');
						}
					} else {
						var str = MESSAGE_PLAT.ERROR_SUBMIT
								+ flag.pageset.message;
						$.messager.alert(MESSAGE_PLAT.ERROR, str, 'error');
					}
					if (flag.pageset.commitType == '1') {
						if (messagerBox) {
							messagerBox.alert(flag.pageset.message);
						}
					}
					$('a', '.div_button', form).each(function(index, obj) {
						$(obj).linkbutton('enable');
					});
				}).error(
						function() {
							$.messager.alert(MESSAGE_PLAT.ERROR,
									MESSAGE_PLAT.ERROR_SUBMIT_NO_MESSAGE,
									'error');
							$('a', '.div_button', form).each(
									function(index, obj) {
										$(obj).linkbutton('enable');
									});
						});
			}

		}
		/**
		 * 初始化为表单赋值
		 */
		function valueInit() {
			// 为下拉框赋值
			$('select', form).each(function(index, value) {
				$('option', value).each(function(index, val) {
					if ($(val).attr('value') == $(value).attr('val')) {
						$(val).attr('selected', true);
						$(value).attr('title', $(val).text());
					}
				});
			});
			if (_pageType == _viewType) {
				$('select', form).each(function(index, value) {
					var valueStr = $(value).attr('title')
					if (!valueStr) {
						valueStr = '';
					}
					$(value).after('<span>' + valueStr + '</span>');
					$(value).remove();
				});
				$(':text', form).each(
						function(index, value) {
							$(value).after(
									'<div style="white-space: normal;">' + $(
											value).attr('value') + '</div>');
							$(value).remove();
						});
				$('textarea', form).each(
						function(index, value) {
							$(value).after(
									'<div style="white-space: normal;">' + $(
											value).text() + '</div>');
							$(value).remove();
						});
				$('label', form).each(function(index, value) {
					$(value).after('<span>' + $(value).html() + '</span>');
					$(value).remove();
				});
			}
		}
		valueInit();
		// 刷新form表格行样式
		initEditTableStyle(form);
		return this;
	}
})(jQuery);
/**
 * 用于判断超链接按钮是否被禁用,class属性中是否包含disabled isDisableClass('#form_a_add')
 * 
 * @param comId
 *            超链接的ID 如 #a_button
 * @return
 */
function isDisableClass(comId) {
	return $(comId).attr('class').indexOf('disabled') >= 0;
}

/**
 * ajax调用删除grid中的记录的通用方法
 * 
 * @param rowIndex
 *            当前操作行在grid中的序号，可以为空，为空时自动获取表中已选记录
 * @param URL删除逻辑的网络地址
 * @param gridId
 *            表格id如#gridid
 * @return
 */
function delGridRow(rowIndex, URL, gridId) {
	var selectedArray;
	var ids_str;
	if (rowIndex != null) {
		selectedArray = [ $(gridId).datagrid('getRows')[rowIndex] ];
		ids_str = selectedArray[0].ID;
	} else {
		selectedArray = $(gridId).datagrid('getSelections');
		ids_str = getGridCheckedIds(gridId);
	}
	if (selectedArray.length > 0) {
		// 有数据执行操作
		var str = selectedArray.length + MESSAGE_PLAT.SUCCESS_DEL_NEXT_IS;
		$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
			if (flag) {
				$(gridId).datagrid('loading');
				$.post(URL + '?ids=' + ids_str, {}, function(flag) {
					$(gridId).datagrid('loaded');
					$(gridId).datagrid('reload');
					if (flag.pageset.commitType == 0) {
						// $.messager.alert('成功', '操作完成!', 'info');
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
/**
 * 数据表格点击工具按钮或快捷菜单时执行的方法
 * 
 * @param rowIndex
 *            右键点击快捷菜单时点击的行号
 * @param menuItem
 *            菜单项的相关属性如：menuItem.name
 * @return
 */
function shortMenuOpen_grid(rowIndex, menuItem) {
	alert('请实现方法shortMenuOpen_grid("' + rowIndex + '", "menuItem:' + menuItem
			+ '")');
}

/**
 * 需要选中表格行后执行的操作
 * 
 * @param rowIndex
 *            行索引数 为空时从表格取选中行
 * @param gridId
 *            表格id如#asd
 * @param isAlert
 *            是否要求用户确认操作
 * @param funchandle
 *            执行的方法
 * @return
 */
function operateHandleForGrid(rowIndex, gridId, isAlert, funchandle) {
	var selectedArray;
	if (rowIndex != null) {
		selectedArray = [ $(gridId).datagrid('getRows')[rowIndex] ];
	} else {
		selectedArray = $(gridId).datagrid('getSelections');
	}
	if (selectedArray.length > 0) {
		// 有数据执行操作
		var str = MESSAGE_PLAT.COMMIT_IS;
		if (isAlert) {
			$.messager.confirm(MESSAGE_PLAT.PROMPT, str, function(flag) {
				if (flag) {
					funchandle(selectedArray);
				}
			});
		} else {
			funchandle(selectedArray);
		}
	} else {
		$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE, 'info');
	}
}
/**
 * 获得tree的选中节点（含实心节点，就是属于半选中状态的）
 * 
 * @param treeID
 *            页面标签的id如#tree
 * @return
 */
function getCheckTreeNodeArray(treeID) {
	var nodes1 = $(treeID).tree('getChecked');
	var nodes2 = [];
	$(treeID).find('.tree-checkbox2').each(function() {
		var node = $(this).parent();
		nodes2.push($.extend( {}, $.data(node[0], 'tree-node'), {
			target : node[0],
			checked : node.find('.tree-checkbox').hasClass('tree-checkbox2')
		}));
	});
	nodes1 = nodes1.concat(nodes2);
	return nodes1;
}

/**
 * 在框架中打开一个标签用URL地址
 * 
 * @param uri
 *            页面地址如：http://www.baidu.com
 * @param id
 *            唯一标识
 * @param title
 *            中文标题
 * @return
 */
function openUrlSheet(uri, id, title) {
	window.parent.openUrlAtIfram(uri, id, title, true);
}
/**
 * 在框架中打开一个标签用struts的action的name
 * 
 * @param uri
 *            struts中配置的action的Name如；EkpKnowCore_ACTION_CONSOLE
 * @param id
 *            唯一标识
 * @param title
 *            中文标题
 * @return
 */
function openStrutsSheet(uri, id, title) {
	window.parent.openUrlAtIfram(uri, id, title, false);
}