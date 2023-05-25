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

import kr.happyjob.study.adm.model.TeacherListModel;
import kr.happyjob.study.adm.service.TeacherListService;


@Controller
@RequestMapping("/adm/")
public class TeacherController {
	
	@Autowired
	TeacherListService teacherListService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 초기화면
	 */
	@RequestMapping("teacher.do")
	public String teacher(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("================== Start " + className + ".teacher"+"================== ");
		logger.info("   - paramMap : " + paramMap);
		

		logger.info("================== End " + className + ".teacher"+"================== ");

		return "adm/teacher/teacher";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("teacherVue.do")
	public String teacherVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("================== Start " + className + ".teacherVue"+"================== ");
		logger.info("   - paramMap : " + paramMap);
		

		logger.info("================== End " + className + ".teacherVue"+"================== ");

		return "adm/teacher/teacherVue";
	}
	
	/* 강사 목록 */
	@RequestMapping("teacherlist.do")
	public String teacherlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("================== Start " + className + ".teacherlist"+"================== ");
		logger.info("   - paramMap : " + paramMap);
		
		int pagenum = Integer.parseInt( String.valueOf( paramMap.get("pagenum") ) );
		int pageSize = Integer.parseInt( String.valueOf( paramMap.get("pageSize") ) );
		int startNum = (pagenum -1) * pageSize;
		
		paramMap.put("startNum", startNum);
		paramMap.put("pageSize", pageSize);
		
		List<TeacherListModel> teacherList = teacherListService.teacherList(paramMap);
		int totalCnt = teacherListService.listCnt(paramMap);
	    
		model.addAttribute("teacherList",teacherList);
	    model.addAttribute("totalCnt",totalCnt);
		
		
		logger.info("================== End " + className + ".teacherlist"+"================== ");
		return "adm/teacher/teacherList";
	}
	
	/* 강사 목록(Vue) */
	@RequestMapping("vueteacherlist.do")
	@ResponseBody
	public Map<String, Object> vueteacherlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("================== Start " + className + ".teacherlistVue"+"================== ");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		int pagenum = Integer.parseInt( String.valueOf( paramMap.get("pagenum") ) );
		int pageSize = Integer.parseInt( String.valueOf( paramMap.get("pageSize") ) );
		int startNum = (pagenum -1) * pageSize;
		
		paramMap.put("startNum", startNum);
		paramMap.put("pageSize", pageSize);
		
		List<TeacherListModel> teacherList = teacherListService.teacherList(paramMap);
		int totalCnt = teacherListService.listCnt(paramMap);
	    
		returnmap.put("teacherList",teacherList);
		returnmap.put("totalCnt",totalCnt);
		
		
		logger.info("================== End " + className + ".teacherlist"+"================== ");
		return returnmap;
	}
	
	
	/* 강사 승인 미승인 수정 */
	@RequestMapping("tutupdate.do")
	@ResponseBody
	public Map<String, Object> tutupdate(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("================== Start " + className + ".tutupdate"+"================== ");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		teacherListService.tutupdate(paramMap);
	
		logger.info("================== End " + className + ".tutupdate"+"================== ");
		return returnmap;
	}
	
	/* 강사 정보 상세보기 */
	@RequestMapping("tutInfoDetail.do")
	@ResponseBody
	public Map<String,Object> tutInfoDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("================== Start " + className + ".tutInfoDetail"+"================== ");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		TeacherListModel teacherInfo = teacherListService.tutInfoDetail(paramMap);
	
		returnmap.put("teacherInfo", teacherInfo);
		logger.info("================== End " + className + ".tutInfoDetail"+"================== ");
		return returnmap;
	}

}
