<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div class="row">
	<div class="col-xs-12">
		<ul class="pagination pagination-sm">
			<c:forEach var="page" begin="${result.startPage}"
				end="${result.endPage}" step="1">
				<c:if test="${page==result.currentPage}">
					<li class="active"><a>${page} </a></li>
				</c:if>
				<c:if test="${page!=result.currentPage}">
					<li><a href="javascript:loadDocs(${page})">${page} </a></li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</div>
<c:forEach items="${result.resultList}" var="node">
	<div class="row">
		<div class="col-xs-12 ">
			<!-- img src="<PF:basePath/>WEB-FACE/img/style/photo.png"
				class="pull-left"
				style="height: 50px; border: 1px solid #DDDDDD; padding: 2px;" / -->
			<div style="margin-left: 4px;" class="pull-left">
				<h4 style="font-weight: bold;">
					<a style="color: #333333;" href="index/FPDocShow.htm?id=${node.ID}">${node.TITLE}</a>
					<c:if test="${node.DOMTYPE=='3'}">
						<span style="color: #4B96BD;" class="glyphicon glyphicon-home"></span>
					</c:if>
					<c:if test="${node.DOMTYPE=='1'}">
						<span class="glyphicon glyphicon-file"></span>
					</c:if>
					<c:if test="${node.DOMTYPE=='5'}">
						<span style="color: #d9534f;"class="glyphicon glyphicon-download-alt"></span>
					</c:if>
				</h4>
				<span style="color: #008000; font-size: 12px; font-weight: lighter;">${node.PUBTIME}发布<c:if
						test="${node.VISITNUM>0}">/访问量:${node.VISITNUM}</c:if>
				</span>
				<p>
					<span class="label label-success typetagsearch"
						title="${node.TYPENAME}"
						style="font-weight: lighter; font-size: 12px; cursor: pointer;">分类:${node.TYPENAME}</span>
					<span class="label label-warning authortagsearch"
						title="${node.AUTHOR}"
						style="font-weight: lighter; font-size: 12px; cursor: pointer;">作者:${node.AUTHOR}</span>
					<c:forEach items="${node.TAGKEY}" var="tag">
						<span class="label label-info tagsearch" title="${tag}"
							style="font-weight: lighter; font-size: 12px; cursor: pointer;">${tag}</span>
					</c:forEach>
				</p>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-xs-12">
			<p style="word-wrap: break-word; color: #333333;">
				${node.DOCDESCRIBE}&nbsp;</p>
		</div>
	</div>
	<hr />
</c:forEach>
<div class="row">
	<div class="col-xs-12">
		<ul class="pagination pagination-sm">
			<c:forEach var="page" begin="${result.startPage}"
				end="${result.endPage}" step="1">
				<c:if test="${page==result.currentPage}">
					<li class="active"><a>${page} </a></li>
				</c:if>
				<c:if test="${page!=result.currentPage}">
					<li><a href="javascript:loadDocs(${page})">${page} </a></li>
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