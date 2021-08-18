<%@ page language="java" contentType="text/html; charset=Shift_JIS" pageEncoding="Shift_JIS"%>
<%@ page contentType="text/html; charset=Shift_JIS" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0.1//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="ja">
	<head>
		<meta http-equiv="Content-Type" Content="text/html;charset=Shift_JIS">
		<title>�X�P�W���[���o�^</title>
		<style>
			table.sche{border:1px solid #a9a9a9;padding:0px;margin:0px;border-collapse:collapse;}
			td{vertical-align:top;margin:0px;padding:2px;font-size:0.75em;height:20px;}
			td.top{border-bottom:1px solid #a9a9a9;text-align:center;}
			td.time{background-color:#f0f8ff;text-align:right;border-right:1px double #a9a9a9;padding-right:5px;}
			td.timeb{background-color:#f0f8ff;border-bottom:1px solid #a9a9a9;border-right:1px double #a9a9a9;}
			td.contents{background-color:#ffffff;border-bottom:1px dotted #a9a9a9;}
			td.contentsb{background-color:#ffffff;border-bottom:1px solid #a9a9a9;}
			td.ex{background-color:#ffebcd;border:1px solid #8b0000;}
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

		String[] scheduleArray = (String[])session.getAttribute("scheduleArray");
		int[] widthArray = (int[])session.getAttribute("widthArray");
%>


		<p>
			<%= username %> "����̃X�P�W���[���ł�"
		</p>

		<p>
			�X�P�W���[���o�^&nbsp;&nbsp;
			[<a href="/scheduleMVC/MonthView
			?YEAR= <%= year  %>
			&MONTH=<%= month %>
			">�J�����_�[�֖߂�</a>]
        </p>

        
        
        
		<div id="contents">

			<div id="left">

				<table class="sche">
					<tr><td class="top" style="width:80px">����</td><td class="top" style="width:300px">�\��</td></tr>

					<tr>
						<td class="timeb">����</td>
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

				<form method="post" action="/scheduleMVC/ScheduleInsert">
					<table>
						<tr>
							<td nowrap>���t</td>
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
										><%=i%>�N
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
										><%=i%>��
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
										><%=i%>��
<%
									}
%>
								</select>

							</td>
						</tr>

						<tr>
							<td nowrap>����</td>
							<td>
								<select name="SHOUR">
									<option value="" selected>--��
<%
										for (int i = 0 ; i <= 23 ; i++){
%>
											<option value="<%=i%>">
												<%=i%>��
<%
										}
%>
								</select>

								<select name="SMINUTE">
									<option value="0">00��
									<option value="30">30��
								</select>

								 -- 

								<select name="EHOUR">
									<option value="" selected>--��
<%
										for (int i = 0 ; i <= 23 ; i++){
%>
											<option value="<%=i%>">
												<%=i%>��
<%
										}
%>
								</select>

								<select name="EMINUTE">
									<option value="0">00��
									<option value="30">30��
								</select>

							</td>
						</tr>

						<tr>
							<td nowrap>�\��</td>
							<td><input type="text" name="PLAN" value="" size="30" maxlength="100"></td>
						</tr>

						<tr>
							<td valign="top" nowrap>����</td>
							<td><textarea name="MEMO" cols="30" rows="10" wrap="virtual"></textarea></td>
						</tr>
					</table>

					<p>
					<input type="submit" name="Register" value="�o�^����">
					<input type="reset" value="���͂�����">
					<p>
				</form>

			</div>
		</div>

	</body>

</html>