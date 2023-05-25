package kr.happyjob.study.tut.controller;

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

import kr.happyjob.study.adm.model.SurveyModel;
import kr.happyjob.study.tut.model.TutSurveyModel;
import kr.happyjob.study.tut.service.TutSurveyService;

@Controller
@RequestMapping("/tut/")
public class TutSurveyController {

	@Autowired
	TutSurveyService tutSurveyService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 초기화면
	 */
	@RequestMapping("survey.do")
	public String survey(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		request.setAttribute("loginID", session.getAttribute("loginId"));

		logger.info("+ Start " + className + ".survey");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".survey");

		return "tut/survey/survey";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("surveyVue.do")
	public String surveyVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		request.setAttribute("loginID", session.getAttribute("loginId"));

		logger.info("+ Start " + className + ".surveyVue");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".surveyVue");

		return "tut/survey/surveyVue";
	}

	// 설문조사 결과 조회
	@RequestMapping("surveyResult.do")
	@ResponseBody
	public Map<String, Object> surveyResult(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".surveyResult");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		paramMap.put("loginID", session.getAttribute("loginId"));

		List<TutSurveyModel> surveyResult = tutSurveyService.surveyResult(paramMap);

		returnMap.put("surveyResult", surveyResult);

		logger.info("+ End " + className + ".surveyResult");

		return returnMap;
	}
	
	// 설문조사 강의 목록 조회
	@RequestMapping("vuesurveyLectureList.do")
	@ResponseBody
	public Map<String, Object> vuesurveyLectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vuesurveyLectureList");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		int pagenum = Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startPage = (pagenum - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPage", startPage);
		
		List<TutSurveyModel> vuesurveyLectureList = tutSurveyService.vuesurveyLectureList(paramMap);
		int totalCnt = tutSurveyService.surveyLectureListCnt(paramMap);
		
		returnmap.put("vuesurveyLectureList", vuesurveyLectureList);
		returnmap.put("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".vuesurveyLectureList");
		
		return returnmap;
	}
	
	// 설문조사 결과 조회
	@RequestMapping("vuesurveyResult.do")
	@ResponseBody
	public Map<String, Object> vuesurveyResult(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vuesurveyResult");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		TutSurveyModel vuesurveyResult = tutSurveyService.vuesurveyResult(paramMap);
		
		returnMap.put("vuesurveyResult", vuesurveyResult);
		
		logger.info("+ End " + className + ".vuesurveyResult");
		
		return returnMap;
	}

}
