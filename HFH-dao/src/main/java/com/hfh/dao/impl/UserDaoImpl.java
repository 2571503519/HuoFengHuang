package com.hfh.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hfh.dao.UserDao;
import com.hfh.dao.base.impl.BaseDaoImpl;
import com.hfh.domain.User;

/**
 * 有关用户操作的持久层接口的实现类
 * @author 家乐
 *
 */
@Repository
public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao {
	
	@Override
	public User findUserByUsernameAndPassword(String username, String password) {
		String hql = "FROM User u WHERE u.username = ? AND u.password = ?";
		List<User> list = (List<User>) this.getHibernateTemplate().find(hql, username, password);
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

}
