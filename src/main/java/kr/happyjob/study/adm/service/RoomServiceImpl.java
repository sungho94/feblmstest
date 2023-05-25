package kr.happyjob.study.adm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.RoomDao;
import kr.happyjob.study.adm.model.ItemModel;
import kr.happyjob.study.adm.model.RoomModel;
import kr.happyjob.study.system.dao.ComnCodDao;


@Service
public class RoomServiceImpl implements RoomService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	RoomDao roomDao;
	
	@Autowired
	ComnCodDao comnCodDao;

	@Override
	public List<RoomModel> roomList(Map<String, Object> paramMap) throws Exception {
		List<RoomModel> roomList = roomDao.roomList(paramMap);
		return roomList;
	}

	@Override
	public int roomListCnt(Map<String, Object> paramMap) throws Exception {
		return roomDao.roomListCnt(paramMap);
	}

	@Override
	public RoomModel roomDetail(Map<String, Object> paramMap) throws Exception {
		return roomDao.roomDetail(paramMap);
	}

	@Override
	public int roomInsert(Map<String, Object> paramMap, HttpSession session) throws Exception {
		
		
		// 공통코드  insert
		Map<String,Object> comcodemap = new HashMap<String,Object>();
		
		comcodemap.put("dtl_grp_cod","room_no");
		comcodemap.put("dtl_cod",paramMap.get("room_no"));
		comcodemap.put("dtl_cod_nm",paramMap.get("room_name"));
		comcodemap.put("dtl_cod_eplti","");
		comcodemap.put("dtl_use_poa","Y");
		comcodemap.put("fst_rgst_sst_id",session.getAttribute("loginId"));
		comcodemap.put("fnl_mdfr_sst_id",session.getAttribute("loginId"));
		
		comnCodDao.insertComnDtlCod(comcodemap);
		
		// tb_rm insert
		roomDao.roomInsert(paramMap);
		
		
		return 1;
	}

	@Override
	public int roomUpdate(Map<String, Object> paramMap) throws Exception {
		roomDao.roomUpdate(paramMap);
		return 1;
	}
	@Override
	public int roomDelete(Map<String, Object> paramMap) throws Exception {
		roomDao.roomDelete(paramMap);
		
		Map<String,Object> comcodemap = new HashMap<String,Object>();
		comcodemap.put("dtl_grp_cod","room_no");
		comcodemap.put("dtl_cod",paramMap.get("room_no"));
		comnCodDao.deleteComnDtlCod(comcodemap);
		
		return 1;
	}

	@Override
	public List<ItemModel> itemList(Map<String, Object> paramMap) throws Exception {
		
		List<ItemModel> listItem = roomDao.itemList(paramMap);
		
		return listItem;
	}

	@Override
	public int itemListCnt(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = roomDao.itemListCnt(paramMap);
		
		return totalCount;
	}

	@Override
	public ItemModel itemDetail(Map<String, Object> paramMap) throws Exception {
		return roomDao.itemDetail(paramMap);
	}

	@Override
	public int itemInsert(Map<String, Object> paramMap) throws Exception {
		return roomDao.itemInsert(paramMap);
	}

	@Override
	public int itemUpdate(Map<String, Object> paramMap) throws Exception {
		return roomDao.itemUpdate(paramMap);
	}

	@Override
	public int itemDelete(Map<String, Object> paramMap) throws Exception {
		return roomDao.itemDelete(paramMap);
	}
	
	
}
