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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.std.model.StdStudyReferenceModel;
import kr.happyjob.study.std.service.StdStudyReferenceService;
import kr.happyjob.study.tut.model.TutStudyReferenceModel;


@Controller
@RequestMapping("/std/")
public class StdStudyReferenceController {
	

	@Autowired	
	StdStudyReferenceService stdStudyReferenceService;
	
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
		
		logger.info("+ End " + className + ".studyReference");

		return "std/studyReference/studyReference";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("studyReferenceVue.do")
	public String studyReferenceVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".studyReferenceVue");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".studyReferenceVue");

		return "std/studyReference/studyReferenceVue";
	}
	
	/**
	 * 강의 목록 조회
	 */
	@RequestMapping("LectureList.do")
	public String LectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".LectureList");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<StdStudyReferenceModel> LectureList = stdStudyReferenceService.LectureList(paramMap);
		int totalcnt = stdStudyReferenceService.LectureListCnt(paramMap);
		
		model.addAttribute("LectureList", LectureList);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".LectureList");

		return "std/studyReference/LectureList";
	}
	
	/**
	* 강의 목록 조회
	*/
	@RequestMapping("vueLectureList.do")
	@ResponseBody
	public Map <String, Object> vueLectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueLectureList");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String,Object> resultMap = new HashMap<String, Object>();
		
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		List<StdStudyReferenceModel> LectureList = stdStudyReferenceService.LectureList(paramMap);
		int totalcnt = stdStudyReferenceService.LectureListCnt(paramMap);
		
		resultMap.put("LectureList", LectureList);
		resultMap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vueLectureList");
		
		return resultMap;
		
		//return "std/studyReference/LectureList";
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
		
		List<StdStudyReferenceModel> referenceselectlist = stdStudyReferenceService.referenceselectlist(paramMap);
		int totalcnt = stdStudyReferenceService.referenceselectlistCnt(paramMap);
		
		model.addAttribute("referenceselectlist", referenceselectlist);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".referenceselectlist");

		return "std/studyReference/referenceselectlist";
	}
	
	/**
	 * 학습자료 목록 조회
	 */
	@RequestMapping("vueReferenceselectlist.do")
	@ResponseBody
	public Map <String, Object> vueReferenceselectlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueReferenceselectlist");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String,Object> resultMap = new HashMap<String, Object>();

		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		List<StdStudyReferenceModel> referenceselectlist = stdStudyReferenceService.referenceselectlist(paramMap);
		int totalcnt = stdStudyReferenceService.referenceselectlistCnt(paramMap);
		
		resultMap.put("referenceselectlist", referenceselectlist);
		resultMap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vueReferenceselectlist");
		
		return resultMap;
		
		//return "std/studyReference/referenceselectlist";
	}
	
	/**
	 * 학습자료 조회
	 */
	@RequestMapping("referenceselect.do")
	@ResponseBody
	public Map<String, Object> referenceselect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".referenceselect");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		StdStudyReferenceModel referenceinfo = stdStudyReferenceService.referenceselect(paramMap);
		
		returnmap.put("referenceinfo", referenceinfo);
		
		logger.info("+ End " + className + ".referenceselect");

		return returnmap;
	}
	
	/**
	 * 학습자료 조회
	 */
	@RequestMapping("vueReferenceselect.do")
	@ResponseBody
	public Map<String, Object> vueReferenceselect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueReferenceselect");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		StdStudyReferenceModel referenceinfo = stdStudyReferenceService.referenceselect(paramMap);
		
		returnmap.put("referenceinfo", referenceinfo);
		
		logger.info("+ End " + className + ".vueReferenceselect");
		
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
		
		StdStudyReferenceModel referenceinfo = stdStudyReferenceService.referenceselect(paramMap);
		
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

