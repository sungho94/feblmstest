package kr.happyjob.study.tut.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.tut.model.LectureModel;
import kr.happyjob.study.tut.model.PlanListModel;
import kr.happyjob.study.tut.model.TaskModel;
import kr.happyjob.study.tut.model.TaskSendModel;
import kr.happyjob.study.tut.service.TaskService;


@Controller
@RequestMapping("/tut/")
public class TaskController {
	
		@Autowired
		TaskService taskService;
		
		// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());
	
		// Get class name for logger
		private final String className = this.getClass().toString();
		
		/**
		 * 과제관리(강사) 초기화면
		 */
		@RequestMapping("task.do")
		public String task(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".task");
			logger.info("   - paramMap : " + paramMap);
			
			logger.info("+ End " + className + ".task");
	
			return "tut/task/task";
		}
		
		/**
		 * 과제관리(강사) 초기화면
		 */
		@RequestMapping("taskVue.do")
		public String taskVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".taskVue");
			logger.info("   - paramMap : " + paramMap);
			
			logger.info("+ End " + className + ".taskVue");
	
			return "tut/task/taskVue";
		}
		
		
	   /**  수업 목록  */
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
		    
			List <LectureModel> lectureList = taskService.lectureList(paramMap, session);
			int totalCnt = taskService.lectureListCnt(paramMap);
			
			model.addAttribute("lectureList", lectureList);
			model.addAttribute("totalCnt",totalCnt);
			
			logger.info("========= End " + className + ".lectureList" +  "=========");
    	  
			return "tut/task/lectureList";
    	  
      }
		
      /**  수업 목록  */
      @RequestMapping("vueLecturelist.do")
      @ResponseBody
      public Map<String, Object> vueLecturelist(Model model,  @RequestParam Map<String, Object> paramMap,
    		  HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
    	  
    	  
    	  logger.info("========= Start  " + className + ".vueLecturelist" + "=========");
    	  logger.info("   - paramMap : " + paramMap);
    	  
    	  Map<String, Object> resultMap = new HashMap<String, Object>();
    	  
    	  int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) ); 
    	  int  pageSize = Integer.parseInt ( String.valueOf ( paramMap.get("pageSize") ) );
    	  int startNum =  (pageNum - 1) * pageSize;
    	  
    	  paramMap.put("startNum", startNum);
    	  paramMap.put("pageSize", pageSize);
    	  paramMap.put("loginid", session.getAttribute("loginId"));
    	  
    	  List <LectureModel> lectureList = taskService.lectureList(paramMap, session);
    	  int totalCnt = taskService.lectureListCnt(paramMap);
    	  
    	  resultMap.put("lectureList", lectureList);
    	  resultMap.put("totalCnt",totalCnt);
    	  
    	  logger.info("========= End " + className + ".vueLecturelist" +  "=========");
    	  
    	  return resultMap;
    	  
      }
      
	   /** 강의계획서 목록  */
     @RequestMapping("planlist.do")
     public String planlist(Model model,  @RequestParam Map<String, Object> paramMap,
   		  HttpServletRequest request, HttpServletResponse response) throws Exception{
   	   
   	  
   	    logger.info("========= Start  " + className + ".planlist" + "=========");
			logger.info("   - paramMap : " + paramMap);
		    int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) ); 
		    int  pageSize = Integer.parseInt ( String.valueOf ( paramMap.get("pageSize") ) );
		    int startNum =  (pageNum - 1) * pageSize;
			
		     paramMap.put("startNum", startNum);
		     paramMap.put("pageSize", pageSize);
		    
			List <PlanListModel> planList = taskService.planList(paramMap);
			int totalCnt = taskService.planListCnt(paramMap);
			
			model.addAttribute("planList", planList);
			model.addAttribute("totalCnt",totalCnt);
			
			logger.info("========= End " + className + ".planlist" +  "=========");
   	  
			return "tut/task/planList";
   	  
     }
      
     /** 강의계획서 목록  */
     @RequestMapping("vuePlanlist.do")
     @ResponseBody
     public Map<String, Object> vuePlanlist(Model model,  @RequestParam Map<String, Object> paramMap,
    		 HttpServletRequest request, HttpServletResponse response) throws Exception{
    	 
    	 
    	 logger.info("========= Start  " + className + ".vuePlanlist" + "=========");
    	 logger.info("   - paramMap : " + paramMap);
    	 
    	 Map<String, Object> resultMap = new HashMap<String, Object>();
    	 
    	 int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) ); 
    	 int  pageSize = Integer.parseInt ( String.valueOf ( paramMap.get("pageSize") ) );
    	 int startNum =  (pageNum - 1) * pageSize;
    	 
    	 paramMap.put("startNum", startNum);
    	 paramMap.put("pageSize", pageSize);
    	 
    	 List <PlanListModel> planList = taskService.planList(paramMap);
    	 int totalCnt = taskService.planListCnt(paramMap);
    	 
    	 resultMap.put("planList", planList);
    	 resultMap.put("totalCnt",totalCnt);
    	 
    	 logger.info("========= End " + className + ".vuePlanlist" +  "=========");
    	 
    	 return resultMap;
    	 
     }
     
      
      /**  과제관리  목록  */
      @RequestMapping("tasklist.do")
      public String taskList(Model model,  @RequestParam Map<String, Object> paramMap,
    		  HttpServletRequest request, HttpServletResponse response) throws Exception{
    	   
    	  
    	    logger.info("========= Start  " + className + ".tasklist" + "=========");
			logger.info("   - paramMap : " + paramMap);
		    int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) ); 
		    int  pageSize = Integer.parseInt ( String.valueOf ( paramMap.get("pageSize") ) );
		    int startNum =  (pageNum - 1) * pageSize;
			
		     paramMap.put("startNum", startNum);
		     paramMap.put("pageSize", pageSize);
		     
			List <TaskModel> taskList = taskService.taskList(paramMap);
			int totalCnt = taskService.taskListCnt(paramMap);
			
			model.addAttribute("taskList", taskList);
			model.addAttribute("totalCnt",totalCnt);
			logger.info("========= End " + className + ".task" +  "=========");
    	  
    	  return "tut/task/taskList";
    	  
      }
	
      /**  과제관리  목록  */
      @RequestMapping("vueTasklist.do")
      @ResponseBody
      public Map<String, Object> vueTasklist(Model model,  @RequestParam Map<String, Object> paramMap,
    		  HttpServletRequest request, HttpServletResponse response) throws Exception{
    	  
    	  logger.info("========= Start  " + className + ".vueTasklist" + "=========");
    	  logger.info("   - paramMap : " + paramMap);
    	  
    	  Map<String, Object> resultMap = new HashMap<String, Object>();
    	  
    	  int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) ); 
    	  int  pageSize = Integer.parseInt ( String.valueOf ( paramMap.get("pageSize") ) );
    	  int startNum =  (pageNum - 1) * pageSize;
    	  
    	  paramMap.put("startNum", startNum);
    	  paramMap.put("pageSize", pageSize);
    	  
    	  List <TaskModel> taskList = taskService.taskList(paramMap);
    	  int totalCnt = taskService.taskListCnt(paramMap);
    	  
    	  resultMap.put("taskList", taskList);
    	  resultMap.put("totalCnt",totalCnt);
    	  logger.info("========= End " + className + ".vueTasklist" +  "=========");
    	  
    	  return resultMap;
    	  
      }
      
      
      /**   과제관리 상세보기   */
      @RequestMapping("taskdetail.do")
      @ResponseBody
      public Map<String, Object> taskDetail(Model model,  @RequestParam Map<String, Object> paramMap,
    		  HttpServletRequest request, HttpServletResponse response) throws Exception{
    	   
    	    logger.info("========= Start  " + className + ".taskDetail" + "=========");
			logger.info("   - paramMap : " + paramMap);

			
			Map<String, Object> returnMap = new HashMap<String, Object>();
			TaskModel taskInfo = taskService.taskDetail(paramMap);
			
			returnMap.put("taskInfo", taskInfo);
			
			
			logger.info("========= End " + className + ".taskDetail" +  "=========");
    	  
    	  return returnMap;
    	  
      }
      
   /**   과제 제출 명단   */
      @RequestMapping("tasksendinfo.do")
      public String tasksendinfo(Model model,  @RequestParam Map<String, Object> paramMap,
    		  HttpServletRequest request, HttpServletResponse response) throws Exception{
    	   
    	    logger.info("========= Start  " + className + ".tasksendinfo" + "=========");
			logger.info("   - paramMap : " + paramMap);
		    int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) ); 
		    int  pageSize = Integer.parseInt ( String.valueOf ( paramMap.get("pageSize") ) );
		    int startNum =  (pageNum - 1) * pageSize;
			
		     paramMap.put("startNum", startNum);
		     paramMap.put("pageSize", pageSize);
			List<TaskSendModel> tasksendinfo = taskService.tasksendinfo(paramMap);
			int totalCnt = taskService.tasksnedtCnt(paramMap);
			
			model.addAttribute("tasksendinfo", tasksendinfo);
			model.addAttribute("totalCnt",totalCnt);
			
			logger.info("========= End " + className + ".tasksendinfo" +  "=========");
    	  
    	  return "tut/task/taskSendList";
    	  
      }
      
      /**   과제 제출 명단   */
      @RequestMapping("vueTasksendinfo.do")
      @ResponseBody
      public Map<String, Object> vueTasksendinfo(Model model,  @RequestParam Map<String, Object> paramMap,
    		  HttpServletRequest request, HttpServletResponse response) throws Exception{
    	  
    	  logger.info("========= Start  " + className + ".vueTasksendinfo" + "=========");
    	  logger.info("   - paramMap : " + paramMap);
    	  
    	  Map<String, Object> resultMap = new HashMap<String, Object>();
    	   
    	  int pageNum = Integer.parseInt( String.valueOf( paramMap.get("pageNum") ) ); 
    	  int  pageSize = Integer.parseInt ( String.valueOf ( paramMap.get("pageSize") ) );
    	  int startNum =  (pageNum - 1) * pageSize;
    	  
    	  paramMap.put("startNum", startNum);
    	  paramMap.put("pageSize", pageSize);
    	  List<TaskSendModel> tasksendinfo = taskService.tasksendinfo(paramMap);
    	  int totalCnt = taskService.tasksnedtCnt(paramMap);
    	  
    	  resultMap.put("tasksendinfo", tasksendinfo);
    	  resultMap.put("totalCnt",totalCnt);
    	  
    	  logger.info("========= End " + className + ".vueTasksendinfo" +  "=========");
    	  
    	  return resultMap;
    	  
      }
      
      /** 제출과제 상세보기*/
      @RequestMapping("taskSendDetail.do")
      @ResponseBody
      public Map<String, Object> taskSendDetail(Model model,  @RequestParam Map<String, Object> paramMap,
    		  HttpServletRequest request, HttpServletResponse response) throws Exception{
    	   
    	    logger.info("========= Start  " + className + ".taskSendDetail" + "=========");
			logger.info("   - paramMap : " + paramMap);
			
			
			Map<String, Object> returnMap = new HashMap<String, Object>();
			TaskSendModel taskSendInfo = taskService.taskSendDetail(paramMap);
			
			returnMap.put("taskSendInfo", taskSendInfo);
			
			
			logger.info("========= End " + className + ".taskSendDetail" +  "=========");
    	  
    	  return returnMap;
    	  
      }
      
      /** 제출 과제 파일  & 다운로드*/
      @RequestMapping("taskSendFile.do")
      public void taskSendFile(Model model, @RequestParam Map<String, Object> paramMap, 
    		  HttpServletRequest request, HttpServletResponse response) throws Exception {
    	  
    	  logger.info("============ Start  " + className + ".taskSendFile" + "============");
    	  logger.info("   - paramMap : " + paramMap);
    	  
    	  TaskSendModel taskSendInfo = taskService.taskSendDetail(paramMap);
    	  
    	  String file = taskSendInfo.getSendMul();
    	  
    	  byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
    	  
    	  response.setContentType("application/octet-stream");
    	  response.setContentLength(fileByte.length);
    	  response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(taskSendInfo.getSendFile(),"UTF-8")+"\";");
    	  response.setHeader("Content-Transfer-Encoding", "binary");
    	  response.getOutputStream().write(fileByte);
    	  
    	  logger.info("============ End  " + className + ".taskSendFile" + "============");
    	  return;
      }
      
      
      /**   과제 등록, 수정(강사) */
      @RequestMapping("taskinsert.do")
      @ResponseBody
      public Map<String, Object> taskInsert (@RequestParam Map<String, Object> paramMap,
    		  HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception{
    	   
    	  logger.info("============ Start  " + className + ".taskInsert" + "============");
    	  logger.info("   - paramMap : " + paramMap);
    	  
    		Map<String, Object> returnMap = new HashMap<String, Object>();
    		
    		String action = String.valueOf(paramMap.get("action"));
    		
    		if("I".equals(action)){
    			taskService.taskInsert(paramMap,session,request);
    		}else if("U".equals(action)){
    			taskService.taskUpdate(paramMap,session,request);
    		}
    		
    	 logger.info("============ End  " + className + ".taskInsert" + "============");
    	  return returnMap;
      }
      
   
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
}
