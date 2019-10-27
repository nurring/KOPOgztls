package com.greenzonesecu.tls.persistence;

import java.util.List;

import com.greenzonesecu.tls.domain.DeviceVO;

public interface DeviceDAO {
	public void insertDevice(DeviceVO vo);
		
	public DeviceVO selectDevice(String device_id);
	
	public List<DeviceVO> deviceList();
	
	public void deleteDevice(String device_id);

}
