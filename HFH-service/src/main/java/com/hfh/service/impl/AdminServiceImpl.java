package com.hfh.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hfh.dao.AdminDao;
import com.hfh.domain.Admin;
import com.hfh.service.AdminService;
import com.hfh.utils.MD5Util;
import com.hfh.utils.PageBean;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	// 自动注入
	private AdminDao adminDao;
	
	
	@Override
	public Admin login(Admin admin) {
		// 将用户输入的密码经过MD5加密后，再与数据库中的数据比较
		String password = MD5Util.md5(admin.getPassword());
		return adminDao.findAdminByUsernameAndPassword(admin.getUsername(), password);
	}


	@Override
	public void editPassword(Long admin_id, String password) {
		password = MD5Util.md5(password);
		adminDao.executeUpdate("admin.editpassword", password, admin_id);
	}


	@Override
	public void pageQuery(PageBean pageBean) {
		adminDao.pageQuery(pageBean);
	}


	@Override
	public void save(Admin admin) {
		admin.setPassword(MD5Util.md5(admin.getPassword()));
		adminDao.save(admin);
	}


	@Override
	public void deleteBatch(String ids) {
		if (StringUtils.isNotBlank(ids)) {
			String[] adminIds = ids.split(",");
			for (String id : adminIds) {
				adminDao.executeUpdate("admin.delete", Long.parseLong(id));
			}
		}
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
