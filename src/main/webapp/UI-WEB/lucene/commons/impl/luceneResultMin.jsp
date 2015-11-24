<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div class="row">
	<div class="col-sm-12" style="margin-bottom: 8px;">
		<h4>
			<span style="color: #D9534F; font-weight: bold;"
				class="glyphicon glyphicon-tag">相关知识</span>
		</h4>
	</div>
</div>
<div class="row">
<!-- // TITLE,PUBTIME,VISITNUM,TYPENAME,AUTHOR,TAGKEY,DOCDESCRIBE,TEXT -->
	<div class="col-sm-12">
		<ol class="breadcrumb">
			<c:forEach items="${result.resultList}" var="node">
				<li>
					<a href="index/FPDocShow.htm?id=${node.ID}">${node.TITLE}</a>
				</li>
			</c:forEach>
		</ol>
	</div>
</div>
