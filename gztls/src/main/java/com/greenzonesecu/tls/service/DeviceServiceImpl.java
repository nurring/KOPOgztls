package com.greenzonesecu.tls.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.greenzonesecu.tls.persistence.DeviceDAO;

@Service
public class DeviceServiceImpl implements DeviceService{
	
	@Inject
	private DeviceDAO dao;

}
