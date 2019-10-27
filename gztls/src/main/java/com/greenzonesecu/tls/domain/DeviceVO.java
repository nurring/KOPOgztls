package com.greenzonesecu.tls.domain;

import java.util.Date;

public class DeviceVO {
	private String device_id;
	private String device_name;
	private String device_ip;
	private String device_address;
	private double device_latitude;
	private double device_longitude;
	private Date regidate;
	private Date updatedate;
	
	public String getDevice_id() {
		return device_id;
	}
	public void setDevice_id(String device_id) {
		this.device_id = device_id;
	}
	public String getDevice_name() {
		return device_name;
	}
	public void setDevice_name(String device_name) {
		this.device_name = device_name;
	}
	public String getDevice_ip() {
		return device_ip;
	}
	public void setDevice_ip(String device_ip) {
		this.device_ip = device_ip;
	}
	public String getDevice_address() {
		return device_address;
	}
	public void setDevice_address(String device_address) {
		this.device_address = device_address;
	}
	public double getDevice_latitude() {
		return device_latitude;
	}
	public void setDevice_latitude(double device_latitude) {
		this.device_latitude = device_latitude;
	}
	public double getDevice_longitude() {
		return device_longitude;
	}
	public void setDevice_longitude(double device_longitude) {
		this.device_longitude = device_longitude;
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
