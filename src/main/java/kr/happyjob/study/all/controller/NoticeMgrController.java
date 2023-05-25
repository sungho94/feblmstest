package kr.happyjob.study.all.controller;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.all.dao.NoticeMgrDao;
import kr.happyjob.study.all.model.NoticeMgrModel;
import kr.happyjob.study.all.model.QnaModel;
import kr.happyjob.study.all.service.NoticeMgrService;



@Controller
@RequestMapping("/all/")
public class NoticeMgrController {
	
	@Autowired
	NoticeMgrService noticeMgrService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 초기화면
	 */
	@RequestMapping("noticeMgr.do")
	public String noticeMgr(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticeMgr");
		logger.info("   - paramMap : " + paramMap);
		
		//사용자 로그인값 넘기기
		request.setAttribute("loginID", session.getAttribute("loginID"));
		request.setAttribute("userType", session.getAttribute("userType"));
		
		
		logger.info("+ End " + className + ".noticeMgr");

		return "all/noticeMgr/noticeMgr";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("noticeMgrVue.do")
	public String noticeMgrVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticeMgrVue");
		logger.info("   - paramMap : " + paramMap);
		
		//사용자 로그인값 넘기기
		request.setAttribute("loginID", session.getAttribute("loginID"));
		request.setAttribute("userType", session.getAttribute("userType"));
		
		
		logger.info("+ End " + className + ".noticeMgrVue");

		return "all/noticeMgr/noticeMgrVue";
	}
	
	
	
	/**
	 * 공지사항 목록 화면 
	 */
	@RequestMapping("noticemgrlist.do")
	public String noticemgrlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticemgrlist");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
	
		int pagenum = Integer.parseInt( String.valueOf( paramMap.get("pagenum") ) );
		int pageSize = Integer.parseInt( String.valueOf( paramMap.get("pageSize") ) );
		int startnum = (pagenum - 1) * pageSize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<NoticeMgrModel> noticemgrlist = noticeMgrService.noticemgrlist(paramMap);
		int totalcnt = noticeMgrService.noticmgrcnt(paramMap);
		model.addAttribute("noticemgrlist",noticemgrlist);
		model.addAttribute("totalcnt",totalcnt);
		
		logger.info("+ End " + className + ".noticemgrlist");

		return "all/noticeMgr/noticelist";
	}
	
	/**
	 * 공지사항 목록 화면  (Vue)
	 */
	@RequestMapping("vuenoticemgrlist.do")
	@ResponseBody
	public Map<String, Object> vuenoticemgrlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticemgrlist");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginID", session.getAttribute("loginId"));
	
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		int pagenum = Integer.parseInt( String.valueOf( paramMap.get("pagenum") ) );
		int pageSize = Integer.parseInt( String.valueOf( paramMap.get("pageSize") ) );
		int startnum = (pagenum - 1) * pageSize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<NoticeMgrModel> noticemgrlist = noticeMgrService.noticemgrlist(paramMap);
		int totalcnt = noticeMgrService.noticmgrcnt(paramMap);
		returnmap.put("noticemgrlist",noticemgrlist);
		returnmap.put("totalcnt",totalcnt);
		returnmap.put("loginID", session.getAttribute("loginId"));  //session lohinId 넘기기위해 추가함 (해당 userId와 작성자 userID가 같을 때 수정 & 삭제 버튼이 보이게끔 하기위해)
		returnmap.put("userType", session.getAttribute("userType"));
		
		logger.info("+ End " + className + ".noticemgrlist");

		return returnmap;
	}
	
	
	/**
	 * 공지사항 하단 상세 목록
	 */
	@RequestMapping("noticecontent.do")
	@ResponseBody
	public Map<String, Object> noticecontent(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticecontent");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnlist = new HashMap<String, Object>();
		
		NoticeMgrModel noticeinfo = noticeMgrService.noticecontent(paramMap);
		
		int count = noticeMgrService.noticount(paramMap);
		
		returnlist.put("noticeinfo", noticeinfo);
		
		logger.info("+ End " + className + ".noticecontent");
		
		return returnlist;
	}
	
	/**
	 * 공지사항 저장
	 */
	@RequestMapping("noticesave.do")
	@ResponseBody
	public Map<String, Object> noticesave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".noticesave");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnlist = new HashMap<String, Object>();
		String action = String.valueOf(paramMap.get("action"));
		
			if("I".equals(action)){
				noticeMgrService.noticeinsert(paramMap);
			} else if("U".equals(action)) {
				noticeMgrService.noticeupdate(paramMap);
			}else if("D".equals(action)) {
				noticeMgrService.noticedelete(paramMap);
			}
			
		logger.info("+ End " + className + ".noticesave");
		
		return returnlist;
	}
	
	
}
