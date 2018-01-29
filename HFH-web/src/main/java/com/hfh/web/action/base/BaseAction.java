package com.hfh.web.action.base;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

import org.apache.poi.ss.formula.functions.T;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 表现层基类的抽取
 * @author 家乐
 *
 * @param <T>
 */
public class BaseAction<T> extends ActionSupport implements ModelDriven<T> {
	protected static final String HOME = "home";
	protected static final String LIST = "list";
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
		try {
			model = entityClass.newInstance();
		} catch (InstantiationException | IllegalAccessException e) {
			e.printStackTrace();
		}
	}
	
}
