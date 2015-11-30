<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>我的留言-${doc.title}<PF:ParameterValue key="config.sys.title"/></title>
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
			<div class="container " style="margin-top:30px;">
				<div class="row">
					<div class="col-md-3  visible-lg visible-md">
						<div class="panel panel-default userbox">
							<div class="panel-body">
								<jsp:include page="/UI-WEB/commons/includeUserPanel.jsp"></jsp:include>
								<jsp:include page="../commons/loginbox.jsp"></jsp:include>
							</div>
						</div>
						<jsp:include page="commons/includePubType.jsp"></jsp:include>
					</div>
					<div class="col-md-9">
						<div class="row">
							<div class="col-sm-12 mytitlebar">
								<span class="glyphicon glyphicon-envelope wcp_columnTitle"
												style="color: #FFFFFF;">已收到-留言</span>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<c:forEach items="${result.resultList}" var="node">
									<hr />
									<p>
										<c:if test="${node.READSTATE=='0'}">
											<span class="label label-danger">new</span>
										</c:if>
										<span
											style="color: #999999; font-size: 12px; font-weight: lighter;">${node.CTIME}</span>
										<a href="javascript:luceneSearch('${node.TITLE}')"> <span
											style="font-size: 16px; font-weight: bold;">${node.TITLE}</span>
										</a>:
										<span style="color: #D9534F;">${node.PCONTENT}</span>
										&nbsp;&nbsp;
										<span
											style="color: #008000; font-size: 12px; font-weight: lighter;">
											${node.CUSERNAME}</span>
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
				+ 'index/FLMyMessageList.htm?query.currentPage=' + page;
	}
</script>
</html>