package kr.happyjob.study.std.dao;

import java.util.Map;

import kr.happyjob.study.std.model.UserUpdateModel;

public interface UserUpdateDao {

	// 학생정보 단건 조회
	public UserUpdateModel userUpdateList(Map<String, Object> paramMap) throws Exception;

	// 개인정보 수정
	public int studentUpdate(Map<String, Object> paramMap) throws Exception;

}
