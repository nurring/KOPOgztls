package com.greenzonesecu.tls;

import java.sql.Connection;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

//Runner 클래스(테스트 메소드를 실행하는 클래스) 를 SpringJUnit4ClassRunner로 함
@RunWith(SpringJUnit4ClassRunner.class)
//location 속성 경로에 있는 xml 파일을 이용해서 스프링이 로딩됨
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
public class DataSourceTest {
	//DataSource의 객체를  new를 사용해 따로 생성해줄 필요없이 스프링이 생성해서 주입해줌
		@Inject
		private DataSource ds;
		
		@Test
		public void testConnection() throws Exception{
			try(Connection con = ds.getConnection()){
				System.out.println(con);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
}
