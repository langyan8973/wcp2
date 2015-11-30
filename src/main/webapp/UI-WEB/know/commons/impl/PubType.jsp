<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<style>
<!--
.doctypeUl {
	font-size: 12px;
}

.doctypeUl li {
	line-height: 20px;
}

.showLableType {
	text-decoration: underline;
	color: #428BCA;
	cursor: pointer;
}
-->
</style>
<div class="row">
	<div class="col-sm-12" style="margin-bottom: 8px;">
		<span style="color: #428BCA;"
			class="glyphicon glyphicon-tag wcp_columnTitle">分类</span>
		<hr />
		<ul class="doctypeUl">
			<c:forEach var="node" items="${result.resultList}">
				<c:if test="${node.PARENTID=='NONE'}">
					<li>
						<h5 class="showLableType" id="${node.ID}">
							${node.NAME}
							<c:if test="${node.NUM>0}">
								<span style="color: #D9534F; font-weight: bold;">${node.NUM}</span>
							</c:if>
						</h5>
						<ul>
							<c:forEach var="node1" items="${result.resultList}">
								<c:if test="${node1.PARENTID==node.ID}">
									<li>
										<h5 class="showLableType" id="${node1.ID}">
											${node1.NAME}
											<c:if test="${node1.NUM>0}">
												<span style="color: #D9534F; font-weight: bold;">${node1.NUM}</span>
											</c:if>
										</h5>
										<ul class="list-inline">
											<c:forEach var="node2" items="${result.resultList}">
												<c:if test="${node2.PARENTID==node1.ID}">
													<li>
														<h5 class="showLableType" id="${node2.ID}">
															<span style="color: #5CB85C;"> ${node2.NAME}</span>
															<c:if test="${node2.NUM>0}">
																<span style="color: #D9534F; font-weight: bold;">${node2.NUM}</span>
															</c:if>
														</h5>
													</li>
												</c:if>
											</c:forEach>
										</ul>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</div>

<script type="text/javascript">
	$(function() {
		$('.showLableType').bind('click', function() {
			window.location = "index/FPtype.htm?id=" + $(this).attr('id');
		});
	});
</script>