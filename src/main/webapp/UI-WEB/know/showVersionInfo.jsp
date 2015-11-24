<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<base href="<PF:basePath/>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${doc.texts.etime}:${doc.title}-<PF:ParameterValue key="config.sys.title"/></title>
		<jsp:include page="/WEB-FACE/conf/include_bootstart.jsp"></jsp:include>

		<script src="<PF:basePath/>WEB-FACE/model/syntax-highlighter/brush.js"></script>
		<link
			href="<PF:basePath/>WEB-FACE/model/syntax-highlighter/shCore.css"
			rel="stylesheet" />
		<link
			href="<PF:basePath/>WEB-FACE/model/syntax-highlighter/shThemeDefault.css"
			rel="stylesheet" />
	</head>
	<body>
		<jsp:include page="../commons/head.jsp"></jsp:include>
		<div class="containerbox">
			<div class="container ">
				<div class="row">
					<div class="col-md-3  visible-lg visible-md">
						<div class="panel panel-default userbox">
							<div class="panel-body">
								<jsp:include page="/UI-WEB/commons/includeUserPanel.jsp"></jsp:include>
								<jsp:include page="../commons/loginbox.jsp"></jsp:include>
							</div>
						</div>
						<jsp:include page="../know/commons/includeNavigationVersion.jsp"></jsp:include>
					</div>
					<div class="col-md-9">
						<jsp:include page="../know/commons/version.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
		<a name="markbuttombutton"></a>
		<jsp:include page="../commons/foot.jsp"></jsp:include>
		<script type="text/javascript">
	$(function() {
		$('img', '#docContentsId').addClass("img-thumbnail");
		SyntaxHighlighter.config.clipboardSwf = basePath + 'WEB-FACE/model/syntax-highlighter/clipboard.swf';
		SyntaxHighlighter.config.strings = {
			expandSource : '展开代码',
			viewSource : '查看代码',
			copyToClipboard : '复制代码',
			copyToClipboardConfirmation : '代码复制成功',
			print : '打印',
			help : '?',
			alert : '语法高亮\n\n',
			noBrush : '不能找到刷子: ',
			brushNotHtmlScript : '刷子没有配置html-script选项',
			aboutDialog : '<div></div>'
		};
		SyntaxHighlighter.all();
	});
</script>
	</body>
</html>