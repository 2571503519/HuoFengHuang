package com.hfh.dao.base.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.springframework.orm.hibernate5.support.HibernateDaoSupport;

import com.hfh.dao.base.BaseDao;
import com.hfh.utils.PageBean;

/**
 * 数据库持久层抽取接口的实现类
 * @author 家乐
 *
 * @param <T>
 */
public class BaseDaoImpl<T> extends HibernateDaoSupport implements BaseDao<T> {
	// 运行时的实体类
	private Class<T> entityClass;
	
	@Resource
	//根据类型注入spring工厂中的会话工厂对象sessionFactory
	public void setMySessionFactory(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}
	
	public BaseDaoImpl() {
		// 获取带泛型的父类类型
		ParameterizedType superclass = (ParameterizedType) this.getClass().getGenericSuperclass();
		// 获取父类上声明的泛型数组
		Type[] typeArguments = superclass.getActualTypeArguments();
		// 获取泛型实际运行时对应的实体类型
		entityClass = (Class<T>) typeArguments[0];
	}
	
	@Override
	public void save(T entity) {
		this.getHibernateTemplate().save(entity);
	}

	@Override
	public void delete(T entity) {
		this.getHibernateTemplate().delete(entity);
	}

	@Override
	public void update(T entity) {
		this.getHibernateTemplate().update(entity);
	}

	@Override
	public T findById(Serializable id) {
		return this.getHibernateTemplate().get(entityClass, id);
	}

	@Override
	public List<T> findAll() {
		String hql = "FROM " + entityClass.getSimpleName();
		return (List<T>) this.getHibernateTemplate().find(hql);
	}

	@Override
	public void executeUpdate(String queryName, Object... objects) {
		// 获取当前线程相关联的session
		Session session = this.getSessionFactory().getCurrentSession();
		// 获取在hbm文件中设置的SQL语句
		Query query = session.getNamedQuery(queryName);
		// 设置参数
		int i = 0;
		for (Object object : objects) {
			query.setParameter(i++, object);
		}
		// 执行
		query.executeUpdate();
	}

	@Override
	public void pageQuery(PageBean pageBean) {
		// 获取当前页、页面显示条数、离线查询对象
		int currentPage = pageBean.getCurrentPage();
		int pageSize = pageBean.getPageSize();
		DetachedCriteria detachedCriteria = pageBean.getDetachedCriteria();
		// 设置聚合函数，查询总记录数，并设置到pageBean中
		detachedCriteria.setProjection(Projections.rowCount());
		List<Long> countList = (List<Long>) this.getHibernateTemplate().findByCriteria(detachedCriteria);
		Long count = countList.get(0);
		pageBean.setTotal(count.intValue());
		// 清空设置的聚合函数
		detachedCriteria.setProjection(null);
		// 设置分页查询条件，查询分页数据，并设置到pageBean中
		int firstResult = (currentPage -1) * pageSize;
		int maxResults = pageSize;
		List rows = this.getHibernateTemplate().findByCriteria(detachedCriteria, firstResult, maxResults);
		pageBean.setRows(rows);
	}

	@Override
	public void saveOrUpdate(T entity) {
		this.getHibernateTemplate().saveOrUpdate(entity);
	}

	
	
	
	
	
	
	
	
	
	
	
}
