package com.hfh.dao;

import java.util.Date;
import java.util.List;
import java.util.Set;

import com.hfh.dao.base.BaseDao;
import com.hfh.domain.Activity;
import com.hfh.domain.ActivityVolunteer;
import com.hfh.domain.Volunteer;

public interface ActivityDao extends BaseDao<Activity>{
	
	List<ActivityVolunteer> listVolunteer(Long act_id);

	void saveActivityVolunteer(ActivityVolunteer activityVolunteer);
	
	List<Activity> findOnDoing(Date currentDate, int count);

	List<Activity> findWillDo(Date currentDate, int count);

}
