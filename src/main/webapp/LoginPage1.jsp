<%@ page language="java" contentType="text/html; charset=Shift_JIS" pageEncoding="Shift_JIS"%>
<%@ page contentType="text/html; charset=Shift_JIS" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="Shift_JIS">
		<title>ログインページ</title>
	</head>
	<body>

		<h1>スケジュール帳へようこそ</h1>
		<p>スケジュール帳をご利用頂くにはまずログインして頂く必要があります。ユーザー名とパスワードを入力してログインして下さい。</p>

        <!-- 認証失敗から呼び出されたのかどうか  --> 
		<%
        Object status = session.getAttribute("status");
		%>

		<%
        if (status != null){
		%>
        	<p>認証に失敗しました</p>
			<p>再度ユーザー名とパスワードを入力して下さい</p>
		<%
            session.setAttribute("status", null);
        }
		%>


		<form method="POST" action="/scheduleMVC/LoginCheck" name="loginform">
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
					<td><input type="submit" value="login"></td>
					<td><input type="reset" value="reset"></td>
				</tr>
			</table>
		</form>

	</body>
</html>
