package com.greenzonesecu.tls.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.greenzonesecu.tls.domain.MemberVO;
import com.greenzonesecu.tls.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
	@Inject
	private MemberDAO dao;

	@Override
	public List<String> selectAll() {
		// TODO Auto-generated method stub
		return dao.selectAll();
	}


}
