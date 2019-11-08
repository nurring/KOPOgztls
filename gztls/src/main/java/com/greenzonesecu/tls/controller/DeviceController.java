package com.greenzonesecu.tls.controller;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.service.DeviceService;

@Controller
public class DeviceController {
	@Autowired
	private DeviceService service; 	
	
	private static final Logger logger = 	LoggerFactory.getLogger(DeviceController.class);
	
	@PostMapping(value = {"bycondition"}) //비동기 X...이전에 하던 방식
	public String time(String server_time, String device_address, Model model) throws ParseException {
		logger.info("time..........."+server_time);
		Map<String, String> params = new HashMap<String, String>();
		params.put("server_time", server_time);
		params.put("device_address", device_address);
		
		List<DeviceVO> vos = service.selectByCondition(params);
		logger.info(vos.toString());
		model.addAttribute("list",vos);
		return "time"; //time.jsp
	}	

}
