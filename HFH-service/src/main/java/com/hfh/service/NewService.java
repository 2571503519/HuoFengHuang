package com.hfh.service;

import com.hfh.domain.New;
import com.hfh.utils.PageBean;

public interface NewService {
	/**
	 * 新闻的分页查询
	 * @param pageBean
	 */
	void pageQuery(PageBean pageBean);

	void publishNews(String ids);

	void revokeNews(String ids);

	void deleteNews(String ids);

	void save(New model);

	New findById(Long new_id);

	void update(New model);
	
}
