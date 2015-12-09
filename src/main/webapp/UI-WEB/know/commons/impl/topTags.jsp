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
		<div class="panel-group" id="accordion" role="tablist">
			<c:set var="index" value="0" />
			<c:forEach items="${years}" varStatus="status" var="y">
				<div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="collapseListGroupHeading${y}">
				      <h4 class="panel-title">
				        <a class="" role="button" data-toggle="collapse" href="#collapseListGroup${y}" aria-expanded="false" aria-controls="collapseListGroup${y}"> 
				         	${y}
				        </a>
				      </h4>
				    </div>
				    <c:if test="${index==0}">
						<c:set var="cssname" value="in" />
					</c:if>
					<c:if test="${index!=0}">
						<c:set var="cssname" value="collapse" />
					</c:if>
				    <div id="collapseListGroup${y}" class="panel-collapse ${cssname}" role="tabpanel" aria-labelledby="collapseListGroupHeading${y}" aria-expanded="false"> 
				    	<ul class="list-group"> 
				    	    <c:forEach items="${yearWenhao[y]}" varStatus="status" var="node">
				    	    	<li class="list-group-item">
				    	    		<a href="index/FPNumber.htm?id=${node.WH}">
										<span class="glyphicon glyphicon-th-list"></span> ${node.TAGKEY} <b> (${node.DOCNUM})</b>
									</a>
				    	    	</li>
							</c:forEach>
				    	</ul> 
				    </div>	    
				</div>
				<c:set var="index" value="${index+1}" />
			</c:forEach>
		  
		</div>
	</div>
</div>