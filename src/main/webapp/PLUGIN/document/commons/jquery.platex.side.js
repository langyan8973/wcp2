/** 2013年04月17日 单表页面默认行为，本文件内的脚本希望被覆盖 王东*** */
var TOOL_BAR = [ {
	id : 'view',
	text : '查看',
	iconCls : 'icon-tip',
	handler : function() {
		shortMenuOpen_grid(null, {
			name : 'view'
		})
	}
}, {
	id : 'add',
	text : '增加',
	iconCls : 'icon-add',
	handler : function() {
		shortMenuOpen_grid(null, {
			name : 'add'
		})
	}
}, {
	id : 'edit',
	text : '修改',
	iconCls : 'icon-edit',
	handler : function() {
		shortMenuOpen_grid(null, {
			name : 'edit'
		})
	}
}, {
	id : 'del',
	text : '删除',
	iconCls : 'icon-remove',
	handler : function() {
		shortMenuOpen_grid(null, {
			name : 'del'
		})
	}
} ];

/**
 * 添加一个功能按钮到功能菜单序列中 相当于在TOOL_BAR中添加一个按钮 
 * 
 * @param id_
 *            功能的操作id即index,系统提供的默认功能有view,edit,del,add
 * @param text_
 *            按钮title
 * @param iconCls_
 *            图标
 * @param index_
 *            插入按钮的位置
 * @param isClear
 *            是否清空默认按钮
 * @return TOOL_BAR
 */
function TOOL_BAR_ADD(id_, text_, iconCls_, index_, isClear) {
	var obj = {
		id : id_,
		text : text_,
		iconCls : iconCls_,
		handler : function() {
			shortMenuOpen_grid(null, {
				name : id_
			})
		}
	};
	if (isClear) {
		TOOL_BAR.splice(0, TOOL_BAR.length);
	}
	TOOL_BAR.splice(index_, 0, obj);
	return TOOL_BAR;
}
// 
/**
 * 表格控件的按钮或菜单被点击
 * 
 * @param rowIndex
 *            点击的表格中的行号
 * @param menuItem
 *            当前操作的字符串标示，对象 有name参数
 * @return 
 */
function shortMenuOpen_grid(rowIndex, menuItem) {
	if (menuItem.name == 'view') {
		row_ViewAndEditFun(DOM_GRID_TABLE, rowIndex, DOM_WINDOW_DIV, function(
				selectedArray) {
			return url_formAction + '?pageset.pageType=0&ids='
					+ selectedArray[0].ID;
		}, title_window);
	}
	if (menuItem.name == 'edit') {
		row_ViewAndEditFun(DOM_GRID_TABLE, rowIndex, DOM_WINDOW_DIV, function(
				selectedArray) {
			return url_formAction + '?pageset.pageType=2&ids='
					+ selectedArray[0].ID;
		}, title_window);
	}
	if (menuItem.name == 'del') {
		delGridRow(rowIndex, url_delAction, DOM_GRID_TABLE);
	}
	if (menuItem.name == 'add') {
		openWindow(DOM_WINDOW_DIV,  windowDefaultSize.height,windowDefaultSize.width, true,
				url_formAction + '?pageset.pageType=1', title_window);
	}
	menuFunctionHandle(rowIndex, menuItem.name);
}
/**
 * 表格控件的按钮或菜单被点击，钩子方法
 * 
 * @param rowIndex
 *            点击的表格中的行号
 * @param opIndex
 *            当前操作的字符串标示
 * @return
 */
function menuFunctionHandle(rowIndex, opIndex) {
}
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
/**
 * 初始化layoutJSP页面脚本
 * 
 * @return
 */
function initLayout() {
	init_grid(DOM_PAGINATION_DIV, DOM_GRID_TABLE, url_searchAction,
			DOM_MENU_DIV, TOOL_BAR, false);
	init_pagination(DOM_PAGINATION_DIV, DOM_GRID_TABLE, DOM_SEARCH_FORM);
	$(LINK_SEARCH).bind('click', function() {
		do_search(DOM_SEARCH_FORM, DOM_GRID_TABLE, DOM_PAGINATION_DIV);
	});
	$(LINK_RESET).bind('click', function() {
		do_searchClear(DOM_SEARCH_FORM);
	});
}
/**
 * 初始化entityJSP页面脚本
 * 
 * @return
 */
function initEntity() {
	var submitForm = $(DOM_DATAFORM_FORM).SubmitForm( {
		pageType : currentPageType,
		gridId : DOM_GRID_TABLE,
		currentWindow : DOM_WINDOW_DIV
	});
	$(LINK_FORM_ADD).bind('click', function() {
		if (!isDisableClass(this)) {
			submitForm.postSubmit(submitAddAction, null);
		}
	});
	$(LINK_FORM_EDIT).bind('click', function() {
		if (!isDisableClass(this)) {
			submitForm.postSubmit(submitEditAction, null);
		}
	});
	$(LINK_FORM_CANCEL).bind('click', function() {
		if (!isDisableClass(this)) {
			cancel_fun(DOM_WINDOW_DIV);
		}
	});

}
/**
 * 初始化选择窗口的默认行为()
 * 
 * @param chooseButtonId
 *            选择按钮的id如#as
 * @param openWindowId
 *            弹出窗口的id
 * @param callback
 *            选中后的回调方法,返回False或不返回值就关闭窗口，返回true就保留窗口
 * @return
 */
function initChoose_Window_Default(chooseButtonId, openWindowId, callback) {
	$(chooseButtonId).bind('click', function() {
		chooseWindowCallBackHandle = function(row) {
			var isClose = callback(row);
			if (!isClose || isClose == false) {
				$(openWindowId).window('close');
			}
		};
		$(openWindowId).panel('open');
	});
}
/**
 * 设置默认查询条件
 * 
 * @param key
 *            键
 * @param value
 *            值
 */
function setQueryRule(gridId, key, value) {
	if (!$(gridId).data('DataQuery')) {
		$(gridId).data('DataQuery', {})
	}
	$(gridId).data('DataQuery')[key] = value;
}