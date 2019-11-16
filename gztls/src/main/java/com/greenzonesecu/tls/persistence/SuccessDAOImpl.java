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
	private static final String SelectPeriod = SM + ".selectPeriod";
	private static final String InsertData = SM + ".insertData";


	@Override
	public List<SuccessVO> selectPeriod(Map<String, String> map) {
		return sqlSession.selectList(SelectPeriod, map);
	}


	@Override
	public void insertData(Map<String, String> map) {
		sqlSession.insert(InsertData, map);
	}

}