<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- ID,TITLE,DOCDESCRIBE,AUTHOR,PUBTIME,TAGKEY ,IMGID,VISITNUM,PRAISEYES,PRAISENO,HOTNUM,TYPENAME -->
<div class="row" style="margin-top: 8px;">
	<div class="col-sm-12" >
		<span class="glyphicon glyphicon-star wcp_columnTitle"
			style="color: #D9534F;">最新公开知识文档 </span>
	</div>
</div>
<c:forEach items="${result.resultList}" var="node">
	<hr style="margin: 16px;"/>
	<div class="row">
		<div class="col-xs-12 ">
			<div class="media">
				<a class="pull-right" href="index/FPuserHome.htm?id=${node.CUSER}" style="max-width: 200px;"
					title="${node.AUTHOR}"> <c:if test="${node.PHOTOURL==null }">
						<img style="max-width: 300px; max-height: 70px;"
							class="img-thumbnail" src="WEB-FACE/img/style/photo.png" />
					</c:if> <c:if test="${node.PHOTOURL!=null }">
						<img style="max-width: 300px; max-height: 70px;"
							class="img-thumbnail" src="${node.PHOTOURL }" />
					</c:if> </a>
				<div class="media-body">
					<div style="margin-left: 4px;" class="pull-left">
						<h4 style="font-weight: bold;">
							<a style="color: #333333;"
								href="index/FPDocShow.htm?id=${node.ID}">${node.TITLE}</a>
							<c:if test="${node.DOMTYPE=='3'}">
								<span style="color: #4B96BD;" class="glyphicon glyphicon-home"></span>
							</c:if>
							<c:if test="${node.DOMTYPE=='1'}">
								<span class="glyphicon glyphicon-file"></span>
							</c:if>
							<c:if test="${node.DOMTYPE=='5'}">
								<span style="color: #d9534f;" class="glyphicon glyphicon-download-alt"></span>
							</c:if>
							<span
								style="color: #008000; font-size: 12px; font-weight: lighter;"><a
								class="authortagsearch" title="${node.AUTHOR}">${node.AUTHOR}</a>&nbsp;&nbsp;于&nbsp;&nbsp;${node.PUBTIME}&nbsp;&nbsp;发布
								在分类&nbsp;&nbsp;<a class="typetagsearch" title="${node.TYPENAME}">${node.TYPENAME}</a>&nbsp;&nbsp;下
								<c:if test="${node.VISITNUM>0}">/访问量:${node.VISITNUM}</c:if> </span>
						</h4>
						<p
							style="word-wrap: break-word; color: #717171; font-size: 12px; line-height: 20px;">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${node.DOCDESCRIBE}&nbsp;
							<span style="color: green;">(最新版本<PF:FormatTime
									date="${node.ETIME}" yyyyMMddHHmmss="yyyy-MM-dd HH:mm" />)</span>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>
<script type="text/javascript">
	$(function() {
		//分类
		$('.typetagsearch').bind('click', function() {
			luceneSearch('TYPE:' + $(this).attr('title'));
		});
		//作者
		$('.authortagsearch').bind('click', function() {
			luceneSearch('AUTHOR:' + $(this).attr('title'));
		});
		//标签
		$('.tagsearch').bind('click', function() {
			luceneSearch('TYPE:' + $(this).attr('title'));
		});
	});
</script>