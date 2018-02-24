package com.hfh.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hfh.dao.NewDao;
import com.hfh.domain.New;
import com.hfh.service.NewService;
import com.hfh.utils.PageBean;

@Service
@Transactional
public class NewServiceImpl implements NewService {
	
	@Autowired
	private NewDao newDao;
	
	@Override
	public void pageQuery(PageBean pageBean) {
		newDao.pageQuery(pageBean);
	}

	@Override
	public void publishNews(String ids) {
		changeNewsStatus(ids, "new.publish");
	}

	@Override
	public void revokeNews(String ids) {
		changeNewsStatus(ids, "new.revoke");
	}

	@Override
	public void deleteNews(String ids) {
		changeNewsStatus(ids, "new.delete");
	}
	
	private void changeNewsStatus(String ids, String queryName) {
		if (StringUtils.isNotBlank(ids)) {
			String[] newIds = ids.split(",");
			for (String newId : newIds) {
				newDao.executeUpdate(queryName, Long.parseLong(newId));
			}
		}
	}

	@Override
	public void save(New model) {
		newDao.save(model);
	}

	@Override
	public New findById(Long new_id) {
		return newDao.findById(new_id);
	}

	@Override
	public void update(New model) {
		newDao.update(model);
	}

	@Override
	public List<New> findLatestNews() {
		// 查询最近添加的5条新闻
		return newDao.findOrdeByCreateTime(5);
	}

}
