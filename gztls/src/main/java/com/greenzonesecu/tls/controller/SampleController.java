package com.greenzonesecu.tls.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.greenzonesecu.tls.domain.ProductVO;

//컨트롤러
@Controller
public class SampleController {
	
	//로그를 남겨줌
	private static final Logger logger = 
		LoggerFactory.getLogger(SampleController.class);
	
	//void return 타입
	@RequestMapping("doA") //URI에 doA 가 입력되면 doA()가 호출됨
	public void doA() {
		logger.info("doA 호출됨");
	}
		
	//String return 타입
	@RequestMapping("doB") //URI에 /doB 가 입력되면 doB()가 호출됨
	public String doB(@ModelAttribute("msg") String msg) {
		logger.info("doB 호출됨");
		return "result";
	}
	
	//만들어진 결과 데이터를 전달
	@RequestMapping("doC")
	public String doC(Model model) {
		//sample date 만듬
		ProductVO product = new ProductVO("Sample Product", 10000);
		
		logger.info("doC 호출됨");
		
		model.addAttribute(product);
		return "productDetail";
	}
	
	@RequestMapping("/doE")
	public String doE(RedirectAttributes rttr) {
		//rttr 객체에 임시데이터 msg를 추가하여 넘김
		rttr.addFlashAttribute("msg","This is the Message!! with redirected");
		return "redirect:/doF";
	}
	
	@RequestMapping("/doF")
	public void doF(@ModelAttribute("msg") String msg) {
		logger.info("doF called..........."+msg); //결과:doF called...........This is the Message!! with redirected
	}
	
	//ProductVO를 json 데이터 형태로 반환
	@RequestMapping("/doJSON")
	public @ResponseBody ProductVO doJSON() {
		ProductVO product = new ProductVO("샘플상품",30000);
		
		return product;
	}
}