package com.greenzonesecu.tls.service;

import java.util.List;
import java.util.Map;

import com.greenzonesecu.tls.domain.DeviceVO;

public interface ErrorService {
	public List<DeviceVO> selectErrByTime(Map<String, String> map);
}
