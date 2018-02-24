package com.hfh.web.action.app;

import java.io.IOException;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hfh.domain.Activity;
import com.hfh.domain.New;
import com.hfh.domain.User;
import com.hfh.service.ActivityService;
import com.hfh.service.NewService;
import com.hfh.service.UserService;
import com.hfh.utils.MyConstant;
import com.hfh.utils.PageBean;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 前台首页的Action
 * @author 家乐
 *
 */
@Controller
@Scope("prototype")
public class IndexAction extends ActionSupport {
	
	@Autowired
	private NewService newService;
	
	@Autowired
	private ActivityService activityService;
	
	@Autowired
	private UserService userService;
	
	private PageBean pageBean = new PageBean();
	private Long id;
	private String username;
	private String password;
	private String email;
	
	public void setId(Long id) {
		this.id = id;
	}
	public void setPage(int page) {
		this.pageBean.setCurrentPage(page);
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	// 网站首页
	public String index() {
		// 查询最近的新闻记录
		List<New> latestNewList = newService.findLatestNews();
		// 查询正在进行的活动
		List<Activity> onDoingActivityList = activityService.findOnDoing(5);
		// 查询将要进行的活动
		List<Activity> willDoActivityList = activityService.findWillDo(5);
		
		ActionContext.getContext().put("latestNewList", latestNewList);
		ActionContext.getContext().put("onDoingActivityList", onDoingActivityList);
		ActionContext.getContext().put("willDoActivityList", willDoActivityList);
		return "app_index";
	}
	
	// 用户登录
	public String login() {
		System.out.println("用户登录");
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		User existedUser = userService.login(user);
		if (existedUser != null) {
			// 登录成功
			ServletActionContext.getRequest().getSession().setAttribute(MyConstant.LOGINED_USER, existedUser);
			// 重定向到首页
			return "app_index_redirect";
		} else {
			// 失败
			ActionContext.getContext().put("errorInfo", "用户名或密码错误！");
			return "app_login";
		}
	}
	
	// 用户注册
	public String register() throws IOException {
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setEmail(email);
		user.setStatus(1);
		int status = 0; // 注册状态 0失败，1成功
		int res = userService.register(user);
		switch(res) {
			case 0:
				// 注册状态
				ActionContext.getContext().put("status", status);
				// 错误消息
				ActionContext.getContext().put("errorInfo", "注册失败");
				break;
			case 1:
				status = 1;
				ActionContext.getContext().put("status", status);
				ActionContext.getContext().put("errorInfo", "注册成功");
				break;
			default: break;
		}
		
		return "app_register";
	}
	
	// 新闻详情
	public String newDetail() {
		
		New n = newService.findById(id);
		ActionContext.getContext().put("theNew", n);
		
		return "app_newinfo";
	}
	// 新闻列表
	public String newList() {
		this.pageBean.setPageSize(5);
		// 构建离线查询对象
		DetachedCriteria criteria = DetachedCriteria.forClass(New.class);
		criteria.add(Restrictions.eq("status", 1));
		criteria.addOrder(Order.desc("create_time"));
		this.pageBean.setDetachedCriteria(criteria);
		
		// 分页查询新闻
		newService.pageQuery(pageBean);
		// 查询正在进行的活动
		List<Activity> onDoingActivityList = activityService.findOnDoing(5);
		// 查询将要进行的活动
		List<Activity> willDoActivityList = activityService.findWillDo(5);
		
		// 总页数
		int totalPage = pageBean.getTotal() % pageBean.getPageSize() == 0 ?
				pageBean.getTotal() / pageBean.getPageSize():
				pageBean.getTotal() / pageBean.getPageSize() + 1;
				
		ActionContext.getContext().put("newList", pageBean.getRows());
		ActionContext.getContext().put("currentPage", pageBean.getCurrentPage());
		ActionContext.getContext().put("totalPage", totalPage);
		ActionContext.getContext().put("onDoingActivityList", onDoingActivityList);
		ActionContext.getContext().put("willDoActivityList", willDoActivityList);
		
		return "app_newlist";
	}
	
}
