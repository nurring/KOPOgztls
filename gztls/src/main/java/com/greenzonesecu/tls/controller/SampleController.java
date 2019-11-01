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