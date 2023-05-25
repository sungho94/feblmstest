package kr.happyjob.study.adm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.StudentModel;

public interface StudentDao {

	// 학생관리 강의 목록 조회
	public List<StudentModel> lectureList(Map<String, Object> paramMap) throws Exception;

	// 학생관리 강의 목록 조회수
	public int lectureListCnt(Map<String, Object> paramMap) throws Exception;

	// 학생관리 학생 목록 조회
	public List<StudentModel> studentList(Map<String, Object> paramMap) throws Exception;

	// 학생관리 학생 목록 조회수
	public int studentListCnt(Map<String, Object> paramMap) throws Exception;

	// 학생 상세조회
	public StudentModel studentSelect(Map<String, Object> paramMap) throws Exception;

	// 학생 수강 취소
	public int studentCancel(Map<String, Object> paramMap) throws Exception;

}
