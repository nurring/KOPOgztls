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
import com.greenzonesecu.tls.service.SuccessService;

@Controller
public class SuccessController {
	@Inject
	private SuccessService service;
	
	private static final Logger logger = 	LoggerFactory.getLogger(SuccessController.class);
	
	@GetMapping(value = "/time/{date}")
	public String time(@PathVariable("date") String time, Model model) throws ParseException {
		logger.info("time..........."+time);
		List<SuccessVO> vo = service.selectTime(time);
		logger.info("vo.get(0).getServer_time()...."+vo.get(0).getData_content());
		model.addAttribute("time", time);
		model.addAttribute("vo", vo);
		return "time";
	}
}
