<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--任务-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
		<div style="text-align: left;">
			<p>
				任务URL:
				<font style="color: black; font-weight: lighter;">${entity.url}</font><a
					href="${entity.url}" target="_blank">打开</a>
			</p>
			<p>
				任务标题:
				<font style="color: black; font-weight: lighter;">${entity.title}</font>
			</p>
			<div class="demo-info">
				<div class="demo-tip icon-tip"></div>
				<div>
					<c:if test="${entity.type=='1'}">种子任务</c:if>
					<c:if test="${entity.type=='2'}">文档任务</c:if>
					<c:if test="${entity.pstate=='1'}">还未开始</c:if>
					<c:if test="${entity.pstate=='2'}">正在执行</c:if>
					<c:if test="${entity.pstate=='3'}">已经完成</c:if>
					<c:if test="${entity.pstate=='4'}">发生异常</c:if>
				</div>
			</div>
		</div>
	</div>
	<div data-options="region:'center'" style="background-color: black;">
		<c:if test="${entity.pstate=='4'}">发生异常
			<div
				style="border: dotted; border-width: 1px; margin: 8px; padding: 4px; background-color: white;">
				${entity.pcontent}
			</div>
		</c:if>
		<c:forEach var="node" items="${result.resultList}">
			<div style="margin: 4px; color: white; font-weight: bold;">
				${node.ATTRNAME}
			</div>
			<div
				style="border: dotted; border-width: 1px; margin: 8px; padding: 4px; background-color: white;">
				${node.PCONTENT}
			</div>
		</c:forEach>
	</div>
</div>
