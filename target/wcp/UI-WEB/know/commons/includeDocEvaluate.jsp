<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<div class="btn-group ">
	<button type="button" id="btnPraiseOkId"
		class="btn btn-default btn-success">
		 好评
		<span id="praiseyesNumId">${doc.runinfo.praiseyes}</span>
	</button>
	<button type="button" id="textLablePraiseNumId" class="btn btn-default"
		disabled="disabled">
		${doc.runinfo.evaluate}
	</button>
	<button type="button" id="btnPraiseNoId"
		class="btn btn-default btn-danger">
		差评
		<span id="praisenoNumId">${doc.runinfo.praiseno}</span>
	</button>
</div>
<script type="text/javascript">
	$(function() {
		var posting = false;
		$('#btnPraiseOkId').bind('click', function() {
			if (posting) {
				return;
			}
			$('#textLablePraiseNumId').text("...");
			posting = true;
			$.post('index/FPPraiseYes.htm', {
				id : '${doc.id}'
			}, function(flag) {
				posting = false;
				if (flag.pageset.commitType == '0') {
					$('#textLablePraiseNumId').text(flag.runinfo.evaluate);
					$('#praiseyesNumId').text(flag.runinfo.praiseyes);
					$('#praisenoNumId').text(flag.runinfo.praiseno);
				} else {
					alert(flag.pageset.message);
				}
			});
		});
		$('#btnPraiseNoId').bind('click', function() {
			if (posting) {
				return;
			}
			$('#textLablePraiseNumId').text("...");
			posting = true;
			$.post('index/FPPraiseNo.htm', {
				id : '${doc.id}'
			}, function(flag) {
				posting = false;
				if (flag.pageset.commitType == '0') {
					$('#textLablePraiseNumId').text(flag.runinfo.evaluate);
					$('#praiseyesNumId').text(flag.runinfo.praiseyes);
					$('#praisenoNumId').text(flag.runinfo.praiseno);
				} else {
					alert(flag.pageset.message);
				}
			});
		});
	});
</script>