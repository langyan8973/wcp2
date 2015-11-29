<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- ID,TITLE,DOCDESCRIBE,AUTHOR,PUBTIME,TAGKEY ,IMGID,VISITNUM,PRAISEYES,PRAISENO,HOTNUM,TYPENAME -->
<div class="row mytitlebar">
	<div class="col-sm-12" style="margin-bottom: 8px;">
		<span style="color: #D9534F;"
			class="glyphicon glyphicon-fire wcp_columnTitle">常用</span>
	</div>
</div>
<div class="row">
	<div class="col-sm-6">
		<div class="list-group">
			<c:forEach items="${result.resultList}" varStatus="status" var="node">
				<c:if test="${status.index%2==0}">
					<a href="index/FPDocShow.htm?id=${node.ID}" class="list-group-item">
						<h4 class="list-group-item-heading" style="font-weight: bold;">
							<c:if test="${node.DOMTYPE=='3'}">
								<span style="color: #4B96BD;" class="glyphicon glyphicon-home"></span>
							</c:if>
							<c:if test="${node.DOMTYPE=='1'}">
								<span class="glyphicon glyphicon-file"></span>
							</c:if>
							<c:if test="${node.DOMTYPE=='5'}">
								<span style="color: #d9534f;" class="glyphicon glyphicon-download-alt"></span>
							</c:if>
							${node.TITLE}
							<span class="badge">${node.HOTNUM}</span>
						</h4>
						<p class="list-group-item-text" style="line-height: 30px;">
							<span class="label label-success typetagsearch"
								title="${node.TYPENAME}"
								style="font-weight: lighter; font-size: 12px; cursor: pointer;">分类:${node.TYPENAME}</span>
							<span class="label label-warning authortagsearch"
								title="${node.AUTHOR}"
								style="font-weight: lighter; font-size: 12px; cursor: pointer;">作者:${node.AUTHOR}</span>
						</p> </a>
				</c:if>
			</c:forEach>
		</div>
	</div>
	<div class="col-sm-6">
		<div class="list-group">
			<c:forEach items="${result.resultList}" varStatus="status" var="node">
				<c:if test="${status.index%2!=0}">
					<a href="index/FPDocShow.htm?id=${node.ID}" class="list-group-item">
						<h4 class="list-group-item-heading" style="font-weight: bold;">
							<c:if test="${node.DOMTYPE=='3'}">
								<span style="color: #4B96BD;" class="glyphicon glyphicon-home"></span>
							</c:if>
							<c:if test="${node.DOMTYPE=='1'}">
								<span class="glyphicon glyphicon-file"></span>
							</c:if>
							<c:if test="${node.DOMTYPE=='5'}">
								<span style="color: #d9534f;" class="glyphicon glyphicon-download-alt"></span>
							</c:if>
							${node.TITLE}
							<span class="badge">${node.HOTNUM}</span>
						</h4>
						<p class="list-group-item-text" style="line-height: 30px;">
							<span class="label label-success typetagsearch"
								title="${node.TYPENAME}"
								style="font-weight: lighter; font-size: 12px; cursor: pointer;">分类:${node.TYPENAME}</span>
							<span class="label label-warning authortagsearch"
								title="${node.AUTHOR}"
								style="font-weight: lighter; font-size: 12px; cursor: pointer;">作者:${node.AUTHOR}</span>
						</p> </a>
				</c:if>
			</c:forEach>
		</div>
	</div>
</div>