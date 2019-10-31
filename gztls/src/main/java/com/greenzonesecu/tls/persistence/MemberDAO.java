package com.greenzonesecu.tls.persistence;

import java.util.HashMap;
import java.util.List;

import com.greenzonesecu.tls.domain.MemberVO;

public interface MemberDAO {//샘플
	
	//public String getTime();
	
	public void insertMember(MemberVO vo);
	
	public MemberVO selectMember(String userid);
	//public String selectMember(HashMap<String,Object> map);
	
	//public List<MemberVO> selectAll();
	public List<String> selectAll();
}