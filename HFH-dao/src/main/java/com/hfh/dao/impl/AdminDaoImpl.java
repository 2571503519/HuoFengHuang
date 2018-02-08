package com.hfh.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hfh.dao.AdminDao;
import com.hfh.dao.base.impl.BaseDaoImpl;
import com.hfh.domain.Admin;

@Repository
public class AdminDaoImpl extends BaseDaoImpl<Admin> implements AdminDao {


	@Override
	public Admin findAdminByUsernameAndPassword(String username, String password) {
		// 用户名、密码都正确，并且账户处于启用状态，才能查询成功
		String hql = "FROM Admin a WHERE a.username = ? AND a.password = ? AND a.status = 1";
		List<Admin> list = (List<Admin>) this.getHibernateTemplate().find(hql, username, password);
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

}
