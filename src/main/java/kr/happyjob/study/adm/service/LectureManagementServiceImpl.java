package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.LectureManagementDao;
import kr.happyjob.study.adm.model.LectureManagementModel;
import kr.happyjob.study.adm.model.StudentModel;

@Service
public class LectureManagementServiceImpl implements LectureManagementService {
	
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());
   
   // Get class name for logger
   private final String className = this.getClass().toString();
   
   @Autowired
   LectureManagementDao lectureManagementDao;
	 
   //강의 목록 조회
   @Override
   public List<LectureManagementModel> lectureListSearch(Map<String, Object> paramMap) throws Exception {
   	List<LectureManagementModel> lectureListSearch = lectureManagementDao.lectureListSearch(paramMap);
   	return lectureListSearch;
   }

   //강의 목록 갯수
   @Override
   public int lectureListCnt(Map<String, Object> paramMap) throws Exception {
   	int totalCount = lectureManagementDao.lectureListCnt(paramMap);
   	return totalCount;
   }
   
   //강의 한건 조회
   @Override
	public LectureManagementModel lectureSelect(Map<String, Object> paramMap) throws Exception {
	   return lectureManagementDao.lectureSelect(paramMap);
	}
   
   //강의 insert
	@Override
	public int lectureInsert(Map<String, Object> paramMap) throws Exception {
		int lectureInsert = lectureManagementDao.lectureInsert(paramMap);
		return lectureInsert;
	}
	//강의 update
	@Override
	public int lectureUpdate(Map<String, Object> paramMap) throws Exception {
		int lectureUpdate = lectureManagementDao.lectureUpdate(paramMap);
		return lectureUpdate;
	}
	//강의 delete
/*	@Override
	public int lectureDelete(Map<String, Object> paramMap) throws Exception {
		int lectureDelete = lectureManagementDao.lectureDelete(paramMap);
		return lectureDelete;
	}*/
	//학생 목록 조회
	@Override
	public List<StudentModel> studentList(Map<String, Object> paramMap) throws Exception {
		List<StudentModel> studentList = lectureManagementDao.studentList(paramMap);
		return studentList;
	}
	//학생 목록 총 갯수
	@Override
	public int studentListCnt(Map<String, Object> paramMap) throws Exception {
		int totalCount = lectureManagementDao.studentListCnt(paramMap);
	   	return totalCount;
	}
	//강의실 사용유무 update
	@Override
	public int roomStatusUpdate(Map<String, Object> paramMap) throws Exception {
		int roomStatusUpdate = lectureManagementDao.roomStatusUpdate(paramMap);
		return roomStatusUpdate;
	}

	

	//강의 tb_detail_code insert
/*	@Override
	public int lectureInsertComnDtlCod(Map<String, Object> paramMap) throws Exception {
		int lectureInsertComnDtlCod = lectureManagementDao.lectureInsertComnDtlCod(paramMap);
		return lectureInsertComnDtlCod;
	}*/
}
