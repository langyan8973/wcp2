<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<p style="padding: 4px;">
	<%
		double total = (Runtime.getRuntime().totalMemory())
				/ (1024.0 * 1024);
		double max = (Runtime.getRuntime().maxMemory()) / (1024.0 * 1024);
		double free = (Runtime.getRuntime().freeMemory()) / (1024.0 * 1024);
		out.println("JVM最大内存量: " + max + "MB<br/>");
		out.println("JVM内存总量: " + total + "MB<br/>");
		out.println("JVM空闲内存: " + free + "MB<br/>");
		out.println("JVM实际可用内存: " + (max - total + free) + "MB<br/>");
	%>
</p>