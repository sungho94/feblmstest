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

import kr.happyjob.study.tut.model.CounselModel;
import kr.happyjob.study.tut.service.CounselService;

@Controller
@RequestMapping("/tut/")
public class CounselController {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	CounselService counselService;
	
	/**
	 * 초기화면
	 */
	@RequestMapping("counsel.do")
	public String counsel(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".counsel");
		logger.info("   - paramMap : " + paramMap);

		// 로그인 사용자 정보 넣기
		request.setAttribute("loginID", session.getAttribute("loginId"));

		logger.info("+ End " + className + ".counsel");

		return "tut/counsel/counsel";
	}

	/**
	 * 초기화면
	 */
	@RequestMapping("counselVue.do")
	public String counselVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".counselVue");
		logger.info("   - paramMap : " + paramMap);

		// 로그인 사용자 정보 넣기
		request.setAttribute("loginID", session.getAttribute("loginId"));

		logger.info("+ End " + className + ".counselVue");

		return "tut/counsel/counselVue";
	}
	

	// vue 강의 목록 불러오기
	@RequestMapping("vuecounselLectureList.do")
	@ResponseBody
	public Map<String, Object> vuecounselLectureList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".vuecounselLectureList");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.get("lecture");
		System.out.print(paramMap.get("lecture"));
		
		Map<String, Object> returnmap = new HashMap<String, Object>();

		int pageNum = Integer.parseInt(String.valueOf(paramMap.get("pageNum")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startPage = (pageNum - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPage", startPage);
		
		List<CounselModel> counselLectureList = counselService.counselLectureList(paramMap);
		int totalcnt = counselService.counselLectureListCnt(paramMap);
		
		returnmap.put("counselLectureList", counselLectureList);
		returnmap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vuecounselLectureList");

		return returnmap;
	}

	// 강의 목록 불러오기
	@RequestMapping("counselLectureList.do")
	public String counselLectureList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".counselLectureList");
		logger.info("   - paramMap : " + paramMap);

		int pageNum = Integer.parseInt(String.valueOf(paramMap.get("pageNum")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startPage = (pageNum - 1) * pageSize;

		paramMap.put("pageSize", pageSize);
		paramMap.put("startPage", startPage);

		List<CounselModel> counselLectureList = counselService.counselLectureList(paramMap);
		int totalCnt = counselService.counselLectureListCnt(paramMap);

		model.addAttribute("counselLectureList", counselLectureList);
		model.addAttribute("totalCnt", totalCnt);

		logger.info("+ End " + className + ".counselLectureList");

		return "tut/counsel/counselLectureList";
	}

	// 학생 목록 불러오기
	@RequestMapping("counselStudentList.do")
	public String counselStudentList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".counselStudentList");
		logger.info("   - paramMap : " + paramMap);

		int pageNum = Integer.parseInt(String.valueOf(paramMap.get("pageNum")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startPage = (pageNum - 1) * pageSize;

		paramMap.put("pageSize", pageSize);
		paramMap.put("startPage", startPage);

		List<CounselModel> counselStudentList = counselService.counselStudentList(paramMap);
		int totalCnt = counselService.counselStudentListCnt(paramMap);

		model.addAttribute("counselStudentList", counselStudentList);
		model.addAttribute("totalCnt", totalCnt);

		logger.info("+ End " + className + ".counselStudentList");

		return "tut/counsel/counselStudentList";
	}
	

	// 학생 목록 불러오기
	@RequestMapping("vuecounselStudentList.do")
	@ResponseBody
	public Map<String, Object> vuecounselStudentList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".vuecounselStudentList");
		logger.info("   - paramMap : " + paramMap);

		int pageNum = Integer.parseInt(String.valueOf(paramMap.get("pageNum")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startPage = (pageNum - 1) * pageSize;

		paramMap.put("pageSize", pageSize);
		paramMap.put("startPage", startPage);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		List<CounselModel> counselStudentList = counselService.counselStudentList(paramMap);
		int totalCnt = counselService.counselStudentListCnt(paramMap);

		returnmap.put("counselStudentList", counselStudentList);
		returnmap.put("totalCnt", totalCnt);

		logger.info("+ End " + className + ".vuecounselStudentList");

		return returnmap;
	}

	// 학생 상세보기
	@RequestMapping("vuedetailStudent.do")
	@ResponseBody
	public Map<String, Object> vuedetailStudent(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".vuedetailStudent");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CounselModel detailStudent = counselService.detailStudent(paramMap);
		
		returnMap.put("detailStudent", detailStudent);

		logger.info("+ End " + className + ".vuedetailStudent");
		
		return returnMap;
	}
	

	// 학생 상세보기
	@RequestMapping("detailStudent.do")
	@ResponseBody
	public Map<String, Object> detailStudent(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".detailStudent");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		CounselModel detailStudent = counselService.detailStudent(paramMap);
		
		returnMap.put("detailStudent", detailStudent);

		logger.info("+ End " + className + ".detailStudent");
		
		return returnMap;
	}
	
	// 상담 일지 저장 및 수정,삭제
		@RequestMapping("vuesaveCounsel.do")
		@ResponseBody
		public Map<String, Object> vuesaveCounsel(Model model, @RequestParam Map<String, Object> paramMap,
				HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			paramMap.put("loginID", session.getAttribute("loginId"));
			
			logger.info("+ Start " + className + ".vuesaveCounsel");
			logger.info("   - paramMap : " + paramMap);

			Map<String, Object> returnMap = new HashMap<String, Object>();
			
			String action = String.valueOf(paramMap.get("action"));
			
			if("I".equals(action)){
				counselService.insertCounsel(paramMap);
			} else if("U".equals(action)){
				System.out.println("들어왔다");
				counselService.updateCounsel(paramMap);
			} else if("D".equals(action)) {
				counselService.deleteCounsel(paramMap);
			}

			returnMap.put("result", "sucess");

			logger.info("+ End " + className + ".vuesaveCounsel");

			return returnMap;
		}
		
	// 상담 일지 저장 및 수정,삭제
	@RequestMapping("saveCounsel.do")
	@ResponseBody
	public Map<String, Object> saveCounsel(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		logger.info("+ Start " + className + ".saveCounsel");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)){
			counselService.insertCounsel(paramMap);
		} else if("U".equals(action)){
			System.out.println("들어왔다");
			counselService.updateCounsel(paramMap);
		} else if("D".equals(action)) {
			counselService.deleteCounsel(paramMap);
		}

		returnMap.put("result", "sucess");

		logger.info("+ End " + className + ".saveCounsel");

		return returnMap;
	}

}
