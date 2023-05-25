package kr.happyjob.study.all.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.all.dao.NoticeMgrDao;
import kr.happyjob.study.all.model.NoticeMgrModel;




@Service
public class NoticeMgrServiceImpl implements NoticeMgrService {

   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());
   
   // Get class name for logger
   private final String className = this.getClass().toString();
   	
   	@Autowired
   	NoticeMgrDao noticemgrDao;
   	
   	/** 로그인 사용자 불러오기 */
   	public NoticeMgrModel userinfo(Map<String, Object> paramMap) {
   		return noticemgrDao.userinfo(paramMap);
   	}
   	
   	/** 공지사항 목록조회 */
	@Override
	public List<NoticeMgrModel> noticemgrlist(Map<String, Object> paramMap) {
		
		List<NoticeMgrModel> noticelist = noticemgrDao.noticemgrlist(paramMap);
		
		return noticelist;
	}
	
	/** 공지사항 검색 목록 sesarachlist"*/
	public List<NoticeMgrModel> sesarachlist(Map<String, Object> paramMap) {
		
		List<NoticeMgrModel> sesarachlist = noticemgrDao.sesarachlist(paramMap);
		
		return sesarachlist;
	}
	
	/**공지사항 하단 목록 noticecontent*/
	public NoticeMgrModel noticecontent(Map<String, Object> paramMap) {
	
		NoticeMgrModel noticecontent = noticemgrDao.noticecontent(paramMap);
	
		return noticecontent;
	}
	
	/**공지사항 조회수*/
	public int noticount(Map<String, Object> paramMap) throws Exception{
		
		return noticemgrDao.noticount(paramMap);
	}
   
	/** 공지사항 목록 카운트 */
	@Override
	public int noticmgrcnt(Map<String, Object> paramMap) {
		
		int noticmgrcnt = noticemgrDao.noticmgrcnt(paramMap);
		
		return noticmgrcnt;
	}
	
	/** 공지사항  등록 */
	public int noticeinsert(Map<String, Object> paramMap) throws Exception {
		
		return noticemgrDao.noticeinsert(paramMap);
	}
	
	/**공지사항 수정 noticeupdate*/
	public int noticeupdate(Map<String, Object> paramMap) throws Exception{
		
		return noticemgrDao.noticeupdate(paramMap);
	}
	
	/**공지사항 삭제 noticedelete*/
	public int noticedelete(Map<String, Object> paramMap) throws Exception{
		
		return noticemgrDao.noticedelete(paramMap);
	}
	
}