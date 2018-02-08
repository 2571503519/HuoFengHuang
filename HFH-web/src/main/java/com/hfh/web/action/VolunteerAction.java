package com.hfh.web.action;

import java.io.IOException;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hfh.domain.Activity;
import com.hfh.domain.Volunteer;
import com.hfh.service.VolunteerService;
import com.hfh.utils.MyConstant;
import com.hfh.web.action.base.BaseAction;

@Controller
@Scope("prototype")
public class VolunteerAction extends BaseAction<Volunteer> {
	@Autowired
	private VolunteerService volunteerService;
	// 属性驱动，批量删除时，由id组成的字符串 "1,2,3"
	private String ids;
	private String provinceTmp;
	private String cityTmp;
	private String countyTmp;
	private String townTmp;
	
	public void setIds(String ids) {
		this.ids = ids;
	}
	
	public void setProvinceTmp(String provinceTmp) {
		this.provinceTmp = provinceTmp;
	}

	public void setCityTmp(String cityTmp) {
		this.cityTmp = cityTmp;
	}

	public void setCountyTmp(String countyTmp) {
		this.countyTmp = countyTmp;
	}

	public void setTownTmp(String townTmp) {
		this.townTmp = townTmp;
	}

	public String pageQuery() {
		volunteerService.pageQuery(this.pageBean);
		// 将pageBean转换成json数据，设置到responce中返回给浏览器
		this.java2Json(pageBean, new String[] {"currentPage","detachedCriteria","pageSize", "actVols"});
		// 将json数据返回后，前端easyui框架会自己解析json数据，所以不需要跳转、刷新页面
		return NONE;
	}
	
	public String publishVolunteers() {
		volunteerService.publishVolunteers(ids);
		
		return LIST;
	}
	
	public String revokeVolunteers() {
		volunteerService.revokeVolunteers(ids);
		
		return LIST;
	}
	
	public String deleteVolunteers() {
		volunteerService.deleteVolunteers(ids);
		
		return LIST;
	}
	
	public String add() throws IOException {
		// 对内容进行判断, 姓名和身份证不能为空
		String error = null;
		String json = null;
		model.setProvince(provinceTmp);
		model.setCity(cityTmp);
		model.setCounty(countyTmp);
		model.setTown(townTmp);
		if (!StringUtils.isNotBlank(model.getVol_name()) 
				|| !StringUtils.isNotBlank(model.getVol_IDCard()) ) {
			//  姓名或身份证为空，直接返回错误状态码和错误消息提示
			error = "姓名或身份证不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		model.setReg_time(new Date());
		volunteerService.save(model);
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	public String edit() throws IOException {
		// 对内容进行判断, 标题和内容不能为空
		String error = null;
		String json = null;
		model.setProvince(provinceTmp);
		model.setCity(cityTmp);
		model.setCounty(countyTmp);
		model.setTown(townTmp);
		if (!StringUtils.isNotBlank(model.getVol_name()) 
				|| !StringUtils.isNotBlank(model.getVol_IDCard()) ) {
			//  姓名或身份证为空，直接返回错误状态码和错误消息提示
			error = "姓名或身份证不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		Volunteer v = volunteerService.findById(model.getVol_id());
		v.setVol_name(model.getVol_name());
		v.setVol_IDCard(model.getVol_IDCard());
		v.setLive_url(model.getLive_url());
		v.setProvince(model.getProvince());
		v.setCity(model.getCity());
		v.setCounty(model.getCounty());
		v.setTown(model.getTown());
		v.setAddr_detail(model.getAddr_detail());
		volunteerService.update(v);
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
}
