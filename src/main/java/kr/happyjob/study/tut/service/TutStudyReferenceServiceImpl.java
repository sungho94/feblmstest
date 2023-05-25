package kr.happyjob.study.tut.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.tut.dao.TutStudyReferenceDAO;
import kr.happyjob.study.tut.model.TutStudyReferenceModel;

@Service
public class TutStudyReferenceServiceImpl implements TutStudyReferenceService {
	
	@Autowired
	TutStudyReferenceDAO tutStudyReferenceDAO;
	
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
	public List<TutStudyReferenceModel> LectureList(Map<String, Object> paramMap) throws Exception{
		
		List<TutStudyReferenceModel> LectureList = tutStudyReferenceDAO.LectureList(paramMap);
		
		return LectureList;
		
	}
	
	//강의 목록 갯수
	public int LectureListCnt(Map<String, Object> paramMap)throws Exception{
		
		int totalCount = tutStudyReferenceDAO.LectureListCnt(paramMap);
		
		return totalCount;
		
	}
	
	//학습자료 목록 조회
	public List<TutStudyReferenceModel> referenceselectlist(Map<String, Object> paramMap) throws Exception{
		
		List<TutStudyReferenceModel> referenceselectlist = tutStudyReferenceDAO.referenceselectlist(paramMap);
		
		return referenceselectlist;
		
	}
	
	//학습자료 목록 갯수
	public int referenceselectlistCnt(Map<String, Object> paramMap)throws Exception{
		
		int totalCount = tutStudyReferenceDAO.referenceselectlistCnt(paramMap);
		
		return totalCount;
		
	}
	
	/** 학습자료 조회 */
	public TutStudyReferenceModel referenceselect(Map<String, Object> paramMap) throws Exception{
		
		return tutStudyReferenceDAO.referenceselect(paramMap);
		
	}
	
	/** 학습자료 등록 */
	public int referenceinsert(Map<String, Object> paramMap, HttpServletRequest request, HttpSession session) throws Exception{
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		//파일저장
		String itemFilePath = roomimage + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		fileInfo.put("file_non", virtualRootPath + File.separator + itemFilePath + fileInfo.get("reference_file"));
		
		paramMap.put("fileInfo", fileInfo);
		
		// tb_rm insert
		tutStudyReferenceDAO.referenceinsert(paramMap);
		
		return 1;
		
	}
	
	/** 학습자료 수정 */
	public int referenceupdate(Map<String, Object> paramMap, HttpServletRequest request, HttpSession session) throws Exception{
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		//파일저장
		String itemFilePath = roomimage + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		paramMap.put("referenceno", paramMap.get("reference_no"));
		
		TutStudyReferenceModel referenceinfo = tutStudyReferenceDAO.referenceselect(paramMap);
		
		//파일삭제
		if(!"".equals(referenceinfo.getReference_file()) || referenceinfo.getReference_file() != null){
			
			String ppath = referenceinfo.getReference_mul();
			if(ppath != null){
			File currentfile = new File(ppath);
			currentfile.delete();
			}
			
		}
		
		if(!"".equals(fileInfo.get("file_nm")) || fileInfo.get("file_nm") == null) {
			
			fileInfo.put("file_non", "");
			
		} else {
			
			fileInfo.put("file_non", virtualRootPath + File.separator + itemFilePath + fileInfo.get("file_nm"));
			
		}
		
		
		paramMap.put("fileInfo", fileInfo);
		
		// tb_rm insert
		
		return tutStudyReferenceDAO.referenceupdate(paramMap);
		
	}
	
	/** 학습자료 삭제 */
	public int referencedelete(Map<String, Object> paramMap, HttpServletRequest request) throws Exception{
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		//파일저장
		String itemFilePath = roomimage + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		paramMap.put("referenceno", paramMap.get("reference_no"));
		
		TutStudyReferenceModel referenceinfo = tutStudyReferenceDAO.referenceselect(paramMap);
		
		//파일삭제
		if(!"".equals(referenceinfo.getReference_file())){
			
			String ppath = referenceinfo.getReference_mul();
			
			File currentfile = new File(ppath);
			currentfile.delete();
			
		}
		
		tutStudyReferenceDAO.referencedelete(paramMap);
		
		return 1;
		
	}
}
