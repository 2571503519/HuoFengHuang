package com.hfh.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hfh.dao.UserDao;
import com.hfh.domain.User;
import com.hfh.service.UserService;
import com.hfh.utils.MD5Util;

@Service
@Transactional
public class UserServiceImpl implements UserService {
	
	@Autowired
	// 自动注入
	private UserDao userDao;
	
	
	@Override
	public User login(User user) {
		// 将用户输入的密码经过MD5加密后，再与数据库中的数据比较
		String password = MD5Util.md5(user.getPassword());
		return userDao.findUserByUsernameAndPassword(user.getUsername(), password);
	}


	@Override
	public int register(User user) {
		User existedUser = userDao.findUserByUsername(user.getUsername());
		if (existedUser != null) {
			return 0; // 用户名已被注册
		} else {
			user.setPassword(MD5Util.md5(user.getPassword()));
			userDao.save(user);
			return 1; // 用户注册成功
		}
	}


	@Override
	public User findById(Long user_id) {
		return userDao.findById(user_id);
	}

}
