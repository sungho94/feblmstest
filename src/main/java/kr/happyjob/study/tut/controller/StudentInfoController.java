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

import kr.happyjob.study.tut.model.StudentInfoModel;
import kr.happyjob.study.tut.service.StudentInfoService;


@Controller
@RequestMapping("/tut/")
public class StudentInfoController {
	
	@Autowired
	StudentInfoService studentInfoService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/*
	 * 초기화면
	 */
	@RequestMapping("studentInfo.do")
	public String studentInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studentInfo");
		logger.info("   - paramMap : " + paramMap);
		
		request.setAttribute("loginID", session.getAttribute("loginId")); //
		
		logger.info("+ End " + className + ".studentInfo");

		return "tut/studentInfo/studentInfo";
	}
	
	/*
	 * 초기화면
	 */
	@RequestMapping("studentInfoVue.do")
	public String studentInfoVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studentInfoVue");
		logger.info("   - paramMap : " + paramMap);
		
		request.setAttribute("loginID", session.getAttribute("loginId"));  //
		
		logger.info("+ End " + className + ".studentInfoVue");

		return "tut/studentInfo/studentInfoVue";
	}
	
	// 수업 리스트
	@RequestMapping("lectureInfoList.do")
	public String lectureInfoList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureInfoList");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId")); 
		
		int pagenum = Integer.parseInt( String.valueOf(paramMap.get("pagenum")));
		int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1)*pageSize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pageSize",pageSize);
		
		
		//session.setAttribute("loginID",paramMap.get("loginID"));
		
		List<StudentInfoModel> lectureInfo = studentInfoService.lectureInfoList(paramMap);
		
		int totalcnt = studentInfoService.lectureInfoListCnt(paramMap);
		
		model.addAttribute("lectureInfo",lectureInfo);
		model.addAttribute("totalcnt",totalcnt);
		
		logger.info("+ End " + className + ".lectureInfoList");

		return "tut/studentInfo/lectureInfoList";
	}
	
	// 수업 리스트
		@RequestMapping("vuelectureInfoList.do")
		@ResponseBody
		public Map<String, Object> vuelectureInfoList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".vuelectureInfoList");
			logger.info("   - paramMap : " + paramMap);
			
			paramMap.put("loginID", session.getAttribute("loginId"));   
			
			int pagenum = Integer.parseInt( String.valueOf(paramMap.get("pagenum")));
			int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize")));
			int startnum = (pagenum - 1)*pageSize;
			
			Map <String, Object> returnMap = new HashMap<String, Object>();
			
			paramMap.put("startnum", startnum);
			paramMap.put("pageSize",pageSize);
			
			
			//session.setAttribute("loginID",paramMap.get("loginID"));
			
			List<StudentInfoModel> lectureInfo = studentInfoService.lectureInfoList(paramMap);
			
			int totalcnt = studentInfoService.lectureInfoListCnt(paramMap);
			
			returnMap.put("lectureInfo",lectureInfo);
			returnMap.put("totalcnt",totalcnt);
			
			logger.info("+ End " + className + ".vuelectureInfoList");

			return returnMap; 
		}
	
	// 수업단건 조회
	@RequestMapping("lectureInfoSearch.do")
	public Map<String,Object> lectureInfoSearch (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureInfoSearch");
		logger.info("   - paramMap : " + paramMap);
		
		StudentInfoModel lectureSelect = studentInfoService.lectureInfoSearch(paramMap);
		
		Map<String, Object> lectureInfoSearch = new HashMap<String, Object>();
		
		lectureInfoSearch.put("lectureInfoSearch",lectureSelect);
		
		logger.info("+ End " + className + ".lectureInfoSearch");

		return lectureInfoSearch;
	}
	// 수강학생 리스트
		@RequestMapping("studentInfoList.do")
		public String studentInfoList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".studentInfoList");
			logger.info("   - paramMap : " + paramMap);
			
			int spagenum = Integer.parseInt( String.valueOf(paramMap.get("spagenum")));
			int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize")));
			int startnum = (spagenum - 1)*pageSize;
			
			paramMap.put("startnum", startnum);
			paramMap.put("pageSize",pageSize);
			session.setAttribute("lecture_seq",paramMap.get("lecture_seq"));
			
			
			List<StudentInfoModel> studentInfo = studentInfoService.studentInfoList(paramMap);
			
			int stotalcnt = studentInfoService.studentInfoListCnt(paramMap);
			
			model.addAttribute("studentInfo",studentInfo);
			model.addAttribute("stotalcnt",stotalcnt);
			
			logger.info("+ End " + className + ".studentInfoList");

			return "tut/studentInfo/studentInfoList";
		}
		
		// 수강학생 리스트
				@RequestMapping("vuestudentInfoList.do")
				@ResponseBody
				public Map<String, Object> vuestudentInfoList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
						HttpServletResponse response, HttpSession session) throws Exception {
					
					logger.info("+ Start " + className + ".vuestudentInfoList");
					logger.info("   - paramMap : " + paramMap);
					
					int spagenum = Integer.parseInt( String.valueOf(paramMap.get("spagenum")));
					int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize")));
					int startnum = (spagenum - 1)*pageSize;
					
					paramMap.put("startnum", startnum);
					paramMap.put("pageSize",pageSize);
					session.setAttribute("lecture_seq",paramMap.get("lecture_seq"));
					
					Map <String, Object> returnMap = new HashMap <String, Object>();
					
					List<StudentInfoModel> studentInfo = studentInfoService.studentInfoList(paramMap);
					
					int stotalcnt = studentInfoService.studentInfoListCnt(paramMap);
					
					returnMap.put("studentInfo",studentInfo);
					returnMap.put("stotalcnt",stotalcnt);
					
					logger.info("+ End " + className + ".vuestudentInfoList");

					return returnMap;
				}
	/*수강생 수강여부 '승인'*/
		@RequestMapping("studentInfoConfirmYes.do")
		@ResponseBody
		public Map<String,Object> studentInfoConfirmYes (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			logger.info("+ Start " + className + ".studentInfoConfirmYes");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			int confirmYes = studentInfoService.studentInfoConfirmYes(paramMap);
			
			returnmap.put("student_lecture",confirmYes);
			
			logger.info("+ End " + className + ".studentInfoConfirmYes");
			
			return returnmap;
		}
	/*수강생 수강여부 '취소'*/
		@RequestMapping("studentInfoConfirmNo.do")
		@ResponseBody
		public Map<String,Object> studentInfoConfirmNo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			logger.info("+ Start " + className + ".studentInfoConfirmNo");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			int confirmNo=studentInfoService.studentInfoConfirmNo(paramMap);
			
			returnmap.put("student_lecture",confirmNo);
			
			logger.info("+ End " + className + ".sudentInfoConfrimNo");
			
			return returnmap;
		}
}
