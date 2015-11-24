<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- 文档中的目录导航 -->
<div class="panel panel-default " id="docContentMenuId">
	<div class="panel-heading" style="font-size: 14px;">
		<span class="glyphicon glyphicon-list-alt"></span> 目录
	</div>
	<div class="panel-body"
		style="line-height: 20px; list-style: none; padding: 4px;">
		<ul id="ContentMenuId" style="list-style-type: none"></ul>
	</div>
	<div id="docContentsId" style="height: 0px; overflow: hidden;"></div>
</div>
<script type="text/javascript">
	function creatMenus(i, obj) {
		if ($(obj).get(0).tagName == 'H1') {
			$('#ContentMenuId').append(
					'<li style="margin-left: -20px;"><a style="font-size: 16px;" id="linkmark'
							+ i + '">' + $(obj).text() + '</a></li>');
		}
		if ($(obj).get(0).tagName == 'H2') {
			$('#ContentMenuId')
					.append(
							'<li style="margin-left: -20px;">&nbsp;&nbsp;&nbsp;&nbsp;<a style="font-size: 14px;" id="linkmark'
									+ i + '">' + $(obj).text() + '</a></li>');
		}
		if ($(obj).get(0).tagName == 'H3') {
			$('#ContentMenuId')
					.append(
							'<li style="margin-left: -20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a style="font-size: 12px;" id="linkmark'
									+ i + '">' + $(obj).text() + '</a></li>');
		}
	}
	function initLeftMenuFromHtml(html) {
		$('#ContentMenuId').html('');
		try {
			$('#docContentsId').html(html);
		} catch (e) {
		}
		$('h1,h2,h3', '#docContentsId').each(function(i, obj) {
			creatMenus(i, obj);
		});
		$('#ContentMenuId').css('height', $(window).height() - 300);
		$('#ContentMenuId').css('overflow-y', 'auto');
	}
</script>