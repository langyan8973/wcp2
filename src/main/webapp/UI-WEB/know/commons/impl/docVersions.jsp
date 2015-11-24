<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- ID,ETIME,CUSERNAME,DOCID,PCONTENT -->
<table class="table table-bordered table-hover" style="font-size: 12px;">
	<tr>
		<td>
			<b>修改日期</b>
		</td>
		<td>
			<b>修改人</b>
		</td>
		<td>
			<b>备注</b>
		</td>
	</tr>
	<tr>
		<td>
			<a href="index/FPDocShow.htm?id=${id}"> <PF:FormatTime
					date="${doc.etime}" yyyyMMddHHmmss="yyyy/MM/dd HH:mm:ss" /> </a>
		</td>
		<td>
			${doc.cusername}
		</td>
		<td>
			[当前]${doc.texts.pcontent}
		</td>
	</tr>
	<c:set var="isShowAllVersion" value="false"></c:set>
	<c:forEach items="${result.resultList}" var="node" varStatus="status">
		<c:if test="${status.index<=3}">
			<tr>
				<td>
					<a href="index/FPDocVersionShow.do?id=${node.ID}">${node.ETIME}</a>
				</td>
				<td>
					${node.CUSERNAME}
				</td>
				<td>
					${node.PCONTENT}
				</td>
			</tr>
		</c:if>
		<c:if test="${status.index>3}">
			<c:set var="isShowAllVersion" value="true"></c:set>
			<tr class="hideVersionTr" style="display: none;">
				<td>
					<a href="index/FPDocVersionShow.do?id=${node.ID}">${node.ETIME}</a>
				</td>
				<td>
					${node.CUSERNAME}
				</td>
				<td>
					${node.PCONTENT}
				</td>
			</tr>
		</c:if>
	</c:forEach>
	<c:if test="${isShowAllVersion}">
		<tr>
			<td colspan="3" style="text-align: center;">
				<button type="button" id="ShowAllVersionId"
					class="btn btn-primary btn-xs">
					显示全部${result.totalSize}条
				</button>
			</td>
		</tr>
	</c:if>
</table>
<script type="text/javascript">
	$(function() {
		$('#ShowAllVersionId').bind('click', function() {
			$('.hideVersionTr').show();
			$('#ShowAllVersionId').hide();
		});
	});
</script>
