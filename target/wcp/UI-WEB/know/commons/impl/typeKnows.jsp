<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fun"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- ID,TITLE,DOCDESCRIBE,AUTHOR,PUBTIME,TAGKEY ,IMGID,VISITNUM,PRAISEYES,PRAISENO,HOTNUM,TYPENAME -->
<c:if test="${fun:length(result.resultList) > 0}">
	<jsp:include page="/UI-WEB/docgroup/commons/impl/docsMinNoPage.jsp"></jsp:include>
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
							<a href="javascript:typeBoxGoPage(${page})">${page} </a>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
</c:if>
<c:if test="${fun:length(result.resultList) <= 0}">
	<div class="row">
		<div class="col-xs-12">
			<div class="panel-body">
				<div class="text-center">
					<img class="img-thumbnail" src="WEB-FACE/img/style/logo.png"
						style="margin: 20px;" />
				</div>
			</div>
		</div>
	</div>
</c:if>