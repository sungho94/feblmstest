package kr.happyjob.study.adm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.adm.dao.EmployDao;
import kr.happyjob.study.adm.model.EmployModel;

@Service
public class EmployServiceImpl implements EmployService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	EmployDao empDao;
	
	//취업을 위한 학생 리스트 가져오기. empclasslist
	public List<EmployModel> empclasslist(Map<String, Object> paramMap) {
		return empDao.empclasslist(paramMap);
	}
	
	//취업을 위한 학생 리스트 cnt studentclasscnt
	public int studentclasscnt(Map<String, Object> paramMap){
		return empDao.studentclasscnt(paramMap);
	}
	
	//학생 employee detail 내용 detailcontent
	public List<EmployModel> detailcontent(Map<String, Object> paramMap){
		return empDao.detailcontent(paramMap);
	}
	
	// 학생 employee detail 내용 상세보기
	public EmployModel sdetailcontent(Map<String, Object> paramMap){
		return empDao.sdetailcontent(paramMap);
	}
	
	//학생 employee detail 리스트 cnt detailcnt
	public int detailcnt(Map<String, Object> paramMap){
		return empDao.detailcnt(paramMap);
	}
	
	//상단에 취업 학생 list 추가하기.
	public int empinsert(Map<String, Object> paramMap){
		return empDao.empinsert(paramMap);
	}
	
	//하단에서 수정 하기.empupdate
	public int empupdate(Map<String, Object> paramMap){
		return empDao.empupdate(paramMap);
	}
	
	//하단에서 삭제 하기.empdelete
	public int empdelete(Map<String, Object> paramMap){
		return empDao.empdelete(paramMap);
	}
}