<%@ page language="java" contentType="text/html; charset=Shift_JIS" pageEncoding="Shift_JIS"%>
<%@ page contentType="text/html; charset=Shift_JIS" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0.1//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="ja">
	<head>
		<meta http-equiv="Content-Type" Content="text/html;charset=Shift_JIS">
		<title>ユーザーの作成</title>
	</head>
	<body>



		<h1>ユーザーの作成</h1>
		<p>新しいユーザーを作成します</p>

<%
		Object status = session.getAttribute("CreateUserCheck");

		if (status != null){
			String statusStr = (String)status;

			if (statusStr.equals("Fail")){
%>
				<p>ユーザーの作成に失敗しました</p>
				<p>再度ユーザー名とパスワードを入力して下さい</p>
<%
            }else if (statusStr.equals("Success")){
%>
				<p>ユーザーの作成に成功しました</p>
				<p>続けて作成する場合はユーザー名とパスワードを入力して下さい</p>
<%
            }

            session.setAttribute("CreateUserCheck", null);
        }
%>

		<form method="POST" action="/scheduleMVC/CreateUserCheck" name="loginform">
			<table>
				<tr>
					<td>ユーザー名</td>
					<td><input type="text" name="user" size="32"></td>
				</tr>
				<tr>
					<td>パスワード</td>
					<td><input type="password" name="pass" size="32"></td>
				</tr>
				<tr>
					<td>権限</td>
					<td>
						<select name="roll">
							<option value="1">管理者
							<option value="0" selected>一般
						</select>
					</td>
				</tr>
				<tr>
					<td><input type="submit" value="create"></td>
					<td><input type="reset" value="reset"></td>
				</tr>
			</table>
		</form>

		<p>
			<a href="/scheduleMVC/MonthView">スケジュール一覧へ</a>
		</p>

	</body>
</html>
















