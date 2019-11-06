package com.greenzonesecu.tls.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.domain.SuccessVO;
import com.greenzonesecu.tls.service.DeviceService;
import com.greenzonesecu.tls.service.SuccessService;

@RestController
public class RController {
	@Autowired
	private DeviceService ds; 	
	@Autowired
	private SuccessService ss;
	
	private static final Logger logger = 	LoggerFactory.getLogger(RController.class);
	
	/**
	 * @RequestMapping(value="/OOOjsn") ~ json 형식으로 return함
	 */		
	@RequestMapping(value="/mainjsn")
	public List<DeviceVO> main(){
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String strDate = sdf.format(cal.getTime());
		//strDate.substring(strDate.length()-2, strDate.length());
		strDate+="00";
		logger.info("strDate..........."+strDate);
		List<DeviceVO> vos = ds.selectByServerTime(strDate);//서버 시간으로 매 초 갱신 됨(ajax)
		return vos; //객체를 json으로 리턴
	}	
	
	@RequestMapping(value="/bytimejsn/{server_time}", method=RequestMethod.GET)
	public List<DeviceVO> bytime(@PathVariable("server_time") String server_time){
		logger.info("server_time..........."+server_time);
		List<DeviceVO> vos = ds.selectByServerTime(server_time);//요청 시간 받은 시간대 출력
		logger.info(vos.toString());
		return vos;
	}
	
	@RequestMapping(value="/avgbyconjsn", method=RequestMethod.GET)
	public List<DeviceVO> avgbycon(@RequestParam Map<String, String> param, DeviceVO vo){
		logger.info("param..........."+param);
		List<DeviceVO> vos = ds.selectAvgByCondition(param);
		logger.info(vos.toString());
		return vos;
	}
	
	@RequestMapping(value="/byperiodjsn", method=RequestMethod.GET)
	public List<SuccessVO> byperiod(@RequestParam Map<String, String> param){
		logger.info("param..........."+param);
		SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		Calendar calt = Calendar.getInstance();	//현재시간		
		String to_date = sdt.format(calt.getTime());
		
		calt.add(Calendar.DATE, -1);//하루전		
		String from_date = sdt.format(calt.getTime());
		
		Map<String, String> params = new HashMap<String, String>();
		params.put("from_date", from_date);
		params.put("to_date", to_date);
		params.put("device_id", param.get("device_id"));
		
//		param.put("server_time", server_time);
//		param.put("to_date", to_date);
			
		logger.info("from_date"+ from_date);	
		logger.info("to_date"+ to_date);	
		logger.info("params"+ params);
		List<SuccessVO> vos = ss.selectPeriod(params);
		return vos;
		
	}

}