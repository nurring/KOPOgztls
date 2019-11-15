package com.greenzonesecu.tls.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.greenzonesecu.tls.domain.DeviceVO;

@Repository
public class ErrorDAOImpl implements ErrorDAO {
	@Autowired
	private SqlSession sqlSession;
	
	private static final String EM = "ErrorMapper";
	private static final String SelectErrByTime = EM + ".selectErrByTime";

	@Override
	public List<DeviceVO> selectErrByTime(Map<String, String> map) {
		return sqlSession.selectList(SelectErrByTime, map);
	}
}
