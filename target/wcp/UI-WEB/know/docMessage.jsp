<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>评论-${doc.title}<PF:ParameterValue key="config.sys.title"/></title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
		<link rel="stylesheet"
			href="<PF:basePath/>WEB-FACE/model/kindeditor/themes/default/default.css" />
		<script charset="utf-8"
			src="<PF:basePath/>WEB-FACE/model/kindeditor/kindeditor-all-min.js"></script>
		<script charset="utf-8"
			src="<PF:basePath/>WEB-FACE/model/kindeditor/zh_CN.js"></script>
		<script charset="utf-8"
			src="<PF:basePath/>WEB-FACE/model/supervilidate/validate.js"></script>
	</head>
	<body>
		<jsp:include page="../commons/head.jsp"></jsp:include>
		<div class="containerbox">
			<div class="container ">
				<div class="row">
					<div class="col-md-3  visible-lg visible-md">
						<div class="panel panel-default userbox">
							<div class="panel-body">
								<jsp:include page="/UI-WEB/commons/includeUserPanel.jsp"></jsp:include>
								<jsp:include page="../commons/loginbox.jsp"></jsp:include>
							</div>
						</div>
						<jsp:include page="commons/includeHotKnowsMin.jsp"></jsp:include>
					</div>
					<div class="col-md-9">
						<div class="row">
							<div class="col-md-12">
								<span
									style="color: #008000; font-size: 12px; font-weight: lighter;">作者:<span
									style="color: #D9534F; font-size: 14px; font-weight: bold;">${doc.author}</span>于<PF:FormatTime
										date="${doc.pubtime}" yyyyMMddHHmmss="yyyy年MM月dd日" />发布</span>
								<h1>
									<a href="index/FPDocShow.htm?id=${doc.id}"> ${doc.title}</a>
									<small>[编辑:<c:if test="${doc.writepop==1}">
									公开
									</c:if> <c:if test="${doc.writepop==0}">
									私有
									</c:if> <c:if test="${doc.writepop==2}">
									托管
									</c:if> ][读:<c:if test="${doc.readpop==1}">
									公开
									</c:if> <c:if test="${doc.readpop==0}">
									私有
									</c:if> <c:if test="${doc.readpop==2}">
									托管
									</c:if> ]</small>
								</h1>
								<h1>
									<span class="typetagsearch" style="cursor: pointer;"
										title="${doc.types[0].name}"> <small>${doc.types[0].name}</small>
									</span>
								</h1>
								<div style="padding: 2px;">
									<c:forEach items="${doc.tags}" var="node">
										<span class="label label-info typetagsearch"
											style="cursor: pointer;" title="${node}">${node}</span>
									</c:forEach>
									<span class="badge"><span
										class="glyphicon glyphicon-hand-up"></span>${doc.runinfo.visitnum}</span><span
										class="badge"><span
										class="glyphicon glyphicon-circle-arrow-up"></span>${doc.runinfo.hotnum}</span>
								</div>
								<hr />
							</div>
						</div>
						<form role="form" action="index/FLDocMessageSubmit.htm"
							id="knowSubmitFormId" method="post">
							<input type="hidden" name="message.appid" value="${doc.id}" />
							<input type="hidden" name="message.title" value="${doc.title}" />
							<input type="hidden" name="message.readuserid"
								value="${doc.cuser}" />
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<textarea class="form-control" id="mesTextId"
											name="message.content" placeholder="请输入留言内容"></textarea>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-2">
									<button type="button" id="msgSubmitButtonId"
										class="btn btn-primary">
										发表留言
									</button>
								</div>
								<div class="col-md-10">
									<span class="alertMsgClass" id="errormessageShowboxId"></span>
								</div>
							</div>
						</form>
						<div class="row">
							<div class="col-md-12">
								<c:forEach items="${result.resultList}" var="node">
									<hr />
									<p>
										<span
											style="color: #008000; font-size: 12px; font-weight: lighter;">
											${node.CUSERNAME}</span><span
											style="color: #999999; font-size: 12px; font-weight: lighter;">${node.CTIME}</span>
									</p>
									<p>
										${node.CONTENT}
									</p>
								</c:forEach>
							</div>
						</div>
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
												<a href="javascript:typeBoxGoPage(${page})">${page} </a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../commons/foot.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
	$(function() {
		//分类
		$('.typetagsearch').bind('click', function() {
			luceneSearch('TYPE:' + $(this).attr('title'));
		});
		$('#msgSubmitButtonId')
				.bind(
						'click',
						function() {
							if (!validate('knowSubmitFormId')) {
								$('#errormessageShowboxId').text('信息录入有误，请检查！');
							} else {
								$('#knowSubmitFormId').submit();
								$('#msgSubmitButtonId').hide();
								$('#msgSubmitButtonId')
										.before(
												"<h2><span class='label label-info glyphicon glyphicon-link'>提交中...</span></h2>");
							}
						});
		validateInput('mesTextId', function(id, val, obj) {
			// 留言
				if (valid_isNull(val)) {
					return {
						valid : false,
						msg : '不能为空'
					};
				}
				if (valid_maxLength(val, 128)) {
					return {
						valid : false,
						msg : '长度不能大于' + 128
					};
				}
				return {
					valid : true,
					msg : '正确'
				};
			});
	});
	function typeBoxGoPage(page) {
		window.location = basePath
				+ 'index/FLDocMessageShow.htm?id=${doc.id}&query.currentPage='
				+ page;
	}
</script>
</html>