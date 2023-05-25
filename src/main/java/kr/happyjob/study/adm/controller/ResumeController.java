package kr.happyjob.study.adm.controller;

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

import kr.happyjob.study.adm.model.ResumeModel;
import kr.happyjob.study.adm.service.ResumeService;
import kr.happyjob.study.tut.model.TutStudyReferenceModel;


@Controller
@RequestMapping("/adm/")
public class ResumeController {
	
	@Autowired
	ResumeService resumeService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 초기화면
	 */
	@RequestMapping("resume.do")
	public String resume(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".resume");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".resume");

		return "adm/resume/resume";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("resumeVue.do")
	public String resumeVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".resumeVue");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".resumeVue");

		return "adm/resume/resumeVue";
	}
	
	/**
	 * 개설 강의 목록 조회
	 */
	@RequestMapping("resumeLectureListSearch.do")
	public String resumeLectureListSearch(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".resumeLectureListSearch");
		logger.info("   - paramMap : " + paramMap);
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<ResumeModel> resumeLectureListSearch = resumeService.resumeLectureListSearch(paramMap);
		int totalcnt = resumeService.resumeLectureListCnt(paramMap);
		
		model.addAttribute("resumeLectureListSearch", resumeLectureListSearch);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".resumeLectureListSearch");

		return "adm/resume/resumeLectureList";
	}
	
	/**
	 * 개설 강의 목록 조회
	 */
	@RequestMapping("resumeLectureListSearchVue.do")
	@ResponseBody
	public Map<String, Object> resumeLectureListSearchVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".resumeLectureListSearch");
		logger.info("   - paramMap : " + paramMap);
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;
		
		Map <String, Object> returnData = new HashMap<String, Object>();

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<ResumeModel> resumeLectureListSearch = resumeService.resumeLectureListSearch(paramMap);
		int totalcnt = resumeService.resumeLectureListCnt(paramMap);
		
		returnData.put("resumeLectureListSearch", resumeLectureListSearch);
		returnData.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".resumeLectureListSearch");

		return returnData;
	}
	
	/**
	 * 학생 목록 조회
	 */
	@RequestMapping("resumeLectureSelect.do")
	public String resumeLectureSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".resumeLectureSelect");
		logger.info("   - paramMap : " + paramMap);
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<ResumeModel> resumeLectureSelect = resumeService.resumeLectureSelect(paramMap);
		int totalcnt = resumeService.resumeLectureSelectCnt(paramMap);
		
		model.addAttribute("resumeLectureSelect", resumeLectureSelect);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".resumeLectureSelect");

		return "adm/resume/resumeStudentList";
	}
	
	/**
	 * 학생 목록 조회
	 */
	@RequestMapping("resumeLectureSelectVue.do")
	@ResponseBody
	public Map <String, Object> resumeLectureSelectVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".resumeLectureSelect");
		logger.info("   - paramMap : " + paramMap);
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		Map <String, Object> returnData = new HashMap<String,Object>();
		
		List<ResumeModel> resumeLectureSelect = resumeService.resumeLectureSelect(paramMap);
		int totalcnt = resumeService.resumeLectureSelectCnt(paramMap);
		
		returnData.put("resumeLectureSelect", resumeLectureSelect);
		returnData.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".resumeLectureSelect");

		return returnData;
	}
	/**
	 * 이력서 다운로드
	 */
	@RequestMapping("Downloadselect.do")
	@ResponseBody
	public Map<String, Object> Downloadselect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".Downloadselect");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		ResumeModel filenameinfo = resumeService.userinfo(paramMap);
		
		returnMap.put("filenameinfo", filenameinfo);
		
		logger.info("+ End " + className + ".Downloadselect");

		return returnMap;
	}
	
	/**
	 * 이력서 다운로드
	 */
	@RequestMapping("Download.do")
	public void referencedownload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".Download");
		logger.info("   - paramMap : " + paramMap);
		
		ResumeModel userinfo = resumeService.userinfo(paramMap);
		
		String file = userinfo.getResume_mul();
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(file));
		
	    response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(userinfo.getResume_file(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
		
		logger.info("+ End " + className + ".Download");

		return;
	}
	
	
}
