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

import kr.happyjob.study.adm.dao.StudentDao;
import kr.happyjob.study.adm.model.StudentModel;
import kr.happyjob.study.adm.service.StudentService;


@Controller
@RequestMapping("/adm/")
public class StudentController {
	
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	StudentService studentService;
	
	/**
	 * 초기화면
	 */
	@RequestMapping("student.do")
	public String student(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".student");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".student");

		return "adm/student/student";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("studentVue.do")
	public String studentVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studentVue");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".studentVue");

		return "adm/student/studentVue";
	}
	
	// 강의 목록 조회
	@RequestMapping("lectureList.do")
	public String lectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageNum = Integer.parseInt(String.valueOf(paramMap.get("pageNum")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startPage = (pageNum -1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPage", startPage);
		
		List<StudentModel> lectureList = studentService.lectureList(paramMap);
		int totalCnt = studentService.lectureListCnt(paramMap);
		
		model.addAttribute("lectureList", lectureList);
		model.addAttribute("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".LectureList");
		
		return "adm/student/studentLectureList";
	}
	
	// 강의 목록 조회(Vue)
	@RequestMapping("vuelectureList.do")
	@ResponseBody
	public Map<String, Object> vuelectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureList");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		int pageNum = Integer.parseInt(String.valueOf(paramMap.get("pageNum")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startPage = (pageNum -1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPage", startPage);
		
		List<StudentModel> lectureList = studentService.lectureList(paramMap);
		int totalCnt = studentService.lectureListCnt(paramMap);
		
		returnmap.put("lectureList", lectureList);
		returnmap.put("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".LectureList");
		
		return returnmap;
	}	
	
	
	// 학생 목록 조회
	@RequestMapping("studentList.do")
	public String studentList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studentList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageNum = Integer.parseInt(String.valueOf(paramMap.get("pageNum")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startPage = (pageNum - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPage", startPage);
		
		List<StudentModel> studentList = studentService.studentList(paramMap);
		int totalCnt = studentService.studentListCnt(paramMap);
		
		model.addAttribute("studentList", studentList);
		model.addAttribute("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".studentList");
		
		return "adm/student/studentList";
	}
	
	// 학생 목록 조회(Vue)
	@RequestMapping("vuestudentList.do")
	@ResponseBody
	public Map<String, Object> vuestudentList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studentList");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		int pageNum = Integer.parseInt(String.valueOf(paramMap.get("pageNum")));
		int pageSize = Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startPage = (pageNum - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPage", startPage);
		
		List<StudentModel> studentList = studentService.studentList(paramMap);
		int totalCnt = studentService.studentListCnt(paramMap);
		
		returnmap.put("studentList", studentList);
		returnmap.put("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".studentList");
		
		return returnmap;
	}
	
	// 학생 상세 조회
	@RequestMapping("studentSelect.do")
	@ResponseBody
	public Map<String, Object> studentSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studentSelect");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		StudentModel studentSelect = studentService.studentSelect(paramMap);
		
		returnMap.put("studentSelect", studentSelect);
		
		logger.info("+ End " + className + ".studentSelect");
		
		return returnMap;
	}
	
	// 학생 수강 취소
	@RequestMapping("studentCancel.do")
	@ResponseBody
	public Map<String, Object> studentCancel(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studentCancel");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		int studentCancel = studentService.studentCancel(paramMap);
		
		returnMap.put("studentCancel", studentCancel);
		
		logger.info("+ End " + className + ".studentCancel");
		
		return returnMap;
	}
	
	


}
