package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.ResumeDao;
import kr.happyjob.study.adm.model.ResumeModel;


@Service
public class ResumeServiceImpl implements ResumeService{

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ResumeDao resumeDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.roomimage}")
	private String roomimage;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	//개설 강의 목록 조회
	public List<ResumeModel> resumeLectureListSearch(Map<String, Object> paramMap) throws Exception{
		
		List<ResumeModel> resumeLectureListSearch = resumeDao.resumeLectureListSearch(paramMap);
		
		return resumeLectureListSearch;
		
	}
	
	//강의 목록 갯수
	public int resumeLectureListCnt(Map<String, Object> paramMap)throws Exception{
		
		int totalCount = resumeDao.resumeLectureListCnt(paramMap);
		
		return totalCount;
		
	}
	
	//학생 목록 조회
	public List<ResumeModel> resumeLectureSelect(Map<String, Object> paramMap) throws Exception{
		
		List<ResumeModel> resumeLectureSelect = resumeDao.resumeLectureSelect(paramMap);
		
		return resumeLectureSelect;
		
	}
	
	//학생 목록 갯수
	public int resumeLectureSelectCnt(Map<String, Object> paramMap)throws Exception{
		
		int totalCount = resumeDao.resumeLectureSelectCnt(paramMap);
		
		return totalCount;
		
	}
	
	/** 이력서 다운로드 */
	public ResumeModel userinfo(Map<String, Object> paramMap) throws Exception{
		
		return resumeDao.userinfo(paramMap);
		
	}
	
}
