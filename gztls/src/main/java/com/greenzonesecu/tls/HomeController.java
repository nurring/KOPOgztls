package com.greenzonesecu.tls;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.service.DeviceService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController { //jsp view로 return
	@Autowired
	private DeviceService service; 	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@GetMapping(value = "/")
	public String home(Model model) {
		logger.info("Welcome home!");		
//		SimpleDateFormat sdt= new SimpleDateFormat("YYYYMMddHHmmss");
//		Calendar calt = Calendar.getInstance();
		List<DeviceVO> vos = service.deviceList();
		model.addAttribute("list",vos);
		return "main";
	}
	
	@GetMapping(value = "/bymap")
	public String oneView(Model model) {
		logger.info("main.jsp started ===================================");
		List<DeviceVO> vos = service.deviceList();
		model.addAttribute("list",vos);
		return "bymap"; //bymap.jsp
	}
	
	@GetMapping(value = "/bytime")
	public String time() throws ParseException {	
		logger.info("bytime.jsp started ===================================");	
		return "bytime"; //bytime.jsp
	}
	
	@GetMapping(value = "/avgbycon")
	public String con() {
		return "avgbycon";
	}
	
	@GetMapping(value = "/byperiod")
	public String period(Model model) {
		Calendar calt = Calendar.getInstance();	
		SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");		
		model.addAttribute("devices", service.deviceList());
		model.addAttribute("now", sdt.format(calt.getTime()));
		return "byperiod";
	}
	
	@GetMapping(value = "/errormain")
	public String errormain(Model model) {
		return "errormain";
	}
}
