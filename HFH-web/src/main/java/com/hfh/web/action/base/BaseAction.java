package com.hfh.web.action.base;

import java.io.IOException;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import org.apache.poi.ss.formula.functions.T;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;

import com.hfh.utils.PageBean;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

/**
 * 表现层基类的抽取
 * @author 家乐
 *
 * @param <T>
 */
public class BaseAction<T> extends ActionSupport implements ModelDriven<T> {
	protected static final String HOME = "home";
	protected static final String LIST = "list";
		
	// 分页查询的抽取
	protected PageBean pageBean = new PageBean();
	// 在构造方法中创建对象，并设置到pageBean中
	DetachedCriteria detachedCriteria = null;
	// 接受请求传来的page参数
	public void setPage(int page) {
		pageBean.setCurrentPage(page);
	}
	// 接受请求传来的rows参数
	public void setRows(int rows) {
		pageBean.setPageSize(rows);
	}
	
	public void java2Json(Object obj, String[] excludes) {
		// 将查询出的pageBean转化成Json数据，通过输出流返回到页面中
		//JSONObject---将单一对象转为json
		//JSONArray----将数组或者集合对象转为json
		JsonConfig jsonConfig = new JsonConfig();
		//指定哪些属性不需要转json
		jsonConfig.setExcludes(excludes);
		String json = JSONObject.fromObject(obj, jsonConfig).toString();
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		try {
			ServletActionContext.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void java2Json(List obj, String[] excludes) {
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(excludes);
		String json = JSONArray.fromObject(obj, jsonConfig).toString();
		ServletActionContext.getResponse().setContentType("text/json;charset=utf-8");
		try {
			ServletActionContext.getResponse().getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	// 模型驱动的对象
	protected T model;
	
	@Override
	public T getModel() {
		return model;
	}
	
	public BaseAction() {
		// 由于模型驱动需要先创建对象，所以需要获取运行时的类型，通过反射创建对象
		ParameterizedType superclass = (ParameterizedType) this.getClass().getGenericSuperclass();
		Type[] actualTypeArguments = superclass.getActualTypeArguments();
		Class<T> entityClass = (Class<T>) actualTypeArguments[0];
		// 获取运行时的类型，创建离线查询对象
		detachedCriteria = DetachedCriteria.forClass(entityClass);
		// 将离线查询对象设置到pageBean中
		pageBean.setDetachedCriteria(detachedCriteria);
		try {
			model = entityClass.newInstance();
		} catch (InstantiationException | IllegalAccessException e) {
			e.printStackTrace();
		}
	}
	
}
