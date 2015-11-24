<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--选择组件-->
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north',border:false">
		<form id="dom_chooseSearchChoosecomponent">
			<table class="editTable">
				<tr>
					<td class="title">
						组件名称
					</td>
					<td>
						 <input name="TITLE:like" type="text">
					</td>
					<td class="title">
						<a id="a_search" href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-search">查询</a>
					</td>
					<td>
						<a id="a_reset" href="javascript:void(0)"
							class="easyui-linkbutton" iconCls="icon-reload">清除条件</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table class="easyui-datagrid" id="dom_chooseGridChoosecomponent">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="TITLE" data-options="sortable:true" width="80">
						组件名称
					</th>
					<th field="URL" data-options="sortable:true" width="80">
						URL
					</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<script type="text/javascript">
	var chooseGridChoosecomponent;
	var chooseSearchfarmChoosecomponent;
	var toolbar_chooseChoosecomponent = [ {
		text : '选择',
		iconCls : 'icon-ok',
		handler : function() {
			var selectedArray = $('#dom_chooseGridChoosecomponent').datagrid(
					'getSelections');
			if (selectedArray.length > 0) {
				chooseWindowCallBackHandle(selectedArray);
			} else {
				$.messager.alert(MESSAGE_PLAT.PROMPT, MESSAGE_PLAT.CHOOSE_ONE,
						'info');
			}
		}
	} ];
	$(function() {
		chooseGridChoosecomponent = $('#dom_chooseGridChoosecomponent')
				.datagrid( {
					url : 'admin/ChoosecomponentChooseQuery.do',
					fit : true,
					'toolbar' : toolbar_chooseChoosecomponent,
					pagination : true,
					closable : true,
					checkOnSelect : true,
					striped : true,
					rownumbers : true,
					ctrlSelect : true,
					fitColumns : true
				});
		chooseSearchfarmChoosecomponent = $('#dom_chooseSearchChoosecomponent')
				.searchForm( {
					gridObj : chooseGridChoosecomponent
				});
	});
	//-->
</script>







<!--1.在调用JSP页面，中粘贴下面js中的一段（绑定到按钮事件，或通过方法打开窗口） 
//---------------------------使用下面的（绑定到按钮事件）----------------------------------------------------- 
<a id="buttonChoosecomponentChoose" href="javascript:void(0)" class="easyui-linkbutton" style="color: #000000;">选择</a>
<script type="text/javascript">
  $(function() {
    $('#buttonChoosecomponentChoose').bindChooseWindow('chooseChoosecomponentWin', {
      width : 600,
      height : 300,
      modal : true,
      url : 'admin/ChoosecomponentChooseGridPage.do',
      title : '选择组件',
      callback : function(rows) {
        //$('#NAME_like').val(rows[0].NAME);
      }
    });
  });
</script>
//----------------------或----使用下面的（窗口中打开）----------------------------------------------------- 
chooseWindowCallBackHandle = function(row) {
    $("#chooseChoosecomponentWin").window('close');  
};
$.farm.openWindow( {
  id : 'chooseChoosecomponentWin',
  width : 600,
  height : 300,
  modal : true,
  url : 'admin/ChoosecomponentChooseGridPage.do',
  title : '选择组件'
});
 -->





<!--2.StrutsXml 粘贴到struts的xml中
struts-default加载选择组件页面
    <action name="ChoosecomponentChooseGridPage">
      <result>/PLUGIN/code/ChoosecomponentChooseGridWin.jsp</result>
    </action>
json-default选择组件查询 
    <action name="ChoosecomponentChooseQuery" method="queryall"
      class="*********************">
      <result type="json">
        <param name="root">jsonResult</param>
      </result>
    </action>
 -->





<!--3.粘贴到Action中的java方法
/**
 * 选择组件查询
 * 
 * @return
 */
public String queryall() {
  try {
    query = EasyUiUtils.formatGridQuery(getRequest(), query);
    //DataResult result = **************************;
    jsonResult = EasyUiUtils.formatGridData(result);
  } catch (Exception e) {
    throw new RuntimeException(e);
  }
  return SUCCESS;
}

-->