package com.hfh.dao.impl;

import java.util.Date;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.hfh.dao.ActivityDao;
import com.hfh.dao.base.impl.BaseDaoImpl;
import com.hfh.domain.Activity;
import com.hfh.domain.ActivityVolunteer;

@Repository
public class ActivityDaoImpl extends BaseDaoImpl<Activity> implements ActivityDao {
	@SuppressWarnings("unchecked")
	@Override
	public List<ActivityVolunteer> listVolunteer(Long act_id) {
		String hql = "FROM ActivityVolunteer WHERE act_id = ?";
		List<ActivityVolunteer> list = (List<ActivityVolunteer>) this.getHibernateTemplate().find(hql, act_id);
		return list;
	}
	
	@Override
	public void saveActivityVolunteer(ActivityVolunteer activityVolunteer) {
		this.getHibernateTemplate().save(activityVolunteer);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Activity> findOnDoing(Date currentDate, int count) {
		DetachedCriteria criteria = DetachedCriteria.forClass(Activity.class);
		criteria.add(Restrictions.eq("status", 1));
		criteria.add(Restrictions.le("start_time", currentDate));
		criteria.add(Restrictions.ge("end_time", currentDate));
		criteria.addOrder(Order.desc("start_time"));
		return (List<Activity>) this.getHibernateTemplate()
				.findByCriteria(criteria, 0, count);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Activity> findWillDo(Date currentDate, int count) {
		DetachedCriteria criteria = DetachedCriteria.forClass(Activity.class);
		criteria.add(Restrictions.eq("status", 1));
		criteria.add(Restrictions.ge("start_time", currentDate));
		criteria.addOrder(Order.desc("start_time"));
		return (List<Activity>) this.getHibernateTemplate()
				.findByCriteria(criteria, 0, count);
	}
	
	
}
