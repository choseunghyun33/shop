package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.SignService;

@WebServlet("/signController")
public class SignController extends HttpServlet{
	// 멤버변수
	private SignService signService;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// json 인코딩, contentType setter
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		// 값 받기
		String customerCkId = request.getParameter("customerCkId");
		String employeeCkId = request.getParameter("employeeCkId");
	
		// 디버깅
		System.out.println("SignController.java customerCkId : " + customerCkId);
		System.out.println("SignController.java employeeCkId : " + employeeCkId);
		
		// 리턴받을 변수 초기화
		// 리턴값 boolean - true (id 사용가능)
		boolean idAvailable = false;
		// 메서드 실행 위한 객체 초기화
		this.signService = new SignService();
		
		
		// json으로 변경해는 Gson API 사용
		Gson gson = new Gson();
		String jsonStr = "";
		
		
		// 고객/직원 중 null이 아닌 것으로 분기
		if(customerCkId != null) {
			idAvailable = this.signService.idCheck(customerCkId);
			
			if(idAvailable) { // 성공
				jsonStr = gson.toJson("customerCkId ok");
			}
		} else if(employeeCkId != null) {
			idAvailable = this.signService.idCheck(employeeCkId);
			
			if(idAvailable) { // 성공
				jsonStr = gson.toJson("employeeCkId ok");
			}
		}
		// 디버깅
		System.out.println("SignController.java idAvailable : " + idAvailable);
		
		if(!idAvailable) {
			jsonStr = gson.toJson("not ok");
		}
		
		
		
		// 데이터 보내기
		PrintWriter out = response.getWriter();
		out.print(jsonStr);
		
		out.flush(); // 용량이 커도 다 보여주기
		out.close(); // 닫기
	}
	
}
