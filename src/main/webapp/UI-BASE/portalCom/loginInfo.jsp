<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.farm.authority.service.UserServiceInter"%>
<%@page import="com.farm.web.spring.BeanFactory"%>
<%@page import="com.farm.authority.domain.User"%>
<%@page import="com.farm.authority.domain.Organization"%>
<%@page import="java.util.List"%>
<%@page import="com.farm.authority.domain.Post"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%
	UserServiceInter userIMP = (UserServiceInter) BeanFactory
			.getBean("farm_authority_user_ProxyId");
	String userid = ((User) session.getAttribute("USEROBJ")).getId();
	Organization organization = userIMP.getUserOrganization(userid);
	List<Post> posts=userIMP.getUserPosts(userid);
%>
<p style="padding: 4px;">
	<b><c:forEach var="node" varStatus="index"
			items="${sessionScope.LOGINROLES}">
			<c:if test="${index.count!=1}">,</c:if>
						${node.name}
						</c:forEach> </b>
	<span style="color: green; font-weight: bold;">${sessionScope.USEROBJ.name}</span>
	<br />
	组织机构:<%=organization == null ? "" : organization.getName()%><br />
	岗位:<%for(Post post:posts){ %><%=post.getName() %>&nbsp;
	<%} %><br />
	<b>${sessionScope.USERORG.name}</b>
	<br />
	<span style="color: #666666;">本次登录在 <PF:FormatTime
			date="${sessionScope.LOGINTIME}" yyyyMMddHHmmss="yyyy年MM月dd日HH:mm" />
		, 最近一次登录在 <PF:FormatTime date="${sessionScope.USEROBJ.logintime}"
			yyyyMMddHHmmss="yyyy年MM月dd日HH:mm" /> </span>
</p>