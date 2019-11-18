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
		// TODO Auto-generated method stub
		return sqlSession.selectList(SelectOneErrCnt, map);
	}
}
