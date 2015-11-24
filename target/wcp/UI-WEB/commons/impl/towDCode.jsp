<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.util.Hashtable"%>
<%@page import="com.google.zxing.EncodeHintType"%>
<%@page import="com.google.zxing.common.BitMatrix"%>
<%@page import="com.google.zxing.MultiFormatWriter"%>
<%@page import="com.google.zxing.BarcodeFormat"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.io.File"%>
<%@page import="com.farm.wcp.know.common.ZxingTowDCode"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<%
	String path = request.getContextPath();
	String text = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	int width = 300;
	int height = 300;
	// 二维码的图片格式
	String format = "gif";
	Hashtable hints = new Hashtable();
	// 内容所使用编码
	hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
	BitMatrix bitMatrix = new MultiFormatWriter().encode(text,
	BarcodeFormat.QR_CODE, width, height, hints);
	//关于文件下载时采用文件流输出的方式处理：
	response.setContentType("application/x-download");
	String filedownload = "想办法找到要提供下载的文件的物理路径＋文件名";
	String filedisplay = "给用户提供的下载文件名";
	filedisplay = URLEncoder.encode(filedisplay, "UTF-8");
	response.addHeader("Content-Disposition", "attachment;filename="
	+ filedisplay);
	OutputStream outp = null;
	try {
		outp = response.getOutputStream();
		ZxingTowDCode.writeToStream(bitMatrix, format, outp);
	} catch (Exception e) {
		System.out.println("Error!");
		e.printStackTrace();
	} finally {
		if (outp != null) {
		outp.close();
		outp = null;
		}
	}
	out.clear();
	out = pageContext.pushBody();
%>