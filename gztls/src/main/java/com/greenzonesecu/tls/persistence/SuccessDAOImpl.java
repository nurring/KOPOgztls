package com.greenzonesecu.tls.persistence;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.greenzonesecu.tls.domain.SuccessVO;

@Repository
public class SuccessDAOImpl implements SuccessDAO{
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String SM = "SuccessMapper";
	private static final String SelectTime = SM + ".selectTime";
	private static final String SelectPeriod = "DeviceMapper.selectPeriod";

	@Override
	public List<SuccessVO> selectTime(String time) {
		return sqlSession.selectList(SelectTime, time);
	}

	@Override
	public List<SuccessVO> selectPeriod(Map<String, String> map) {
		return sqlSession.selectList(SelectPeriod, map);
	}

}