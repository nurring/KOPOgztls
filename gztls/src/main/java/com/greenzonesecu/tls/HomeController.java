package com.greenzonesecu.tls;

import java.text.ParseException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
//	@RequestMapping(value = "/", method = RequestMethod.GET)
//	public String home(Locale locale, Model model) {
//		logger.info("Welcome home! The client locale is {}.", locale);		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);	
//		String formattedDate = dateFormat.format(date);		
//		model.addAttribute("serverTime", formattedDate );		
//		return "home";
//	}
	
	@GetMapping(value = "/")
	public String oneView(Model model) {
		logger.info("main.jsp started ===================================");		
		return "main"; //main.jsp
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
	
}
