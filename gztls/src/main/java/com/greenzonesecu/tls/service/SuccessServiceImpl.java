package com.greenzonesecu.tls.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.greenzonesecu.tls.domain.SuccessVO;
import com.greenzonesecu.tls.persistence.SuccessDAO;

@Service
public class SuccessServiceImpl implements SuccessService {
	@Inject
	private SuccessDAO dao;

	@Override
	public List<SuccessVO> selectPeriod(Map<String, String> map) {
		return dao.selectPeriod(map);
	}


}
