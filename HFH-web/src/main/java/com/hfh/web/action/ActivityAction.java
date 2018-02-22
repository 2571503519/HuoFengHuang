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
import com.hfh.domain.ActivityVolunteer;
import com.hfh.domain.CommonSense;
import com.hfh.domain.Law;
import com.hfh.domain.Volunteer;
import com.hfh.service.ActivityService;
import com.hfh.service.LawService;
import com.hfh.utils.MyConstant;
import com.hfh.web.action.base.BaseAction;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

@Controller
@Scope("prototype")
public class ActivityAction extends BaseAction<Activity> {
	@Autowired
	private ActivityService activityService;
	// 属性驱动，批量删除时，由id组成的字符串 "1,2,3"
	private String ids;
	// 修改活动申请所需要传入的id
	private Long actVol_id;
	
	public void setIds(String ids) {
		this.ids = ids;
	}

	public void setActVol_id(Long actVol_id) {
		this.actVol_id = actVol_id;
	}

	public String pageQuery() {
		activityService.pageQuery(this.pageBean);
		// 将pageBean转换成json数据，设置到responce中返回给浏览器
		this.java2Json(pageBean, new String[] {"currentPage","detachedCriteria","pageSize", "actVols"});
		// 将json数据返回后，前端easyui框架会自己解析json数据，所以不需要跳转、刷新页面
		return NONE;
	}
	
	public String publishActivities() {
		activityService.publishActivities(ids);
		
		return LIST;
	}
	
	public String revokeActivities() {
		activityService.revokeActivities(ids);
		
		return LIST;
	}
	
	public String deleteActivities() {
		activityService.deleteActivities(ids);
		
		return LIST;
	}
	
	public String add() throws IOException {
		// 对内容进行判断, 标题和内容不能为空
		String error = null;
		String json = null;
		if (!StringUtils.isNotBlank(model.getAct_title()) 
				|| !StringUtils.isNotBlank(model.getAct_content()) ) {
			// 标题或内容为空，直接返回错误状态码和错误消息提示
			error = "标题或内容不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		model.setCreate_time(new Date());
		activityService.save(model);
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	public String edit() throws IOException {
		// 对内容进行判断, 标题和内容不能为空
		String error = null;
		String json = null;
		if (!StringUtils.isNotBlank(model.getAct_title()) 
				|| !StringUtils.isNotBlank(model.getAct_content()) ) {
			// 标题或内容为空，直接返回错误状态码和错误消息提示
			error = "标题或内容不能为空！";
			json = "{status:" + MyConstant.ADD_NEW_FAIL + ", error:" + "'" + error + "'" +"}";
			ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
			ServletActionContext.getResponse().getWriter().print(json);
			return NONE;
		}
		Activity c = activityService.findById(model.getAct_id());
		c.setAct_title(model.getAct_title());
		c.setAct_content(model.getAct_content());
		c.setAct_addr(model.getAct_addr());
		c.setStart_time(model.getStart_time());
		c.setEnd_time(model.getEnd_time());
		c.setLive_url(model.getLive_url());
		c.setSponsor(model.getSponsor());
		c.setUpdate_time(new Date());
		activityService.update(c);
		
		json = "{status:" + MyConstant.ADD_NEW_SUCCESS +"}";
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		ServletActionContext.getResponse().getWriter().print(json);
		return NONE;
	}
	
	public String listVolunteer() {
		List<ActivityVolunteer> list = activityService.listVolunteerById(model.getAct_id());
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[] {"actVols"});
		String json = JSONArray.fromObject(list, jsonConfig).toString();
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		try {
			ServletActionContext.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return NONE;
	}

	public String approval() {
		System.out.println(actVol_id);
		activityService.approval(actVol_id);
		String json = "{\"status\":" + MyConstant.ADD_NEW_SUCCESS +"}";
		System.out.println(json);
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		try {
			ServletActionContext.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return NONE;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
