package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.std.dao.StdStudyReferenceDAO;
import kr.happyjob.study.std.model.StdStudyReferenceModel;

@Service
public class StdStudyReferenceServiceImpl implements StdStudyReferenceService {
	
	@Autowired
	StdStudyReferenceDAO stdStudyReferenceDAO;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.roomimage}")
	private String roomimage;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
   
	// Get class name for logger
  	private final String className = this.getClass().toString();
	
	//강의 목록 조회
	public List<StdStudyReferenceModel> LectureList(Map<String, Object> paramMap) throws Exception{
		
		List<StdStudyReferenceModel> LectureList = stdStudyReferenceDAO.LectureList(paramMap);
		
		return LectureList;
		
	}
	
	//강의 목록 갯수
	public int LectureListCnt(Map<String, Object> paramMap)throws Exception{
		
		int totalCount = stdStudyReferenceDAO.LectureListCnt(paramMap);
		
		return totalCount;
		
	}
	
	//학습자료 목록 조회
	public List<StdStudyReferenceModel> referenceselectlist(Map<String, Object> paramMap) throws Exception{
		
		List<StdStudyReferenceModel> referenceselectlist = stdStudyReferenceDAO.referenceselectlist(paramMap);
		
		return referenceselectlist;
		
	}
	
	//학습자료 목록 갯수
	public int referenceselectlistCnt(Map<String, Object> paramMap)throws Exception{
		
		int totalCount = stdStudyReferenceDAO.referenceselectlistCnt(paramMap);
		
		return totalCount;
		
	}
	
	/** 학습자료 조회 */
	public StdStudyReferenceModel referenceselect(Map<String, Object> paramMap) throws Exception{
		
		return stdStudyReferenceDAO.referenceselect(paramMap);
		
	}

	
}
