package com.hfh.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.hfh.dao.NewDao;
import com.hfh.dao.base.impl.BaseDaoImpl;
import com.hfh.domain.New;
import com.hfh.utils.MyConstant;
import com.hfh.utils.PageBean;


@Repository
public class NewDaoImpl extends BaseDaoImpl<New> implements NewDao {

	@Override
	public List<New> findOrdeByCreateTime(int i) {
		DetachedCriteria criteria = DetachedCriteria.forClass(New.class);
		
		criteria.add(Restrictions.eq("status", 1));
		criteria.addOrder(Order.desc("create_time"));
		
		
		return (List<New>) this.getHibernateTemplate()
				.findByCriteria(criteria, 0, i);
	}

}
