<%@ page language="java" contentType="text/html; charset=Shift_JIS" pageEncoding="Shift_JIS"%>
<%@ page contentType="text/html; charset=Shift_JIS" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0.1//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="ja">
	<head>
		<meta http-equiv="Content-Type" Content="text/html;charset=Shift_JIS">
		<title>���[�U�[�̍쐬</title>
	</head>
	<body>



		<h1>���[�U�[�̍쐬</h1>
		<p>�V�������[�U�[���쐬���܂�</p>

<%
		Object status = session.getAttribute("CreateUserCheck");

		if (status != null){
			String statusStr = (String)status;

			if (statusStr.equals("Fail")){
%>
				<p>���[�U�[�̍쐬�Ɏ��s���܂���</p>
				<p>�ēx���[�U�[���ƃp�X���[�h����͂��ĉ�����</p>
<%
            }else if (statusStr.equals("Success")){
%>
				<p>���[�U�[�̍쐬�ɐ������܂���</p>
				<p>�����č쐬����ꍇ�̓��[�U�[���ƃp�X���[�h����͂��ĉ�����</p>
<%
            }

            session.setAttribute("CreateUserCheck", null);
        }
%>

		<form method="POST" action="/scheduleMVC/CreateUserCheck" name="loginform">
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
					<td>����</td>
					<td>
						<select name="roll">
							<option value="1">�Ǘ���
							<option value="0" selected>���
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
			<a href="/scheduleMVC/MonthView">�X�P�W���[���ꗗ��</a>
		</p>

	</body>
</html>
















