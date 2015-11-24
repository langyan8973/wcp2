<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fun"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<c:if test="${fun:length(result.resultList) > 0}">
	<div class="row" style="margin-top: 8px;">
		<div class="col-sm-12">
			<span class="glyphicon glyphicon-tree-conifer wcp_columnTitle"
				style="color: green;">我的小组动态<small>,共${result.totalSize}条</small>
			</span>
		</div>
	</div>
	<c:forEach items="${result.resultList}" var="node">
		<hr style="margin: 16px;" />
		<div class="row">
			<div class="col-xs-12 ">
				<div class="media">
					<a class="pull-left" style="max-width: 100px;"
						href="index/FPGroupInfo.htm?id=${node.GROUPID}"> <img
						class="media-object img-thumbnail"
						style="max-height: 70px; max-width: 300px;"
						src="${node.GROUPIMG }" alt="...">
					</a>
					<div class="media-body">
						<p class="media-heading" style="font-weight: bold;">
							<a href="index/FPDocShow.htm?id=${node.ID}">${node.TITLE} 
								<c:if test="${node.DOMTYPE=='3'}">
									<span style="color: #4B96BD;" class="glyphicon glyphicon-home"></span>
								</c:if>
								<c:if test="${node.DOMTYPE=='1'}">
									<span class="glyphicon glyphicon-file"></span>
								</c:if>
								<c:if test="${node.DOMTYPE=='5'}">
									<span style="color: #d9534f;" class="glyphicon glyphicon-download-alt"></span>
								</c:if>
							</a> &nbsp;
							<!-- <span class="label label-success typetagsearch"
							title="${node.TYPENAME}"
							style="font-weight: lighter; font-size: 12px; cursor: pointer; padding: 0px; padding-left: 4px; padding-right: 4px;">分类:${node.TYPENAME}</span> -->
							&nbsp; <span class="label label-warning authortagsearch"
								title="${node.AUTHOR}"
								style="font-weight: lighter; font-size: 12px; cursor: pointer; padding: 0px; padding-left: 4px; padding-right: 4px;">作者:${node.AUTHOR}</span>
							<span
								style="color: #008000; font-size: 12px; font-weight: lighter;">
								<PF:FormatTime date="${node.PUBTIME}"
									yyyyMMddHHmmss="yyyy-MM-dd  HH:mm" /> 发布<c:if
									test="${node.VISITNUM>0}">/访问量:${node.VISITNUM}</c:if>
							</span>
						</p>
						<p
							style="word-wrap: break-word; color: #717171; font-size: 12px; line-height: 20px;">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${node.DOCDESCRIBE}</p>

					</div>
				</div>
			</div>
		</div>
	</c:forEach>
	<c:if test="${result.endPage>1}">
		<div class="row">
			<div class="col-xs-12">
				<ul class="pagination pagination-sm"
					style="margin: 4px; padding: 0px;">
					<c:forEach var="page" begin="${result.startPage}"
						end="${result.endPage}" step="1">
						<c:if test="${page==result.currentPage}">
							<li class="active"><a>${page} </a></li>
						</c:if>
						<c:if test="${page!=result.currentPage}">
							<li><a href="javascript:LoadHomeMyGroupDiv(${page})">${page}
							</a></li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
	</c:if>
</c:if>