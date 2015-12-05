<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- ID,TITLE,DOCDESCRIBE,AUTHOR,PUBTIME,TAGKEY ,IMGID,VISITNUM,PRAISEYES,PRAISENO,HOTNUM,TYPENAME -->
<div class="bs-docs-header">
	<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
	  <!-- Indicators -->
	  <ol class="carousel-indicators">
	    <c:set var="index" value="0" />
	    <c:forEach var="node" items="${result.resultList}" varStatus="status">
			<c:if test="${node.DISPLAY==1}">
				<c:if test="${index==0}">
					<li data-target="#carousel-example-generic" data-slide-to="${index}" class="active"></li>
				</c:if>
				<c:if test="${index!=0}">
					<li data-target="#carousel-example-generic" data-slide-to="${index}"></li>
				</c:if>
				<c:set var="index" value="${index+1}" />
			</c:if>
		</c:forEach>
	  </ol>		
	  <!-- Wrapper for slides -->
	  <div class="carousel-inner" role="listbox">
	    
	    <c:set var="index" value="0" />
	    <c:forEach var="node" items="${result.resultList}" varStatus="status">
			<c:if test="${node.DISPLAY==1}">
				<c:if test="${index==0}">
					<div class="item active" style="height:300px; background:url(${node.URL}); background-size:cover;">
				      <div class="carousel-caption">
				        ${node.TITLE}
				      </div>
				    </div>
				</c:if>
				<c:if test="${index!=0}">
					<div class="item" style="height:300px; background:url(${node.URL}); background-size:cover;">
				      <div class="carousel-caption">
				        ${node.TITLE}
				      </div>
				    </div>
				</c:if>
				<c:set var="index" value="${index+1}" />
			</c:if>
		</c:forEach>
	    
	  </div>
	
	  <!-- Controls -->
	  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
	    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	    <span class="sr-only">Previous</span>
	  </a>
	  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
	    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	    <span class="sr-only">Next</span>
	  </a>
	</div>
</div>