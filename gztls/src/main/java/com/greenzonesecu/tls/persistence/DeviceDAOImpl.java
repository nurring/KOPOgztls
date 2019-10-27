package com.greenzonesecu.tls.persistence;

import java.util.List;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.greenzonesecu.tls.domain.DeviceVO;

@Repository
public class DeviceDAOImpl implements DeviceDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String DM = "DeviceMapper";
	private static final String InsertDevice = DM + ".insertDevice";
	private static final String SelectDevice = DM + ".selectDevice";
	private static final String DeviceList = DM + ".deviceList";
	private static final String DeleteDevice = DM + ".deleteDevice";
	//update만들기~

	@Override
	public void insertDevice(DeviceVO vo) {
		sqlSession.insert(InsertDevice,vo);
	}

	@Override
	public DeviceVO selectDevice(String device_id) {
		return (DeviceVO)sqlSession.selectOne(SelectDevice, device_id);
	}

	@Override
	public List<DeviceVO> deviceList() {
		return sqlSession.selectList(DeviceList);
	}

	@Override
	public void deleteDevice(String device_id) {
		sqlSession.delete(DeleteDevice, device_id);	
	}

}
