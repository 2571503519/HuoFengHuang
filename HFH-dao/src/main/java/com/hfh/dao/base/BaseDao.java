package com.hfh.dao.base;

import java.io.Serializable;
import java.util.List;

import com.hfh.utils.PageBean;

/**
 * 数据库持久层接口抽取
 * @author 家乐
 *
 * @param <T>
 */
public interface BaseDao<T> {
	// 增
	void save(T entity);
	// 删
	void delete(T entity);
	// 改
	void update(T entity);
	// 根据id查
	T findById(Serializable id);
	// 查询所有
	List<T> findAll();
	
	void executeUpdate(String queryName, Object...objects);
	
	void pageQuery(PageBean pageBean);
}
