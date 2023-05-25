package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.SubjectFailModel;

public interface SubjectFailService {
	public List<SubjectFailModel> getSubjectFailList(Map<String, Object> paramMap) throws Exception;
	public int getSubjectFailTotal(Map<String, Object> paramMap) throws Exception;
	public SubjectFailModel getSubjectFailRatio(Map<String, Object> paramMap) throws Exception;
}
