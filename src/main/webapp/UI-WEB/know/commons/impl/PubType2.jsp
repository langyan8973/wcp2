<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<style>
<!--
.typeDocs_type {
	color: #000000;
	cursor: pointer;
}
-->
</style>
<div class="row">
	<div class="col-sm-12 mytitlebar">
		<span style="color: #FFFFFF;"
			class="glyphicon glyphicon-tag wcp_columnTitle">分类<c:if
				test="${knowtype!=null}">:${knowtype}</c:if> </span>
		<em style="color: #FFFFFF;">某些被赋予权限的知识在登录后被显示</em>
		
	</div>
	<div class="btn-group" role="group" aria-label=""
		style="float: right; margin-top:10px;">
		<c:if test="${USEROBJ!=null}">
			<PF:AuthForUser actionName="FarmDoctype_ACTION_CONSOLE">
				<div class="btn-group" role="group">
					<button type="button"
						class="btn btn-default dropdown-toggle btn-sm"
						data-toggle="dropdown" aria-expanded="false">
						分类管理
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu" style="min-width: 120px;">
						<li>
							<a class="glyphicon glyphicon-plus"
								href="index/FLtypeAdd.htm?id=${currentTypeid}">添加分类 </a>
						</li>
						<c:if test="${id!=null&&id!='NONE'}">
							<li>
								<a class="glyphicon glyphicon-pencil"
									href="index/FLtypeEdit.htm?id=${currentTypeid}">修改分类 </a>
							</li>
							<li>
								<a class="glyphicon glyphicon-remove"
									id="removeDocTypeButtonId">删除分类 </a>
							</li>
						</c:if>
					</ul>
				</div>
			</PF:AuthForUser>
		</c:if>
		<c:if test="${id!=null&&id!='NONE'}">
			<c:if test="${USEROBJ!=null}">
				<div class="btn-group" role="group">
					<button type="button"
						class="btn btn-default dropdown-toggle btn-sm"
						data-toggle="dropdown" aria-expanded="false">
						创建知识
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<jsp:include
							page="/UI-WEB/user/commons/userMenu/userKnowMenu.jsp"></jsp:include>
					</ul>
				</div>
			</c:if>
		</c:if>
		<c:if test="${id!=null&&id!='NONE'}">
			<a href="index/FPtype.htm?id=${typeid}" type="button"
				class="btn btn-primary btn-sm">返回上级</a>
		</c:if>
	</div>
</div>
<c:if test="${pageset.message!=null&&pageset.message!=''}">
	<div class="row">
		<div class="col-sm-12">
			<div class="form-group">
				<div class="alert alert-danger" role="alert"
					style="margin-top: 8px;">
					<span class="alertMsgClass" id="errormessageShowboxId">${pageset.message}</span>
				</div>
			</div>
		</div>
	</div>
</c:if>
<div class="row" style="margin-top:10px;">
	<c:forEach var="node" items="${result.resultList}">
		<c:if test="${node.PARENTID==id}">
			<div class="col-sm-4">
				<div class="panel panel-default"
					style="min-height: 120px; background-color: #fcfcfc;">
					<div class="panel-body">
						<h4 class="media-heading">
							<a href="index/FPtype.htm?id=${node.ID}"> <span
								style="color: #428BCA; font-weight: bold;">${node.NAME}</span> </a>
							<c:if test="${node.NUM>0}">
								<span style="color: #D9534F; font-weight: bold;">${node.NUM}</span>
							</c:if>
						</h4>
						<div>
							<c:forEach var="node1" items="${result.resultList}">
								<c:if test="${node1.PARENTID==node.ID}">
									<h6 style="float: left; margin: 4px;">
										<a href="index/FPtype.htm?id=${node1.ID}"> ${node1.NAME} </a>
										<c:if test="${node1.NUM>0}">
											<span style="color: #D9534F; font-weight: bold;">${node1.NUM}</span>
										</c:if>
									</h6>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</c:if>
	</c:forEach>
</div>
<script type="text/javascript">
	$(function() {
		$('#removeDocTypeButtonId').bind('click', function() {
			if (confirm("是否确定要删除该分类？")) {
				window.location = 'index/FLtypeDel.htm?id=${currentTypeid}';
			}
		});
	});
</script>