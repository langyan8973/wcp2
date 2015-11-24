<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<script>
	var gridTask = null;
	var currentEvent = null;
	$(document).ready(function() {
		$('#calendar').fullCalendar( {
			header : {
				left : 'prev,next today',
				center : 'title',
				right : 'month,basicWeek,basicDay'//,
			},
			height : 400,
			defaultDate : '${currentDate}',
			selectable : true,
			selectHelper : true,
			viewRender : nextTime,
			select : addEvent,
			eventClick : doEvent,
			editable : false
		});
	});
	function initEventColor(weightV) {
		var colorV = '#2966A3';
		if (weightV == '1') {
			colorV = '#2966A3';
		}
		if (weightV == '2') {
			colorV = '#CC6666';
		}
		if (weightV == '3') {
			colorV = '#CC3333';
		}
		if (weightV == '4') {
			colorV = '#CC0000';
		}
		if (weightV == '5') {
			colorV = '#FF0000';
		}
		return colorV;
	}

	function loadEvent(titelV, startV, endV, idV, weightV) {
		$("#calendar").fullCalendar('renderEvent', {
			title : titelV,
			start : startV,
			end : endV,
			id : idV,
			color : initEventColor(weightV)
		}, true);
	}
	function nextTime(flag) {
		var startPara = DateToFullDateTimeString(new Date(flag.start));
		var endPara = DateToFullDateTimeString(new Date(flag.end));
		$.post('admin/FarmCalendarLoadTask.do', {
			startD : startPara,
			endD : endPara
		}, function(flag) {
			$('#calendar').fullCalendar('removeEvents');
			$(flag.rows).each(
					function(i, obj) {
						loadEvent(obj.NAME, obj.PLANSTARTTIME,
								obj.PLANCOMPTIME, obj.ID, obj.WEIGHTVAL);
					});
		});
	}
	function addEvent(start, end) {
		var url = "admin/FarmPlanTaskAddShow.do" + '?pageset.pageType='
				+ PAGETYPE.ADD + "&entity.planstarttime="
				+ DateToFullDateTimeString(new Date(start));
		$.farm.openWindow( {
			id : 'winTask',
			width : 600,
			height : 300,
			modal : true,
			url : url,
			title : '添加任务'
		});
	}
	//添加任务完成后的回调函数
	function addSuccess(flag) {
		loadEvent(flag.entity.name, flag.entity.planstarttime,
				flag.entity.plancomptime, flag.entity.id, flag.entity.weightval);
	}
	//修改任务完成后的回调函数（修改、完成、确认）
	function editSuccess() {
		$.post('admin/FarmCalendarTaskInfo.do', {
			ids : currentEvent.id
		}, function(flag) {
			if (flag) {
				currentEvent.title = flag.name;
				currentEvent.start = flag.planstarttime;
				currentEvent.end = flag.plancomptime;
				currentEvent.color = initEventColor(flag.weightval);
				$('#calendar').fullCalendar('updateEvent', currentEvent);
			} else {
				$('#calendar').fullCalendar('removeEvents', currentEvent.id);
			}
		});
	}

	function doEvent(event) {
		currentEvent = event;
		var url = "admin/FarmPlanTaskShow.do" + '?pageset.pageType='
				+ PAGETYPE.EDIT + '&ids=' + event.id;
		$.farm.openWindow( {
			id : 'winTask',
			width : 600,
			height : 300,
			modal : true,
			url : url,
			title : '任务详情'
		});
	}
	//格式化日期：yyyy-MM-dd
	function DateToFullDateTimeString(date) {
		var year = date.getFullYear();
		var month = date.getMonth();
		var day = date.getDate();
		var hour = date.getHours();
		var minute = date.getMinutes();
		var second = date.getSeconds();
		var datestr;
		if (month < 9) {
			month = '0' + (month + 1);
		} else {
			month = (month + 1);
		}
		if (day < 10) {
			day = '0' + day;
		}
		if (hour < 10) {
			hour = '0' + hour;
		}
		if (minute < 10) {
			minute = '0' + minute;
		}
		if (second < 10) {
			second = '0' + second;
		}
		datestr = year + '-' + month + '-' + day;
		return datestr;
	}
</script>
<style>
.fc-widget-header {
	background-color: #F3F3E8;
}

.fc-widget-content {
	background-color: #FAFAF3;
}

.fc-more {
	font-weight: bold;
	font-size: 12px;
	color: #2966a3;
}

a.fc-more {
	font-weight: bold;
	font-size: 12px;
	color: #2966a3;
}
</style>
<div id='calendar' style="margin: 6px;"></div>