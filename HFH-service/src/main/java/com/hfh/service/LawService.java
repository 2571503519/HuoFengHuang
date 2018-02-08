package com.hfh.service;

import com.hfh.domain.Law;
import com.hfh.utils.PageBean;

public interface LawService {

	void pageQuery(PageBean pageBean);

	void revokeLaws(String ids);

	void publishLaws(String ids);

	void deleteLaws(String ids);
	
	void save(Law model);

	Law findById(Long sense_id);

	void update(Law model);
	
}
