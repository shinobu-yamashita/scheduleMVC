<%@ page language="java" contentType="text/html; charset=Shift_JIS" pageEncoding="Shift_JIS"%>
<%@ page contentType="text/html; charset=Shift_JIS" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0.1//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="ja">
	<head>
		<meta http-equiv="Content-Type" Content="text/html;charset=Shift_JIS">
		<title>スケジュール変更</title>
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

		<p><%=username%>さんのスケジュールです</p>

		<p>
			スケジュールの変更&nbsp;&nbsp;
			[<a href="/scheduleMVC/ScheduleView?ID=<%=currentscheduleid%>">スケジュール表示に戻る</a>]
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
								<%=scheduleArray[0]%>
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
								<td class="ex" rowspan="<%=widthArray[i]%>"><%=scheduleArray[i]%>
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
				</table>");
			</div>

			<div id="right">

				<form method="post" action="/scheduleMVC/ScheduleUpdate">
					<table>
						<tr>

							<td nowrap>日付</td>
							<td>
								<select name="YEAR">
<%
									for (int i = 2005 ; i <= 2999 ; i++){
%>
										<option value="<%=i%>"
<%
											if (i == year){
%>
												 selected
<%
											}
%>
											><%=i%>年
<%
									}
%>
								</select>

								<select name="MONTH">
<%
									for (int i = 1 ; i <= 12 ; i++){
%>
										<option value="<%=i%>"
<%
											if (i == (month + 1)){
%>
 												 selected
<%
											}
%>
											><%=i%>月
<%
									}
%>
								</select>

								<select name="DAY">
<%
									int monthLastDay = (int)session.getAttribute("getMonthLastDay");

									for (int i = 1 ; i <= monthLastDay ; i++){
%>
										<option value="<%=i%>"
<%
											if (i == day){
%>
												 selected
<%
											}
%>
											><%=i%>日
<%
									}
%>
								</select>

							</td>

						</tr>

						<tr>
							<td nowrap>時刻</td>
							<td>
								<select name="SHOUR">
<%
									if (currentStartTime == null){
%>
										<option value="" selected>--時
<%
											for (int i = 0 ; i <= 23 ; i++){
%>
												<option value="<%=i%>"><%=i%>時
<%
											}
									}else{
%>
										<option value="">--時
<%
											int shour = Integer.parseInt(currentStartTime.substring(0, 2));

											for (int i = 0 ; i <= 23 ; i++){
%>
												<option value="<%=i%>"
<%
												if (i == shour){
%>
													 selected
<%
												}
%>
												><%=i%>時
<%
											}
									}
%>
								</select>

								<select name="SMINUTE">
<%
									if (currentStartTime == null){
%>
										<option value="0" selected>00分
										<option value="30">30分
<%
									}else{
										String sminute = currentStartTime.substring(3, 5);
										if (sminute.equals("00")){
%>
											<option value="0" selected>00分
											<option value="30">30分
<%
										}else{
%>
											<option value="0">00分
											<option value="30" selected>30分
<%
										}
									}
%>
								</select>

								 -- 

								<select name="EHOUR">
<%
									if (currentEndTime == null){
%>
										<option value="" selected>--時
<%
										for (int i = 0 ; i <= 23 ; i++){
%>
											<option value="<%=i%>"><%=i%>時
<%
										}
									}else{
%>
										<option value="">--時
<%
											int ehour = Integer.parseInt(currentEndTime.substring(0, 2));

											for (int i = 0 ; i <= 23 ; i++){
%>
												<option value="<%=i%>"
<%
												if (i == ehour){
%>
													 selected
<%
												}
%>
												><%=i%>時
<%
											}
									}
%>
								</select>

								<select name="EMINUTE">
<%
									if (currentEndTime == null){
%>
										<option value="0" selected>00分
										<option value="30">30分
<%
									}else{

										String eminute = currentEndTime.substring(3, 5);

										if (eminute.equals("00")){
%>
											<option value="0" selected>00分
											<option value="30">30分
<%
										}else{
%>
											<option value="0">00分
											<option value="30" selected>30分
<%
										}
									}
%>
								</select>

							</td>
						</tr>

						<tr>
							<td nowrap>予定</td>
							<td><input type="text" name="PLAN" value="<%=currentSchedule%>" size="30" maxlength="100"></td>
						</tr>

						<tr>
							<td valign="top" nowrap>メモ</td>
							<td><textarea name="MEMO" cols="30" rows="10" wrap="virtual"><%=currentMemo%></textarea></td>
						</tr>

					</table>

					<p>
						<input type="hidden" name="ID" value="<%=currentscheduleid%>">
						<input type="submit" name="Register" value="変更する">
					<p>

				</form>

			</div>
		</div>

	</body>
</html>

