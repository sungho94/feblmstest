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

import kr.happyjob.study.adm.model.CounselHistoryModel;
import kr.happyjob.study.adm.model.LectureModel;
import kr.happyjob.study.adm.service.CounselHistoryService;


@Controller
@RequestMapping("/adm/")
public class CounselHistoryController {
	
	@Autowired
	CounselHistoryService counselHistoryService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 상담 초기화면(관리자)
	 */
	@RequestMapping("counselHistory.do")
	public String counselHistory(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".counselHistory");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".counselHistory");

		return "adm/counselHistory/counselHistory";
	}
	
	/**
	 * 상담 초기화면(관리자)
	 */
	@RequestMapping("counselHistoryVue.do")
	public String counselHistoryVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".counselHistoryVue");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".counselHistoryVue");

		return "adm/counselHistory/counselHistoryVue";
	}
	
	/* 강의 목록 */
	 @RequestMapping("lecturelist.do")
     public String lectureList(Model model,  @RequestParam Map<String, Object> paramMap,
   		  HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
   	   
   	  
   	    logger.info("========= Start  " + className + ".lectureList" + "=========");
			logger.info("   - paramMap : " + paramMap);
		    int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) ); 
		    int  pageSize = Integer.parseInt ( String.valueOf ( paramMap.get("pageSize") ) );
		    int startNum =  (pageNum - 1) * pageSize;
			
		     paramMap.put("startNum", startNum);
		     paramMap.put("pageSize", pageSize);
		     paramMap.put("loginid", session.getAttribute("loginId"));
		     
			List <LectureModel> counselLectureList = counselHistoryService.counselLectureList(paramMap);
			int totalCnt = counselHistoryService.lectureListCnt(paramMap);
			
			model.addAttribute("counselLectureList", counselLectureList);
			model.addAttribute("totalCnt",totalCnt);
			
			logger.info("========= End " + className + ".lectureList" +  "=========");
   	  
			return "adm/counselHistory/lectureList";
   	  
     }
	 
	 /* 강의 목록 */
	 @RequestMapping("vueLecturelist.do")
	 @ResponseBody
	 public Map<String, Object> vueLecturelist(Model model,  @RequestParam Map<String, Object> paramMap,
			 HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		 
		 
		 logger.info("========= Start  " + className + ".vueLecturelist" + "=========");
		 logger.info("   - paramMap : " + paramMap);
		 
		 Map<String,Object> resultMap = new HashMap<String, Object>();

		 int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) ); 
		 int  pageSize = Integer.parseInt ( String.valueOf ( paramMap.get("pageSize") ) );
		 int startNum =  (pageNum - 1) * pageSize;
		 
		 paramMap.put("startNum", startNum);
		 paramMap.put("pageSize", pageSize);
		 paramMap.put("loginid", session.getAttribute("loginId"));
		 
		 List <LectureModel> counselLectureList = counselHistoryService.counselLectureList(paramMap);
		 int totalCnt = counselHistoryService.lectureListCnt(paramMap);
		 
		 resultMap.put("counselLectureList", counselLectureList);
		 resultMap.put("totalCnt",totalCnt);
		 
		 logger.info("========= End " + className + ".vueLecturelist" +  "=========");
		 
		 return resultMap;
		 
	 }
	 
	 /* 상담 내역 */
	@RequestMapping("counselList.do")
	public String counselList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("=========  Start " + className + ".counselList" + "========= ");
		logger.info("   - paramMap : " + paramMap);

		int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) );
		int pageSize = Integer.parseInt( String.valueOf( paramMap.get("pageSize") ) );
		int startNum = (pageNum -1) * pageSize;
		
		paramMap.put("startNum", startNum);
		paramMap.put("pageSize", pageSize);
		
		List<CounselHistoryModel> counselList = counselHistoryService.counselList(paramMap);
		int totalCnt = counselHistoryService.counselCnt(paramMap);
	    
		model.addAttribute("counselList",counselList);
	    model.addAttribute("totalCnt",totalCnt);
		
		
		logger.info("=========  End " + className + ".counselList" + "========= ");

		return "adm/counselHistory/counselList";
	}
	
	/* 상담 내역 */
	@RequestMapping("vueCounselList.do")
	@ResponseBody
	public Map<String, Object> vueCounselList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("=========  Start " + className + ".vueCounselList" + "========= ");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String,Object> resultMap = new HashMap<String, Object>();
		
		int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) );
		int pageSize = Integer.parseInt( String.valueOf( paramMap.get("pageSize") ) );
		int startNum = (pageNum -1) * pageSize;
		
		paramMap.put("startNum", startNum);
		paramMap.put("pageSize", pageSize);
		
		List<CounselHistoryModel> counselList = counselHistoryService.counselList(paramMap);
		int totalCnt = counselHistoryService.counselCnt(paramMap);
		
		resultMap.put("counselList",counselList);
		resultMap.put("totalCnt",totalCnt);
		
		
		logger.info("=========  End " + className + ".vueCounselList" + "========= ");
		
		return resultMap;
	}
	
	/* 상담 상세조회*/
	@RequestMapping("counselSelect.do")
	@ResponseBody
	public Map<String, Object> counselSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("=========  Start " + className + ".counselSelect" + "========= ");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
			
		CounselHistoryModel counselInfo = counselHistoryService.counselSelect(paramMap);
		
		returnMap.put("counselInfo", counselInfo);
		
		logger.info("=========  End " + className + ".counselSelect" + "========= ");

		return returnMap;
	}
	
	


}
