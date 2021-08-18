<%@ page language="java" contentType="text/html; charset=Shift_JIS" pageEncoding="Shift_JIS"%>
<%@ page contentType="text/html; charset=Shift_JIS" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0.1//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="ja">
	<head>
		<meta http-equiv="Content-Type" Content="text/html;charset=Shift_JIS">
		<title>スケジュール管理</title>
		<style>
			table{border:1px solid #a9a9a9;width:90%;padding:0px;margin:0px;border-collapse:collapse;}
			td{width:12%;border-top:1px solid #a9a9a9;border-left:1px solid #a9a9a9;vertical-align:top;margin:0px;padding:2px;}
			td.week{background-color:#f0f8ff;text-align:center;}
			td.day{background-color:#f5f5f5;text-align:right;font-size:0.75em;}
			td.otherday{background-color:#f5f5f5;color:#d3d3d3;text-align:right;font-size:0.75em;}
			td.sche{background-color:#fffffff;text-align:left;height:80px;}
			img{border:0px;}
			span.small{font-size:0.75em;}
		</style>
	</head>

	<body>

		<%
			Object tmp = session.getAttribute("username");
			String username;
			if (tmp == null){
				username = "";
			}else{
				username = (String)tmp;
			}


			tmp = session.getAttribute("roll");
			String roll;
			if (tmp == null){
				roll = "";
			}else{
				roll = (String)tmp;
			}

			tmp = session.getAttribute("UserCalenderTable");
			String usertable;
			if (tmp == null){
				usertable = "";
			}else{
				usertable = (String)tmp;
			}
		%>


		<p>
			<%= username %> "さんのスケジュールです"

			<% if (roll.equals("1")){ %>
	        	&nbsp;[<a href="/scheduleMVC/NewUser">ユーザーの追加</a>]
			<% } %>

        	&nbsp;[<a href="/scheduleMVC/Logout">ログアウト</a>]
        </p>

		<%= usertable %>

	</body>

</html>
