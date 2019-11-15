package com.greenzonesecu.tls.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.persistence.ErrorDAO;

@Service
public class ErrorServiceImpl implements ErrorService {
	
	@Autowired
	private ErrorDAO dao;

	@Override
	public List<DeviceVO> selectErrByTime(Map<String, String> map) {
		return dao.selectErrByTime(map);
	}

}
