<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<link href='WEB-FACE/model/fullcalendar/fullcalendar.min.css'
	rel='stylesheet' />
<link href='WEB-FACE/model/fullcalendar/fullcalendar.print.css'
	rel='stylesheet' media='print' />
<script src='WEB-FACE/model/fullcalendar/moment.min.js'></script>
<script src='WEB-FACE/model/fullcalendar/fullcalendar.min.js'></script>
<script src='WEB-FACE/model/fullcalendar/zh-cn.js'></script>
<script>
	$(document).ready(
			function() {

				$('#calendar').fullCalendar(
						{
							header : {
								left : 'prev,next today',
								center : 'title',
								right : 'month,agendaWeek,agendaDay'
							},
							height : 400,
							defaultDate : '2014-11-12',
							selectable : true,
							selectHelper : true,
							select : function(start, end) {
								var title = prompt('日程:');
								var eventData;
								if (title) {
									eventData = {
										title : title,
										start : start,
										end : end
									};
									$('#calendar').fullCalendar('renderEvent',
											eventData, true); // stick? = true
								}
								$('#calendar').fullCalendar('unselect');
							},
							editable : true,
							eventLimit : true, // allow "more" link when too many events
							events : [ {
								title : 'All Day Event',
								start : '2014-11-01'
							}, {
								title : 'Long Event',
								start : '2014-11-07',
								end : '2014-11-10'
							}, {
								id : 999,
								title : 'Repeating Event',
								start : '2014-11-09T16:00:00'
							}, {
								id : 999,
								title : 'Repeating Event',
								start : '2014-11-16T16:00:00'
							}, {
								title : 'Conference',
								start : '2014-11-11',
								end : '2014-11-13'
							}, {
								title : 'Meeting',
								start : '2014-11-12T10:30:00',
								end : '2014-11-12T12:30:00'
							}, {
								title : 'Lunch',
								start : '2014-11-12T12:00:00'
							}, {
								title : 'Meeting',
								start : '2014-11-12T14:30:00'
							}, {
								title : 'Happy Hour',
								start : '2014-11-12T17:30:00'
							}, {
								title : 'Dinner',
								start : '2014-11-12T20:00:00'
							}, {
								title : 'Birthday Party',
								start : '2014-11-13T07:00:00'
							}, {
								title : 'Click for Google',
								url : 'http://google.com/',
								start : '2014-11-28'
							} ]
						});

			});
</script>
<style>
.fc-widget-header {
	background-color: #F3F3E8;
}

.fc-widget-content {
	background-color: #FAFAF3;
}
</style>
<div id='calendar' style="margin: 6px;"></div>