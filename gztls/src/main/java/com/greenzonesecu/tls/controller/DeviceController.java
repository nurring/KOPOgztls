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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.service.DeviceService;

@Controller
public class DeviceController {
	@Autowired
	private DeviceService service; 	
	
	private static final Logger logger = 	LoggerFactory.getLogger(DeviceController.class);
	
	@GetMapping(value = "servertime/{server_time}")
	public String time(@PathVariable("server_time") String server_time, Model model) throws ParseException {
		logger.info("time..........."+server_time);
		
		List<DeviceVO> vos = service.selectByServerTime(server_time);


		logger.info(vos.toString());
		model.addAttribute("list",vos);
		return "time";
	}
	
	@RequestMapping(value="test") //json 데이터 ajax로 어떻게 받아오는 건가요.. url...
	@ResponseBody
	public List<DeviceVO> test(){
		List<DeviceVO> vos = service.selectByServerTime("20190901000100");
		return vos;
	}
	

}
