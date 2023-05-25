package kr.happyjob.study.adm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.adm.model.SubjectFailModel;

public interface SubjectFailDao {
	public List<SubjectFailModel> getSubjectFailList(Map<String, Object> paramMap) throws Exception;
	public int getSubjectFailTotal(Map<String, Object> paramMap) throws Exception;
	public SubjectFailModel getSubjectFailRatio(Map<String, Object> paramMap) throws Exception;
}
