<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- ID,TITLE,DOCDESCRIBE,AUTHOR,PUBTIME,TAGKEY ,IMGID,VISITNUM,PRAISEYES,PRAISENO,HOTNUM,TYPENAME -->
<div class="row">
	<div class="col-sm-12">
		<span style="color: #D9534F;"
			class="glyphicon glyphicon-fire wcp_columnTitle">常用</span>
	</div>
</div>
<div class="row" style="margin-top: 16px;">
	<div class="col-sm-12">
		<div class="list-group">
			<c:forEach items="${result.resultList}" varStatus="status" var="node">
				<a href="index/FPDocShow.htm?id=${node.ID}" class="list-group-item">
					<c:if test="${node.DOMTYPE=='3'}">
						<span style="color: #4B96BD;" class="glyphicon glyphicon-home"></span>
					</c:if> <c:if test="${node.DOMTYPE=='1'}">
						<span class="glyphicon glyphicon-file"></span>
					</c:if> <c:if test="${node.DOMTYPE=='5'}">
						<span style="color: #d9534f;"
							class="glyphicon glyphicon-download-alt"></span>
					</c:if> ${node.TITLE} <b> (${node.HOTNUM})</b> 
				</a>
			</c:forEach>
		</div>
	</div>
</div>