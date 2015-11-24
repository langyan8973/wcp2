<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${group.groupname}小组首页-<PF:ParameterValue
				key="config.sys.title" />
		</title>
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
				<jsp:include page="commons/includeSearch.jsp"></jsp:include>
				<div class="row">
					<div class="col-md-3 ">
						<jsp:include page="commons/includeGroupLeft.jsp"></jsp:include>
					</div>
					<div class="col-md-9">
						<p class="bg-success">
							<small>小组成立于</small>
							<strong> <u><PF:FormatTime date="${group.ctime}"
										yyyyMMddHHmmss="yyyy-MM-dd HH:mm" /> </u> </strong>
							<small>,有成员</small><strong> <u>${group.usernum}</u> </strong><small>人,共发布文档</small><strong>
								<u>${docnum}</u> </strong><small>篇</small>
						</p>
						<c:if test="${usergroup==null}">
							<div class="alert alert-danger" role="alert">
								<b>当前权限只能查看公开的文档</b>:加入小组并登陆后可以查看更多文档
							</div>
						</c:if>
						<hr />
						<ul class="nav nav-tabs" role="tablist">
							<li class="active">
								<a role="tab" id="home" class="glyphicon glyphicon-home"
									data-toggle="tab">首页</a>
							</li>
							<li>
								<a role="tab" id="new" class="glyphicon glyphicon-dashboard"
									data-toggle="tab">小组最新知识</a>
							</li>
							<li>
								<a role="tab" id="hot" class="glyphicon glyphicon-fire"
									data-toggle="tab">小组最热知识</a>
							</li>
							<li>
								<a role="tab" id="good" class="glyphicon glyphicon-thumbs-up"
									data-toggle="tab">小组优质知识</a>
							</li>
							<li>
								<a role="tab" id="bad" class="glyphicon glyphicon-thumbs-down"
									data-toggle="tab">待改善知识</a>
							</li>
						</ul>
						<!-- Tab panes -->
						<div class="tab-content" id="resultBoxDivId">
							Loading...
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal -->
		<jsp:include page="../commons/foot.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
	var loadUrl;
	$(function() {
		loadUrl = 'index/FPLoadMygroupHome.htm';
		loadDocs(1);
		$('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
			if ($(this).attr('id') == 'home') {
				loadUrl = 'index/FPLoadMygroupHome.htm';
				loadDocs(1);
			}
			if ($(this).attr('id') == 'new') {
				loadUrl = 'index/FPLoadGroupNewDoc.htm';
				loadDocs(1);
			}
			if ($(this).attr('id') == 'hot') {
				loadUrl = 'index/FPLoadGroupHotDoc.htm';
				loadDocs(1);
			}
			if ($(this).attr('id') == 'good') {
				loadUrl = 'index/FPLoadGroupGoodDoc.htm';
				loadDocs(1);
			}
			if ($(this).attr('id') == 'bad') {
				loadUrl = 'index/FPLoadGroupBadDoc.htm';
				loadDocs(1);
			}
		})
	});

	function loadDocs(page) {
		$('#resultBoxDivId').html('Loading...');
		$('#resultBoxDivId').load(loadUrl, {
			id : '${group.id}',
			'query.currentPage' : page
		});
	}
</script>
</html>