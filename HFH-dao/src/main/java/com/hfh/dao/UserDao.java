package com.hfh.dao;

import com.hfh.dao.base.BaseDao;
import com.hfh.domain.User;

/**
 * 关于用户操作的持久层接口
 * @author 家乐
 *
 */
public interface UserDao extends BaseDao<User> {
	/**
	 * 根据用户名、密码查找对应的用户。存在则返回查找到的用户对象，不存在则返回null
	 * @param username 用户名
	 * @param password 密码（加密后的）
	 * @return User:数据库中查找出来的用户对象，null:数据库中不存在改用户
	 */
	User findUserByUsernameAndPassword(String username, String password);

	User findUserByUsername(String username);
	
}
