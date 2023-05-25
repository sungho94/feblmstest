package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.system.model.comcombo;

public interface ComnComboService {

	/** 시험 조회 */
	public List<comcombo> selecttestlist(Map<String, Object> paramMap) throws Exception;
	
    /** 사용자  목록 조회 */
    public List<comcombo> selectuserlist(Map<String, Object> paramMap) throws Exception;
  
    /** 로그인 사용자 강의목록 조회 */
	public List<comcombo> selectlecbyuserlist(Map<String, Object> paramMap) throws Exception;
    
	/** 로그인 사용자 강의실 목록 조회  lecture_seq */
	public List<comcombo> selectlecseqbyuserlist(Map<String, Object> paramMap) throws Exception;
	
	
	/** 강의실 조회 */
	public List<comcombo> selectroomlist(Map<String, Object> paramMap) throws Exception;
	
	/** 수강 사용자  목록 조회 */
    public List<comcombo> selectuserbyleclist(Map<String, Object> paramMap) throws Exception;
    
    /** 강의 목록(시퀀스) 조회 */
    public List<comcombo> selectlecseqUserlist(Map<String, Object> paramMap) throws Exception;
  
	
	
}
