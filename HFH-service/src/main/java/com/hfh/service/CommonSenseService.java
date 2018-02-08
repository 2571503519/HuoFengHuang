package com.hfh.service;

import com.hfh.domain.CommonSense;
import com.hfh.utils.PageBean;

public interface CommonSenseService {

	void pageQuery(PageBean pageBean);

	void revokeCommonSense(String ids);

	void publishCommonSense(String ids);

	void deleteCommonSense(String ids);

	void save(CommonSense model);

	CommonSense findById(Long sense_id);

	void update(CommonSense model);
	
}
