package com.greenzonesecu.tls.controller;

import java.text.ParseException;
import java.util.List;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.service.DeviceService;

@Controller
public class DeviceController {
	@Autowired
	private DeviceService service; 	
	
	private static final Logger logger = 	LoggerFactory.getLogger(DeviceController.class);
	
	@GetMapping(value = "servertime/{server_time}") //비동기 X...이전에 하던 방식
	public String time(@PathVariable("server_time") String server_time, Model model) throws ParseException {
		logger.info("time..........."+server_time);
		
		List<DeviceVO> vos = service.selectByServerTime(server_time);
		logger.info(vos.toString());
		model.addAttribute("list",vos);
		return "time"; //time.jsp
	}	

}
