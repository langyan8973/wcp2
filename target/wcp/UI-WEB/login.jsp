<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.farm.web.constant.FarmConstant"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%@ taglib uri="/WEB-TAG/farmdoc.tld" prefix="DOC"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>首页-<PF:ParameterValue key="config.sys.title" />
		</title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="commons/head.jsp"></jsp:include>
		<div class="containerbox">
			<div class="container ">
				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-default userbox"
							style="margin: auto; width: 300px; margin-top: 20px;">
							<div class="panel-body">
								<div class="text-center">
									<img class="img-thumbnail" src="WEB-FACE/img/style/logo.png"
										style="margin: 20px;" />
								</div>
								<jsp:include page="commons/loginbox.jsp"></jsp:include>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="commons/foot.jsp"></jsp:include>
	</body>
</html>