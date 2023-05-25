package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.std.dao.LectureListDAO;
import kr.happyjob.study.std.model.LectureListModel;

@Service
public class LectureListServiceImpl implements LectureListService {
	
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());
   
   // Get class name for logger
   private final String className = this.getClass().toString();
   
   @Autowired
   LectureListDAO lectureListDao;

    //강의 목록 조회
	@Override
	public List<LectureListModel> lectureListSearch(Map<String, Object> paramMap) throws Exception {
		List<LectureListModel> lectureListSearch = lectureListDao.lectureListSearch(paramMap);
		return lectureListSearch;
	}
	
	//강의 목록 갯수
	@Override
	public int lectureListCnt(Map<String, Object> paramMap) throws Exception {
		int totalCount = lectureListDao.lectureListCnt(paramMap);
		return totalCount;
	}
	
	//list 한건 조회
	@Override
	public LectureListModel lectureSelect(Map<String, Object> paramMap) throws Exception {
		LectureListModel lectureSelect = lectureListDao.lectureSelect(paramMap);
		return lectureSelect;
	}
	//강의 신청
	@Override
	public int studentInsert(Map<String, Object> paramMap) throws Exception {
		int studentInsert = lectureListDao.studentInsert(paramMap);
		return studentInsert;
	}
	// 강의 계획 리스트
	@Override
	public List<LectureListModel> lecturePlanSelect(Map<String, Object> paramMap) throws Exception {
		List<LectureListModel> lecturePlanSelect = lectureListDao.lecturePlanSelect(paramMap);
		return lecturePlanSelect;
	}
	   
	//강의 목록 갯수
		@Override
		public int lecturePlanCnt(Map<String, Object> paramMap) throws Exception {
			int totalCount = lectureListDao.lecturePlanCnt(paramMap);
			return totalCount;
		}
   


}
