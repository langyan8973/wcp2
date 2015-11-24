<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div class="row">
	<div class="col-md-8">
		<span style="color: #008000; font-size: 12px; font-weight: lighter;">作者:<span
			class="authortagsearch" title="${doc.author}"
			style="color: #D9534F; font-size: 14px; font-weight: bold; cursor: pointer; text-decoration: underline;">${doc.author}</span>于<PF:FormatTime
				date="${doc.texts.etime}" yyyyMMddHHmmss="yyyy年MM月dd日" />发布该版本</span>
		<div>
			<h1>
				
				<PF:FormatTime date="${doc.texts.etime}"
					yyyyMMddHHmmss="yyyy/MM/dd HH:mm:ss" />
				:${doc.title}
			</h1>
		</div>
		<jsp:include page="includeDocVersions.jsp"></jsp:include>
		<ol class="breadcrumb">
			<c:forEach var="node" items="${doc.currenttypes}" varStatus="status">
				<li>
					<a class="typetagsearch" title="${node.name}">${node.name}</a>
				</li>
			</c:forEach>
		</ol>
	</div>
	<div class="col-md-4">

	</div>
</div>

<div class="row">
	<div class="col-md-12" id="docContentsId">
		<hr />
		${doc.texts.text1}
	</div>
</div>
<div class="row">
	<div class="col-md-12">
		<hr />
	</div>
</div>
<script type="text/javascript">
	$(function() {
		$('#editTopButtonId').bind('click', function() {
			window.location = basePath + 'index/FLEditKnow.htm?id=${doc.id}';
		});
		$('#docMessageId')
				.bind(
						'click',
						function() {
							window.location = basePath + 'index/FLDocMessageShow.htm?id=${doc.id}';
						});
		$('#delTopButtonId')
				.bind(
						'click',
						function() {
							if (confirm("删除后该知识将无法恢复，确定要删除吗？")) {
								window.location = basePath + 'index/FLDelKnow.htm?id=${doc.id}';
							}
						});
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
		//收藏
		$('#enjoyId')
				.live(
						'click',
						function() {
							$
									.post(
											'index/FLenjoy.htm?id=${doc.id}',
											function(flag) {
												if (flag.pageset.commitType == '0') {
													alert('收藏成功');
													var buttonStr = '<button type="button" id="disEnjoyId" class="btn btn-default  btn-xs"><span class="glyphicon glyphicon-star"></span>取消收藏</button>';
													$('#enjoyId').before(
															buttonStr);
													$('#enjoyId').remove();
												} else {
													alert('收藏失败');
												}
											});
						});
		//取消收藏
		$('#disEnjoyId')
				.live(
						'click',
						function() {
							$
									.post(
											'index/FLunEnjoy.htm?id=${doc.id}',
											function(flag) {
												if (flag.pageset.commitType == '0') {
													alert('取消收藏成功');
													var buttonStr = '<button type="button" id="enjoyId" class="btn btn-default  btn-xs"><span class="glyphicon glyphicon-star"></span>收藏</button>';
													$('#disEnjoyId').before(
															buttonStr);
													$('#disEnjoyId').remove();
												} else {
													alert('取消收藏失败');
												}
											});
						});
	});
</script>