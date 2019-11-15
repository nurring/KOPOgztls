package com.greenzonesecu.tls;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.persistence.ErrorDAO;

//Runner 클래스(테스트 메소드를 실행하는 클래스) 를 SpringJUnit4ClassRunner로 함
@RunWith(SpringJUnit4ClassRunner.class)
//location 속성 경로에 있는 xml 파일을 이용해서 스프링이 로딩됨
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
public class ErrorDAOTest {
	@Inject
	private ErrorDAO dao;
	
	@Test
	public void selectErrByTime() {
		Map<String, String> params = new HashMap<String, String>();
//		params.put("yyyy", "2019");
//		params.put("mm", "02");
//		params.put("dd", "15");
//		params.put("hh", "03");
		params.put("server_time", "2018-06-03 08:34:20");
		List<DeviceVO> vos = dao.selectErrByTime(params);
		System.out.println(vos.toString());
	};
	

}