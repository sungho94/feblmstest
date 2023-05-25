package kr.happyjob.study.std.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.std.model.CourseInfoModel;
import kr.happyjob.study.std.model.TaskListModel;
import kr.happyjob.study.std.service.TaskSendService;
import kr.happyjob.study.std.model.TaskModel;
import kr.happyjob.study.std.model.TaskSendModel;

@Controller
@RequestMapping("/std/")
public class TaskSendController {
	
	@Autowired
	TaskSendService taskSendService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	/**  과제 제출 초기화면 */
	@RequestMapping("taskSend.do")
	public String taskSend(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".taskSend");
		logger.info("   - paramMap : " + paramMap);

	     paramMap.put("loginid", session.getAttribute("loginId"));
		logger.info("+ End " + className + ".taskSend");

		return "std/taskSend/taskSend";
	}
	
	/**  과제 제출 초기화면 Vue*/
	@RequestMapping("taskSendVue.do")
	public String taskSendVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".taskSendVue");
		logger.info("   - paramMap : " + paramMap);

	     paramMap.put("loginid", session.getAttribute("loginId"));
		logger.info("+ End " + className + ".taskSendVue");

		return "std/taskSend/taskSendVue";
	}
	
	
	 /* 수강내역  */
    @RequestMapping("courseList.do")
    public String courselList(Model model,  @RequestParam Map<String, Object> paramMap,
  		  HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
  	   
  	  
  	    logger.info("========= Start  " + className + ".courselList" + "=========");
			logger.info("   - paramMap : " + paramMap);
		    int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) ); 
		    int  pageSize = Integer.parseInt ( String.valueOf ( paramMap.get("pageSize") ) );
		    int startNum =  (pageNum - 1) * pageSize;
			
		     paramMap.put("startNum", startNum);
		     paramMap.put("pageSize", pageSize);
		     paramMap.put("loginid", session.getAttribute("loginId"));
		    
			List <CourseInfoModel> lectureList = taskSendService.lectureList(paramMap, session);
			int totalCnt = taskSendService.lectureListCnt(paramMap);
			
			model.addAttribute("lectureList", lectureList);
			model.addAttribute("totalCnt",totalCnt);
			
			logger.info("========= End " + className + ".courselList" +  "=========");
  	  
			return "std/taskSend/lectureList";
  	  
    }

    /**
	 * 수강내역 리스트 vue */
	@RequestMapping("courseListVue.do")
	@ResponseBody
	public Map<String, Object> courseListVue(Model model,  @RequestParam Map<String, Object> paramMap,
							  HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{


		logger.info("========= Start  " + className + ".courselListVue" + "=========");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnMap = new HashMap<String, Object>();

		int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) );
		int  pageSize = Integer.parseInt ( String.valueOf ( paramMap.get("pageSize") ) );
		int startNum =  (pageNum - 1) * pageSize;

		paramMap.put("startNum", startNum);
		paramMap.put("pageSize", pageSize);
		paramMap.put("loginid", session.getAttribute("loginId"));

		List <CourseInfoModel> lectureList = taskSendService.lectureList(paramMap, session);
		int totalCnt = taskSendService.lectureListCnt(paramMap);

		//model.addAttribute("lectureList", lectureList);
		//model.addAttribute("totalCnt",totalCnt);

		returnMap.put("lectureList", lectureList);
		returnMap.put("totalCnt", totalCnt);

		logger.info("========= End " + className + ".courselList" +  "=========");

		return returnMap;

	}

    /* 주차별 과제 목록 */
    @RequestMapping("taskList.do")
    public String taskList(Model model,  @RequestParam Map<String, Object> paramMap,
  		  HttpServletRequest request, HttpServletResponse response) throws Exception{
  	  
  	    logger.info("========= Start  " + className + ".taskList" + "=========");
			logger.info("   - paramMap : " + paramMap);
		    int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) ); 
		    int pageSize = Integer.parseInt ( String.valueOf ( paramMap.get("pageSize") ) );
		    int startNum =  (pageNum - 1) * pageSize;
			
		     paramMap.put("startNum", startNum);
		     paramMap.put("pageSize", pageSize);
		    
			List <TaskListModel> taskList = taskSendService.taskList(paramMap);
			int totalCnt = taskSendService.taskListCnt(paramMap);
			
			model.addAttribute("taskList", taskList);
			model.addAttribute("totalCnt",totalCnt);
			
			logger.info("========= End " + className + ".taskList" +  "=========");
  	  
			return "std/taskSend/taskList";
  	  
    }

    /**
	 * 과제 목록 조회 vue */
	@RequestMapping("taskListVue.do")
	@ResponseBody
	public Map taskListVue(Model model,  @RequestParam Map<String, Object> paramMap,
						   HttpServletRequest request, HttpServletResponse response) throws Exception{

		logger.info("========= Start  " + className + ".taskList" + "=========");
		logger.info("   - paramMap : " + paramMap);

		Map<String, Object> returnMap = new HashMap<String, Object>();

		int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) );
		int  pageSize = Integer.parseInt ( String.valueOf ( paramMap.get("pageSize") ) );
		int startNum =  (pageNum - 1) * pageSize;

		paramMap.put("startNum", startNum);
		paramMap.put("pageSize", pageSize);

		List <TaskListModel> taskList = taskSendService.taskList(paramMap);
		int totalCnt = taskSendService.taskListCnt(paramMap);

		//model.addAttribute("taskList", taskList);
		//model.addAttribute("totalCnt",totalCnt);

		returnMap.put("taskList", taskList);
		returnMap.put("totalCnt", totalCnt);

		logger.info("========= End " + className + ".taskList" +  "=========");

		return returnMap;

	}
    
	/* 과제 내용 조회 */
    @RequestMapping("taskContent.do")
    @ResponseBody
    public Map<String, Object> taskContent(Model model,  @RequestParam Map<String, Object> paramMap,
  		  HttpServletRequest request, HttpServletResponse response) throws Exception{
  	   
  	    logger.info("========= Start  " + className + ".taskContent" + "=========");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnMap = new HashMap<String, Object>();
			
			TaskModel taskInfo = taskSendService.taskContent(paramMap);
			
			returnMap.put("taskInfo", taskInfo);
			
			logger.info("========= End " + className + ".taskContent" +  "=========");
  	  
  	  return returnMap;
  	  
    }
    
    
    /* 첨부파일명 미리보기 */
    @RequestMapping("taskFile.do")
    public void taskFile(Model model, @RequestParam Map<String, Object> paramMap, 
  		  HttpServletRequest request, HttpServletResponse response) throws Exception {
  	  
  	  logger.info("============ Start  " + className + ".taskFile" + "============");
  	  logger.info("   - paramMap : " + paramMap);
  	  
            TaskModel taskinfo = taskSendService.taskContent(paramMap);
       
            String file = taskinfo.getTaskMul();
  	  
            byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
       
		    response.setContentType("application/octet-stream");
		    response.setContentLength(fileByte.length);
		    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(taskinfo.getTaskName(),"UTF-8")+"\";");
		    response.setHeader("Content-Transfer-Encoding", "binary");
		    response.getOutputStream().write(fileByte);
       
  	  logger.info("============ End  " + className + ".taskFile" + "============");
  	  return;
    }
    
    /* 제출한 과제 보기*/
    @RequestMapping("taskSendSelect.do")
    @ResponseBody
    public Map<String, Object> taskSendSelect(@RequestParam Map<String, Object> paramMap, 
    		HttpServletRequest request, HttpServletResponse response, HttpSession session ) throws Exception {
    	
	      logger.info("============ Start  " + className + ".taskSendSelect" + "============");
	  	  logger.info("   - paramMap : " + paramMap);

    	  paramMap.put("loginId", session.getAttribute("loginId"));
    	  
	  	  Map<String, Object> returnMap = new HashMap<String, Object>();

	  	  
	  	  TaskSendModel taskSendInfo = taskSendService.taskSendSelect(paramMap);
	  	  
	   	 returnMap.put("taskSendInfo", taskSendInfo);
	  	  
	  	 logger.info("============ End  " + className + ".taskSendSelect" + "============");
	  	 
	  	 return returnMap;
    }
    
    /* 과제 제출 & 수정*/
    @RequestMapping("taskSendSave.do")
    @ResponseBody
    public Map<String, Object> taskSend( @RequestParam Map<String, Object> paramMap, 
    		HttpServletRequest request, HttpServletResponse response, HttpSession session ) throws Exception {
    	
    	  
    	  logger.info("============ Start  " + className + ".taskSendSave" + "============");
    	  logger.info("   - paramMap : " + paramMap);
    	  
    	  Map<String, Object> returnMap = new HashMap<String, Object>();
    	  
    	  String action = String.valueOf(paramMap.get("action"));
    	  paramMap.put("loginId", session.getAttribute("loginId"));
		  System.out.println(paramMap.get("loginId"));

    	  if("I".equals(action)){
    		  taskSendService.taskInsert(paramMap, session, request);
    	  }else if("U".equals(action)){
    		  taskSendService.taskUpdate(paramMap, session, request);
    	  }
    	
     	  logger.info("============ End  " + className + ".taskSendSave" + "============");
    	return returnMap;
    }
     
    
	


}
