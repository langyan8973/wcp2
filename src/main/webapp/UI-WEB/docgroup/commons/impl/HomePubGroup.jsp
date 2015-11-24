<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%@ taglib uri="/WEB-TAG/farmdoc.tld" prefix="DOC"%>
<c:if test="${fn:length(result.resultList)>0}">
	<div class="row visible-lg" class="">
		<div class="col-sm-12">
			<span class="glyphicon glyphicon-tree-conifer wcp_columnTitle"
				style="color: green;">推荐小组 </span>&nbsp;&nbsp;&nbsp;&nbsp;
			<!-- <a class="btn btn-primary btn-xs" href="index/FPDocGroupMng.htm"
			role="button">查看更多小组</a> -->
			<hr />
		</div>
	</div>
	<div class="row visible-lg">
		<c:forEach items="${result.resultList}" varStatus="status" var="node">
			<div class="col-sm-3 ">
				<div class="thumbnail" style="height: 350px;">
					<div style="height: 170px; overflow: hidden;">
						<center>
							<img src="${node.GROUPIMG}" class="img-responsive img-thumbnail"
								style="max-height: 150px;margin-top: 16px;" alt="...">
						</center>
					</div>
					<div class="caption" style="text-align: center;">
						<div style="height: 100px;">
							<h5 style="font-weight: bold;">
								<c:if test="${node.JOINCHECK=='0'}">
									<a href="index/FPGroupInfo.htm?id=${node.ID}">${node.GROUPNAME}</a>
								</c:if>
								<c:if test="${node.JOINCHECK=='1'}">
					${node.GROUPNAME}&nbsp;<span class="glyphicon glyphicon-lock"></span>
								</c:if>
							</h5>
							<p style="font-size: 12px; line-height: 15px; text-align: left;">
								&nbsp;&nbsp;&nbsp;&nbsp;
								<DOC:Describe maxnum="64" text="${node.GROUPNOTE}"></DOC:Describe>
							</p>
						</div>
						<p>
							<c:if test="${node.JOINCHECK=='1'}">
								<c:if test="${USEROBJ!=null}">
									<a href="index/joinGroup.htm?id=${node.ID}"
										class="btn btn-warning" role="button">申请</a>
								</c:if>
								<c:if test="${USEROBJ==null}">
									<a disabled="disabled" class="btn btn-warning" role="button">登录后申请加入</a>
								</c:if>
							</c:if>
							<c:if test="${node.JOINCHECK=='0'}">
								<c:if test="${USEROBJ!=null}">
									<a href="index/joinGroup.htm?id=${node.ID}"
										class="btn btn-primary" role="button">加入</a>
								</c:if>
								<c:if test="${USEROBJ==null}">
									<a disabled="disabled" class="btn btn-primary" role="button">登录后加入小组</a>
								</c:if>
							</c:if>
						</p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</c:if>
