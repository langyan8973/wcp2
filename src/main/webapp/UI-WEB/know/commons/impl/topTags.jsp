<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- ID,TITLE,DOCDESCRIBE,AUTHOR,PUBTIME,TAGKEY ,IMGID,VISITNUM,PRAISEYES,PRAISENO,HOTNUM,TYPENAME -->
<div class="row" style="margin-right: -13px;">
	<div class="col-sm-12 mytitlebar">
		<!-- #D9534F -->
		<span style="color: #FFFFFF;" class="glyphicon glyphicon-fire wcp_columnTitle">发文号</span>
	</div>
</div>
<div class="row" style="margin-top: 4px;">
	<div class="col-sm-12">
		<div class="list-group">
			<c:forEach items="${result.resultList}" varStatus="status" var="node">
				<a href="index/FPDocShow.htm?id=${node.TAGKEY}" class="list-group-item">
					<span class="glyphicon glyphicon-th-list"></span> ${node.TAGKEY} <b> (${node.DOCNUM})</b>
				</a>
			</c:forEach>
		</div>
	</div>
</div>