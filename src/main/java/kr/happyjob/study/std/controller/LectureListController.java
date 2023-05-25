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

import kr.happyjob.study.std.model.LectureListModel;
import kr.happyjob.study.std.service.LectureListService;


@Controller
@RequestMapping("/std/")
public class LectureListController {
	
	@Autowired
	LectureListService lecturelistService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 초기화면
	 */
	@RequestMapping("lectureList.do")
	public String lectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureList");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".lectureList");

		return "std/lectureList/lectureList";
	}
	
	/**
	 * vue 초기화면
	 */
	@RequestMapping("lectureListVue.do")
	public String lectureListVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureListVue");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".lectureListVue");

		return "std/lectureList/lectureListVue";
	}
	
	//list 출력
	@RequestMapping("lectureListSearch.do")
	public String lectureListSearch(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureListSearch");
		logger.info("   - paramMap : " + paramMap);
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<LectureListModel> lectureListSearch = lecturelistService.lectureListSearch(paramMap);
		int totalcnt = lecturelistService.lectureListCnt(paramMap);
		
		model.addAttribute("lectureListSearch", lectureListSearch);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".lectureListSearch");

		return "std/lectureList/lectureListSearch";
	}
	/**
	 vue list 출력하기
	 Map형식으로 받아서 ResponseBody로 비동기 처리하기
	 */
	@RequestMapping("lectureListSearchVue.do")
	@ResponseBody
	public Map<String,Object> lectureListSearchVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
												   HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".lectureListSearch");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnMap = new HashMap<String, Object>();

		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);

		List<LectureListModel> lectureListSearch = lecturelistService.lectureListSearch(paramMap);
		int totalcnt = lecturelistService.lectureListCnt(paramMap);

		//model.addAttribute("lectureListSearch", lectureListSearch);
		//model.addAttribute("totalcnt", totalcnt);

		returnMap.put("lectureListSearch", lectureListSearch);
		returnMap.put("totalcnt", totalcnt);

		logger.info("+ End " + className + ".lectureListSearch");

		return returnMap;
	}



	//planList 조회 lecturePlanSelect
	
	@RequestMapping("lecturePlanSelect.do")
	public String lecturePlanSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureListSearch");
		logger.info("   - paramMap : " + paramMap);
		
		List<LectureListModel> lecturePlanSelect = lecturelistService.lecturePlanSelect(paramMap);
		int totalcnt = lecturelistService.lecturePlanCnt(paramMap);
		
		model.addAttribute("lecturePlanSelect", lecturePlanSelect);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".lecturePlanSelect");

		return "std/lectureList/lectureSelect";
	}

	/**
	 * vue 강의계획서 조회하기 */
	@RequestMapping("showLecturePlan.do")
	@ResponseBody
	public Map<String, Object> lecturePlanSelectVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
									HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".lectureListSearch");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnMap = new HashMap<String, Object>();

		List<LectureListModel> lecturePlanSelect = lecturelistService.lecturePlanSelect(paramMap);
		int totalcnt = lecturelistService.lecturePlanCnt(paramMap);
		//paramMap.put("totalcnt" , totalcnt);

		//model.addAttribute("lecturePlanSelect", lecturePlanSelect);
		//model.addAttribute("totalcnt", totalcnt);

		returnMap.put("lecturePlanSelect", lecturePlanSelect);
		returnMap.put("totalcnt", totalcnt);

		logger.info("+ End " + className + ".lecturePlanSelect");

		return returnMap;
	}



	//list 한건 조회
	
	@RequestMapping("lectureSelect.do")
	@ResponseBody
	public Map<String, Object> lectureSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureSelect");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		LectureListModel lectureSelect = lecturelistService.lectureSelect(paramMap);

		returnmap.put("lectureSelect", lectureSelect);
		
		logger.info("+ End " + className + ".lectureSelect");

		return returnmap;
	}


	@RequestMapping("studentInsert.do")
	@ResponseBody
	public Map<String, Object> studentInsert(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".studentInsert");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
		String result="";

		paramMap.put("loginId", session.getAttribute("loginId"));
		logger.info("loginId : " + paramMap.get("loginId"));

		if("I".equals(action)){
			lecturelistService.studentInsert(paramMap);
			result = "INSERT";
			System.out.println(paramMap);
		} else {
			result = "FALSE : 등록에 실패하였습니다.";
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		
		return resultMap;
	}
	
	

}
