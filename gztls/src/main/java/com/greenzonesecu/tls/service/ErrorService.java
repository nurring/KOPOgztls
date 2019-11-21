package com.greenzonesecu.tls.service;

import java.util.List;
import java.util.Map;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.domain.ErrorVO;

public interface ErrorService {
	public List<DeviceVO> selectErrByTime(Map<String, String> map);
	
	public List<ErrorVO> selectErrCnt(Map<String, String> map);
	
	public List<DeviceVO> selectOneErrCnt(Map<String, String> map);
	
	public List<ErrorVO> errmntr(Map<String, String> map);
	
	public void insertError(Map<String, String> map);
	
	public List<DeviceVO> err24(Map<String, String> map);
	
	public List<DeviceVO> cntByMonth(Map<String, String> map);
	
	public List<ErrorVO> yearList();
}
