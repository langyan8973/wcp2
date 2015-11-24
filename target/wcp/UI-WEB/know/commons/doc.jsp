<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%@ taglib uri="/WEB-TAG/farmdoc.tld" prefix="DOC"%>
<div class="row">
	<div class="col-md-8">
		<span style="color: #008000; font-size: 12px; font-weight: lighter;">作者:<span
			class="authortagsearch" title="${doc.author}"
			style="color: #D9534F; font-size: 14px; font-weight: bold; cursor: pointer; text-decoration: underline;">${doc.author}</span>于<PF:FormatTime
				date="${doc.pubtime}" yyyyMMddHHmmss="yyyy年MM月dd日" /><b>发布</b> <PF:FormatTime
				date="${doc.texts.ctime}" yyyyMMddHHmmss="yyyy年MM月dd日" /><b>编辑</b>
		</span>
		<h2>
			${doc.title}
		</h2>
		<h3>
			<small> [编辑: <c:if test="${doc.writepop==3}">
			禁止
			</c:if> <c:if test="${doc.writepop==1}">
			公开
			</c:if> <c:if test="${doc.writepop==0}">
			私有
			</c:if> <c:if test="${doc.writepop==2}">
			小组
			</c:if> ] [阅读: <c:if test="${doc.readpop==3}">
			禁止
			</c:if> <c:if test="${doc.readpop==1}">
			公开
			</c:if> <c:if test="${doc.readpop==0}">
			私有
			</c:if> <c:if test="${doc.readpop==2}">
			小组
			</c:if> ] </small>
		</h3>
		<ol class="breadcrumb">
			<c:forEach var="node" items="${doc.currenttypes}" varStatus="status">
				<li>
					<a href="index/FPtype.htm?id=${node.id}" title="${node.name}">${node.name}</a>
				</li>
			</c:forEach>
		</ol>
		<div style="padding: 2px;">
			<c:forEach items="${doc.tags}" var="node">
				<span class="label label-info typetagsearch"
					style="cursor: pointer;" title="${node}">${node}</span>
			</c:forEach>
			<span class="badge"><span class="glyphicon glyphicon-hand-up"></span>${doc.runinfo.visitnum}</span><span
				class="badge"><span
				class="glyphicon glyphicon-circle-arrow-up"></span>${doc.runinfo.hotnum}</span>
		</div>
		<!-- 如果是内容类型等于4小组首页，则在此处不提供任何操作功能 -->
		<c:if test="${doc.domtype!='4'}">
			<div style="padding: 2px;">
				<c:if test="${USEROBJ!=null}">
					<c:if test="${isenjoy}">
						<button type="button" id="disEnjoyId"
							class="btn btn-default  btn-xs">
							<span class="glyphicon glyphicon-star"></span>&nbsp;取消收藏
						</button>
					</c:if>
					<c:if test="${!isenjoy}">
						<button type="button" id="enjoyId" class="btn btn-default  btn-xs">
							<span class="glyphicon glyphicon-star"></span>&nbsp;收藏
						</button>
					</c:if>
					<button type="button" class="btn btn-default  btn-xs"
						id="docMessageId">
						<span class="glyphicon glyphicon-envelope"></span>&nbsp;留言&nbsp;(&nbsp;${doc.runinfo.answeringnum}&nbsp;)
					</button>
					<DOC:canWriteIsShow docId="${doc.id}">
						<button type="button" id="editTopButtonId"
							class="btn btn-default  btn-xs">
							<span class="glyphicon glyphicon-envelope"></span>&nbsp;修改
						</button>
					</DOC:canWriteIsShow>
					<DOC:canDelIsShow docId="${doc.id}">
						<button type="button" id="delTopButtonId"
							class="btn btn-default  btn-xs">
							<span class="glyphicon glyphicon-envelope"></span>&nbsp;删除
						</button>
						<button type="button" id="publickButtonId"
							class="btn btn-default  btn-xs">
							<span class="glyphicon glyphicon-plane"></span>&nbsp;公开文档
						</button>
					</DOC:canDelIsShow>
				</c:if>
				<c:if test="${USEROBJ==null}">
					<button type="button" class="btn btn-default btn-xs"
						disabled="disabled">
						<span class="glyphicon glyphicon-star"></span>登录后收藏
					</button>
					<button type="button" class="btn btn-default btn-xs"
						disabled="disabled">
						<span class="glyphicon glyphicon-star"></span>登录后留言
					</button>
				</c:if>
			</div>
		</c:if>
	</div>
	<div class="col-md-4">
		<jsp:include page="../../docgroup/commons/includeGroupLogo.jsp"></jsp:include>
		<c:if test="${doc.group==null}">
			<jsp:include page="../../lucene/commons/includeLuceneResultMin.jsp"></jsp:include>
		</c:if>
	</div>
</div>

<div class="row">
	<div class="col-md-12" id="docContentsId">
		<div class="table-responsive" style="overflow: auto; border: 0px;">
			<hr />
			${doc.texts.text1}
		</div>
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
		$('#publickButtonId')
				.bind(
						'click',
						function() {
							if (confirm("是否要将该文档开放阅读和编辑权限，同时如果是小组文档将删除小组所有权？")) {
								window.location = basePath + 'index/FLflyKnow.htm?id=${doc.id}';
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