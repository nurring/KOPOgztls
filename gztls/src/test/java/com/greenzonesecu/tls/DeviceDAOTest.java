package com.greenzonesecu.tls;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.domain.SuccessVO;
import com.greenzonesecu.tls.persistence.DeviceDAO;
import com.greenzonesecu.tls.service.DeviceService;


//Runner 클래스(테스트 메소드를 실행하는 클래스) 를 SpringJUnit4ClassRunner로 함
@RunWith(SpringJUnit4ClassRunner.class)
//location 속성 경로에 있는 xml 파일을 이용해서 스프링이 로딩됨
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
public class DeviceDAOTest {
	//DAO 를 구현한 객체 자동으로 생성
	@Inject
	private DeviceDAO dao;
	private DeviceService service;
	
//	@Test
//	public void testSelectByServerTime() throws Exception{
//		Map<String, String> params = new HashMap<String, String>();
//		params.put("server_time", "20190901000100");
//		params.put("device_id", "0000000090bcf7ffb827eb");
//		params.put("device_address", "경기도");
//		List<DeviceVO> vos = dao.selectByCondition(params);
//		for (int i = 0; i<vos.size(); i++){
//			String print = vos.get(i).getDevice_id()+"/"
//					+vos.get(i).getDevice_address()+"/"
//					+vos.get(i).getDevice_latitude()+"/"
//					+vos.get(i).getDevice_longitude()+"/"
//					+vos.get(i).getSuccessList().get(0).getData_type()+"/"
//					+vos.get(i).getSuccessList().get(0).getData_content()+"/"
//					+vos.get(i).getSuccessList().get(0).getServer_time()+"/";			
//			System.out.println(print);
//		}		
//	}
	
//	@Test
//	public void testInsertDevice() throws Exception{
//		DeviceVO vo = new DeviceVO();
//		vo.setDevice_id("test");
//		vo.setDevice_name("Device4");
//		vo.setDevice_ip("127.0.0.1");
//		vo.setDevice_address("서울특별시 중랑구 묵동");
//		vo.setDevice_latitude(37.612683);
//		vo.setDevice_longitude(127.078713);		
//		dao.insertDevice(vo);
//		
//	}
	
//	@Test
//	public void testSelectDevice() throws Exception{
//		DeviceVO vo = dao.selectDevice("0000000090bcf7ffb827eb");
//		System.out.println(vo.getDevice_id()+"/"+vo.getDevice_name()+"/"
//							+vo.getDevice_ip()+"/"
//							+vo.getDevice_address()+"/"
//							+vo.getDevice_latitude()+"/"
//							+vo.getDevice_longitude()+"/"
//							+vo.getRegidate()+"/"
//							+vo.getUpdatedate());		
//	}
	
//	@Test
//	public void testDevice() throws Exception{
//		List<DeviceVO> vos = dao.deviceList();
//		for (DeviceVO vo : vos) {
//			String print = vo.getDevice_id()+"/"+vo.getDevice_name()+"/"
//							+vo.getDevice_ip()+"/"
//							+vo.getDevice_address()+"/"
//							+vo.getDevice_latitude()+"/"
//							+vo.getDevice_longitude()+"/"
//							+vo.getRegidate()+"/"
//							+vo.getUpdatedate();
//			System.out.println(print);
//		}
//	}
	
//	@Test
//	public void testDeleteDevice() throws Exception{
//		dao.deleteDevice("test");
//	}
	
	@Test
	public void selectErrByTime() {
		Map<String, String> params = new HashMap<String, String>();
//		params.put("yyyy", "2019");
//		params.put("mm", "02");
//		params.put("dd", "15");
//		params.put("hh", "03");
		params.put("server_time", "2019-02-15 03:19:06");
		List<DeviceVO> vos = dao.selectErrByTime(params);
		System.out.println(vos.toString());
	};
	

	
}
