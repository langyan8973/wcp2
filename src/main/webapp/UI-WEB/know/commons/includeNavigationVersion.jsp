<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!-- 文档中的目录导航 -->
<style>
<!--
.affix {
	top: 4px;
	width: 230px;
}
-->
</style>
<div class="panel panel-default " id="docContentMenuId"
	style="z-index: 1000;">
	<div class="panel-heading">
		<span class="glyphicon glyphicon-list-alt"></span> 目录[
		<a id="topbuttonId">返回顶端</a>][
		<a id="buttombuttonId">返回底端</a>]
	</div>
	<div class="panel-body"
		style="line-height: 20px; list-style: none; padding: 4px;">
		<ul id="ContentMenuId" style="list-style-type: none"></ul>
		<hr />
	</div>
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
	function initLeftMenu() {
		$('#docContentMenuId').affix( {
			offset : {
				top : 400,
				bottom : 5
			}
		})
		$('h1,h2,h3', '#docContentsId').each(
				function(i, obj) {
					creatMenus(i, obj);
					$(obj).before("<a name='mark" + i + "'></a>");
					$('#linkmark' + i).bind('click', function() {
						location.hash = "mark" + i;
					});
				});
		$('#ContentMenuId').css('height', $(window).height() - 200);
		$('#ContentMenuId').css('overflow-y', 'auto');
	}
	$(function() {
		$('#topbuttonId').bind('click', function() {
			window.scrollTo(0, 0);
		});
		$('#markFileListSuperLink').bind('click', function() {
			location.hash = "markFileList";
		});
		$('#buttombuttonId').bind('click', function() {
			location.hash = "markbuttombutton";
		});
		$('#markdocTypeSuperLink').bind('click', function() {
			location.hash = "markdocType";
		});
		$('#markVersionListSuperLink').bind('click', function() {
			location.hash = "markVersionList";
		});

		initLeftMenu();
	});
</script>