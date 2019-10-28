package com.greenzonesecu.tls.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.greenzonesecu.tls.service.DeviceService;

@Controller
public class DeviceController {
	@Inject
	private DeviceService service; 	
	
}
