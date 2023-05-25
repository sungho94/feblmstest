package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.SubjectFailDao;
import kr.happyjob.study.adm.model.SubjectFailModel;

@Service
public class SubjectFailServiceImpl implements SubjectFailService {
	@Autowired
	SubjectFailDao sfd;
	
	@Override
	public List<SubjectFailModel> getSubjectFailList(Map<String, Object> paramMap) throws Exception {
		return sfd.getSubjectFailList(paramMap);
	}
	
	@Override
	public int getSubjectFailTotal(Map<String, Object> paramMap) throws Exception {
		return sfd.getSubjectFailTotal(paramMap);
	}
	
	@Override
	public SubjectFailModel getSubjectFailRatio(Map<String, Object> paramMap) throws Exception {
		return sfd.getSubjectFailRatio(paramMap);
	}
}
