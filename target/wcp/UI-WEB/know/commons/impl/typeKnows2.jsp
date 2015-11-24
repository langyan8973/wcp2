<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--简单用于知识展示中的便捷链接 ID,TITLE,DOCDESCRIBE,AUTHOR,PUBTIME,TAGKEY ,IMGID,VISITNUM,PRAISEYES,PRAISENO,HOTNUM,TYPENAME -->
<div class="row">
	<div class="col-sm-12" style="margin-bottom: 8px;">
			<span style="color: #D9534F;"
				class="glyphicon glyphicon-tag wcp_columnTitle">分类:${doctype.name}</span>
			<a href="index/FPtype.htm?id=${typeid}">进入分类</a>
		<hr />
	</div>
</div>
<div class="row">
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