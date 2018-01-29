package com.hfh.dao;

import com.hfh.dao.base.BaseDao;
import com.hfh.domain.Admin;
import com.hfh.domain.User;
import com.hfh.utils.PageBean;

public interface AdminDao extends BaseDao<Admin>  {
	
	
	Admin findAdminByUsernameAndPassword(String username, String password);


	
	
}
