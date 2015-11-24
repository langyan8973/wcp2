<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${group.groupname}小组成员管理-<PF:ParameterValue key="config.sys.title"/>
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
						<a class="thumbnail"> <c:if test="${group.groupimg==null}">
								<img src="UI-WEB/docgroup/commons/imgDemo.png" alt="...">
							</c:if> <c:if test="${group.groupimg!=null}">
								<img src="${group.imgurl}" alt="...">
							</c:if> </a>
						<h3 style="text-align: center; font-weight: bold;">
							${group.groupname}&nbsp;&nbsp;
						</h3>
						<hr />
						<p>
							<c:forEach items="${group.tags}" var="tag">
								<span class="label label-info tagsearch" title="${tag}"
									style="font-weight: lighter; font-size: 12px; cursor: pointer;">${tag}</span>
							</c:forEach>
						</p>
						<p>
							${group.groupnote}
						</p>
					</div>
					<div class="col-md-9">
						<div class="row">
							<div class="col-md-12">
								<ol class="breadcrumb">
									<li>
										<a href="#">WCP</a>
									</li>
									<li>
										<a href="index/FPGroupInfo.htm?id=${group.id}">${group.groupname}小组</a>
									</li>
									<li class="active">
										加入申请
									</li>
								</ol>
							</div>
						</div>
						<jsp:include page="commons/includeApplyMng.jsp"></jsp:include>
						<div class="row">
							<div class="col-md-12">
								<ol class="breadcrumb">
									<li class="active">
										管理员
									</li>
								</ol>
							</div>
						</div>
						<jsp:include page="commons/includeAdministratorMng.jsp"></jsp:include>
						<div class="row">
							<div class="col-md-12">
								<ol class="breadcrumb">
									<li class="active">
										成员
									</li>
								</ol>
							</div>
						</div>
						<jsp:include page="commons/includeUserMng.jsp"></jsp:include>
						<p style="text-align: center;">
							<a href="index/FPGroupInfo.htm?id=${group.id}"
								class="btn btn-default">返回小组首页</a>
						</p>
					</div>
				</div>
			</div>
		</div>
		<!-- /.modal -->
		<jsp:include page="../commons/foot.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
	var currentGroupUser='${usergroup.id}';
	function quitGourp(groupUserId) {
		if (confirm('是否将该用户退出小组？')) {
			$.post('index/GroupQuit.htm', {
				id : groupUserId
			}, function(flag) {
				if (flag.pageset.commitType == '0') {
					loadGroupAdministrator(1);
					loadGroupUser(1);
					if(groupUserId==currentGroupUser){
						window.location = 'index/FPDocGroupMng.htm';
					}
				} else {
					alert(flag.pageset.message);
				}
			});
		}
	}
</script>
</html>