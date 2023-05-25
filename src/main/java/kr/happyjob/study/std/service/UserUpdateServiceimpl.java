package kr.happyjob.study.std.service;

import java.io.File;
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
import kr.happyjob.study.std.dao.UserUpdateDao;
import kr.happyjob.study.std.model.UserUpdateModel;

@Service
public class UserUpdateServiceimpl implements UserUpdateService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Value("${fileUpload.rootPath}")
	private String rootPath;

	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;

	@Value("${fileUpload.roomimage}")
	private String roomimage;

	@Autowired
	UserUpdateDao userUpdateDao;

	// 학생정보 단건 조회
	@Override
	public UserUpdateModel userUpdateList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return userUpdateDao.userUpdateList(paramMap);
	}

	// 개인정보 수정
	public int studentUpdate(Map<String, Object> paramMap, HttpServletRequest request, HttpSession session)
			throws Exception {

		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;

		String itemFilePath = roomimage + File.separator; // 업로드 실제 경로 조립
		// (무나열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리

		UserUpdateModel userUpdateList = userUpdateDao.userUpdateList(paramMap);

		if (userUpdateList.getResume_file()!= null) {
			// 기존 첨부파일 삭제
			String ppath = userUpdateList.getResume_mul();

			File currentFile = new File(ppath);
			currentFile.delete();
		}

		if ("".equals(fileInfo.get("file_nm")) || fileInfo.get("file_nm") == null) {
			fileInfo.put("file_lloc", "");
		} else {

			fileInfo.put("file_lloc", virtualRootPath + File.separator + itemFilePath + fileInfo.get("file_nm"));
		}

		paramMap.put("fileInfo", fileInfo);

		return userUpdateDao.studentUpdate(paramMap);
	}

}
