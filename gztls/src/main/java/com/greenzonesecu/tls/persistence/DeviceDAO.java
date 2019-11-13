package com.greenzonesecu.tls.persistence;

import java.util.List;
import java.util.Map;

import com.greenzonesecu.tls.domain.DeviceVO;

public interface DeviceDAO {
	public void insertDevice(DeviceVO vo);
		
	public List<DeviceVO> selectDevice(Map<String, String> map);
	
	public List<DeviceVO> deviceList();
	
	public void deleteDevice(String device_id);
	
	public List<DeviceVO> selectByCondition(Map<String, String> map);

	public List<DeviceVO> selectAvgByCondition(Map<String, String> map);
	
	public List<DeviceVO> selectErrByTime(Map<String, String> map);
}
