var MESSAGE_PLAT = {
	PROMPT : '提示',
	CHOOSE_ONE : '请至少选择一条记录!',
	COMMIT_IS : '该操作将向服务器提交数据,确定继续吗?',
	SUCCESS_CLOSE_WINDOW : '操作已成功,是否关闭当前页面?',
	SUCCESS : '操作已成功',
	ERROR : '错误',
	ERROR_SUBMIT : '如有疑问请联系系统管理员:',
	ERROR_SUBMIT_NO_MESSAGE : '服务器响应错误,请联系系统管理员',
	SUCCESS_DEL_NEXT_IS : '条数据将被删除，是否继续?'
};
/*******************************************************************************
 * 查询条件封装方法
 * 
 ******************************************************************************/
(function($, document) {
	$.fn.searchForm = function(options) {
		var gridObj;// 参数:gridObj数据表格对象
		if (options && options.gridObj) {
			gridObj = options.gridObj;
		}
		var searchFormVar = this;
		/**
		 * 获得表单序列化this.arrayStr()
		 */
		this.arrayStr = function() {
			var formValueStr = "";
			var formVar = $(searchFormVar).serializeArray();
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
		// 执行查询功能
		this.dosearch = function(rules) {
			if (rules) {
				$(gridObj).datagrid('load', rules);
			} else {
				$(gridObj).datagrid('load', {});
			}
			return;
		}
		$('tr', searchFormVar).each(function(index, obj) {
			if (index % 2 != 0) {
				$(obj).css('background', '#f3f3e8');
			}
		})
		$('#a_search', searchFormVar).bind('click', function() {
			searchFormVar.dosearch( {
				'query.ruleText' : searchFormVar.arrayStr
			});
		});
		$('#a_reset', searchFormVar).bind('click', function() {
			searchFormVar.reSet()
		});
		return searchFormVar;
	};
})(jQuery, document);
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
		if (option.currentWindowId) {
			_currentWindow = option.currentWindowId;
		}
		// -----------
		if (option.messager) {
			messagerBox = option.messager;
		}
		if (option.debug) {
			debug = option.debug;
		}
		if (option.grid) {
			datagrid = option.grid;// 提交结果后需要刷新的数据表格
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
											$('#' + _currentWindow).window(
													'close');
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
		valueInit();
		// 刷新form表格行样式
		initEditTableStyle(form);
		return this;
	}
})(jQuery);
$.extend( {
	farm : {
		/**
		 * 获得数据表对象的多选id（逗号分隔的字符串）
		 * 
		 * @param grid
		 *            数据表格对象
		 * @return id的逗号分隔的字符串序列
		 * @demo $.farm.getCheckedIds(grid)
		 */
		getCheckedIds : function(grid) {
			var selectedArray = $(grid).datagrid('getSelections');
			var ids;
			$(selectedArray).each(function(index, obj) {
				if (index == 0) {
					ids = obj.ID;
				} else {
					ids = ids + ',' + obj.ID;
				}
			});
			return ids;
		},
		/**
		 * 打开一个ajax窗口
		 * 
		 * @param id
		 *            窗口控件的id如
		 * @param height
		 *            窗口高
		 * @param width
		 *            窗口宽
		 * @param modal
		 *            模态true 非模态false
		 * @param url
		 *            窗口将打开的远程代码地址
		 * @param title
		 *            窗口标题
		 * @demo $.farm.openWindow( { id : 'win', width : 600, height :300,
		 *       modal : true, url : url, title : '发送消息' });
		 */
		openWindow : function(options) {
			if (!$('#' + options.id) || $('#' + options.id).length <= 0) {
				$('<div id="' + options.id + '"></div>').appendTo('body');
			}
			$('#' + options.id).window( {
				width : options.width,
				height : options.height,
				title : options.title,
				modal : options.modal,
				minimizable : false,
				closed : true
			});
			$('#' + options.id).window('open');
			$('#' + options.id).window('refresh', options.url);
			return this;
		}
	}
});
/**
 * 初始化选择窗口的默认行为()
 * 在弹出窗口中执行chooseWindowCallBackHandle(selectedArray);方法就會调用回调用传入的回调方法方法options.callback(row)
 * 
 * @param id
 *            弹出窗口的id(直接写)
 * @param callback
 *            选中后的回调方法,返回False或不返回值就关闭窗口，返回true就保留窗口
 * @return options:options.width,options.height,options.modal,options.url,options.title
 */
var chooseWindowCallBackHandle;// 弹出选择框的回调方法,传送门，
(function($, document) {
	$.fn.bindChooseWindow = function(id, options) {
		$(this).bind('click', function() {
			chooseWindowCallBackHandle = function(row) {
				var isClose = options.callback(row);
				if (!isClose || isClose == false) {
					$("#" + id).window('close');
				}
			};
			$.farm.openWindow( {
				id : id,
				width : options.width,
				height : options.height,
				modal : options.modal,
				url : options.url,
				title : options.title
			});
		});
		return this;
	};
})(jQuery, document);
