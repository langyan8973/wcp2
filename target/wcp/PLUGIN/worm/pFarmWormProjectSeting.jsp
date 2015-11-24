<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--下载项目-->
<div id="tabsbox" class="easyui-tabs"
	style="width: 500px; height: 250px;">
	<div title="项目信息"
		data-options="href:'index/FarmWormProjectshow.do?pageset.pageType=${pageset.pageType}&ids=${ids}'">
	</div>
	<div title="URL过滤器配置"
		data-options="href:'index/FarmWormUrlfilter_ACTION_ALERT.do?pageset.pageType=${pageset.pageType}&proid=${ids}'">
	</div>
	<div title="文档解析配置"
		data-options="href:'index/FarmWormAttrparse_ACTION_ALERT.do?pageset.pageType=${pageset.pageType}&proid=${ids}'">
	</div>
	<div title="当前任务"
		data-options="href:'index/FarmWormTask_ACTION_ALERT.do?pageset.pageType=${pageset.pageType}&proid=${ids}'">
	</div>
</div>
<script type="text/javascript">
	$(function() {
		$('#tabsbox').tabs( {
			border : false,
			fit : true
		});
	});
</script>