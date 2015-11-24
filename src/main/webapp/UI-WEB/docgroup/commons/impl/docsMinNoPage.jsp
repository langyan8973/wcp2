<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<style>
<!--
.table {
	table-layout: fixed
}

.title_li_docs {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap
}
-->
</style>
<div class="row" style="margin-top: 8px;">
	<div class="col-sm-12">
		<div class="table-responsive">
			<table class="table">
				<tr>
					<th width="55">标题</th>
					<th width="15">作者</th>
					<th width="15">评价/热度/留言</th>
					<th width="15">发布时间</th>
				</tr>
				<c:forEach items="${result.resultList}" varStatus="status"
					var="node">
					<tr>
						<td class="title_li_docs"><a href="index/FPDocShow.htm?id=${node.ID}">
								${node.TITLE}</a></td>
						<td>${node.AUTHOR}</td>
						<td>
							${node.EVALUATE}&nbsp;&nbsp;/&nbsp;&nbsp;${node.HOTNUM}&nbsp;&nbsp;/&nbsp;&nbsp;${node.ANSWERINGNUM}
						</td>
						<td><PF:FormatTime date="${node.PUBTIME}"
								yyyyMMddHHmmss="yyyy-MM-dd HH:mm" /></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>