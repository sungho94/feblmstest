package kr.happyjob.study.system.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
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

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.system.model.comcombo;
import kr.happyjob.study.system.service.ComnComboService;

@Controller
@RequestMapping("/system/")
public class ComnComboController {
	
	@Autowired
	ComnComboService comnComboService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 *  공통 콤보 
	 */
	@RequestMapping("selectComCombo.do")
	@ResponseBody
	public Map<String, Object> selectComCombo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectComCombo");
		logger.info("   - paramMap : " + paramMap);

		String ComType = (String) paramMap.get("comtype");
		String roomtype = ComType.substring(0, 3);
		
		List<comcombo> comComboModel = new ArrayList<>();
		
		logger.info("   - ComType : " + ComType);
		
		if("test".equals(ComType)) {
			// 공통 콤보 조회 제품 
			comComboModel = comnComboService.selecttestlist(paramMap);
		} else if("userbylec".equals(ComType)) {
			comComboModel = comnComboService.selectuserbyleclist(paramMap);
		} else if("usr".equals(ComType)) {
			// 공통 콤보 조회 창고 담당자 이름, LoginID
			comComboModel = comnComboService.selectuserlist(paramMap);
		} else if("roo".equals(roomtype)) {
			// 공통 콤보 조회 창고 담당자 이름, LoginID
			String[] tcomtype = ComType.split(":");
			paramMap.put("roomid", tcomtype[0]);
			
			if(tcomtype.length > 1) {
				paramMap.put("roomtype", tcomtype[1]);
			} else {
				paramMap.put("roomtype", "");
			}
			
			
			comComboModel = comnComboService.selectroomlist(paramMap);
		} else if("lecbyuser".equals(ComType)) {
			// 공통 콤보 조회 제품 
			paramMap.put("loginId", session.getAttribute("loginId"));
			comComboModel = comnComboService.selectlecbyuserlist(paramMap);
		} else if("lecseqbyuser".equals(ComType)) {
			// 공통 콤보 조회 제품 
			paramMap.put("loginId", session.getAttribute("loginId"));
			paramMap.put("test_no", session.getAttribute("test_no"));
			comComboModel = comnComboService.selectlecseqbyuserlist(paramMap);
		} else if("lecseqUser".equals(ComType)) {
			// 공통 콤보 조회 제품 
			paramMap.put("loginId", session.getAttribute("loginId"));
			comComboModel = comnComboService.selectlecseqUserlist(paramMap);
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("list", comComboModel);
		/*System.out.println("렉쳐시퀀스로 보내려는거 : "+resultMap.get("list").toString());
		//session.setAttribute("lecture_seq", resultMap.get("list"));
*/		
		logger.info("+ End " + className + ".selectComCombo");
		
		return resultMap;
	}
	
	

}
