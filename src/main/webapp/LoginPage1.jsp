<%@ page language="java" contentType="text/html; charset=Shift_JIS" pageEncoding="Shift_JIS"%>
<%@ page contentType="text/html; charset=Shift_JIS" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="Shift_JIS">
		<title>���O�C���y�[�W</title>
	</head>
	<body>

		<h1>�X�P�W���[�����ւ悤����</h1>
		<p>�X�P�W���[�����������p�����ɂ͂܂����O�C�����Ē����K�v������܂��B���[�U�[���ƃp�X���[�h����͂��ă��O�C�����ĉ������B</p>

        <!-- �F�؎��s����Ăяo���ꂽ�̂��ǂ���  --> 
		<%
        Object status = session.getAttribute("status");
		%>

		<%
        if (status != null){
		%>
        	<p>�F�؂Ɏ��s���܂���</p>
			<p>�ēx���[�U�[���ƃp�X���[�h����͂��ĉ�����</p>
		<%
            session.setAttribute("status", null);
        }
		%>


		<form method="POST" action="/scheduleMVC/LoginCheck" name="loginform">
			<table>
				<tr>
					<td>���[�U�[��</td>
					<td><input type="text" name="user" size="32"></td>
				</tr>

				<tr>
					<td>�p�X���[�h</td>
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
