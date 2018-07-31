package com.hfh.utils;

public class StatusBean {
	
	private int status;
	private String error;
	private String url;
	
	public StatusBean() {}
	public StatusBean(int status, String error, String url) {
		this.status = status;
		this.error = error;
		this.url = url;
	}
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getError() {
		return error;
	}
	public void setError(String error) {
		this.error = error;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
	
	
}
