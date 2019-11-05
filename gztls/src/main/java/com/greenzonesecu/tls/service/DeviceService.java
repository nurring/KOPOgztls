package com.greenzonesecu.tls.service;

import java.util.List;
import java.util.Map;

import com.greenzonesecu.tls.domain.DeviceVO;

public interface DeviceService {
	public List<DeviceVO> selectByServerTime(String server_time);
	
	public List<DeviceVO> selectAvgByCondition(Map<String, String> param);
}
