<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>授权信息-<PF:ParameterValue key="config.sys.title " /></title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="../commons/head.jsp"></jsp:include>
		<div class="containerbox">
			<div class="container ">
				<div class="row">
					<div class="col-sm-12" style="text-align: center;">
						<img class="img-thumbnail" src="WEB-FACE/img/style/logo.png"
							style="margin: 20px;" />
						<div style="max-width: 500px; margin: auto; text-align: left;">
							<c:if test="${pageset.commitType=='1'}">
								<div class="alert alert-danger" style="text-align: center;"
									role="alert">
									${pageset.message}
								</div>
							</c:if>
							<table class="table table-striped">
								<tr>
									<td style="font-weight: bold;">
										版本
									</td>
									<td style="width: 50%">
										${orgname}<PF:ParameterValue key="config.wcp.version.c" />
									</td>
								</tr>
								<tr>
									<td style="font-weight: bold;">
										许可
									</td>
									<td>
										请不要用于商业用途
									</td>
								</tr>
								<c:if test="${!authTrue}">
									<tr>
										<td style="font-weight: bold;">
											注册码
										</td>
										<td style="font-weight: bold;">
											${text}
										</td>
									</tr>
								</c:if>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../commons/foot.jsp"></jsp:include>
	</body>
</html>