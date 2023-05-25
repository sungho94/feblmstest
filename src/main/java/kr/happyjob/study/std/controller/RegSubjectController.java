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

import kr.happyjob.study.common.comnUtils.ComnUtil;
import kr.happyjob.study.std.model.RegSubjectModel;
import kr.happyjob.study.std.service.RegSubjectService;

@Controller
@RequestMapping("/std/")
public class RegSubjectController {

	@Autowired
	RegSubjectService regSubjectService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 초기화면
	 */
	@RequestMapping("regSubject.do")
	public String regSubject(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".regSubject");
		logger.info("   - paramMap : " + paramMap);

		request.setAttribute("loginId", session.getAttribute("loginId"));

		logger.info("+ End " + className + ".regSubject");

		return "std/regSubject/regSubject";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("regSubjectVue.do")
	public String regSubjectVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".regSubjectVue");
		logger.info("   - paramMap : " + paramMap);

		request.setAttribute("loginId", session.getAttribute("loginId"));

		logger.info("+ End " + className + ".regSubjectVue");

		return "std/regSubject/regSubjectVue";
	}

	// 수강목록 조회
	@RequestMapping("regSubjectList.do")
	public String regSubjectList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".regSubjectList");
		logger.info("   - paramMap : " + paramMap);

		int pageNum = Integer.parseInt(String.valueOf(paramMap.get("pageNum")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startPage = (pageNum - 1) * pageSize;

		paramMap.put("pageSize", pageSize);
		paramMap.put("startPage", startPage);

		paramMap.put("loginID", session.getAttribute("loginId"));

		List<RegSubjectModel> regSubjectList = regSubjectService.regSubjectList(paramMap);
		int totalCnt = regSubjectService.regSubjectListCnt(paramMap);

		model.addAttribute("regSubjectList", regSubjectList);
		model.addAttribute("totalCnt", totalCnt);

		logger.info("+ End " + className + ".regSubjectList");

		return "std/regSubject/regSubjectList";
	}
	
	// 수강목록 조회
		@RequestMapping("vueregSubjectList.do")
		@ResponseBody
		public Map<String, Object> vueregSubjectList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			logger.info("+ Start " + className + ".vueregSubjectList");
			logger.info("   - paramMap : " + paramMap);

			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			int pageNum = Integer.parseInt(String.valueOf(paramMap.get("pageNum")));
			int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
			int startPage = (pageNum - 1) * pageSize;

			paramMap.put("pageSize", pageSize);
			paramMap.put("startPage", startPage);

			paramMap.put("loginID", session.getAttribute("loginId"));
			
			List<RegSubjectModel> regSubjectList = regSubjectService.regSubjectList(paramMap);
			int totalCnt = regSubjectService.regSubjectListCnt(paramMap);

			returnmap.put("regSubjectList", regSubjectList);
			returnmap.put("totalCnt", totalCnt);
			
			logger.info("+ End " + className + ".vueregSubjectList");

			return returnmap;
		}

	// 강의 목표 및 강의 계획서 조회
	@RequestMapping("lecturePlanList.do")
	public String lecturePlanList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".lecturePlanList");
		logger.info("   - paramMap : " + paramMap);

		List<RegSubjectModel> lecturePlanList = regSubjectService.lecturePlanList(paramMap);
		//List<RegSubjectModel> lectureGoalList = regSubjectService.lectureGoalList(paramMap);
		
		int totalCnt = regSubjectService.lecturePlanListCnt(paramMap);

		model.addAttribute("lecturePlanList", lecturePlanList);
		//model.addAttribute("lectureGoalList", lectureGoalList);
		model.addAttribute("totalCnt", totalCnt);

		logger.info("+ End " + className + ".lecturePlanList");

		return "std/regSubject/lecturePlanList";
	}
	
	// 강의 목표 및 강의 계획서 조회
		@RequestMapping("vuelecturePlanList.do")
		@ResponseBody
		public Map<String, Object> vuelecturePlanList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("+ Start " + className + ".vuelecturePlanList");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			List<RegSubjectModel> lecturePlanList = regSubjectService.lecturePlanList(paramMap);
			//List<RegSubjectModel> lectureGoalList = regSubjectService.lectureGoalList(paramMap);
			
			int totalCnt = regSubjectService.lecturePlanListCnt(paramMap);

			returnmap.put("lecturePlanList", lecturePlanList);
			//model.addAttribute("lectureGoalList", lectureGoalList);
			returnmap.put("totalCnt", totalCnt);

			logger.info("+ End " + className + ".vuelecturePlanList");

			return returnmap;
		}

	// 설문조사 문항 목록 조회
	@RequestMapping("surveyQuestionList.do")
	public String surveyQuestionList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".surveyQuestionList");
		logger.info("   - paramMap : " + paramMap);

		List<RegSubjectModel> surveyQuestionList = regSubjectService.surveyQuestionList(paramMap);

		model.addAttribute("surveyQuestionList", surveyQuestionList);

		logger.info("+ End " + className + ".surveyQuestionList");

		return "std/regSubject/surveyQuestionList";
	}
	

	// 설문조사 문항 목록 조회
	@RequestMapping("vuesurveyQuestionList.do")
	@ResponseBody
	public Map<String, Object> vuesurveyQuestionList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".vuesurveyQuestionList");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		List<RegSubjectModel> surveyQuestionList = regSubjectService.surveyQuestionList(paramMap);

		returnmap.put("surveyQuestionList", surveyQuestionList);

		logger.info("+ End " + className + ".vuesurveyQuestionList");

		return returnmap;
	}

	// 설문 조사 저장
	@RequestMapping("saveSurvey.do")
	@ResponseBody
	public Map<String, Object> saveSurvey(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".saveSurvey");
		logger.info("   - paramMap : " + paramMap);

		paramMap.put("loginID", session.getAttribute("loginId"));

		Map<String, Object> returnMap = new HashMap<String, Object>();

		String qnum = "0";
		int qad = 0;

		for (qad = 0; qad <= 4; qad++) {

			qnum = String.valueOf(paramMap.get("use_yn" + qad));

			paramMap.put("bslecture_seq", Integer.parseInt(String.valueOf(paramMap.get("bslecture_seq"))));
			paramMap.put("serveyitem_queno", qad + 1);
			paramMap.put("servey_answer", Integer.parseInt(qnum));
			paramMap.put("servey_no", 1);

			// insert
			
			regSubjectService.saveSurvey(paramMap);
		}

		regSubjectService.updateStudent(paramMap);

		returnMap.put("result", "SUECCES");

		logger.info("+ End " + className + ".saveSurvey");

		return returnMap;
	}

}
