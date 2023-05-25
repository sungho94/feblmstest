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

import kr.happyjob.study.adm.model.EmployModel;
import kr.happyjob.study.adm.service.EmployService;
import kr.happyjob.study.all.model.NoticeMgrModel;


@Controller
@RequestMapping("/adm/")
public class EmployController {
	
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	EmployService empService;
	
	/**
	 * 초기화면
	 */
	@RequestMapping("employ.do")
	public String employ(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".employ");
		logger.info("   - paramMap : " + paramMap);
		
		//사용자 로그인값 넘기기
		request.setAttribute("loginID", session.getAttribute("loginID"));
		request.setAttribute("userType", session.getAttribute("userType"));
				
		logger.info("+ End " + className + ".employ");

		return "adm/employ/employ";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("employVue.do")
	public String employVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".employVue");
		logger.info("   - paramMap : " + paramMap);
		
		//사용자 로그인값 넘기기
		request.setAttribute("loginID", session.getAttribute("loginID"));
		request.setAttribute("userType", session.getAttribute("userType"));
				
		logger.info("+ End " + className + ".employVue");

		return "adm/employ/employVue";
	}
	
	/**
	 * 취업 정보 등록 리스트 empclasslist
	 */
	@RequestMapping("empclasslist.do")
	public String empclasslist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".empclasslist");
		logger.info("   - paramMap : " + paramMap);
		
		int pagenum = Integer.parseInt( String.valueOf( paramMap.get("pagenum") ) );
		int pageSize = Integer.parseInt( String.valueOf( paramMap.get("pageSize") ) );
		int startnum = (pagenum - 1) * pageSize;

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<EmployModel> empclasslist = empService.empclasslist(paramMap);
		int totalcnt = empService.studentclasscnt(paramMap);
		model.addAttribute("empclasslist", empclasslist);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".empclasslist");
		
		return "adm/employ/empstulist";
	}
	
	/**
	 * 취업 정보 등록 리스트 vueempclasslist
	 */
	@RequestMapping("vueempclasslist.do")
	@ResponseBody
	public Map<String, Object> vueempclasslist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueempclasslist");
		logger.info("   - paramMap : " + paramMap);
		
		int pagenum = Integer.parseInt( String.valueOf( paramMap.get("pagenum") ) );
		int pageSize = Integer.parseInt( String.valueOf( paramMap.get("pageSize") ) );
		int startnum = (pagenum - 1) * pageSize;
		
		Map<String, Object> returnmap = new HashMap<String, Object>();

		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<EmployModel> empclasslist = empService.empclasslist(paramMap);
		int totalcnt = empService.studentclasscnt(paramMap);
		
		returnmap.put("empclasslist", empclasslist);
		returnmap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vueempclasslist");
		
		return returnmap;
	}
	
	/**
	 * 학생 employee detail 내용 detailcontent
	 */
	@RequestMapping("detailcontent.do")
	public String detailcontent(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".detailcontent");
		logger.info("   - paramMap : " + paramMap);
		
		List<EmployModel> employdetaillist = empService.detailcontent(paramMap);
		int totalcnt = empService.detailcnt(paramMap);
		model.addAttribute("employdetaillist", employdetaillist);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".detailcontent");
		
		return "adm/employ/empstucontent";
	}
	
	/**
	 * 학생 employee detail 내용 detailcontent
	 */
//	@RequestMapping("vuedetailcontent.do")
//	@ResponseBody
//	public Map<String, Object> vuedetailcontent(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
//			HttpServletResponse response, HttpSession session) throws Exception {
//
//		logger.info("+ Start " + className + ".vuedetailcontent");
//		logger.info("   - paramMap : " + paramMap);
//		
//		Map<String, Object> returnmap = new HashMap<String, Object>();
//		
//		List<EmployModel> employdetaillist = empService.detailcontent(paramMap);
//		int totalcnt = empService.detailcnt(paramMap);
//		
//		returnmap.put("employdetaillist", employdetaillist);
//		returnmap.put("totalcnt", totalcnt);
//		
//		logger.info("+ End " + className + ".vuedetailcontent");
//		
//		return returnmap;
//	}
	
	/**
	 * 학생 employee detail 내용 detailcontent paging수정
	 */
	@RequestMapping("vuedetailcontent.do")
	@ResponseBody
	public Map<String, Object> vuedetailcontent(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".vuedetailcontent");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		int pagenum =Integer.parseInt(String.valueOf(paramMap.get("pagenum")));
		int pageSize =Integer.parseInt(String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1) * pageSize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<EmployModel> employdetaillist = empService.detailcontent(paramMap);
		int totalcnt = empService.detailcnt(paramMap);
		
		returnmap.put("employdetaillist", employdetaillist);
		returnmap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vuedetailcontent");
		
		return returnmap;
	}
	
	/**
	 * 학생 employee detail 내용 detailcontent
	 */
	@RequestMapping("vuesdetailcontent.do")
	@ResponseBody
	public Map<String, Object> vuesdetailcontent(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".vuesdetailcontent");
		logger.info("   - paramMap : " + paramMap);
		
		EmployModel empInfo = empService.sdetailcontent(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("empInfo", empInfo);
		
		logger.info("+ End " + className + ".vuesdetailcontent");
		
		return returnmap;
	}
	
	/**
	 * 상단 취업 학생 추가 (insert, update)
	 */
	@RequestMapping("empsave.do")
	@ResponseBody
	public Map<String, Object> empinsert(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".empsave");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnlist = new HashMap<String, Object>();
		String empaction = String.valueOf(paramMap.get("action"));
		
		if("I".equals(empaction)){
			empService.empinsert(paramMap);
		} else if("U".equals(empaction)){
			empService.empupdate(paramMap);
		} else if("D".equals(empaction)){
			empService.empdelete(paramMap);
		}
		
		logger.info("+ End " + className + ".empsave");
		
		return returnlist;
	}
}
