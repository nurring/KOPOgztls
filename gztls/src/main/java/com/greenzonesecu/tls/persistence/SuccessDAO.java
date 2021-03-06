package com.greenzonesecu.tls.persistence;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.greenzonesecu.tls.domain.SuccessVO;

public interface SuccessDAO {	
	public List<SuccessVO> selectPeriod(Map<String, String> map);
	
	public void insertData(Map<String, String> map);
}