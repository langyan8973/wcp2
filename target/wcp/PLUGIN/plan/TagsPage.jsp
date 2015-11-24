<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--计划任务表单-->
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'center'"
		style="text-align: center; padding: 8px;">
		<c:if test="${pageset.message!=null }">
			<span style="color: red;">${pageset.message}</span>
		</c:if>
		<c:forEach items="${tags}" var="node">
			<a class="easyui-linkbutton tabButtonCla"
				data-options="iconCls:'${node.key}'">${node.value}</a>
		</c:forEach>
	</div>
</div>
<script type="text/javascript">
	$(function() {
		$('.tabButtonCla').bind('click', function() {
			if ($('#tag_ids').val()) {
				$('#tag_ids').val($('#tag_ids').val() + ',' + $(this).text());
			} else {
				$('#tag_ids').val($(this).text());
			}
			$('#winTag').window('close');
		});
	});
</script>