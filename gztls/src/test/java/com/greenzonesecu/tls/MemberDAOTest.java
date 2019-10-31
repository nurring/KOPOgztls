package com.greenzonesecu.tls;
import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.greenzonesecu.tls.domain.MemberVO;
import com.greenzonesecu.tls.persistence.MemberDAO;


//Runner 클래스(테스트 메소드를 실행하는 클래스) 를 SpringJUnit4ClassRunner로 함
@RunWith(SpringJUnit4ClassRunner.class)
//location 속성 경로에 있는 xml 파일을 이용해서 스프링이 로딩됨
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")

public class MemberDAOTest {
	//DAO 를 구현한 객체 자동으로 생성
	@Inject
	private MemberDAO dao;
	
	@Before //@Test 전에 실행
	public void testInsertMember() throws Exception{
		MemberVO vo = new MemberVO();
		vo.setUserid("gguri");
		vo.setUserpw("1234");
		vo.setUsername("koo");
		vo.setEmail("rudals4549@naver.com");
		
		dao.insertMember(vo);
	}
	@Test
	public void testSelectMember() throws Exception{
//		MemberVO vo = dao.selectMember("gguri");
//		System.out.println(vo.getUserid()+"/"+vo.getUsername()+"/"
//				+vo.getEmail());
	}
	
}