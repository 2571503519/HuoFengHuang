package com.hfh.service;

import com.hfh.domain.Admin;
import com.hfh.utils.PageBean;

public interface AdminService {
	
	/**
	 * 管理员登录
	 * @param admin 需要登录的管理员
	 * @return 从数据库查询并返回的管理员对象，存在则代表登录成功，否则登录失败
	 */
	Admin login(Admin admin);

	void editPassword(Long admin_id, String password);

	void pageQuery(PageBean pageBean);

	void save(Admin admin);

	void deleteBatch(String ids);
	
}
