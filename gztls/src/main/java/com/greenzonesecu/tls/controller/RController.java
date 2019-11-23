package com.greenzonesecu.tls.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.greenzonesecu.tls.domain.DeviceVO;
import com.greenzonesecu.tls.domain.ErrorVO;
import com.greenzonesecu.tls.domain.SuccessVO;
import com.greenzonesecu.tls.service.DeviceService;
import com.greenzonesecu.tls.service.ErrorService;
import com.greenzonesecu.tls.service.SuccessService;

@RestController //Rest방식만 따로 모음
public class RController {
	@Autowired
	private DeviceService ds; 	
	@Autowired
	private SuccessService ss;
	@Autowired
	private ErrorService es;
	
	private static final Logger logger = 	LoggerFactory.getLogger(RController.class);
	
	/**
	 * @RequestMapping(value="/OOOjsn") ~ json 형식으로 return함
	 */		
	@RequestMapping(value="/bymapjsn", method=RequestMethod.GET)
	public List<DeviceVO> main(@RequestParam Map<String, String> param){				
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String strDate = sdf.format(cal.getTime());
		strDate+="00";		
		
		Map<String, String> str = new HashMap<String, String>();
		str.put("device_id", param.get("device_id")); //기기명
		str.put("create_time", strDate);
		logger.info("str..........."+str);
		List<DeviceVO> vos = ds.selectByCondition(str);
		logger.info("vos.toString()"+vos.toString());
		return vos; //객체를 json으로 리턴
	}
	
	@RequestMapping(value="/avgbyconjsn", method=RequestMethod.GET)
	public List<DeviceVO> avgbycon(@RequestParam Map<String, String> param, DeviceVO vo){
		logger.info("param..........."+param);
		List<DeviceVO> vos = ds.selectAvgByCondition(param);
		logger.info(vos.toString());
		return vos;
	}
	
	@RequestMapping(value="/byperiodjsn", method=RequestMethod.GET)
	public List<SuccessVO> byperiod(@RequestParam Map<String, String> param){
		SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		Calendar calt = Calendar.getInstance();	//현재시간		
		String to_date = sdt.format(calt.getTime());		
		calt.add(Calendar.DATE, -1);//하루전		
		String from_date = sdt.format(calt.getTime());
		
		Map<String, String> params = new HashMap<String, String>();
		params.put("from_date", from_date);
		params.put("to_date", to_date);
		params.put("device_id", param.get("device_id"));	
		List<SuccessVO> vos = ss.selectPeriod(params);
		return vos;
		
	}
	
	@RequestMapping(value="/searchjsn", method=RequestMethod.GET)
	public List<DeviceVO> byname(@RequestParam Map<String, String> param) {
		logger.info("param..........."+param);
		List<DeviceVO> vo = ds.selectDevice(param);
		logger.info(vo.toString());
		return vo;
	}
	
	@RequestMapping(value="/dlistjsn", method=RequestMethod.GET)
	public List<DeviceVO> deviceList() {
		List<DeviceVO> vos = ds.deviceList();
		logger.info("vos.toString()..........."+vos.toString());
		return vos;
	}
	
	@RequestMapping(value="/nowjsn", method=RequestMethod.GET)
	public List<DeviceVO> nowData(@RequestParam Map<String, String> param) {
		Map<String, String> params = new HashMap<String, String>();
		
		Calendar calt = Calendar.getInstance();	//현재시간		
		SimpleDateFormat sdt= new SimpleDateFormat("yyyyMMddHHmm");		
		String now = sdt.format(calt.getTime());
		now+="00";
		params.put("create_time", now);
		params.put("device_id", param.get("device_id"));
		List<DeviceVO> vos = ds.selectByCondition(params);
		logger.info("params..........."+params);
		logger.info("vos.toString()..........."+vos.toString());
		logger.info("vos.size()..........."+vos.size());
		return vos;
	}
	
	@RequestMapping(value="/errcntjsn", method=RequestMethod.GET)
	public List<ErrorVO> errcnt(@RequestParam Map<String, String> param) {	
		logger.info("param..........."+param);
		List<ErrorVO> vos = es.selectErrCnt(param);
		return vos;		
	}
	
