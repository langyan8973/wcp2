<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="row" style="padding-bottom: 20px;margin-top: 16px;">
	<div class="col-sm-12  visible-lg visible-md">
		<img class="img-thumbnail"
			src="<PF:basePath/>UI-WEB/commons/impl/towDCode.jsp" />
		<div style="text-align: center;">
			<a href="<PF:basePath/>">扫描二维码访问本站</a>
		</div>
	</div>
</div>