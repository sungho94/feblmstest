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

import kr.happyjob.study.adm.model.SubjectFailModel;
import kr.happyjob.study.adm.service.SubjectFailService;

@Controller
@RequestMapping("/adm/")
public class SubjectFailController {
	
	@Autowired
	SubjectFailService sfs;

	private final Logger logger = LogManager.getLogger(this.getClass());

	private final String className = this.getClass().toString();

	// 초기 페이지
	@RequestMapping("subjectFail.do")
	public String subjectFail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".subjectFail");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".subjectFail");

		return "adm/subjectFail/subjectFail";
	}
	
	// 초기 페이지
		@RequestMapping("subjectFailVue.do")
		public String subjectFailVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {

			logger.info("+ Start " + className + ".subjectFailVue");
			logger.info("   - paramMap : " + paramMap);

			logger.info("+ End " + className + ".subjectFailVue");

			return "adm/subjectFail/subjectFailVue";
		}

	// 페이지 이동 후 init에서 리스트 가져오기 실행 후 jstl로 이동 작업
	@RequestMapping("subjectFailList.do")
	public String getFailureList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		// 선언단
		int pageNum = Integer.parseInt((String)paramMap.get("pageNum"));
		int endPage = Integer.parseInt((String)paramMap.get("listCount"));
		int startPage = (pageNum - 1) * endPage;

		// 페이징 처리를 위한 파라미터 추가
		paramMap.put("startPage", startPage);
		paramMap.put("endPage", endPage);

		// 클라이언트에서 넘어온 데이터 체크
		logger.info("      paramMap Check    ::      " + paramMap);

		// DB 접근해서 리스트 + 카운트 가져와서 model에 추가
		model.addAttribute("subjectFailList", sfs.getSubjectFailList(paramMap));
		model.addAttribute("subjectFailCount", sfs.getSubjectFailTotal(paramMap));

		return "adm/subjectFail/subjectFailList";
	}
	
	// 페이지 이동 후 init에서 리스트 가져오기 실행 후 jstl로 이동 작업
	@RequestMapping("vuesubjectFailList.do")
	@ResponseBody
	public Map<String, Object> vuesubjectFailList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vuesubjectFailList");
		logger.info("   - paramMap : " + paramMap);
		
		// 선언단
		int pagenum = Integer.parseInt( String.valueOf( paramMap.get("pagenum") ) );
		logger.info(pagenum);
		int endPage = Integer.parseInt( String.valueOf( paramMap.get("listCount") ) );
		logger.info(endPage);
		int startPage = (pagenum - 1) * endPage;
		logger.info(startPage);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		logger.info(returnmap);

		// 페이징 처리를 위한 파라미터 추가
		paramMap.put("startPage", startPage);
		paramMap.put("endPage", endPage);

		List<SubjectFailModel> getSubjectFailList = sfs.getSubjectFailList(paramMap);
		int totalcnt = sfs.getSubjectFailTotal(paramMap);
		
		logger.info(getSubjectFailList);

		// DB 접근해서 리스트 + 카운트 가져와서 model에 추가
		returnmap.put("subjectFailList", getSubjectFailList);
		returnmap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vuesubjectFailList");

		return returnmap;
	}

	// 과목별 상세 비율 조회
	@ResponseBody
	@RequestMapping("subjectFailRatio.do")
	public Map<String, Object> getFailureRatio(@RequestParam Map<String, Object> paramMap) throws Exception {
		
		SubjectFailModel ratioInfo = sfs.getSubjectFailRatio(paramMap);
		
		// 선언단
		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 클라이언트에서 넘어온 데이터 체크
		logger.info("      paramMap Check    ::      " + paramMap);

		// DB 접근해서 리스트 + 카운트 가져와서 resultMap에 추가
		resultMap.put("ratioInfo", ratioInfo);

		return resultMap;
	}



}
