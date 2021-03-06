<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div class="panel panel-default" style="background-color: #FCFCFA;">
	<div class="panel-body">
		<p>
			<span class="glyphicon glyphicon-user wcp_columnTitle">好评用户排名</span>
		</p>
		<table class="table" style="font-size: 12px;">
			<tr>
				<th>
					排名
				</th>
				<th>
					用户
				</th>
				<th>
					好评
				</th>
			</tr>
			<c:forEach items="${result.resultList}" varStatus="status" var="node">
				<tr>
					<td>
						${status.index+1}
					</td>
					<td>
						${node.NAME}
					</td>
					<td>
						${node.SUMYES}
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>