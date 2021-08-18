import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

public class ScheduleView1 extends HttpServlet{

    protected Connection conn = null;

    public void init() throws ServletException{

    	String jndi_url = "java:comp/env/jdbc/schedule";

    	try {
			Context ctx = new javax.naming.InitialContext();
			DataSource ds = (DataSource)ctx.lookup(jndi_url);
			conn = ds.getConnection();
    	}
//		catch (ClassNotFoundException ex){
//			log("ClassNotFoundException:" + e.getMessage());
//		}
		catch(NamingException ex) {
			// の呼び出しで、この例外が発生する可能性があります。
			log("NamingException:" + ex.getMessage());
		}
		catch(SQLException ex) {
			//ds. で、この例外が発生する可能性があります。
			log("SQLException:" + ex.getMessage());
		}
//		}catch (Exception ex){
//			log("Exception:" + ex.getMessage());
//		}

    }

    public void destory(){
        try{
            if (conn != null){
                conn.close();
            }
        }catch (SQLException e){
            log("SQLException:" + e.getMessage());
        }
    }

    public void doGet(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException{

        res.setContentType("text/html;charset=Shift_Jis");
        PrintWriter out = res.getWriter();

        int year = -1;
        int month = -1;
        int day = -1;
        int currentscheduleid;
        String currentStartTime = "";
        String currentEndTime = "";
        String currentSchedule = "";
        String currentMemo = "";

        String param = req.getParameter("ID");
        if (param == null || param.length() == 0){
            currentscheduleid = -1;
        }else{
            try{
                currentscheduleid = Integer.parseInt(param);
            }catch (NumberFormatException e){
                currentscheduleid = -1;
            }
        }

        /* パラメータが不正な場合はトップページへリダイレクト */
        if (currentscheduleid == -1){
            res.sendRedirect("/scheduleMVC/top.html");
        }

        /* ユーザー情報を取り出す */
        HttpSession session = req.getSession(false);
        String tmpuserid = (String)session.getAttribute("userid");
        int userid = 0;
        if (tmpuserid != null){
            userid = Integer.parseInt(tmpuserid);
        }

        try {
            String sql = "SELECT * FROM schedule WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, currentscheduleid);
            ResultSet rs = pstmt.executeQuery();

            rs.next();
        	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String scheduledate = dateFormat.format(rs.getDate("scheduledate"));
            String yearStr = scheduledate.substring(0, 4);
            String monthStr = scheduledate.substring(5, 7);
            String dayStr = scheduledate.substring(8, 10);

            year = Integer.parseInt(yearStr);
            month = Integer.parseInt(monthStr) - 1;
            day = Integer.parseInt(dayStr);

            dateFormat = new SimpleDateFormat("HH:mm:ss");
            currentStartTime = dateFormat.format(rs.getTime("starttime"));
            currentEndTime = dateFormat.format(rs.getTime("endtime"));
            currentSchedule = rs.getString("schedule");
            currentMemo = rs.getString("schedulememo");

            rs.close();
            pstmt.close();

        }catch (SQLException e){
            log("SQLException:" + e.getMessage());
        }

        
        session.setAttribute("year", year);
        session.setAttribute("month", month);
        session.setAttribute("day", day);

        
        session.setAttribute("currentscheduleid", currentscheduleid);
        session.setAttribute("currentStartTime", currentStartTime);
        session.setAttribute("currentEndTime", currentEndTime);
        session.setAttribute("currentSchedule", currentSchedule);
        session.setAttribute("currentMemo", currentMemo);
        

        String[] scheduleArray = new String[49];
        int[] widthArray = new int[49];

        for (int i = 0 ; i < 49 ; i++){
            scheduleArray[i] = "";
            widthArray[i] = 0;
        }

        try {
            String sql = "SELECT * FROM schedule WHERE userid = ? and scheduledate = ? ORDER BY starttime";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            String startDateStr = year + "-" + (month + 1) + "-" + day;
            pstmt.setInt(1, userid);
			pstmt.setDate(2, Date.valueOf(startDateStr));

            ResultSet rs = pstmt.executeQuery();

            while(rs.next()){
                int id = rs.getInt("id");
            	SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
            	String starttime = dateFormat.format(rs.getTime("starttime"));
            	String endtime = dateFormat.format(rs.getTime("endtime"));
                String schedule = rs.getString("schedule");

                if (starttime == null || endtime == null){
                    widthArray[0] = 1;

                    StringBuffer sbSchedule = new StringBuffer();
                    sbSchedule.append("<a href=\"/scheduleMVC/ScheduleView?ID=");
                    sbSchedule.append(id);
                    sbSchedule.append("\">");
                    sbSchedule.append(schedule);
                    sbSchedule.append("</a>");

                    scheduleArray[0] = scheduleArray[0] + (new String(sbSchedule)) + "<br>";

                }else{
                    String startTimeStr = starttime.substring(0, 2);
                    String startMinuteStr = starttime.substring(3, 5);

                    int startTimeNum = Integer.parseInt(startTimeStr);
                    int index = startTimeNum * 2 + 1;
                    if (startMinuteStr.equals("30")){
                        index++;
                    }

                    if (widthArray[index] == 0){
                    /* 既にデータが入っていた場合は異常な状態なので無視する */

                        String endTimeStr = endtime.substring(0, 2);
                        String endMinuteStr = endtime.substring(3, 5);

                        int endTimeNum = Integer.parseInt(endTimeStr);
                        int width = (endTimeNum - startTimeNum) * 2;

                        if (startMinuteStr.equals("30")){
                            width--;
                        }

                        if (endMinuteStr.equals("30")){
                            width++;
                        }

                        StringBuffer sbSchedule = new StringBuffer();
                        sbSchedule.append(startTimeStr);
                        sbSchedule.append(":");
                        sbSchedule.append(startMinuteStr);
                        sbSchedule.append("-");
                        sbSchedule.append(endTimeStr);
                        sbSchedule.append(":");
                        sbSchedule.append(endMinuteStr);
                        sbSchedule.append(" ");
                        sbSchedule.append("<a href=\"/scheduleMVC/ScheduleView?ID=");
                        sbSchedule.append(id);
                        sbSchedule.append("\">");
                        sbSchedule.append(schedule);
                        sbSchedule.append("</a>");

                        scheduleArray[index] = new String(sbSchedule);
                        widthArray[index] = width;

                        /* 同じスケジュールの先頭以外の箇所には「-1」を設定 */
                        for (int i = 1 ; i < width ; i++){
                            widthArray[index + i] = -1;
                        }
                    }
                }
            }

            rs.close();
            pstmt.close();

        }catch (SQLException e){
            log("SQLException:" + e.getMessage());
        }

        
        
        session.setAttribute("scheduleArray", scheduleArray);
        session.setAttribute("widthArray", widthArray);
        session.setAttribute("getMonthLastDay", getMonthLastDay(year, month, day));

        
        // JSPへのフォワード
    	RequestDispatcher rd = req.getRequestDispatcher("ScheduleView1.jsp");
    	rd.forward(req, res);
    }

    protected int getMonthLastDay(int year, int month, int day){

        Calendar calendar = Calendar.getInstance();

        /* 今月が何日までかを確認する */
        calendar.set(year, month + 1, 0);
        int thisMonthlastDay = calendar.get(Calendar.DATE);

        return thisMonthlastDay;
    }

}
