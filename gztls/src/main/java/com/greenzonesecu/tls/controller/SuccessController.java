package com.greenzonesecu.tls.controller;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.greenzonesecu.tls.domain.SuccessVO;
import com.greenzonesecu.tls.service.SuccessService;

@Controller
public class SuccessController {
	@Inject
	private SuccessService service;
	
	private static final Logger logger = 	LoggerFactory.getLogger(SuccessController.class);
	
	@GetMapping(value = "/time/{date}")	//날짜 String으로 가져와서 Date로 변환하여 조회하자~ 내일 고치기
	public String time(@PathVariable("date") @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") Date time, Model model) {
		logger.info("selecTime called..........."+time);
		List<SuccessVO> vo = service.selectTime(time);
		model.addAttribute("user", vo);
		return "time";
	}
}