	@RequestMapping(value="/errcntbyidjsn", method=RequestMethod.GET)
	public List<DeviceVO> errcntbyid(@RequestParam Map<String, String> param) {	
		logger.info("param..........."+param);
		List<DeviceVO> vos = es.selectOneErrCnt(param);
		return vos;		
	}
	
	@RequestMapping(value="/errnowjsn", method=RequestMethod.GET)
	public List<ErrorVO> errmntr() {	
		Map<String, String> params = new HashMap<String, String>();
		
		SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		Calendar calt = Calendar.getInstance();		
		String til = sdt.format(calt.getTime());//현재시간	
		calt.add(Calendar.MINUTE, -1);	
		String from = sdt.format(calt.getTime());//1분 전			
		params.put("from", from);
		params.put("til", til);
		logger.info("param..........."+params);
		List<ErrorVO> vos = es.errmntr(params);
		logger.info("vos..........."+vos.toString());
		return vos;		
	}
	
	@RequestMapping(value="/err24jsn", method=RequestMethod.GET)
	public List<DeviceVO> err24(){
		Map<String, String> params = new HashMap<String, String>();
		
		SimpleDateFormat sdt= new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		Calendar calt = Calendar.getInstance();		
		String til = sdt.format(calt.getTime());//현재시간	
		calt.add(Calendar.DATE, -1);	
		String from = sdt.format(calt.getTime());//하루전			
		params.put("from", from);
		params.put("til", til);
		logger.info("param..........."+params);
		List<DeviceVO> vos = es.err24(params);
		logger.info("vos..........."+vos.toString());
		return vos;
	}
	
	@RequestMapping(value="/yearListjsn", method=RequestMethod.GET)
	public List<ErrorVO> yearList(){
		List<ErrorVO> vos = es.yearList();
		return vos;
	}
	
	@RequestMapping(value="/cntbymonthjsn", method=RequestMethod.GET)
	public List<DeviceVO> cntbymonth(@RequestParam Map<String, String> param){		
		logger.info("param..........."+param);
		List<DeviceVO> vos = es.cntByMonth(param);
		logger.info("vos..........."+vos.toString());
		return vos;
	}
	
	@RequestMapping(value="/cntbyyearjsn", method=RequestMethod.GET)
	public List<DeviceVO> cntbyyear(@RequestParam Map<String, String> param){		
		logger.info("param..........."+param);
		List<DeviceVO> vos = es.cntByYear(param);
		logger.info("vos..........."+vos.toString());
		return vos;
	}
	
	@RequestMapping(value="/errallbymsgjsn", method=RequestMethod.GET)
	public List<ErrorVO> errallbymsg(@RequestParam Map<String, String> param){		
		logger.info("param..........."+param);
		List<ErrorVO> vos = es.errAllByMsg(param);
		logger.info("vos..........."+vos.toString());
		return vos;
	}
	
	@RequestMapping(value="/errbymsgjsn", method=RequestMethod.GET)
	public List<DeviceVO> errbymsg(@RequestParam Map<String, String> param){		
		logger.info("param..........."+param);
		List<DeviceVO> vos = es.errByMsg(param);
		logger.info("vos..........."+vos.toString());
		return vos;
	}
	
