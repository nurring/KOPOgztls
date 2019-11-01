package com.greenzonesecu.tls.service;

import java.util.List;

import com.greenzonesecu.tls.domain.DeviceVO;

public interface DeviceService {
	public List<DeviceVO> selectByServerTime(String server_time);
}
