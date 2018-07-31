package com.hfh.service;

import com.hfh.domain.User;

/**
 * 有关用户的服务层接口
 * @author 家乐
 *
 */
public interface UserService {
	/**
	 * 用户登录
	 * @param user 需要登录的用户
	 * @return 从数据库查询并返回的用户对象，存在则代表登录成功，否则登录失败
	 */
	User login(User user);

	int register(User user);

	User findById(Long user_id);
	
}
