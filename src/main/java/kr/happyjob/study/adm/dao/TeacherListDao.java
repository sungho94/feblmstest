package kr.happyjob.study.adm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.TeacherListModel;

public interface TeacherListDao {
	
	/** 강사 목록 */
	public List<TeacherListModel> teacherList(Map<String, Object> paramMap) throws Exception;
	
	/** 강사 목록 수*/
	public int listCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 강사 유저타입 업데이트*/
	public int tutupdate(Map<String, Object> paramMap) throws Exception;
	
	/** 강사 정보 상세보기*/
	public TeacherListModel tutInfoDetail(Map<String, Object> paramMap) throws Exception;
}
