package kr.happyjob.study.all.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.all.model.NoticeMgrModel;


public interface NoticeMgrDao {

	/** 공지사항 userinfo 불러오기 */
	public NoticeMgrModel userinfo(Map<String, Object> paramMap);
	
	/** 공지사항 목록 조회 */
	public List<NoticeMgrModel> noticemgrlist(Map<String, Object> paramMap);
	
	/** 공지사항 검색 목록 sesarachlist*/
	public List<NoticeMgrModel> sesarachlist(Map<String, Object> paramMap);
   
	/** 공지사항 목록 count */
	public int noticmgrcnt(Map<String, Object> paramMap);
	
	/** 공지사항 상세 목록 */
	public NoticeMgrModel noticmgrcontent(Map<String, Object> paramMap);

	/**공지사항 하단 목록*/
	public NoticeMgrModel noticecontent(Map<String, Object> paramMap);
	
	/**공지사항 조회수*/
	public int noticount(Map<String, Object> paramMap) throws Exception;
	
	/**공지사항 등록 noticeinsert*/
	public int noticeinsert(Map<String, Object> paramMap) throws Exception;
	
	/**공지사항 수정 noticeupdate*/
	public int noticeupdate(Map<String, Object> paramMap) throws Exception;
	
	/**공지사항 삭제 noticedelete*/
	public int noticedelete(Map<String, Object> paramMap) throws Exception;
	
}