package com.greenzonesecu.tls.domain;

import java.util.Date;

public class SuccessVO {
	private String g_id;
	private DeviceVO device; //Device Entity에 매핑
	private String sequence_no;
	private String data_type;
	private Double data_content;
	private long create_time;
	private Date server_time;
	
	public String getG_id() {
		return g_id;
	}
	public void setG_id(String g_id) {
		this.g_id = g_id;
	}
	public DeviceVO getDevice() {
		return device;
	}
	public void setDevice(DeviceVO device) {
		this.device = device;
	}
	public String getSequence_no() {
		return sequence_no;
	}
	public void setSequence_no(String sequence_no) {
		this.sequence_no = sequence_no;
	}
	public String getData_type() {
		return data_type;
	}
	public void setData_type(String data_type) {
		this.data_type = data_type;
	}
	public Double getData_content() {
		return data_content;
	}
	public void setData_content(Double data_content) {
		this.data_content = data_content;
	}
	public long getCreate_time() {
		return create_time;
	}
	public void setCreate_time(long create_time) {
		this.create_time = create_time;
	}
	public Date getServer_time() {
		return server_time;
	}
	public void setServer_time(Date server_time) {
		this.server_time = server_time;
	}
	
}