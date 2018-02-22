package com.hfh.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hfh.dao.LawDao;
import com.hfh.domain.Law;
import com.hfh.service.LawService;
import com.hfh.utils.PageBean;

@Service
@Transactional
public class LawServiceImpl implements LawService {

	@Autowired
	private LawDao lawDao;
	
	@Override
	public void pageQuery(PageBean pageBean) {
		lawDao.pageQuery(pageBean);
	}

	@Override
	public void revokeLaws(String ids) {
		changeNewsStatus(ids, "law.revoke");
	}

	@Override
	public void publishLaws(String ids) {
		changeNewsStatus(ids, "law.publish");
	}

	@Override
	public void deleteLaws(String ids) {
		changeNewsStatus(ids, "law.delete");
	}
	
	private void changeNewsStatus(String ids, String queryName) {
		if (StringUtils.isNotBlank(ids)) {
			String[] newIds = ids.split(",");
			for (String newId : newIds) {
				lawDao.executeUpdate(queryName, Long.parseLong(newId));
			}
		}
	}
	
	@Override
	public void save(Law model) {
		lawDao.save(model);
	}

	@Override
	public Law findById(Long sense_id) {
		return lawDao.findById(sense_id);
	}

	@Override
	public void update(Law model) {
		lawDao.update(model);
	}


}
