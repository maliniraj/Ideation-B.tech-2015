package controller;

import java.io.IOException;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utility.Misc;
import dao.user_roledao;
import dao.userdao;

/**
 * Servlet implementation class adddmincontroller
 */
@WebServlet("/addadmincontroller")
public class addadmincontroller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addadmincontroller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String user_id=request.getParameter("uid");
		String user_name=request.getParameter("uname");
        String email=request.getParameter("uemail");
       String mobile_no=request.getParameter("umobile");
       int level=Integer.parseInt(request.getParameter("ulevel"));
       int layer=Integer.parseInt(request.getParameter("ulayer"));
       String doj=request.getParameter("udoj");
       Random r=new Random();
       try{
           java.sql.Date date_joined = java.sql.Date.valueOf(doj);
    	 //Password Generation
           String str1;
           if(user_name.length()>=3)
    	   str1=user_name.substring(0,3);
           else
           str1=user_name;
           int r1=10000 + r.nextInt(90000);
           String str2=Integer.toString(r1);
           String password=str1.concat(str2);
    	   request.setAttribute("user_id",user_id);
           request.setAttribute("password",password);
           password=Misc.Encrypt(password);
    	   userdao userd=new userdao();
    	   userd.setUser(user_id, user_name, email, password, date_joined, level, layer, 0, mobile_no, "","",false,true);
           user_roledao user_roled=new user_roledao();
           user_roled.setUserRolebyUId(user_id,"2");
           RequestDispatcher rd=request.getRequestDispatcher("addadminsuccess.jsp");
			rd.forward(request, response);
       }
       catch(Exception e){
    	  e.printStackTrace(); 
       }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
