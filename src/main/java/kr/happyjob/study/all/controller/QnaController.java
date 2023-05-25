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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.all.model.NoticeMgrModel;
import kr.happyjob.study.all.model.QnaModel;
import kr.happyjob.study.all.model.QnaReplyModel;
import kr.happyjob.study.all.service.QnaReplyService;
import kr.happyjob.study.all.service.QnaService;


@Controller
@RequestMapping("/all/")
public class QnaController {
	
	@Autowired
	QnaService qnaService;
	
	@Autowired
	QnaReplyService replyService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 초기화면
	 */
	@RequestMapping("qna.do")
	public String qna(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qna");
		logger.info("   - paramMap : " + paramMap);
		
		// 사용자 로그인값 넘기기
		request.setAttribute("loginID", session.getAttribute("loginID"));
		request.setAttribute("userType", session.getAttribute("userType"));
		
		logger.info("+ End " + className + ".qna");

		return "all/qna/qna";
	}
	
	/**
	 * 초기화면
	 */
	@RequestMapping("qnaVue.do")
	public String qnaVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnaVue");
		logger.info("   - paramMap : " + paramMap);
		
		// 사용자 로그인값 넘기기
		request.setAttribute("loginID", session.getAttribute("loginID"));
		request.setAttribute("userType", session.getAttribute("userType"));
		
		logger.info("+ End " + className + ".qnaVue");

		return "all/qna/qnaVue";
	}
	
	// 로그인 사용자 정보 가져오기
	@RequestMapping("userinfo.do")
	@ResponseBody
	public Map<String, Object> userinfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".userinfo");
		logger.info("   - paramMap : " + paramMap);
		
		// 사용자 로그인 값 가져오기
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		QnaModel userinfo = qnaService.userinfo(paramMap);
		
		returnMap.put("userinfo", userinfo);
		
		logger.info("+ End " + className + ".userinfo");
		
		return returnMap;
	}
	
	/**
	 * QnA 목록 화면 
	 */
	@RequestMapping("qnalist.do")
	public String qnalist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnalist");
		logger.info("   - paramMap : " + paramMap);
		
		int pagenum = Integer.parseInt( String.valueOf( paramMap.get("pagenum") ) );
		int pageSize = Integer.parseInt( String.valueOf( paramMap.get("pageSize") ) );
		int startnum = (pagenum - 1) * pageSize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<QnaModel> qnalist = qnaService.qnalist(paramMap);
		int totalcnt = qnaService.qnacnt(paramMap);
		model.addAttribute("qnalist",qnalist);
		model.addAttribute("totalcnt",totalcnt);
		
		logger.info("+ End " + className + ".qnalist");

		return "all/qna/qnalist";
	}
	
	/**
	 * QnA 목록 화면 
	 */
	@RequestMapping("qnalistVue.do")
	@ResponseBody
	public Map<String, Object> qnalistVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnalist");
		logger.info("   - paramMap : " + paramMap);
		
		int pagenum = Integer.parseInt( String.valueOf( paramMap.get("pagenum") ) );
		int pageSize = Integer.parseInt( String.valueOf( paramMap.get("pageSize") ) );
		int startnum = (pagenum - 1) * pageSize;
		
		Map <String, Object> returnData = new HashMap<String, Object>(); 
		
		paramMap.put("startnum", startnum);
		paramMap.put("pageSize", pageSize);
		
		List<QnaModel> qnalist = qnaService.qnalist(paramMap);
		int totalcnt = qnaService.qnacnt(paramMap);
		returnData.put("qnalist",qnalist);
		returnData.put("totalcnt",totalcnt);
		
		logger.info("+ End " + className + ".qnalist");

		return returnData;
	}
	
	/**
	 * QnA 하단 상세 목록 qnacontent
	 */
	@RequestMapping("qnacontent.do")
	@ResponseBody
	public Map<String, Object> qnacontent(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnacontent");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnlist = new HashMap<String, Object>();
		
		QnaModel qnainfo = qnaService.qnacontent(paramMap);
		
		int count = qnaService.viewcount(paramMap);
		
		returnlist.put("qnainfo", qnainfo);
		
		logger.info("+ End " + className + ".qnacontent");
		
		return returnlist;
	}
	
	/**
	 * QnA 저장 qnasave
	 */
	@RequestMapping("qnasave.do")
	@ResponseBody
	public Map<String, Object> qnasave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticesave");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnlist = new HashMap<String, Object>();
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)){
			qnaService.qnainsert(paramMap);
		} else if("U".equals(action)) {
			//update 했을 때
			qnaService.qnaupdate(paramMap);
		}else if("D".equals(action)) {
			// delete 했을 때
			qnaService.qnadelete(paramMap);
		}
		
		logger.info("+ End " + className + ".noticesave");
		
		return returnlist;
	}
	
	/**
	 * reply 상세목록  replylist
	 */
	@RequestMapping("replylist.do")
	public String replylist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".replylist");
		logger.info("   - paramMap : " + paramMap);
		
		List<QnaReplyModel> replylist = replyService.replylist(paramMap);
		int totalcnt = replyService.replycnt(paramMap);
		model.addAttribute("replylist", replylist);
		model.addAttribute("totalcnt",totalcnt);
		
		logger.info("+ End " + className + ".replylist");

		return "all/qna/replylist";
	}
	
	/**
	 * reply 상세목록  replylist
	 */
	@RequestMapping("replylistVue.do")
	@ResponseBody
	public Map<String,Object> replylistVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".replylist");
		logger.info("   - paramMap : " + paramMap);
		
		Map <String, Object> returnData = new HashMap <String, Object>();
		
		List<QnaReplyModel> replylist = replyService.replylist(paramMap);
		int totalcnt = replyService.replycnt(paramMap);
		returnData.put("replylist", replylist);
		returnData.put("totalcnt",totalcnt);
		
		logger.info("+ End " + className + ".replylist");

		return returnData;
	}
	
	/**
	 * reply 저장 replysave
	 */
	@RequestMapping("replysave.do")
	@ResponseBody
	public Map<String, Object> replysave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".replysave");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnlist = new HashMap<String, Object>();
		String baction = String.valueOf(paramMap.get("action"));
		
		if("I".equals(baction)){
			replyService.replyinsert(paramMap);
		} else if("D".equals(baction)) {
			replyService.replydelete(paramMap);
		}
		
		logger.info("+ End " + className + ".replysave");
		
		return returnlist;
	}
}
