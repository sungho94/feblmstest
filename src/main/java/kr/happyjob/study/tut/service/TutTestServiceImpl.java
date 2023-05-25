package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import kr.happyjob.study.tut.dao.TutTestDAO;
import kr.happyjob.study.tut.model.TutTestModel;

@Service
@Component
@Repository
public class TutTestServiceImpl implements TutTestService {

		@Autowired
		TutTestDAO tutTestDAO;
		//시험 리스트
		@Override
		public List<TutTestModel> testList(Map<String, Object> paramMap) throws Exception {
			return tutTestDAO.testList(paramMap);
		}
		//시험갯수
		@Override
		public int testListCnt(Map<String, Object> paramMap) throws Exception {
			return tutTestDAO.testListCnt(paramMap);
		}
		//시험상세보기
		@Override
		public TutTestModel testDetail(Map<String, Object> paramMap) throws Exception {
			TutTestModel testDetail = tutTestDAO.testDetail(paramMap);
			return testDetail;
		}
		//시험상세보기에서 등록된강의보기
		@Override
		public Map<String,Object> testDetailSelect(Map<String, Object> paramMap) throws Exception {
			return tutTestDAO.testDetailSelect(paramMap);
		}
		//문제리스트
		@Override
		public List<TutTestModel> questionList(Map<String, Object> paramMap) throws Exception {
			return tutTestDAO.questionList(paramMap);
		}
		//문제리스트갯수
		@Override
		public int questionListCnt(Map<String, Object> paramMap) throws Exception {
			return tutTestDAO.questionListCnt(paramMap);
		}
		//문제상세보기
		@Override
		public TutTestModel questionDetail(Map<String, Object> paramMap) throws Exception {
			return tutTestDAO.questionDetail(paramMap);
		}
		// 문제 등록
		@Override
		public int questionInsert(Map<String, Object> paramMap) throws Exception {
			return tutTestDAO.questionInsert(paramMap);
		}
		//문제 삭제
		@Override
		public int questionDelete(Map<String, Object> paramMap) throws Exception {
			return tutTestDAO.questionDelete(paramMap);
		}
		//문제 수정
		@Override
		public int questionUpdate(Map<String, Object> paramMap) throws Exception {
			return tutTestDAO.questionUpdate(paramMap);
		}
		@Override
		public int testInsert(Map<String, Object> paramMap) throws Exception {
			return tutTestDAO.testInsert(paramMap);
		}
		@Override
		public int testUpdate(Map<String, Object> paramMap) throws Exception {
			      int testUpdate = tutTestDAO.testUpdate(paramMap);
			return testUpdate;
		}
		@Override
		public int testDelete(Map<String, Object> paramMap) throws Exception {
			return tutTestDAO.testDelete(paramMap);
		}

}
