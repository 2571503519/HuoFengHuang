package com.hfh.service;

import java.util.List;
import java.util.Set;

import com.hfh.domain.Activity;
import com.hfh.domain.ActivityVolunteer;
import com.hfh.domain.Volunteer;
import com.hfh.utils.PageBean;

public interface ActivityService {

	void pageQuery(PageBean pageBean);
	
	void revokeActivities(String ids);

	void publishActivities(String ids);

	void deleteActivities(String ids);
	
	void save(Activity model);

	Activity findById(Long act_id);

	void update(Activity model);
	
	List<ActivityVolunteer> listVolunteerById(Long act_id);

	void approval(Long actVol_id);
	
}
