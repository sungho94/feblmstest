package kr.happyjob.study.login.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
/*import kr.happyjob.study.common.comnUtils.AESCryptoHelper;
import kr.happyjob.study.common.comnUtils.ComnUtil;*/
import kr.happyjob.study.login.dao.LoginDao;
import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.login.model.UserInfo;
import kr.happyjob.study.login.model.UsrMnuAtrtModel;
import kr.happyjob.study.login.model.UsrMnuChildAtrtModel;
import kr.happyjob.study.system.dao.ComnCodDao;

@Service("loginService")
public class LoginServiceImpl implements LoginService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	private LoginDao loginDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.roomimage}")
	private String roomimage;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Autowired
	ComnCodDao comnCodDao;
	
	/** 사용자 로그인 체크*/
	public String checkLogin(Map<String, Object> paramMap) throws Exception {
		return loginDao.checkLogin(paramMap);
	}
	
	/** 사용자 로그인 */
	public LgnInfoModel loginProc(Map<String, Object> paramMap) throws Exception {
		String password = paramMap.get("pwd").toString();
		
		//logger.info(" login before password : " + password);
		//AES 방식 암호화
		//password = AESCryptoHelper.encode( ComnUtil.AES_KEY, password);
		
		//logger.info(" login after password : " + password);
		paramMap.put("pwd", password);
		return loginDao.selectLogin(paramMap);
	}
	
	
	/**  사용자 메뉴 권한 */
	public List<UsrMnuAtrtModel> listUsrMnuAtrt(Map<String, Object> paramMap) throws Exception {	
		return loginDao.listUsrMnuAtrt(paramMap);
	}
	

	/**  사용자 자식 메뉴 권한 */
	public List<UsrMnuChildAtrtModel> listUsrChildMnuAtrt(Map<String, Object> paramMap) throws Exception{
		return loginDao.listUsrChildMnuAtrt(paramMap);

	}
	
	/**사용자 회원가입*/
	@Override
	public int registerUser(Map<String, Object> paramMap, HttpServletRequest request, HttpSession session) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		//파일저장
		String itemFilePath = roomimage + File.separator; // 업로드 실제 경로 조립 (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		fileInfo.put("file_non", virtualRootPath + File.separator + itemFilePath + fileInfo.get("file_nm"));
		
		paramMap.put("fileInfo", fileInfo);

        //System.out.println("=================== fileInfo.file_loc : " + fileInfo.get("file_loc"));
		
		loginDao.registerUser(paramMap);
		
		return 1;
	}
	
	/**loginID 중복체크*/
	@Override
	public int check_loginID(LgnInfoModel model) throws Exception {
		int result = loginDao.check_loginID(model);
		return result;
	}
	
	@Override
	public int check_email(LgnInfoModel model) throws Exception {
		int result = loginDao.check_email(model);
		return result;
	}

	/** 사용자 ID 찾기 */
	public LgnInfoModel selectFindId(Map<String, Object> paramMap) throws Exception{
		System.out.println(loginDao.selectFindId(paramMap));
		return loginDao.selectFindId(paramMap);
	}

	/** 사용자 PW 찾기 */
	public LgnInfoModel selectFindPw(Map<String, Object> paramMap) throws Exception{
/*		String password = paramMap.get("pwd").toString();
		//AES 방식 암호화
		password = AESCryptoHelper.encode( ComnUtil.AES_KEY, password);
		paramMap.put("pwd", password);*/
		return loginDao.selectFindPw(paramMap);
	}
	/** 사용자 PW 찾기 ID 체크*/
	@Override
	public LgnInfoModel registerIdCheck(Map<String, Object> paramMap) throws Exception {
	
		return loginDao.registerIdCheck(paramMap);
	}
}
