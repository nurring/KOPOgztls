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

@RestController //Rest방식만 따로 모음
public class RController {
	@Autowired
	private DeviceService ds; 	
	@Autowired
	private SuccessService ss;
	
	private static final Logger logger = 	LoggerFactory.getLogger(RController.class);
	
	/**
	 * @RequestMapping(value="/OOOjsn") ~ json 형식으로 return함
	 */		
	@RequestMapping(value="/bymapjsn", method=RequestMethod.GET)
	public List<DeviceVO> main(@RequestParam Map<String, String> param){
		Map<String, String> str = new HashMap<String, String>();
		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String strDate = sdf.format(cal.getTime());
		strDate+="00";
		String tempDate = "20190901000000";//데이터 확인용!
		
		str.put("device_id", param.get("device_id")); //기기명
		str.put("server_time", tempDate);
		logger.info("str..........."+str);
		List<DeviceVO> vos = ds.selectByCondition(str);
		return vos; //객체를 json으로 리턴
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
//		logger.info("param..........."+param);
		SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		Calendar calt = Calendar.getInstance();	//현재시간		
		String to_date = sdt.format(calt.getTime());
		
		calt.add(Calendar.DATE, -1);//하루전		
		String from_date = sdt.format(calt.getTime());
		
		Map<String, String> params = new HashMap<String, String>();
		params.put("from_date", from_date);
		params.put("to_date", to_date);
		params.put("device_id", param.get("device_id"));	
////		param.put("server_time", server_time);
////		param.put("to_date", to_date);
//			
//		logger.info("from_date"+ from_date);	
//		logger.info("to_date"+ to_date);	
//		logger.info("params"+ params);
		List<SuccessVO> vos = ss.selectPeriod(params);
		return vos;
		
	}
	
	@RequestMapping(value="/searchjsn", method=RequestMethod.GET)
	public List<DeviceVO> byname(@RequestParam Map<String, String> param) {
		logger.info("param..........."+param);
		List<DeviceVO> vo = ds.selectDevice(param);
		logger.info(vo.toString());
		return vo;
	}
	
	@RequestMapping(value="/dlistjsn", method=RequestMethod.GET)
	public List<DeviceVO> deviceList() {
		List<DeviceVO> vos = ds.deviceList();
		logger.info("vos.toString()..........."+vos.toString());
		return vos;
	}
	
	@RequestMapping(value="/nowjsn", method=RequestMethod.GET) //수정하다 말았어용
	public List<DeviceVO> nowData(@RequestParam Map<String, String> param) {
		SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		Calendar calt = Calendar.getInstance();	//현재시간		
		String now = sdt.format(calt.getTime());
		Map<String, String> params = new HashMap<String, String>();
		params.put("server_time", now);
		List<DeviceVO> vos = ds.selectByCondition(param);
		logger.info("vos.toString()..........."+vos.toString());
		return vos;
	}

}
