package com.greenzonesecu.tls.persistence;

import java.util.Date;
import java.util.List;

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

	@Override
	public List<SuccessVO> selectTime(Date time) {
		return sqlSession.selectList(SelectTime, time);
	}

}