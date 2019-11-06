package com.greenzonesecu.tls.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.greenzonesecu.tls.domain.SuccessVO;

public interface SuccessService {
	public List<SuccessVO> selectPeriod(Map<String, String> map);
}