	////////////////////////////////////////////////////////////////////////////////////샘플 데이터 넣기
	@RequestMapping(value="/servertimeinsert", method=RequestMethod.GET)
	public void servertimeinsert() {
	    Random random = new Random();
		Map<String, String> params = new HashMap<String, String>();
		String device_id=null; String sequence_no=null;
		String data_type=null; Double data_content=0.0;
		String create_time=null; String server_time=null;
		
		Calendar calt = Calendar.getInstance();	//현재시간		
		SimpleDateFormat ct= new SimpleDateFormat("yyyyMMddHHmm");		
		SimpleDateFormat st= new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		String[] arrs = new String[4];
		arrs[0] = "00000000522291dbb827eb"; arrs[1] = "000000007a62185eb827eb";
		arrs[2] = "000000008263b1fdb827eb"; arrs[3] = "0000000090bcf7ffb827eb";
		sequence_no = "test";
		params.put("sequence_no", sequence_no);
		System.out.println();
		System.out.println();
		for (String arr : arrs) {
			params.put("device_id", arr);
			for (int i = 0; i < 4; i++) {
				create_time = ct.format(calt.getTime()); create_time+="00";
				server_time = st.format(calt.getTime());
				params.put("create_time", create_time);
				params.put("server_time", server_time);
				System.out.println("creat_time"+create_time);
				if (i==0) {										
					params.put("data_type","T");
					data_content=(random.nextInt(4))*10 + (Math.round((random.nextDouble()*10)*100)/100.0);
					params.put("data_content", data_content.toString());					
					ss.insertData(params);
					logger.info("Tparams..........."+params.toString());
				}
				if (i==1) {
					params.put("data_type","H");
					data_content=Math.round(random.nextDouble()*1000)/10.0;
					params.put("data_content", data_content.toString());					
					ss.insertData(params);
					logger.info("Hparams..........."+params.toString());
				}
				if (i==2) {
					params.put("data_type","D1");
					data_content=Math.round(random.nextDouble()*100)/10.0;
					params.put("data_content", data_content.toString());					
					ss.insertData(params);
					logger.info("D1params..........."+params.toString());
				}
				if (i==3) {
					params.put("data_type","D2");
					data_content=Math.round(random.nextDouble()*1000)/100.0;
					params.put("data_content", data_content.toString());					
					ss.insertData(params);
					logger.info("D1params..........."+params.toString());
				}			
			}
		}
	}
	public static int randomRange(int n1, int n2) {
		return (int) (Math.random() * (n2 - n1 + 1)) + n1;
	}
	@RequestMapping(value="/deviceinsert", method=RequestMethod.GET)//에러데이터넣기 ~ 미완성
	public void deviceinsert() {
		double device_latitude; double device_longitude;
		String device_id = "test"+ randomRange(1,5555555);
		String device_name = "test";
		String device_ip = randomRange(0,255)+"."+randomRange(0,255)+"."+randomRange(0,255)+"."+randomRange(0,255);
		String device_address = "test";		
		device_latitude = (randomRange(32000000, 38000000))/1000000.0;
		device_longitude = (randomRange(125500000, 131500000))/1000000.0;
		Map<String, String> params = new HashMap<String, String>();
		params.put("device_id",device_id);
		params.put("device_name", device_name);
		params.put("device_ip", device_ip);
		params.put("device_address", device_address);
		params.put("device_latitude", Double.toString(device_latitude));
		params.put("device_longitude", Double.toString(device_longitude));
		ds.insertDevice(params);
	}
	
	@RequestMapping(value="/errorinsert", method=RequestMethod.GET)//에러데이터넣기 ~ 미완성
	public void errorinsert() {
		String device_ip; int err_code; String err_type; String err_message; String server_time;		
		device_ip = "10.10.10.47";
		err_code = 2;
		err_type = "X509(인증서) 오류";
		err_message = "X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT";
		Calendar calt = Calendar.getInstance();	
		SimpleDateFormat st= new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		server_time = st.format(calt.getTime());
		Map<String, String> params = new HashMap<String, String>();
		params.put("device_ip", device_ip);
		params.put("err_code", Integer.toString(err_code));
		params.put("err_type", err_type);
		params.put("err_message", err_message);
		params.put("server_time", server_time);
		System.out.println(params);
		es.insertError(params);
	}
	
	@RequestMapping(value="/errorinsert2", method=RequestMethod.GET)//에러데이터넣기 ~ 미완성
	public void errorinsert2() {
		String device_ip; int err_code; String err_type; String err_message; String server_time;		
		device_ip = "10.10.10.46";
		err_code = 1;
		err_type = "데이터 오류";
		err_message = "DATA_ERROR_OUT_RANGE";
		Calendar calt = Calendar.getInstance();	
		SimpleDateFormat st= new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		server_time = st.format(calt.getTime());
		Map<String, String> params = new HashMap<String, String>();
		params.put("device_ip", device_ip);
		params.put("err_code", Integer.toString(err_code));
		params.put("err_type", err_type);
		params.put("err_message", err_message);
		params.put("server_time", server_time);
		System.out.println(params);
		es.insertError(params);
	}
	
}
