package com.greenzonesecu.tls.controller;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.greenzonesecu.tls.domain.ProductVO;
import com.greenzonesecu.tls.persistence.MemberDAO;
import com.greenzonesecu.tls.service.SuccessService;

//컨트롤러
@Controller
public class SampleController {
	@Inject
	private MemberDAO service;
	
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
	
	@RequestMapping(value = "/hashmap", method=RequestMethod.GET)
	public String doG(Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<String> list = new ArrayList();
		list = service.selectAll();
		map.put("hashmaplist", list);
		//map.put(userid, "gguri");
		//String json = service.selectMember(map);		
		//String json = new ObjectMapper().writeValueAsString(JsonVO);
		System.out.println(list);
		model.addAttribute("hashmaplist",list);
		return "hashmap";
	}
	
	/**
	 * Map방식을 이용한 JSON API 컨트롤러
	 * @return
	 */
	@RequestMapping(value="/getJsonByMap")
	public @ResponseBody Map<String , Object> getJsonByMap() {
	    Map<String, Object> jsonObject = new HashMap<String, Object>();
	    Map<String, Object> jsonSubObject = null;
	    ArrayList<Map<String, Object>> jsonList = new ArrayList<Map<String, Object>>();
	         
	    //1번째 데이터
	    jsonSubObject = new HashMap<String, Object>();
	    jsonSubObject.put("idx", 1);
	    jsonSubObject.put("title", "제목입니다");
	    jsonSubObject.put("create_date", new Date());
	    jsonList.add(jsonSubObject);
	    //2번째 데이터
	    jsonSubObject = new HashMap<String, Object>();
	    jsonSubObject.put("idx", 2);
	    jsonSubObject.put("title", "두번째제목입니다");
	    jsonSubObject.put("create_date", new Date());
	    jsonList.add(jsonSubObject);
	         
	    jsonObject.put("success", true);
	    jsonObject.put("total_count", 10);
	    jsonObject.put("result_list", jsonList);
	         
	    return jsonObject;
	}
}