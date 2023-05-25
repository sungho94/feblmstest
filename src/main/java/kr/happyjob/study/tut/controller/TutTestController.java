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
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.tut.model.TutTestModel;
import kr.happyjob.study.tut.service.TutTestService;


@Controller
@RequestMapping("/tut/")
public class TutTestController {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	TutTestService tutTestService;	
	/*
	 * 초기화면
	 */
	@RequestMapping("test.do")
	public String test(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".test");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".test");

		return "tut/test/test";
	}
	
	/*
	 * 초기화면
	 */
	@RequestMapping("testVue.do")
	public String testVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".testVue");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".testVue");

		return "tut/test/testVue";
	}
	
	
	//시험리스트
	@RequestMapping("testList.do")
	public String testList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".testList");
		logger.info("   - paramMap : " + paramMap);
		
		int pagenum = Integer.parseInt( String.valueOf(paramMap.get("pagenum")));
		int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1)*pageSize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pageSize",pageSize);
		
		List<TutTestModel> testList = tutTestService.testList(paramMap);
		int totalcnt = tutTestService.testListCnt(paramMap);
		
		model.addAttribute("testList",testList);
		model.addAttribute("totalcnt", totalcnt);
		logger.info("+ End " + className + ".testList");
		
		return "tut/test/testList";
	}
	
	//시험리스트 Vue
		@RequestMapping("vuetestList.do")
		@ResponseBody
		public Map<String, Object> vuetestList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".vuetestList");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			int pagenum = Integer.parseInt( String.valueOf(paramMap.get("pagenum")));
			int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize")));
			int startnum = (pagenum - 1)*pageSize;
			
			paramMap.put("startnum", startnum);
			paramMap.put("pageSize",pageSize);
			
			List<TutTestModel> testList = tutTestService.testList(paramMap);
			int totalcnt = tutTestService.testListCnt(paramMap);
			
			returnmap.put("testList",testList);
			returnmap.put("totalcnt", totalcnt);
			logger.info("+ End " + className + ".vuetestList");
			
			return returnmap;
		}
	
	/*
	 * 시험 상세 조회
	 */
	@RequestMapping("testDetail.do")
	@ResponseBody
	public Map<String, Object> roomDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".testDetail");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		TutTestModel testInfo = tutTestService.testDetail(paramMap);
		
		
		returnmap.put("testInfo",testInfo);
		session.setAttribute("test_no", paramMap.get("test_no"));

		logger.info("+ End " + className + ".testDetail");
		
		return returnmap;
	}	

	/*
	 * 시험 상세 조회에서 등록된 강의보기 
	 
	@RequestMapping("testDetailSelect.do")
	@ResponseBody
	public Map<String, Object> roomDetailSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".testDetailSelect");
		logger.info("   - paramMap : " + paramMap);
		
		
		session.setAttribute("test_no",paramMap.get("test_no"));
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		Map<String , Object> testInfoSelect = tutTestService.testDetailSelect(paramMap);
		
		
		
		returnmap.put("testInfoSelect",testInfoSelect);
		
		session.setAttribute("testInfoSelect", testInfoSelect);
		model.addAttribute("testInfoSelect", testInfoSelect);
		
		if(testInfoSelect == null || returnmap == null) {
			testInfoSelect.put("", "");
			returnmap.put("","");
		} else{
			System.out.println("세션에 보내는 렉쳐시퀀스 : " +testInfoSelect.get("lecture_seq"));
		}
		logger.info("+ End " + className + ".testDetailSelect");

		
		return returnmap;
	}*/
	
	/*
	 * 시험 저장
	 */
	@RequestMapping("testSave.do")
	@ResponseBody
	public Map<String, Object>testSave (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".testSave");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String action = String.valueOf(paramMap.get("action"));	
		
		if("I".equals(action)) {
			tutTestService.testInsert(paramMap);
		} else if("U".equals(action)) {
			/*model.addAttribute("loginID",session.getAttribute("loginID"));
			model.addAttribute("lecture_seq",);*/
			tutTestService.testUpdate(paramMap);
		} else if("D".equals(action)) {
			tutTestService.testDelete(paramMap);
		}
		
		returnmap.put("result","SUCESS");
		
		logger.info("+ End " + className + ".testSave");

		return returnmap;
	}		
	
	//문제리스트
		@RequestMapping("questionList.do")
		public String questionList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".questionList");
			logger.info("   - paramMap : " + paramMap);
			/*
			int pagenum = Integer.parseInt( String.valueOf(paramMap.get("pagenum")));
			int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize")));
			int startnum = (pagenum - 1)*pageSize;
			
			paramMap.put("startnum", startnum);
			paramMap.put("pageSize",pageSize);*/
			
			List<TutTestModel> questionList = tutTestService.questionList(paramMap);
			int qtotalcnt = tutTestService.questionListCnt(paramMap);
			
			model.addAttribute("questionList",questionList);
			model.addAttribute("qtotalcnt", qtotalcnt);
			
			logger.info("+ End " + className + ".questionList");
			
			return "tut/test/questionList";
		}
		
		//문제리스트 Vue
				@RequestMapping("vuequestionList.do")
				@ResponseBody
				public Map<String, Object> vuequestionList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
						HttpServletResponse response, HttpSession session) throws Exception {
					
					logger.info("+ Start " + className + ".vuequestionList");
					logger.info("   - paramMap : " + paramMap);
					
					Map<String, Object> returnmap = new HashMap<String, Object>();
					
					int pagenum = Integer.parseInt( String.valueOf(paramMap.get("pagenum")));
					int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize")));
					int startnum = (pagenum - 1)*pageSize;
					
					paramMap.put("startnum", startnum);
					paramMap.put("pageSize",pageSize);
					
					List<TutTestModel> questionList = tutTestService.questionList(paramMap);
					int qtotalcnt = tutTestService.questionListCnt(paramMap);
					
					returnmap.put("questionList",questionList);
					returnmap.put("qtotalcnt", qtotalcnt);
					
					logger.info("+ End " + className + ".vuequestionList");
					
					return returnmap;
				}
		
		/*
		 * 문제 상세 조회
		 */
		@RequestMapping("questionDetail.do")
		@ResponseBody
		public Map<String, Object> questionDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".questionDetail");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			TutTestModel questionInfo = tutTestService.questionDetail(paramMap);
			
			
			returnmap.put("questionInfo",questionInfo);
			
			
			logger.info("+ End " + className + ".questionDetail");

			return returnmap;
		}	
		/*
		 * 문제 저장
		 */
		@RequestMapping("questionSave.do")
		@ResponseBody
		public Map<String, Object>questionSave (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".questionSave");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			String qaction = String.valueOf(paramMap.get("qaction"));	
			
			if("I".equals(qaction)) {
				tutTestService.questionInsert(paramMap);
			} else if("U".equals(qaction)) {
				tutTestService.questionUpdate(paramMap);
			} else if("D".equals(qaction)) {
				tutTestService.questionDelete(paramMap);
			}
			
			returnmap.put("result","SUCESS");
			
			logger.info("+ End " + className + ".questionSave");

			return returnmap;
		}		
}
