<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div style="margin: 4px;">
	<div style="text-align: center;">
		<select id="chooseMenuDomainId" style="width: 100px;">
			<option value="alone">
				标准权限
			</option>
			<PF:OptionDictionary index="ALONE_MENU_DOMAIN" isTextValue="0" />
		</select>
		<a id="ActiontreeChooseTreeOpenAll" href="javascript:void(0)"
			class="easyui-linkbutton" data-options="plain:true"
			iconCls="icon-sitemap">全部展开</a>
	</div>
	<hr />
	<ul id="ActionTreeNodeDomTree"></ul>
</div>
<script type="text/javascript">
	$(function() {
		$('#ActiontreeChooseTreeOpenAll').bind('click', function() {
			$('#ActionTreeNodeDomTree').tree('expandAll');
		});
		loadChooseTree($('#chooseMenuDomainId').val());
		$('#chooseMenuDomainId').bind('change', function() {
			loadChooseTree($('#chooseMenuDomainId').val());
		});
	});
	function loadChooseTree(domain) {
		$('#ActionTreeNodeDomTree').tree( {
			url : 'admin/FarmAuthorityActiontreeloadTree.do?domain=' + domain,
			onSelect : ActionTreeNodetreeNodeClick
		});
	}
	function ActionTreeNodetreeNodeClick(node) {
		$.messager.confirm(MESSAGE_PLAT.PROMPT, "是否移动该节点到目标节点下？",
				function(flag) {
					if (flag) {
						$.post("admin/farmAuthorityActionTreeNodeSubmit.do", {
							ids : '${ids}',
							id : node.id
						}, function(flag) {
							if (flag.pageset.commitType == 0) {
								$('#ActionTreeNodeWin').window('close');
							} else {
								$.messager.alert(MESSAGE_PLAT.ERROR,
										flag.pageset.message, 'error');
							}
						});
					}
				});
	}
	//-->
</script>