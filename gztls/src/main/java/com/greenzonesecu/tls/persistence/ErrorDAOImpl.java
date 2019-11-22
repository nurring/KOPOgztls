package com.greenzonesecu.tls.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.domain.ErrorVO;

@Repository
public class ErrorDAOImpl implements ErrorDAO {
	@Autowired
	private SqlSession sqlSession;
	
	private static final String EM = "ErrorMapper";
	private static final String SelectErrByTime = EM + ".selectErrByTime";
	private static final String SelectErrCnt = EM + ".selectErrCnt";
	private static final String SelectOneErrCnt = EM + ".selectOneErrCnt";
	private static final String ErrMntr = EM + ".errmntr";
	private static final String InsertError = EM + ".insertError";
	private static final String Err24 = EM + ".err24";
	private static final String CntByMonth = EM + ".cntByMonth";
	private static final String CntByYear = EM + ".cntByYear";
	private static final String YearList = EM + ".yearList";

	@Override
	public List<DeviceVO> selectErrByTime(Map<String, String> map) {
		return sqlSession.selectList(SelectErrByTime, map);
	}

	@Override
	public List<ErrorVO> selectErrCnt(Map<String, String> map) {
		return sqlSession.selectList(SelectErrCnt, map);
	}

	@Override
	public List<DeviceVO> selectOneErrCnt(Map<String, String> map) {
		return sqlSession.selectList(SelectOneErrCnt, map);
	}

	@Override
	public List<ErrorVO> errmntr(Map<String, String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(ErrMntr, map);
	}

	@Override
	public void insertError(Map<String, String> map) {
		sqlSession.insert(InsertError, map);
	}

	@Override
	public List<DeviceVO> err24(Map<String, String> map) {
		return sqlSession.selectList(Err24, map);
	}

	@Override
	public List<DeviceVO> cntByMonth(Map<String, String> map) {
		return sqlSession.selectList(CntByMonth, map);
	}
	@Override
	public List<DeviceVO> cntByYear(Map<String, String> map) {
		return sqlSession.selectList(CntByYear, map);
	}
	@Override
	public List<ErrorVO> yearList() {
		return sqlSession.selectList(YearList);
	}


}
