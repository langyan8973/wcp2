<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<base href="<PF:basePath/>">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="Cache-Control" content="no-store,must-revalidate">
<!-- black,bootstrap,default,gray,metro  -->
<link rel="stylesheet" type="text/css"
	href="WEB-FACE/model/easy_ui_1_3_6/themes/gray/easyui.css">
<link rel="stylesheet" type="text/css"
	href="WEB-FACE/model/easy_ui_1_3_6/themes/icon.css">
<script type="text/javascript" src="WEB-FACE/script/jquery-1.8.0.min.js"></script>
<script type="text/javascript"
	src="<PF:basePath/>PLUGIN/document/commons/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<PF:basePath/>PLUGIN/document/commons/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" type="text/css"
	href="PLUGIN/document/commons/base.css">
<script src="<PF:basePath/>PLUGIN/document/commons/jquery.platex.js"
	language="javascript" type="text/javascript"></script>
<script
	src="<PF:basePath/>PLUGIN/document/commons/jquery.platex.side.js"
	language="javascript" type="text/javascript"></script>
<script
	src="<PF:basePath/>PLUGIN/document/commons/jquery.validate.exp.js"
	language="javascript" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$.ajaxSetup( {
			cache : false
		});
	})
	var basePath = '<PF:basePath/>';
</script>

