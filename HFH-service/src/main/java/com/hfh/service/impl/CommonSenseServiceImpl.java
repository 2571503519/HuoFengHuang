package com.hfh.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hfh.dao.CommonSenseDao;
import com.hfh.domain.CommonSense;
import com.hfh.service.CommonSenseService;
import com.hfh.utils.PageBean;

@Service
@Transactional
public class CommonSenseServiceImpl implements CommonSenseService {
	
	@Autowired
	private CommonSenseDao commonSenseDao;

	@Override
	public void pageQuery(PageBean pageBean) {
		commonSenseDao.pageQuery(pageBean);
	}

	@Override
	public void publishCommonSense(String ids) {
		changeNewsStatus(ids, "commonSense.publish");
	}

	@Override
	public void revokeCommonSense(String ids) {
		changeNewsStatus(ids, "commonSense.revoke");
	}

	@Override
	public void deleteCommonSense(String ids) {
		changeNewsStatus(ids, "commonSense.delete");
	}
	
	private void changeNewsStatus(String ids, String queryName) {
		if (StringUtils.isNotBlank(ids)) {
			String[] newIds = ids.split(",");
			for (String newId : newIds) {
				commonSenseDao.executeUpdate(queryName, Long.parseLong(newId));
			}
		}
	}

	@Override
	public void save(CommonSense model) {
		commonSenseDao.save(model);
	}

	@Override
	public CommonSense findById(Long sense_id) {
		return commonSenseDao.findById(sense_id);
	}

	@Override
	public void update(CommonSense model) {
		commonSenseDao.update(model);
	}

}
