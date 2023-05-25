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

import kr.happyjob.study.tut.model.TutStudyReferenceModel;
import kr.happyjob.study.tut.service.TutStudyReferenceService;


@Controller
@RequestMapping("/tut/")
public class TutStudyReferenceController {
	
	@Autowired
	TutStudyReferenceService tutStudyReferenceService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 초기화면
	 */
	@RequestMapping("studyReference.do")
	public String studyReference(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studyReference");
		logger.info("   - paramMap : " + paramMap);
		
		request.setAttribute("loginID", session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".studyReference");

		return "tut/studyReference/studyReference";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("studyReferenceVue.do")
	public String studyReferenceVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studyReferenceVue");
		logger.info("   - paramMap : " + paramMap);
		
		request.setAttribute("loginID", session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".studyReferenceVue");

		return "tut/studyReference/studyReferenceVue";
	}
	
	/**
	 * 강의 목록 조회
	 */
	@RequestMapping("LectureList.do")
	public String LectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".LectureList");
		logger.info("   - paramMap : " + paramMap);
		
		String sessionloginid = (String) session.getAttribute("loginId");
		
		if(!"".equals(sessionloginid)) {
			paramMap.put("loginID", session.getAttribute("loginId"));
		}
		
		
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<TutStudyReferenceModel> LectureList = tutStudyReferenceService.LectureList(paramMap);
		int totalcnt = tutStudyReferenceService.LectureListCnt(paramMap);
		
		model.addAttribute("LectureList", LectureList);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".LectureList");

		return "tut/studyReference/LectureList";
	}
	
	/**
	 * 강의 목록 조회 Vue
	 */
	@RequestMapping("vueLectureList.do")
	@ResponseBody
	public Map<String, Object> vueLectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueLectureList");
		logger.info("   - paramMap : " + paramMap);
		
		String sessionloginid = (String) session.getAttribute("loginId");
		if(!"".equals(sessionloginid)) {
			paramMap.put("loginID", session.getAttribute("loginId"));
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<TutStudyReferenceModel> LectureList = tutStudyReferenceService.LectureList(paramMap);
		int totalcnt = tutStudyReferenceService.LectureListCnt(paramMap);
		
		returnmap.put("LectureList", LectureList);
		returnmap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vueLectureList");

		return returnmap;
	}
	
	/**
	 * 학습자료 목록 조회
	 */
	@RequestMapping("referenceselectlist.do")
	public String referenceselectlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".referenceselectlist");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<TutStudyReferenceModel> referenceselectlist = tutStudyReferenceService.referenceselectlist(paramMap);
		int totalcnt = tutStudyReferenceService.referenceselectlistCnt(paramMap);
		
		model.addAttribute("referenceselectlist", referenceselectlist);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".referenceselectlist");

		return "tut/studyReference/referenceselectlist";
	}
	
	/**
	 * 학습자료 목록 조회 Vue
	 */
	@RequestMapping("vuereferenceselectlist.do")
	@ResponseBody
	public Map<String, Object> vuereferenceselectlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vuereferenceselectlist");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<TutStudyReferenceModel> referenceselectlist = tutStudyReferenceService.referenceselectlist(paramMap);
		int totalcnt = tutStudyReferenceService.referenceselectlistCnt(paramMap);
		
		returnmap.put("referenceselectlist", referenceselectlist);
		returnmap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vuereferenceselectlist");

		return returnmap;
	}
	
	/**
	 * 학습자료 목록 detail
	 */
	@RequestMapping("referenceselect.do")
	@ResponseBody
	public Map<String, Object> referenceselect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".referenceselect");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		TutStudyReferenceModel referenceinfo = tutStudyReferenceService.referenceselect(paramMap);
		
		returnmap.put("referenceinfo", referenceinfo);
		
		logger.info("+ End " + className + ".referenceselect");

		return returnmap;
	}
	
	
	
	/**
	 * 학습자료 저장, 수정, 삭제
	 */
	@RequestMapping("savereference.do")
	@ResponseBody
	public Map<String, Object> savereference(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".savereference");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)){
			tutStudyReferenceService.referenceinsert(paramMap, request, session);
		} else if("U".equals(action)){
			tutStudyReferenceService.referenceupdate(paramMap, request, session);
		} else if("D".equals(action)){
			tutStudyReferenceService.referencedelete(paramMap, request);
		}
		
		logger.info("+ End " + className + ".savereference");

		return returnmap;
	}
	
	/**
	 * 학습자료 다운로드
	 */
	@RequestMapping("referencedownload.do")
	public void referencedownload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".referencedownload");
		logger.info("   - paramMap : " + paramMap);
		
		TutStudyReferenceModel referenceinfo = tutStudyReferenceService.referenceselect(paramMap);
		
		String file = referenceinfo.getReference_mul();
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(referenceinfo.getReference_file(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
		
		logger.info("+ End " + className + ".referencedownload");

		return;
	}


}
