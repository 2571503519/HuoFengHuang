package com.hfh.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hfh.dao.VolunteerDao;
import com.hfh.domain.Volunteer;
import com.hfh.service.VolunteerService;
import com.hfh.utils.PageBean;

@Service
@Transactional
public class VolunteerServiceImpl implements VolunteerService {

	@Autowired
	private VolunteerDao volunteerDao;
	
	@Override
	public void pageQuery(PageBean pageBean) {
		volunteerDao.pageQuery(pageBean);
	}

	@Override
	public void revokeVolunteers(String ids) {
		changeVolunteersStatus(ids, "volunteer.revoke");
	}

	@Override
	public void publishVolunteers(String ids) {
		changeVolunteersStatus(ids, "volunteer.publish");
	}

	@Override
	public void deleteVolunteers(String ids) {
		changeVolunteersStatus(ids, "volunteer.delete");
	}
	
	private void changeVolunteersStatus(String ids, String queryName) {
		if (StringUtils.isNotBlank(ids)) {
			String[] actIds = ids.split(",");
			for (String actId : actIds) {
				volunteerDao.executeUpdate(queryName, Long.parseLong(actId));
			}
		}
	}
	
	@Override
	public void save(Volunteer model) {
		volunteerDao.save(model);
	}

	@Override
	public Volunteer findById(Long act_id) {
		return volunteerDao.findById(act_id);
	}

	@Override
	public void update(Volunteer model) {
		volunteerDao.update(model);
	}

	@Override
	public Long saveAndReturnId(Volunteer model) {
		return volunteerDao.saveAndReturnId(model);
	}


}
