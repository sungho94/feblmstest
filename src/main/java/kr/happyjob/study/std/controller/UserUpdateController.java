package kr.happyjob.study.std.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.adm.service.StudentService;
import kr.happyjob.study.std.model.UserUpdateModel;
import kr.happyjob.study.std.service.UserUpdateService;


@Controller
@RequestMapping("/std/")
public class UserUpdateController {
	
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	UserUpdateService userUpdateService;
	
	/**
	 * 초기화면
	 */
	@RequestMapping("userUpdate.do")
	public String userUpdate(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".userUpdate");
		logger.info("   - paramMap : " + paramMap);
		
		// 사용자 아이디 설정
		request.setAttribute("loginId", session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".userUpdate");

		return "std/userUpdate/userUpdate";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("userUpdateVue.do")
	public String userUpdateVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".userUpdateVue");
		logger.info("   - paramMap : " + paramMap);
		
		// 사용자 아이디 설정
		request.setAttribute("loginId", session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".userUpdateVue");

		return "std/userUpdate/userUpdateVue";
	}
	
	// 상세정보 가져오기
	@RequestMapping("userUpdateList.do")
	@ResponseBody
	public Map<String, Object> userUpdateList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".userUpdateList");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		UserUpdateModel userUpdateList = userUpdateService.userUpdateList(paramMap);
		
		returnMap.put("userUpdateList", userUpdateList);
		
		logger.info("+ End " + className + ".userUpdateList");
		
		return returnMap;
	}
	
	// 개인정보 수정 저장
	@RequestMapping("studentUpdate.do")
	@ResponseBody
	public Map<String, Object> studentUpdate(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		userUpdateService.studentUpdate(paramMap, request, session);
		
		returnMap.put("result", "SUCESS");
		
		return returnMap;
	}
	

	// 상세정보 가져오기
	@RequestMapping("vueuserUpdateList.do")
	@ResponseBody
	public Map<String, Object> vueuserUpdateList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".userUpdateList");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		UserUpdateModel userUpdateList = userUpdateService.userUpdateList(paramMap);
		
		returnMap.put("userUpdateList", userUpdateList);
		
		logger.info("+ End " + className + ".userUpdateList");
		
		return returnMap;
	}
	
	// 개인정보 수정 저장
	@RequestMapping("vuestudentUpdate.do")
	@ResponseBody
	public Map<String, Object> vuestudentUpdate(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		userUpdateService.studentUpdate(paramMap, request, session);
		
		returnMap.put("result", "SUCESS");
		
		return returnMap;
	}

}
