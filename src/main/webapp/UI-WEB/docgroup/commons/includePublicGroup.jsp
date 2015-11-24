<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%@ taglib uri="/WEB-TAG/farmdoc.tld" prefix="DOC"%>
<!-- /.row -->
<ol class="breadcrumb">
	<li>
		<span style="color: #2F70A7;"
			class="glyphicon glyphicon glyphicon-tree-conifer wcp_columnTitle">全部小组<c:if
				test="${searchGroupKey!=null&&searchGroupKey!=''}">(过滤条件:${searchGroupKey })</c:if>
		</span>&nbsp;
	</li>
	<li>
		共检索到${result.totalSize}条记录:
	</li>
</ol>
<c:forEach items="${result.resultList}" var="node">
	<hr />
	<div class="row">
		<div class="col-xs-6 col-sm-3">
			<c:if test="${node.GROUPIMG==null}">
				<img src="UI-WEB/docgroup/commons/imgDemo.png" class="thumbnail"
					style="max-height: 100px; max-width: 100px;" alt="...">
			</c:if>
			<c:if test="${node.GROUPIMG!=null}">
				<img src="${node.GROUPIMG}" class="thumbnail"
					style="max-height: 100px; max-width: 100px;" alt="...">
			</c:if>
		</div>
		<div class="col-xs-6" class="caption">
			<p style="font-weight: bold;">
				<c:if test="${node.JOINCHECK=='0'}">
					<a href="index/FPGroupInfo.htm?id=${node.ID}">${node.GROUPNAME}</a>
				</c:if>
				<c:if test="${node.JOINCHECK=='1'}">
					${node.GROUPNAME}&nbsp;<span class="glyphicon glyphicon-lock"></span>
				</c:if>
				(共${node.USERNUM }人,${node.DOCNUM }篇文档)
			</p>
			<p style="font-size: 12px;">
				<DOC:Describe maxnum="64" text="${node.GROUPNOTE}"></DOC:Describe>
			</p>
			<p style="font-size: 12px; color: gray;">
				${node.CUSERNAME}&nbsp;&nbsp;&nbsp;于
				<PF:FormatTime date="${node.CTIME}"
					yyyyMMddHHmmss="yyyy-MM-dd HH:mm" />
				创建
			</p>
		</div>
		<div class="col-xs-12 col-sm-3 " class="caption">
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
			<p>
				<c:if test="${node.JOINCHECK=='0'}">
					<a href="index/FPGroupInfo.htm?id=${node.ID}"
						class="btn btn-default" role="button">查看</a>
				</c:if>
			</p>
		</div>
	</div>
</c:forEach>
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
						<a href="index/FPDocGroupMng.htm?query.currentPage=${page}">${page}
						</a>
					</li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
</div>