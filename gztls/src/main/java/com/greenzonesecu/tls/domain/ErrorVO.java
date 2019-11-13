package com.greenzonesecu.tls.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("ErrorVO")
public class ErrorVO {
	private String e_id;
	private String device_ip;
	private int err_code;
	private String err_type;
	private String err_message;
	private Date server_time;
	
	public String getE_id() {
		return e_id;
	}
	public void setE_id(String e_id) {
		this.e_id = e_id;
	}
	public String getDevice_ip() {
		return device_ip;
	}
	public void setDevice_ip(String device_ip) {
		this.device_ip = device_ip;
	}
	public int getErr_code() {
		return err_code;
	}
	public void setErr_code(int err_code) {
		this.err_code = err_code;
	}
	public String getErr_type() {
		return err_type;
	}
	public void setErr_type(String err_type) {
		this.err_type = err_type;
	}
	public String getErr_message() {
		return err_message;
	}
	public void setErr_message(String err_message) {
		this.err_message = err_message;
	}
	public Date getServer_time() {
		return server_time;
	}
	public void setServer_time(Date server_time) {
		this.server_time = server_time;
	}
	@Override
	public String toString() {
		return "ErrorVO [e_id=" + e_id + ", device_ip=" + device_ip + ", err_code=" + err_code + ", err_type="
				+ err_type + ", err_message=" + err_message + ", server_time=" + server_time + "]";
	} 
}
