package com.greenzonesecu.tls.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.persistence.DeviceDAO;

@Service
public class DeviceServiceImpl implements DeviceService{
	
	@Autowired
	private DeviceDAO dao;

	@Override
	public List<DeviceVO> deviceList() {
		return dao.deviceList();
	}
	
	@Override
	public List<DeviceVO> selectByCondition(Map<String, String> map) {
		return dao.selectByCondition(map);
	}

	@Override
	public List<DeviceVO> selectAvgByCondition(Map<String, String> map) {
		return dao.selectAvgByCondition(map);
	}

	@Override
	public List<DeviceVO> selectDevice(Map<String, String> map) {
		return dao.selectDevice(map);
	}

	

}
