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

import kr.happyjob.study.adm.model.LectureManagementModel;
import kr.happyjob.study.adm.model.StudentModel;
import kr.happyjob.study.adm.service.LectureManagementService;


@Controller
@RequestMapping("/adm/")
public class LectureManagementController {
	
	@Autowired
	LectureManagementService LectureManagementService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 초기화면
	 */
	@RequestMapping("lectureManagement.do")
	public String lectureManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureManagement");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".lectureManagement");

		return "adm/lectureManagement/lectureManagement";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("lectureManagementVue.do")
	public String lectureManagementVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureManagementVue");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".lectureManagementVue");

		return "adm/lectureManagement/lectureManagementVue";
	}
	
	//list 출력
		@RequestMapping("lectureManagementList.do")
		public String lectureListSearch(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".lectureListSearch");
			logger.info("   - paramMap : " + paramMap);
			
			int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
			int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
			int startnum = (pagenum - 1) * pageSize;

			paramMap.put("startnum", startnum);
			paramMap.put("pageSize", pageSize);
			
			List<LectureManagementModel> lectureListSearch = LectureManagementService.lectureListSearch(paramMap);
			int totalcnt = LectureManagementService.lectureListCnt(paramMap);
			
			model.addAttribute("lectureListSearch", lectureListSearch);
			model.addAttribute("totalcnt", totalcnt);
			
			logger.info("+ End " + className + ".lectureListSearch");

			return "adm/lectureManagement/lectureManagementList";
		}
		
		//list 출력
		@RequestMapping("vueLectureManagementList.do")
		@ResponseBody
		public Map<String, Object> vueLectureManagementList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".vueLectureManagementList");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
			int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
			int startnum = (pagenum - 1) * pageSize;
			
			paramMap.put("startnum", startnum);
			paramMap.put("pageSize", pageSize);
			
			List<LectureManagementModel> lectureListSearch = LectureManagementService.lectureListSearch(paramMap);
			int totalcnt = LectureManagementService.lectureListCnt(paramMap);
			
			resultMap.put("lectureListSearch", lectureListSearch);
			resultMap.put("totalcnt", totalcnt);
			
			logger.info("+ End " + className + ".vueLectureManagementList"); 
			
			return resultMap;
		}
		
			//list 출력
			@RequestMapping("studentManagementList.do")
			public String studentList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
					HttpServletResponse response, HttpSession session) throws Exception {
				
				logger.info("+ Start " + className + ".studentList");
				logger.info("   - paramMap : " + paramMap);
				
				int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
				int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
				int startnum = (pagenum - 1) * pageSize;

				paramMap.put("startnum", startnum);
				paramMap.put("pageSize", pageSize);
				
				List<StudentModel> studentListSearch = LectureManagementService.studentList(paramMap);
				int totalcnt = LectureManagementService.studentListCnt(paramMap);
				
				model.addAttribute("studentListSearch", studentListSearch);
				model.addAttribute("totalcnt", totalcnt);
				
				logger.info("+ End " + className + ".studentList");

				return "adm/lectureManagement/studentList";
			}

			//list 출력
			@RequestMapping("vueStudentManagementList.do")
			@ResponseBody
			public Map<String, Object> vueStudentList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
					HttpServletResponse response, HttpSession session) throws Exception {
				
				logger.info("+ Start " + className + ".vueStudentList");
				logger.info("   - paramMap : " + paramMap);
				
				Map<String, Object> resultMap = new HashMap<String, Object>();
				
				int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
				int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
				int startnum = (pagenum - 1) * pageSize;
				
				paramMap.put("startnum", startnum);
				paramMap.put("pageSize", pageSize);
				
				List<StudentModel> studentListSearch = LectureManagementService.studentList(paramMap);
				int totalcnt = LectureManagementService.studentListCnt(paramMap);
				
				resultMap.put("studentListSearch", studentListSearch);
				resultMap.put("totalcnt", totalcnt);
				
				logger.info("+ End " + className + ".vueStudentList");
				
				return resultMap;
			}
			
		/**
		 * 강의 저장
		 */
		@RequestMapping("lectureOption.do")
		@ResponseBody
		public Map<String, Object> lectureInsert(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".lectureInsert");
			logger.info("   - paramMap : " + paramMap);
				
			Map<String, Object> returnmap = new HashMap<String, Object>();

			String action = String.valueOf(paramMap.get("action"));
			String result = "";
			paramMap.put("loginId",session.getAttribute("loginId"));
			
			if("I".equals(action)){
				//LectureManagementService.lectureInsertComnDtlCod(paramMap); // tb_detail_code에 insert하는 구문
				LectureManagementService.roomStatusUpdate(paramMap);
				LectureManagementService.lectureInsert(paramMap);
				
				result = "SUCCESS";
			}else if("U".equals(action)){
				LectureManagementService.lectureUpdate(paramMap);
				result = "UPDATE";
			}
/*			else if("D".equals(action)){
				LectureManagementService.lectureDelete(paramMap);
				result = "DELETE";
			}*/
			
			returnmap.put("result", result);
			
			logger.info("+ End " + className + ".lectureInsert");

			return returnmap;
		}
		
		/**
		 * 강의 조회
		 */
		@RequestMapping("lectureSelect.do")
		@ResponseBody
		public Map<String, Object> lectureSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".lectureSelect");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			LectureManagementModel lectureInfo = LectureManagementService.lectureSelect(paramMap);
			
//			paramMap.put("loginId",session.getAttribute("loginId"));

			returnmap.put("lectureInfo", lectureInfo);

			logger.info("+ End " + className + ".lectureSelect");

			return returnmap;
		}
}
