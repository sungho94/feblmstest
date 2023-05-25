package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.system.dao.ComnComboDao;
import kr.happyjob.study.system.model.comcombo;

@Service
public class ComnComboServiceImpl implements ComnComboService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ComnComboDao comnComboDao;	
	

	
	/** 시험 목록 조회 */
	public List<comcombo> selecttestlist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> list = comnComboDao.selecttestlist(paramMap);
		
		return list;
	}	

  /** 사용자  목록 조회 */
  public List<comcombo> selectuserlist(Map<String, Object> paramMap) throws Exception {
    
    List<comcombo> list = comnComboDao.selectuserlist(paramMap);
    
    return list;
  } 
  

  /** 로그인 사용자 강의목록 조회 */
  public List<comcombo> selectlecbyuserlist(Map<String, Object> paramMap) throws Exception {
	  
	  List<comcombo> list = comnComboDao.selectlecbyuserlist(paramMap);
	    
	  return list;
  }
  
  /** 로그인 사용자 강의실 목록 조회  lecture_seq */
  public List<comcombo> selectlecseqbyuserlist(Map<String, Object> paramMap) throws Exception {
	  
	  List<comcombo> list = comnComboDao.selectlecseqbyuserlist(paramMap);
	    
	  return list;
  }  
  
  
  /** 로그인 사용자 강의실 목록 조회 */
  public List<comcombo> selectroomlist(Map<String, Object> paramMap) throws Exception {
	  
	  List<comcombo> list = comnComboDao.selectroomlist(paramMap);
	    
	  return list;
  }
  
  
  /** 강의 수강 사용자  목록 조회 */
  public List<comcombo> selectuserbyleclist(Map<String, Object> paramMap) throws Exception {
    
    List<comcombo> list = comnComboDao.selectuserbyleclist(paramMap);
    
    return list;
  }
  
  /** 강의 목록(시퀀스) 조회 */
  public List<comcombo> selectlecseqUserlist(Map<String, Object> paramMap) throws Exception {
    
    List<comcombo> list = comnComboDao.selectlecseqUserlist(paramMap);
    
    return list;
  }
  
  
  
}
