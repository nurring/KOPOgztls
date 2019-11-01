package com.greenzonesecu.tls.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.persistence.DeviceDAO;

@Service
public class DeviceServiceImpl implements DeviceService{
	
	@Autowired
	private DeviceDAO dao;

	@Override
	public List<DeviceVO> selectByServerTime(String server_time) {
		return dao.selectByServerTime(server_time);
	}

}
