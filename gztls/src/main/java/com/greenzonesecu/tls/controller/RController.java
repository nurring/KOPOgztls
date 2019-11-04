package com.greenzonesecu.tls.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod; 
import org.springframework.web.bind.annotation.RestController;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.service.DeviceService;

@RestController
public class RController {
	@Autowired
	private DeviceService service; 	
	
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
		List<DeviceVO> vos = service.selectByServerTime(strDate);//서버 시간으로 매 초 갱신 됨(ajax)
		return vos; //객체를 json으로 리턴
	}	
	
	@RequestMapping(value="/bytimejsn/{server_time}", method=RequestMethod.GET)
	public List<DeviceVO> bytime(@PathVariable("server_time") String server_time){
		logger.info("server_time..........."+server_time);
		List<DeviceVO> vos = service.selectByServerTime(server_time);//요청 시간 받은 시간대 출력
		logger.info(vos.toString());
		return vos;
	}
	

}
