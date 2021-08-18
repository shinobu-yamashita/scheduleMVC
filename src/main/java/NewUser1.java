import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class NewUser1 extends HttpServlet{

    public void doGet(HttpServletRequest req, HttpServletResponse res)
        throws IOException, ServletException{

        res.setContentType("text/html; charset=Shift_JIS");
        PrintWriter out = res.getWriter();

        /* ユーザー情報を取り出す */
        HttpSession session = req.getSession(false);
        String roll = (String)session.getAttribute("roll");
        if (roll == null || !roll.equals("1")){
            res.sendRedirect("/scheduleMVC/MonthView");
        }
        else {
    		// JSPへのフォワード
    		RequestDispatcher rd = req.getRequestDispatcher("NewUser1.jsp");
    		rd.forward(req, res);
        }

    }
}