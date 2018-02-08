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
	/**
	 * 管理员修改密码
	 * @param admin_id 
	 * @param password
	 */
	void editPassword(Long admin_id, String password);
	/**
	 * 管理员分页查询
	 * @param pageBean
	 */
	void pageQuery(PageBean pageBean);
	/**
	 * 保存管理员
	 * @param admin
	 */
	void save(Admin admin);
	/**
	 * 批量删除管理员（逻辑上删除，将标志位置为禁用状态）
	 * @param ids
	 */
	void deleteBatch(String ids);
	
}
