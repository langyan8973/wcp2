<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.farm.core.config.AppConfig"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>专业版介绍-<PF:ParameterValue key="config.sys.title "/>
		</title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>
	</head>
	<body>
		<jsp:include page="../../commons/head.jsp"></jsp:include>
		<div class="containerbox">
			<div class="container ">
				<div class="row">
					<div class="col-sm-12" style="text-align: center;">
						<img class="img-thumbnail" src="WEB-FACE/img/style/logo.png"
							style="margin: 20px;" />
						<div style="max-width: 800px; margin: auto; text-align: center;">
							<table class="table table-striped" style="width: 100%;margin: auto;">
								<tr>
									<td colspan="2" style="font-weight: bold;">
										<h1>
											工作小组-功能介绍
										</h1>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<b>选择加入小组</b>:
										<span style="font-size: 12px;">
											系统中允许建立两种工作小组：1.允许用户自由加入的小组。2.限制用户加入的涉密小组。 </span>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<img style="width: 600px;" class="img-thumbnail"
											src="UI-WEB/auth/professional/img/public.png" alt="" />
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<b>小组文档界面</b>:
										<span style="font-size: 12px;"> 此处管理本小组的文档 </span>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<img style="width: 600px;" class="img-thumbnail"
											src="UI-WEB/auth/professional/img/into.png" alt="" />
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<b>小组管理界面</b>:
										<span style="font-size: 12px;"> 管理小组成员的各种权限 </span>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<img style="width: 600px;" class="img-thumbnail"
											src="UI-WEB/auth/professional/img/mguser.png" alt="" />
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<b>小组成员角色划分</b>:
										<span style="font-size: 12px;"> 管理小组成员的各种权限 </span>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<img style="width: 600px;" class="img-thumbnail"
											src="UI-WEB/auth/professional/img/uml1.png" alt="" />
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<b>小组建设流程</b>:
										<span style="font-size: 12px;"></span>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<img style="width: 600px;" class="img-thumbnail"
											src="UI-WEB/auth/professional/img/uml2.png" alt="" />
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<b>基于小组的文档权限</b>:
										<span style="font-size: 12px;"></span>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<img style="width: 600px;" class="img-thumbnail"
											src="UI-WEB/auth/professional/img/uml3.png" alt="" />
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../../commons/foot.jsp"></jsp:include>
	</body>
</html>