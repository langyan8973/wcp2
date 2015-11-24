<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div class="row" style="margin-top: 8px;">
	<div class="col-sm-12">
		<table class="table">
			<tr>
				<th>
					标题
				</th>
				<th>
					作者
				</th>
				<th>
					评价/热度/留言
				</th>
				<th>
					发布时间
				</th>
			</tr>
			<c:forEach items="${result.resultList}" varStatus="status" var="node">
				<tr>
					<td>
						<a href="index/FPDocShow.htm?id=${node.ID}"> ${node.TITLE}</a>
					</td>
					<td>
						${node.AUTHOR}
					</td>
					<td>
						${node.EVALUATE}&nbsp;&nbsp;/&nbsp;&nbsp;${node.HOTNUM}&nbsp;&nbsp;/&nbsp;&nbsp;${node.ANSWERINGNUM}
					</td>
					<td>
					<PF:FormatTime date="${node.PUBTIME}" yyyyMMddHHmmss="yyyy-MM-dd HH:mm"/>	
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<div class="row">
	<div class="col-xs-12">
		<ul class="pagination pagination-sm">
			<c:forEach var="page" begin="${result.startPage}"
				end="${result.endPage}" step="1">
				<c:if test="${page==result.currentPage}">
					<li class="active">
						<a>${page} </a>
					</li>
				</c:if>
				<c:if test="${page!=result.currentPage}">
					<li>
						<a href="javascript:loadDocs(${page})">${page} </a>
					</li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</div>
<script type="text/javascript">
	$(function() {
		//分类
		$('.typetagsearch').bind('click', function() {
			luceneSearch('TYPE:' + $(this).attr('title'));
		});
		//作者
		$('.authortagsearch').bind('click', function() {
			luceneSearch('AUTHOR:' + $(this).attr('title'));
		});
		//标签
		$('.tagsearch').bind('click', function() {
			luceneSearch('TYPE:' + $(this).attr('title'));
		});
	});
</script>