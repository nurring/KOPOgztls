package com.greenzonesecu.tls.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.greenzonesecu.tls.domain.DeviceVO;

@Repository
public class DeviceDAOImpl implements DeviceDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String DM = "DeviceMapper";
	private static final String InsertDevice = DM + ".insertDevice";
	private static final String SelectDevice = DM + ".selectDevice";
	private static final String DeviceList = DM + ".deviceList";
	private static final String DeleteDevice = DM + ".deleteDevice";
	private static final String SelectByCondition = DM + ".selectByCondition";
	private static final String SelectAvgByCondition = DM + ".selectAvgByCondition";
	
	//update만들기~

	@Override
	public void insertDevice(Map<String, String> map) {
		sqlSession.insert(InsertDevice,map);
	}

	@Override
	public List<DeviceVO> selectDevice(Map<String, String> map) {
		return sqlSession.selectList(SelectDevice, map);
	}

	@Override
	public List<DeviceVO> deviceList() {
		return sqlSession.selectList(DeviceList);
	}

	@Override
	public void deleteDevice(String device_id) {
		sqlSession.delete(DeleteDevice, device_id);	
	}

	@Override
	public List<DeviceVO> selectByCondition(Map<String, String> map) {
		return sqlSession.selectList(SelectByCondition, map);
	}

	@Override
	public List<DeviceVO> selectAvgByCondition(Map<String, String> map) {
		return sqlSession.selectList(SelectAvgByCondition, map);
	}

}
