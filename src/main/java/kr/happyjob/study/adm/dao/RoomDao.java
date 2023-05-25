package kr.happyjob.study.adm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.ItemModel;
import kr.happyjob.study.adm.model.RoomModel;

public interface RoomDao {
	 
	//강의실 리스트
	public List<RoomModel> roomList (Map<String,Object>pramMap ) throws Exception;
	//강의실수 카운트
	public int roomListCnt (Map<String, Object> paramMap) throws Exception;
	//강의실 상세조회
	public RoomModel roomDetail (Map<String, Object> paramMap) throws Exception;
	//강의실 신규등록
	public int roomInsert(Map <String, Object> paramMap ) throws Exception;
	//강의실 업데이트
	public int roomUpdate(Map<String, Object> paramMap) throws Exception;
	//강의실 삭제
	public int roomDelete(Map<String, Object> paramMap) throws Exception;
	
	
	//장비 리스트
	public List<ItemModel>itemList (Map<String,Object>pramMap ) throws Exception;
	//장비 카운트
	public int itemListCnt (Map<String, Object> paramMap) throws Exception;
	//장비 상세조회
	public ItemModel itemDetail (Map<String, Object> paramMap) throws Exception;
	//장비 신규등록
	public int itemInsert(Map <String, Object> paramMap ) throws Exception;
	//장비 업데이트
	public int itemUpdate(Map<String, Object> paramMap) throws Exception;
	//장비 삭제
	public int itemDelete(Map<String, Object> paramMap) throws Exception;
	
}
