package com.greenzonesecu.tls.domain;

import java.util.Date;

public class SuccessVO {
	private String g_id;
	private DeviceVO device; //Device Entity에 매핑
	private String sequence_no;
	private String data_type;
	private Double data_content;
	private Date regidate;
	private Date updatedate;
	
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
	public Date getRegidate() {
		return regidate;
	}
	public void setRegidate(Date regidate) {
		this.regidate = regidate;
	}
	public Date getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}

}
