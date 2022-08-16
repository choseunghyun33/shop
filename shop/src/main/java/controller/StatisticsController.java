package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.StatisticsService;

@WebServlet("/StatisticsController/*")
public class StatisticsController extends HttpServlet {
	private StatisticsService statisticsService;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 응답 형태 결정
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		// gson 객체생성
		Gson gson = new Gson();
		String result = "";
		
		String uri = request.getRequestURI();
		// 디버깅
		System.out.println("StatisticsController.java uri --> " + uri);
		System.out.println("StatisticsController.java request.getContextPath() --> " + request.getContextPath());
		
		
		int n = request.getContextPath().length();
		String command = uri.substring(n);
		// 디버깅
		System.out.println("StatisticsController.java command --> " + command);
		
		// 초기화
		this.statisticsService = new StatisticsService();
		
		
		if(command.equals("/StatisticsController/getCount")) {
			Map<String, Object> m = this.statisticsService.getCount();
			result = gson.toJson(m);
		} else {
			System.out.println("잘못된 요청");
		}
		
		PrintWriter out = response.getWriter();
		out.write(result);
		out.flush();
		out.close();
	}
}
