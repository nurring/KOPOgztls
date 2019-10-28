package com.greenzonesecu.tls;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.greenzonesecu.tls.persistence.SuccessDAO;

//Runner 클래스(테스트 메소드를 실행하는 클래스) 를 SpringJUnit4ClassRunner로 함
@RunWith(SpringJUnit4ClassRunner.class)
//location 속성 경로에 있는 xml 파일을 이용해서 스프링이 로딩됨
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
public class SuccessDAOTest {
	@Inject
	private SuccessDAO dao;
	
	@Test
	public void testSelectTime() throws Exception{
		
		//List<SuccessDAO> sdao = dao.selectTime();
	}

}