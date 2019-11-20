package com.greenzonesecu.tls.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.domain.ErrorVO;
import com.greenzonesecu.tls.persistence.ErrorDAO;

@Service
public class ErrorServiceImpl implements ErrorService {
	
	@Autowired
	private ErrorDAO dao;

	@Override
	public List<DeviceVO> selectErrByTime(Map<String, String> map) {
		return dao.selectErrByTime(map);
	}

	@Override
	public List<ErrorVO> selectErrCnt(Map<String, String> map) {
		return dao.selectErrCnt(map);
	}

	@Override
	public List<DeviceVO> selectOneErrCnt(Map<String, String> map) {
		return dao.selectOneErrCnt(map);
	}

	@Override
	public List<ErrorVO> errmntr(Map<String, String> map) {
		return dao.errmntr(map);
	}

	@Override
	public void insertError(Map<String, String> map) {
		dao.insertError(map);
	}

	@Override
	public List<DeviceVO> err24(Map<String, String> map) {
		return dao.err24(map);
	}

}
