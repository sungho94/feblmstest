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

import kr.happyjob.study.std.model.StdTestModel;
import kr.happyjob.study.std.service.StdTestService;


@Controller
@RequestMapping("/std/")
public class StdTestController {
	
	@Autowired
	StdTestService stdTestService;
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 초기화면
	 */
	@RequestMapping("test.do")
	public String test(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".test");
		logger.info("   - paramMap : " + paramMap);
		
		request.setAttribute("loginID", session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".test");

		return "std/test/test";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("testVue.do")
	public String testVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".testVue");
		logger.info("   - paramMap : " + paramMap);
		
		request.setAttribute("loginID", session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".testVue");

		return "std/test/testVue";
	}
	
	// 수강중인 강의 목록 조회
	@RequestMapping("testLectureList.do")
	public String testLectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".testLectureList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageNum = Integer.parseInt(String.valueOf(paramMap.get("pageNum")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int StratNum = (pageNum - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("StratNum", StratNum);
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		List<StdTestModel> testLectureList = stdTestService.testLectureList(paramMap);
		int totalCnt = stdTestService.testLectureListCnt(paramMap);
		
		model.addAttribute("testLectureList", testLectureList);
		model.addAttribute("totalCnt", totalCnt);
		
		
		logger.info("+ End " + className + ".testLectureList");
		
		return "std/test/testLectureList";
		
	}
	
	// 수강중인 강의 목록 조회
	@RequestMapping("vueTestLectureList.do")
	@ResponseBody
	public Map<String, Object> vueTestLectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".vueTestLectureList");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int pageNum = Integer.parseInt(String.valueOf(paramMap.get("pageNum")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int StratNum = (pageNum - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("StratNum", StratNum);
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		List<StdTestModel> testLectureList = stdTestService.testLectureList(paramMap);
		int totalCnt = stdTestService.testLectureListCnt(paramMap);
		
		resultMap.put("testLectureList", testLectureList);
		resultMap.put("totalCnt", totalCnt);
		
		
		logger.info("+ End " + className + ".vueTestLectureList");
		
		return resultMap;
		
	}
	
	// 시험 문제 불러오기
	@RequestMapping("testQuestion.do")
	public String testQuestion(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".testQuestion");
		logger.info("   - paramMap : " + paramMap);
		
		List<StdTestModel> testQuestion = stdTestService.testQuestion(paramMap);
		int testQuestionCnt = stdTestService.testQuestionCnt(paramMap);
		
		model.addAttribute("testQuestion", testQuestion);
		model.addAttribute("testQuestionCnt", testQuestionCnt);
		
		
		logger.info("+ End " + className + ".testQuestion");
		
		return "std/test/testQuestion";
	}
	
	// 시험 문제 불러오기
	@RequestMapping("vueTestQuestion.do")
	@ResponseBody
	public Map<String, Object> vueTestQuestion(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueTestQuestion");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<StdTestModel> testQuestion = stdTestService.testQuestion(paramMap);
		int testQuestionCnt = stdTestService.testQuestionCnt(paramMap);
		
		resultMap.put("testQuestion", testQuestion);
		resultMap.put("testQuestionCnt", testQuestionCnt);
		
		
		logger.info("+ End " + className + ".vueTestQuestion");
		
		return resultMap;
	}
	
	// 시험 문제 저장
	@RequestMapping("saveQuestion.do")
	@ResponseBody
	public Map<String, Object> saveQuestion(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".testQuestion");
		logger.info("   - paramMap : " + paramMap);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		String questionAnswer = "0";
		int questionNum = 1;
		int total = Integer.parseInt(String.valueOf(paramMap.get("testQuestionCnt")));
		
		for(questionNum = 1; questionNum <= total; questionNum++){
			
			questionAnswer = String.valueOf(paramMap.get("use_yn" + questionNum));

			paramMap.put("lecture_seq", Integer.parseInt(String.valueOf(paramMap.get("lecture_seq"))));
			paramMap.put("question_no", questionNum);
			paramMap.put("result_answer", questionAnswer);
			paramMap.put("test_no", Integer.parseInt(String.valueOf(paramMap.get("test_no"))));
			
			stdTestService.saveQuestion(paramMap);
		}
		
		stdTestService.updateStudent(paramMap);
		
		returnMap.put("result", "SUCESS");
		
		logger.info("+ End " + className + ".testQuestion");
		
		return returnMap;
	}
	
	// 시험 문제 저장
		@RequestMapping("vueSaveQuestion.do")
		@ResponseBody
		public Map<String, Object> vueSaveQuestion(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".vueSaveQuestion");
			logger.info("   - paramMap : " + paramMap);
			Map<String, Object> returnMap = new HashMap<String, Object>();
			paramMap.put("loginID", session.getAttribute("loginId"));
			
			String questionAnswer = "0";
			int questionNum = 1;
			int total = Integer.parseInt(String.valueOf(paramMap.get("testQuestionCnt")));
			
			for(questionNum = 1; questionNum <= total; questionNum++){
				
				//System.out.println("[[use_yn : "+String.valueOf(paramMap.get("use_yn["+0+"]"))+"]]");
				
				questionAnswer = String.valueOf(paramMap.get("use_yn["+questionNum+"]"));
				
				paramMap.put("lecture_seq", Integer.parseInt(String.valueOf(paramMap.get("lecture_seq"))));
				paramMap.put("question_no", questionNum);
				paramMap.put("result_answer", questionAnswer);
				paramMap.put("test_no", Integer.parseInt(String.valueOf(paramMap.get("test_no"))));
				
				stdTestService.saveQuestion(paramMap);
			}
			
			stdTestService.updateStudent(paramMap);
			
			returnMap.put("result", "SUCESS");
			
			logger.info("+ End " + className + ".vueSaveQuestion");
			
			return returnMap;
		}


}
