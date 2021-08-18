<%@ page language="java" contentType="text/html; charset=Shift_JIS" pageEncoding="Shift_JIS"%>
<%@ page contentType="text/html; charset=Shift_JIS" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0.1//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="ja">
	<head>
		<meta http-equiv="Content-Type" Content="text/html;charset=Shift_JIS">
		<title>スケジュール登録</title>
		<style>
			table.sche{border:1px solid #a9a9a9;padding:0px;margin:0px;border-collapse:collapse;}
			td{vertical-align:top;margin:0px;padding:2px;font-size:0.75em;height:20px;}
			td.top{border-bottom:1px solid #a9a9a9;text-align:center;}
			td.time{background-color:#f0f8ff;text-align:right;border-right:1px double #a9a9a9;padding-right:5px;}
			td.timeb{background-color:#f0f8ff;border-bottom:1px solid #a9a9a9;border-right:1px double #a9a9a9;}
			td.contents{background-color:#ffffff;border-bottom:1px dotted #a9a9a9;}
			td.contentsb{background-color:#ffffff;border-bottom:1px solid #a9a9a9;}
			td.ex{background-color:#ffebcd;border:1px solid #8b0000;}
			table.view{border:1px solid #a9a9a9;padding:0px;margin:0px;border-collapse:collapse;width:250px}
			table.view td{border:1px solid #a9a9a9;}
			table.view td.left{width:70px;background-color:#f0f8ff;}
			img{border:0px;}
			p{font-size:0.75em;}

			#contents{margin:0;padding:0;width:710px;}
			#left{margin:0;padding:0;float:left;width:400px;}
			#right{margin:0;padding:0;float:right;width:300px;background-color:#ffffff;}
			#contents:after{content:\".\";display:block;height:0;clear:both;visibility:hidden;}
		</style>
	</head>
	<body>

<%
		String username = (String)session.getAttribute("username");

		int year  = (int)session.getAttribute("year");
		int month = (int)session.getAttribute("month");
		int day = (int)session.getAttribute("day");

		int currentscheduleid = (int)session.getAttribute("currentscheduleid");
        String currentStartTime = (String)session.getAttribute("currentStartTime");
        String currentEndTime = (String)session.getAttribute("currentEndTime");
        String currentSchedule = (String)session.getAttribute("currentSchedule");
        String currentMemo = (String)session.getAttribute("currentMemo");

		String[] scheduleArray = (String[])session.getAttribute("scheduleArray");
		int[] widthArray = (int[])session.getAttribute("widthArray");
%>

		<p><%= username %>さんのスケジュールです</p>

		<p>
			既存スケジュール確認&nbsp;&nbsp;
			[<a href="/scheduleMVC/MonthView
			?YEAR= <%= year  %>
			&MONTH=<%= month %>
			">カレンダーへ戻る</a>]
        </p>




		<div id="contents">

			<div id="left">

				<table class="sche">
					<tr>
						<td class="top" style="width:80px">時刻</td>
						<td class="top" style="width:300px">予定</td>
					</tr>

					<tr>
						<td class="timeb">未定</td>
						<td class="contentsb">
<%
							if (widthArray[0] == 1){
%>
								<%= scheduleArray[0] %>
<%
							}
%>
						</td>
					</tr>
<%
					for (int i = 1 ; i < 49 ; i++){
						if (i % 2 == 1){
%>
							<tr><td class="time"><%=i / 2%>:00</td>
<%
						}else{
%>
							<tr><td class="timeb"></td>
<%
						}

						if (widthArray[i] != 0){
							if (widthArray[i] != -1){
%>
								<td class="ex" rowspan="<%= widthArray[i] %>"><%= scheduleArray[i] %>
<%
							}
						}else{
							if (i % 2 == 1){
%>
								<td class="contents">
<%
							}else{
%>
								<td class="contentsb">
<%
							}
						}
%>

						</td></tr>
<%
					}
%>

				</table>

			</div>

			<div id="right">

				<table class="view">
					<tr>
						<td class="left">日付</td>
						<td>
							<%=year%>年
							<%=month + 1%>月
							<%=day%>日
						</td>
					</tr>
					<tr>
						<td class="left">時間</td>
						<td>
<%
							if (currentStartTime == null){
%>
								未定
<%
							}else{
%>
								<%=currentStartTime.substring(0, 5)%> - 
								<%=currentEndTime.substring(0, 5)%>
<%
							}
%>
						</td>
					</tr>
					<tr>
						<td class="left">スケジュール</td>
						<td><%=currentSchedule%></td>
					</tr>
					<tr>
						<td class="left" style="height:150px;">メモ</td>
						<td>
<%							
        					currentMemo = currentMemo.replaceAll("\r\n", "<br>");
%>
							<%=currentMemo%>
						</td>
					</tr>
				</table>

				<p>
					[<a href="/scheduleMVC/EditSchedule?ID=<%=currentscheduleid%>">スケジュールの変更</a>]
					&nbsp;&nbsp;
					[<a href="/scheduleMVC/DeleteCheck?ID=<%=currentscheduleid%>">スケジュールの削除</a>]
				</p>

			</div>
		</div>

	
	</body>
</html>














