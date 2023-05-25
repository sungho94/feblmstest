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

import kr.happyjob.study.tut.model.LecturePlanListModel;
import kr.happyjob.study.tut.model.WeekPlanListModel;
import kr.happyjob.study.tut.service.LecturePlanListService;


@Controller
@RequestMapping("/tut/")
public class LecturePlanController {
	
	@Autowired
	LecturePlanListService lecturePlanListService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 초기화면
	 */
	@RequestMapping("lecturePlan.do")
	public String lecturePlan(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecturePlan");
		logger.info("   - paramMap : " + paramMap);
		
		request.setAttribute("loginID", session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".lecturePlan");

		return "tut/lecturePlan/lecturePlan";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("lecturePlanVue.do")
	public String lecturePlanVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecturePlanVue");
		logger.info("   - paramMap : " + paramMap);
		
		request.setAttribute("loginID", session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".lecturePlanVue");

		return "tut/lecturePlan/lecturePlanVue";
	}
	
	/**
	 * 개설 강의 목록 조회
	 */
	@RequestMapping("lecturePlanListSearch.do")
	public String lecturePlanListSearch(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecturePlanListSearch");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<LecturePlanListModel> lecturePlanListSearch = lecturePlanListService.lecturePlanListSearch(paramMap);
		int totalcnt = lecturePlanListService.lecturePlanListCnt(paramMap);
		
		model.addAttribute("lecturePlanListSearch", lecturePlanListSearch);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".lecturePlanListSearch");

		return "tut/lecturePlan/lecturePlanListSearch";
	}
	
	/**
	 * 개설 강의 목록 조회
	 */
	@RequestMapping("lecturePlanListSearchVue.do")
	@ResponseBody
	public Map<String,Object> lecturePlanListSearchVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecturePlanListSearch");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;
		
		Map<String,Object> returnData = new HashMap <String, Object>();
		
		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<LecturePlanListModel> lecturePlanListSearch = lecturePlanListService.lecturePlanListSearch(paramMap);
		int totalcnt = lecturePlanListService.lecturePlanListCnt(paramMap);
		
		returnData.put("lecturePlanListSearch", lecturePlanListSearch);
		returnData.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".lecturePlanListSearch");

		return returnData;
	}
	
	/**
	 * 강의 목록 선택
	 */
	@RequestMapping("LecturePlanSelect.do")
	@ResponseBody
	public Map<String, Object> LecturePlanSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".LecturePlanSelect");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		LecturePlanListModel lectureinfo = lecturePlanListService.LecturePlanSelect(paramMap);
		
		returnmap.put("lectureinfo", lectureinfo);
		
		logger.info("+ End " + className + ".LecturePlanSelect");

		return returnmap;
	}
	
	/**
	 * 강의 주차별 계획 목록
	 */
	@RequestMapping("weekPlanList.do")
	public String weekPlanList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".weekPlanList");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<WeekPlanListModel> weekPlanList = lecturePlanListService.weekPlanList(paramMap);
		int totalcnt = lecturePlanListService.weekPlanListCnt(paramMap);
		
		model.addAttribute("weekPlanList", weekPlanList);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".weekPlanList");

		return "tut/lecturePlan/weekPlanList";
	}
	
	/**
	 * 강의 주차별 계획 목록
	 */
	@RequestMapping("weekPlanListVue.do")
	@ResponseBody
	public Map<String, Object> weekPlanListVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".weekPlanList");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;
		
		Map <String,Object> returnData = new HashMap<String,Object>();

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<WeekPlanListModel> weekPlanList = lecturePlanListService.weekPlanList(paramMap);
		int totalcnt = lecturePlanListService.weekPlanListCnt(paramMap);
		
		returnData.put("weekPlanList", weekPlanList);
		returnData.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".weekPlanList");

		return returnData;
	}
	
	/**
	 * 주차별계획 조회
	 */
	@RequestMapping("weekselect.do")
	@ResponseBody
	public Map<String, Object> weekselect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".weekselect");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		WeekPlanListModel weekinfo = lecturePlanListService.weekselect(paramMap);
		
		returnmap.put("weekinfo", weekinfo);
		
		logger.info("+ End " + className + ".weekselect");

		return returnmap;
	}
	
	/**
	 * 주차별계획 저장
	 */
	@RequestMapping("weeksave.do")
	@ResponseBody
	public Map<String, Object> weeksave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".weeksave");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String action = String.valueOf(paramMap.get("action"));
						
		if("I".equals(action)){
			lecturePlanListService.weekinsert(paramMap);
		} else if("U".equals(action)){
			lecturePlanListService.weekupdate(paramMap);
		} else if("D".equals(action)){
			lecturePlanListService.weekdelete(paramMap);
		}
		
		returnmap.put("result", "SUCCESS");
		
		logger.info("+ End " + className + ".weeksave");

		return returnmap;
	}
}
