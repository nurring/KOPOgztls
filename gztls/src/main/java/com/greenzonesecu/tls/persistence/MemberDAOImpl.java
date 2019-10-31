package com.greenzonesecu.tls.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.greenzonesecu.tls.domain.MemberVO;

@Repository //DAO를 스프링에 인식시키기 위해서 사용
public class MemberDAOImpl implements MemberDAO{//샘플
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String GetTime = "MemberMapper.getTime";
	private static final String InsertMember = "MemberMapper.insertMember";
	private static final String SelectMember = "MemberMapper.selectMember";
	private static final String SelectAll = "MemberMapper.selectAll";
	
//	@Override
//	public String getTime() {
//		return sqlSession.selectOne(GetTime);
//		
//	}
	@Override
	public void insertMember(MemberVO vo) {
		sqlSession.insert(InsertMember,vo);
	}
	@Override
	public MemberVO selectMember(String userid) {
		return (MemberVO)sqlSession.selectOne(SelectMember,userid);
	}
//	@Override
//	public String selectMember(HashMap<String, Object> map) {
//		//return (MemberVO)sqlSession.selectOne(SelectMember,userid);
//		return sqlSession.getMapper(MemberDAO.class).selectMember(map);
//	}
//	@Override
//	public List<MemberVO> selectAll() {
//		return sqlSession.selectList(SelectAll);
//	}
	@Override
	public List<String> selectAll() {
		return sqlSession.selectList(SelectAll);
	}
}