<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div style="margin: 4px;">
	<div style="text-align: center;">
		<a id="OrganizationtreeChooseTreeOpenAll" href="javascript:void(0)"
			class="easyui-linkbutton" data-options="plain:true"
			iconCls="icon-sitemap">全部展开</a>
	</div>
	<hr />
	<ul id="OrganizationTreeNodeDomTree"></ul>
</div>
<script type="text/javascript">
	$(function() {
		$('#OrganizationtreeChooseTreeOpenAll').bind('click', function() {
			$('#OrganizationTreeNodeDomTree').tree('expandAll');
		});
		loadChooseTree($('#chooseMenuDomainId').val());
		$('#chooseMenuDomainId').bind('change', function() {
			loadChooseTree($('#chooseMenuDomainId').val());
		});
	});
	function loadChooseTree(domain) {
		$('#OrganizationTreeNodeDomTree').tree( {
			url : 'admin/FarmAuthorityOrganizationloadTree.do',
			onSelect : OrganizationTreeNodetreeNodeClick
		});
	}
	function OrganizationTreeNodetreeNodeClick(node) {
		$.messager.confirm(MESSAGE_PLAT.PROMPT, "是否移动该机构到目标机构下？",
				function(flag) {
					if (flag) {
						$.post("admin/farmAuthorityOrgTreeNodeSubmit.do", {
							ids : '${ids}',
							id : node.id
						}, function(flag) {
							if (flag.pageset.commitType == 0) {
								$('#OrgTreeNodeWin').window('close');
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