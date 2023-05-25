package kr.happyjob.study.std.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.happyjob.study.adm.model.SurveyModel;
import kr.happyjob.study.std.model.UserUpdateModel;

public interface UserUpdateService {
	
	// 학생정보 단건 조회
	public UserUpdateModel userUpdateList(Map<String, Object> paramMap) throws Exception;
	
	// 개인정보 수정
	public int studentUpdate(Map<String, Object> paramMap, HttpServletRequest request, HttpSession session) throws	Exception;

}
