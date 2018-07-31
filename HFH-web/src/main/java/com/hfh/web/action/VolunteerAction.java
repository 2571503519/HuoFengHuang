package com.hfh.web.action;

import java.io.IOException;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hfh.domain.Activity;
import com.hfh.domain.ActivityVolunteer;
import com.hfh.domain.User;
import com.hfh.domain.Volunteer;
import com.hfh.service.ActivityService;
import com.hfh.service.UserService;
import com.hfh.service.VolunteerService;
import com.hfh.utils.HFHUtils;
import com.hfh.utils.MyConstant;
import com.hfh.utils.StatusBean;
import com.hfh.web.action.base.BaseAction;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
public class VolunteerAction extends BaseAction<Volunteer> {
	@Autowired
	private VolunteerService volunteerService;
	@Autowired
	private ActivityService activityService;
	@Autowired
	private UserService userService;
	// 属性驱动，批量删除时，由id组成的字符串 "1,2,3"
	private String ids;
	private String provinceTmp;
	private String cityTmp;
	private String countyTmp;
	private String townTmp;
	private String user_tel;
	private String user_email;
	// 查询指定id的活动
	private Long id;
	
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
	
	// 志愿者首页
	public String volunteer() {
		System.out.println("Volunteer Index");
		
		// 查询正在进行的活动
		List<Activity> onDoingActivityList = activityService.findOnDoing(8);
		// 查询将要进行的活动
		List<Activity> willDoActivityList = activityService.findWillDo(8);
		
		ActionContext.getContext().put("onDoingActivityList", onDoingActivityList);
		ActionContext.getContext().put("willDoActivityList", willDoActivityList);
		
		return "app_volunteer";
	}
	// 活动详情
	public String activityDetail() {
		
		System.out.println(this.id + " - act_id");
		Activity theActivity = activityService.findById(id);
		ActionContext.getContext().put("theActivity", theActivity);
		return "app_activityinfo";
	}
	
	// 申请成为志愿者
	public String volunteerApply() {
		StatusBean statusBean = new StatusBean();
		// TODO: 参数校验
		System.out.println(model.getVol_name());
		System.out.println(model.getVol_IDCard());
		// 判断用户是否登录
		User loginedUser = (User) ServletActionContext.getRequest().getSession()
				.getAttribute(MyConstant.LOGINED_USER);
		if (loginedUser == null) {
			statusBean.setError("请先登录！");
			statusBean.setUrl(HFHUtils.getAbsolutePath() + "/app_login");
		} else {
			// 重新查询，防止用户信息已经更新
			loginedUser = userService.findById(loginedUser.getUser_id());
			if (loginedUser.getVol_id() != null) {
				statusBean.setError("您已经是志愿者！请勿重复申请。");
			} else {
				Long volId = volunteerService.saveAndReturnId(model);
			}
		}
		return NONE;
	}
	
	// 活动申请
	public String apply() throws IOException {
		System.out.println(this.id); // 活动的id
		StatusBean statusBean = new StatusBean();
		Activity activity = null;
		Volunteer volunteer = null;
		// 判断用户是否登录
		User loginedUser = (User) ServletActionContext.getRequest().getSession()
				.getAttribute(MyConstant.LOGINED_USER);
		if (loginedUser == null) {
			statusBean.setError("请先登录！");
			statusBean.setUrl(HFHUtils.getAbsolutePath() + "/app_login");
		} else if (loginedUser.getVol_id() == null) {
			statusBean.setError("您目前还不是志愿者！请申请成为志愿者后再申请参加活动。");
		} else {
			activity = activityService.findById(this.id);
			volunteer = volunteerService.findById(loginedUser.getVol_id());
			if (activity == null) {
				statusBean.setError("无相关活动！");
			} else if (volunteer == null) {
				statusBean.setError("志愿者不存在！");
			}
		}
		if (statusBean.getError() != null)
			statusBean.setStatus(MyConstant.STATUS_FAIL);
		else {
			// 向act_vol表中添加记录
			ActivityVolunteer activityVolunteer = new ActivityVolunteer();
			activityVolunteer.setActivity(activity);
			activityVolunteer.setVolunteer(volunteer);
			activityVolunteer.setCreate_time(new Date());
			activityVolunteer.setStatus(0);
			activityService.saveActivityVolunteer(activityVolunteer);
			statusBean.setStatus(MyConstant.STATUS_SUCCESS);
		}
		this.java2Json(statusBean, new String[] {});
		return NONE;
	}
	
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

	public void setId(Long id) {
		this.id = id;
	}
	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
}
