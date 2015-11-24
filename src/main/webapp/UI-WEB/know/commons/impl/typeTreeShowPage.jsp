<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<style>
<!--
.doctypeUl {
	font-size: 14px;
}

.chooseLableType {
	cursor: pointer;
}
-->
</style>
<ul class="doctypeUl">
	<c:forEach var="node" items="${result.resultList}">
		<c:if test="${node.PARENTID=='NONE'}">
			<li>
				<h3 class="chooseLableType" id="${node.ID}">
					<span style="color: #0E6390;font-weight: bold;">${node.NAME}</span>
				</h3>
				<ul>
					<c:forEach var="node1" items="${result.resultList}">
						<c:if test="${node1.PARENTID==node.ID}">
							<li>
								<h5 class="chooseLableType" id="${node1.ID}">
									<span style="color: #D9534F; font-weight: bold;">
										${node1.NAME}</span>
								</h5>
								<ul class="list-inline">
									<c:forEach var="node2" items="${result.resultList}">
										<c:if test="${node2.PARENTID==node1.ID}">
											<li style="line-height: 15px;">
												<h5 class="chooseLableType" style="line-height: 15px;"
													id="${node2.ID}">
													<span style="color: #5CB85C;">
														${node2.NAME}</span>
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
<script type="text/javascript">
	$(function() {
		$('.chooseLableType')
				.bind(
						'click',
						function() {
							try {
								clickDocType($(this).attr('id'), $.trim($(this)
										.text()));
							} catch (e) {
								alert('请覆盖方法 clickDocType(id, text) -('
										+ $(this).attr('id') + ':'
										+ $.trim($(this).text()) + ')');
							}

						});
	});
</script>