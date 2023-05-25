package kr.happyjob.study.adm.controller;

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

import kr.happyjob.study.adm.model.TestResultModel;
import kr.happyjob.study.adm.service.TestResultService;


@Controller
@RequestMapping("/adm/")
public class TestResultController {
	
	@Autowired
	TestResultService testResultService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 초기화면
	 */
	@RequestMapping("testResult.do")
	public String testResult(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".testResult");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".testResult");

		return "adm/testResult/testResult";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("testResultVue.do")
	public String testResultVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".testResultVue");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".testResultVue");

		return "adm/testResult/testResultVue";
	}
	
	/**
	 * 개설 강의 목록 조회
	 */
	@RequestMapping("testResultLectureList.do")
	public String testResultLectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".testResultLectureList");
		logger.info("   - paramMap : " + paramMap);
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<TestResultModel> testResultLectureList = testResultService.testResultLectureList(paramMap);
		int totalcnt = testResultService.testResultLectureListCnt(paramMap);
		
		model.addAttribute("testResultLectureList", testResultLectureList);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".testResultLectureList");

		return "adm/testResult/testResultLectureList";
	}
	
	/**
	 * 개설 강의 목록 조회 Vue
	 */
	@RequestMapping("vuetestResultLectureList.do")
	@ResponseBody
	public Map<String, Object> vuetestResultLectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vuetestResultLectureList");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<TestResultModel> testResultLectureList = testResultService.testResultLectureList(paramMap);
		int totalcnt = testResultService.testResultLectureListCnt(paramMap);
		
		returnmap.put("testResultLectureList", testResultLectureList);
		returnmap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vuetestResultLectureList");

		return returnmap;
	}
	
	/**
	 * 학생 목록 조회
	 */
	@RequestMapping("testResultSelect.do")
	public String testResultSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".testResultSelect");
		logger.info("   - paramMap : " + paramMap);
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<TestResultModel> testResultSelect = testResultService.testResultSelect(paramMap);
		int totalcnt = testResultService.testResultSelectCnt(paramMap);
		
		model.addAttribute("testResultSelect", testResultSelect);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".testResultSelect");

		return "adm/testResult/testResultStudentList";
	}
	
	/**
	 * 학생 목록 조회 Vue
	 */
	@RequestMapping("vuetestResultSelect.do")
	@ResponseBody
	public Map<String, Object> vuetestResultSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vuetestResultSelect");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<TestResultModel> testResultSelect = testResultService.testResultSelect(paramMap);
		int totalcnt = testResultService.testResultSelectCnt(paramMap);
		
		returnmap.put("testResultSelect", testResultSelect);
		returnmap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vuetestResultSelect");

		return returnmap;
	}


}
