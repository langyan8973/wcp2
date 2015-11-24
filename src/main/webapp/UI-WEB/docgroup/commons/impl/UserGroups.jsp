<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%@ taglib uri="/WEB-TAG/farmdoc.tld" prefix="DOC"%>
<div class="panel panel-default">
	<div class="panel-body" style="background-color: #FCFCFA;">
			<p>
				<span class="glyphicon glyphicon-tree-conifer wcp_columnTitle">知识小组</span>
				&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: #959486;"> 
						该用户加入了如下知识小组
				</span>
			</p>
			<c:forEach items="${result.resultList}" var="node">
				<div class="col-xs-6 col-md-3">
					<a class="thumbnail" href="index/FPGroupInfo.htm?id=${node.ID}">
						<c:if test="${node.GROUPIMG==null}">
							<img src="UI-WEB/docgroup/commons/imgDemo.png"
								style="max-height: 100px; max-width: 100px;" class="thumbnail"
								alt="...">
						</c:if> <c:if test="${node.GROUPIMG!=null}">
							<img src="${node.GROUPIMG}"
								style="max-height: 100px; max-width: 100px;" class="thumbnail"
								alt="...">
						</c:if>
					</a>
				</div>
			</c:forEach>
	</div>
</div>