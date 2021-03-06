package com.greenzonesecu.tls.service;

import java.util.List;
import java.util.Map;

import com.greenzonesecu.tls.domain.DeviceVO;

public interface DeviceService {
	public void insertDevice(Map<String, String> map);
	
	public List<DeviceVO> selectDevice(Map<String, String> map);
	
	public List<DeviceVO> deviceList();
	
	public List<DeviceVO> selectByCondition(Map<String, String> map);
	
	public List<DeviceVO> selectAvgByCondition(Map<String, String> map);

}
