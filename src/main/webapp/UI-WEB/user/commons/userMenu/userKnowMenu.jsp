<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<li>
	<a
		href="index/FLcreatKnow.htm?typeid=${currentTypeid}&docgroup=${group.id}"><span
		class="glyphicon glyphicon-pencil"></span>&nbsp;创建文档知识</a>
</li>
<li>
	<a
		href="index/FLDownWebKnow.htm?typeid=${currentTypeid}&docgroup=${group.id}"><span
		class="glyphicon glyphicon-save"></span>&nbsp;下载网页知识 </a>
</li>
<%-- <li>
	<a
		href="index/webSiteshowPage.htm?typeid=${currentTypeid}&docgroup=${group.id}"><span
		class="glyphicon glyphicon-cloud-upload"></span>&nbsp;上传HTML站点
	</a>
</li> --%>
<li>
	<a
		href="index/FLcreatWebFile.htm?typeid=${currentTypeid}&docgroup=${group.id}"><span
		class="glyphicon glyphicon-floppy-open"></span>&nbsp;上传资源文件
	</a>
</li>