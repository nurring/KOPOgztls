package com.greenzonesecu.tls.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ErrorDAOImpl implements ErrorDAO {
	@Autowired
	private SqlSession sqlSession;

}
