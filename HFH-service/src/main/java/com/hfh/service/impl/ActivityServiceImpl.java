package com.hfh.service.impl;

import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hfh.dao.ActivityDao;
import com.hfh.domain.Activity;
import com.hfh.domain.ActivityVolunteer;
import com.hfh.domain.Volunteer;
import com.hfh.service.ActivityService;
import com.hfh.utils.PageBean;

@Service
@Transactional
public class ActivityServiceImpl implements ActivityService {

	@Autowired
	private ActivityDao activityDao;
	
	@Override
	public void pageQuery(PageBean pageBean) {
		activityDao.pageQuery(pageBean);
	}

	@Override
	public void revokeActivities(String ids) {
		changeActivitiesStatus(ids, "activity.revoke");
	}

	@Override
	public void publishActivities(String ids) {
		changeActivitiesStatus(ids, "activity.publish");
	}

	@Override
	public void deleteActivities(String ids) {
		changeActivitiesStatus(ids, "activity.delete");
	}
	
	private void changeActivitiesStatus(String ids, String queryName) {
		if (StringUtils.isNotBlank(ids)) {
			String[] actIds = ids.split(",");
			for (String actId : actIds) {
				activityDao.executeUpdate(queryName, Long.parseLong(actId));
			}
		}
	}
	
	@Override
	public void save(Activity model) {
		activityDao.save(model);
	}

	@Override
	public Activity findById(Long act_id) {
		return activityDao.findById(act_id);
	}

	@Override
	public void update(Activity model) {
		activityDao.update(model);
	}

	@Override
	public List<ActivityVolunteer> listVolunteerById(Long act_id) {
		return activityDao.listVolunteer(act_id);
	}

	@Override
	public void approval(Long actVol_id) {
		activityDao.executeUpdate("activityVolunteer.approval", actVol_id);
	}


}
