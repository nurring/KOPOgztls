package com.greenzonesecu.tls.service;

import javax.inject.Inject;

import com.greenzonesecu.tls.persistence.DeviceDAO;

public class DeviceServiceImpl implements DeviceService{
	
	@Inject
	private DeviceDAO dao;

}
