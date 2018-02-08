package com.hfh.service;

import com.hfh.domain.Volunteer;
import com.hfh.utils.PageBean;

public interface VolunteerService {

	void pageQuery(PageBean pageBean);

	void revokeVolunteers(String ids);

	void publishVolunteers(String ids);

	void deleteVolunteers(String ids);
	
	void save(Volunteer model);

	Volunteer findById(Long vol_id);

	void update(Volunteer model);
	
}
