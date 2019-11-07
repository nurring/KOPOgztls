package com.greenzonesecu.tls.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.domain.MemberVO;
import com.greenzonesecu.tls.domain.ProductVO;
import com.greenzonesecu.tls.persistence.MemberDAO;
import com.greenzonesecu.tls.service.MemberService;

//컨트롤러
@Controller
public class SampleController {
	@Inject
	private MemberService service;
	
	//로그를 남겨줌
	private static final Logger logger = 
		LoggerFactory.getLogger(SampleController.class);
	
	//ProductVO를 json 데이터 형태로 반환
	@RequestMapping("doJSON")
	public @ResponseBody ProductVO doJSON() {
		ProductVO product = new ProductVO("샘플상품",30000);
		
		return product;
	}
	
	@RequestMapping(value = "/hashmap", method=RequestMethod.GET)
	public String doG(Model model) {
		
		return "hashmap";
	}
	

	@GetMapping(value = "/userid/{userid}")
	public String time(@PathVariable("userid") String userid, Model model) throws ParseException {
		logger.info("userid..........."+userid);
		
		MemberVO vo = service.selectMember(userid);
		System.out.println(vo.getUserid()+"/"+vo.getUsername()+"/"
				+vo.getEmail());
		model.addAttribute("list",vo);
		return "home";
	}
}