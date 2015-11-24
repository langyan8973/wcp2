var wcpKnowdialog;
var wcpKnowEditor;
KindEditor.plugin('wcpknow',function(K) {
	wcpKnowEditor = this, name = 'wcpknow';
	wcpKnowEditor.clickToolbar(name,function() {
		wcpKnowdialog = K
			.dialog( {
				width : 250,
				title : '选择知识',
				body : '<div style="margin:10px;text-align: center;"><input id="wcpknow_input_id" type="text"/><span class="ke-button-common ke-button-outer ke-dialog-yes" title="查找"><input class="ke-button-common ke-button" id="wcpknow_button_id" value="查找" type="button"></span><br/><div class="wcpknow_search_rbox_c" id="wcpknow_search_rbox"></div></div>',
				closeBtn : {
					name : '关闭',
					click : function(e) {
						wcpKnowdialog.remove();
					}
				}
			});
		loadKnow_wcpKnow();
		$('#wcpknow_button_id').bind('click',function() {
			loadKnow_wcpKnow($(
					'#wcpknow_input_id')
					.val());
		});
		$('#wcpknow_input_id').keydown(function(e){
			if(e.keyCode==13){
				loadKnow_wcpKnow($(
				'#wcpknow_input_id')
				.val());
			}
		});
	});
});
function loadKnow_wcpKnow(knowtitle) {
	$('#wcpknow_search_rbox').html('loading...');
	$.post('index/FPsearchKnow.htm', {
		'knowtitle' : knowtitle
	}, function(flag) {
		if (flag && flag.totalSize && flag.totalSize > 0) {
			$('#wcpknow_search_rbox').html('');
			$(flag.resultList).each(
					function(i, obj) {
						$('#wcpknow_search_rbox').append(
								'<a onClick="clickLink_wcpKnow(this)" id="'
										+ obj.ID + '" wcptype="'
										+ obj.DOMTYPE + '">' + obj.TITLE
										+ '</a></br>');
					});
		} else {
			alert('未匹配到相关知识!');
		}
	});
}
function clickLink_wcpKnow(flag) {
	var id = $(flag).attr('id');
	var title = $(flag).text();
	var type = $(flag).attr('wcptype');
	//1.HTML文档，2.txt，3html站点
	if (type == '1') {
		wcpKnowEditor.insertHtml('<a href="index/FPDocShow.htm?id=' + id
				+ '">' + title + '</a>');
	}
	if (type == '3') {
		wcpKnowEditor
				.insertHtml('<a href="index/FPwebSiteVisitSite.htm?id='
						+ id + '" target="_blank">' + title + '</a>');
	}
	wcpKnowdialog.remove();
}


KindEditor.lang({ wcpknow : '插入知识' });