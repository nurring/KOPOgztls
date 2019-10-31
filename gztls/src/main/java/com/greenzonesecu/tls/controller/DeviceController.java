package com.greenzonesecu.tls.controller;

import java.text.ParseException;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.greenzonesecu.tls.domain.SuccessVO;
import com.greenzonesecu.tls.service.DeviceService;

@Controller
public class DeviceController {
	@Inject
	private DeviceService service; 	
	
	private static final Logger logger = 	LoggerFactory.getLogger(SuccessController.class);
	
	@GetMapping(value = "/{dd}")
	public String time(@PathVariable("dd") String time, Model model) throws ParseException {
		logger.info("time..........."+time);
		return "time";
	}
	
}
