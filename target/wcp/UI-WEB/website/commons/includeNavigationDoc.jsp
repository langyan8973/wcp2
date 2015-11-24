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
		<a id="topbuttonId">TOP</a>][
		<a id="buttombuttonId">BUTTOM</a>]
	</div>
	<div class="panel-heading">
		<div style="text-align: center;">
			<jsp:include page="/UI-WEB/know/commons/includeDocEvaluate.jsp"></jsp:include>
		</div>
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
		$('h1,h2,h3', '#docContentsId').each(function(i, obj) {
			creatMenus(i, obj);
			$(obj).before("<a name='mark" + i + "'></a>");
			$('#linkmark' + i).bind('click', function() {
				//location.hash = "mark" + i;
					$('html,body').animate( {
						scrollTop : $("a[name='mark" + i + "']").offset().top
					}, 500);
				});
		});
		$('#ContentMenuId').css('overflow-y', 'auto');
	}
	$(function() {
		$('#topbuttonId').bind('click', function() {
			//window.scrollTo(0, 0);
				$('html,body').animate( {
					scrollTop : 0
				}, 500);
			});
		$('#markDocPriceSuperLink').bind('click', function() {
			//location.hash = "markFileList";
				$('html,body').animate( {
					scrollTop : $("a[name='markDocPrice']").offset().top - 50
				}, 500);
			});
		$('#markFileListSuperLink').bind('click', function() {
			//location.hash = "markFileList";
				$('html,body').animate( {
					scrollTop : $("a[name='markFileList']").offset().top
				}, 500);
			});
		$('#buttombuttonId').bind('click', function() {
			//location.hash = "markbuttombutton";
				$('html,body').animate( {
					scrollTop : $("a[name='markbuttombutton']").offset().top
				}, 500);
			});
		$('#markdocTypeSuperLink').bind('click', function() {
			//location.hash = "markdocType";
				$('html,body').animate( {
					scrollTop : $("a[name='markdocType']").offset().top
				}, 500);
			});
		$('#markVersionListSuperLink').bind('click', function() {
			//location.hash = "markVersionList";
				$('html,body').animate( {
					scrollTop : $("a[name='markVersionList']").offset().top
				}, 500);
			});

		initLeftMenu();
	});
</script>