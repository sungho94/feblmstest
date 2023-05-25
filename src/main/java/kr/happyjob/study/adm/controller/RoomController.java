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

import kr.happyjob.study.adm.model.ItemModel;
import kr.happyjob.study.adm.model.RoomModel;
import kr.happyjob.study.adm.service.RoomService;

@Controller
@RequestMapping("/adm/")
public class RoomController {
	
	@Autowired
	RoomService roomService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/*
	 * 공통코드 관리 초기화면
	 */
	@RequestMapping("Room.do")
	public String roomMng (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".roomMng");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".roomMng");

		return "adm/room/room";
	}
	/*
	 * 공통코드 관리 초기화면
	 */
	@RequestMapping("RoomVue.do")
	public String roomMngVue (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".roomMngVue");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".roomMngVue");

		return "adm/room/roomVue";
	}
	
	//강의실 리스트 조회
	@RequestMapping("roomList.do")
	public String roomList (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".roomList");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".roomList");
	
		int pagenum = Integer.parseInt( String.valueOf(paramMap.get("pagenum")));
		int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize")));
		int startnum = (pagenum - 1)*pageSize;
		
		paramMap.put("startnum", startnum);
		paramMap.put("pageSize",pageSize);
		
		List<RoomModel> roomList = roomService.roomList(paramMap);
		int totalcnt = roomService.roomListCnt(paramMap);
		
		model.addAttribute("roomList", roomList);
		model.addAttribute("totalcnt", totalcnt);

		logger.info("+ End " + className + ".roomList");
		
		return "adm/room/roomList";
	}
	
		//강의실 리스트 조회 vue
		@RequestMapping("vueroomList.do")
		@ResponseBody
		public Map<String, Object> vueroomList (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception{
			
			logger.info("+ Start " + className + ".vueroomList");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
		
			int pagenum = Integer.parseInt( String.valueOf(paramMap.get("pagenum")));
			int pageSize = Integer.parseInt( String.valueOf(paramMap.get("pageSize")));
			int startnum = (pagenum - 1)*pageSize;
			
			paramMap.put("startnum", startnum);
			paramMap.put("pageSize",pageSize);
			
			List<RoomModel> roomInfo = roomService.roomList(paramMap);
			int totalcnt = roomService.roomListCnt(paramMap);
			
			returnmap.put("roomInfo", roomInfo);
			returnmap.put("totalcnt", totalcnt);
			
			logger.info("+ End " + className + ".vueroomList");
			
			return returnmap;
		}
		
		/*
		 * 강의실 조회 vue
		 */
		@RequestMapping("vueroomDetail.do")
		@ResponseBody
		public Map<String, Object> vueroomDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".vueroomDetail");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			RoomModel roomInfo = roomService.roomDetail(paramMap);
			
			returnmap.put("roomInfo",roomInfo);
			
			logger.info("+ End " + className + ".vueroomDetail");

			return returnmap;
		}	
		
	/*
	 * 강의실 조회
	 */
	@RequestMapping("roomDetail.do")
	@ResponseBody
	public Map<String, Object> roomDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".roomDetail");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		RoomModel roomInfo = roomService.roomDetail(paramMap);
		
		
		returnmap.put("roomInfo",roomInfo);
		
		logger.info("+ End " + className + ".roomDetail");

		return returnmap;
	}	

	//vue 강의실 저장
	@RequestMapping("vueroomSave.do")
	@ResponseBody
	public Map<String, Object> vueroomSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueroomSave");
		logger.info("   - paramMap : " + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		String action = String.valueOf(paramMap.get("action"));
		
		if("I".equals(action)) {
			roomService.roomInsert(paramMap,session);
		}else if ("U".equals(action)) {
			roomService.roomUpdate(paramMap);
		}else if("D".equals(action)) {
			roomService.roomDelete(paramMap);
		}
		
		returnmap.put("result","SUCCESS");
		
		logger.info("+ End " + className + ".vueroomSave");

		return returnmap;
	}	

		//강의실 저장
		@RequestMapping("roomSave.do")
		@ResponseBody
		public Map<String, Object> roomsave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".roomSave");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			String action = String.valueOf(paramMap.get("action"));
			
			if("I".equals(action)) {
				roomService.roomInsert(paramMap,session);
			}else if ("U".equals(action)) {
				roomService.roomUpdate(paramMap);
			}else if("D".equals(action)) {
				roomService.roomDelete(paramMap);
			}
			
			returnmap.put("result","SUCCESS");
			
			logger.info("+ End " + className + ".roomSave");

			return returnmap;
		}	
		/*
		 * 장비 목록 화면
		 */
		@RequestMapping("itemList.do")
		public String itemList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".itemList");
			logger.info("   - paramMap : " + paramMap);
			
			int pagenum = Integer.parseInt( String.valueOf( paramMap.get("pagenum") ) );
			int pageSize = Integer.parseInt( String.valueOf( paramMap.get("pageSize") ) );
			int startnum = (pagenum - 1) * pageSize;
			
			
			paramMap.put("startnum", startnum);
			paramMap.put("pageSize", pageSize);
			
			List<ItemModel> itemList = roomService.itemList(paramMap);
			int itotalcnt = roomService.itemListCnt(paramMap);
			
			model.addAttribute("itemList",itemList);
			model.addAttribute("itotalcnt",itotalcnt);
			
			
			logger.info("+ End " + className + ".itemList");

			return "adm/room/itemList";
		}	
		
		/*
		 * vue 장비 목록 화면
		 */
		@RequestMapping("vueitemList.do")
		@ResponseBody
		public Map<String, Object> vueitemList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".vueitemList");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			int pagenum = Integer.parseInt( String.valueOf( paramMap.get("pagenum") ) );
			int pageSize = Integer.parseInt( String.valueOf( paramMap.get("pageSize") ) );
			int startnum = (pagenum - 1) * pageSize;
			
			
			paramMap.put("startnum", startnum);
			paramMap.put("pageSize", pageSize);
			
			List<ItemModel> itemList = roomService.itemList(paramMap);
			int totalcnt = roomService.itemListCnt(paramMap);
			
			returnmap.put("itemList",itemList);
			returnmap.put("totalcnt",totalcnt);
			
			logger.info("+ End " + className + ".vueitemList");

			return returnmap;
		}	
		/*
		 * vue 장비 조회
		 */
		@RequestMapping("vueitemDetail.do")
		@ResponseBody
		public Map<String, Object> vueitemDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".vueitemDetail");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			ItemModel itemInfo = roomService.itemDetail(paramMap);
			
			returnmap.put("itemInfo", itemInfo);
			
			logger.info("   - itemInfo : " + itemInfo);
			
			logger.info("+ End " + className + ".vueitemDetail");

			return returnmap;
		}	
		
		/*
		 * 장비 조회
		 */
		@RequestMapping("itemDetail.do")
		@ResponseBody
		public Map<String, Object> itemselect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".itemDetail");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			ItemModel itemInfo = roomService.itemDetail(paramMap);
			
			
			returnmap.put("itemInfo",itemInfo);
			
			
			logger.info("+ End " + className + ".itemDetail");

			return returnmap;
		}	
		/*
		 * 장비 저장
		 */
		@RequestMapping("vueitemSave.do")
		@ResponseBody
		public Map<String, Object> vueitemSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".vueitemSave");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			String iaction = String.valueOf(paramMap.get("iaction"));	
			
			if("I".equals(iaction)) {
				roomService.itemInsert(paramMap);
			} else if("U".equals(iaction)) {
				roomService.itemUpdate(paramMap);
			} else if("D".equals(iaction)) {
				roomService.itemDelete(paramMap);
			}
			returnmap.put("result","SUCESS");
			
			logger.info("+ End " + className + ".vueitemSave");

			return returnmap;
		}		
		
		/*
		 * 장비 저장
		 */
		@RequestMapping("itemSave.do")
		@ResponseBody
		public Map<String, Object> itemsave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".itemSave");
			logger.info("   - paramMap : " + paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			String iaction = String.valueOf(paramMap.get("iaction"));	
			
			if("I".equals(iaction)) {
				roomService.itemInsert(paramMap);
			} else if("U".equals(iaction)) {
				roomService.itemUpdate(paramMap);
			} else if("D".equals(iaction)) {
				roomService.itemDelete(paramMap);
			}
			
			returnmap.put("result","SUCESS");
			
			logger.info("+ End " + className + ".itemSave");

			return returnmap;
		}		
}
