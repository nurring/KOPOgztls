package com.greenzonesecu.tls.service;

import java.util.Date;
import java.util.List;

import com.greenzonesecu.tls.domain.SuccessVO;

public interface SuccessService {
	public List<SuccessVO> selectTime(String time);
}
