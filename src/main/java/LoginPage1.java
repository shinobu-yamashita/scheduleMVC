import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginPage1 extends HttpServlet{

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException{

    	
    	//sessionの開始
        HttpSession session = request.getSession(true);
    	
		// ログイン画面の処理
		// JSPへのフォワード
		RequestDispatcher rd = request.getRequestDispatcher("LoginPage1.jsp");
		rd.forward(request, response);

    }
}