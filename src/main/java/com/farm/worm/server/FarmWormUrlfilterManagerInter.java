package com.farm.worm.server;

import java.util.List;

import com.farm.worm.domain.FarmWormUrlfilter;
import com.farm.core.auth.domain.LoginUser;
import com.farm.core.sql.query.DataQuery;

/**
 * URL过滤器类功能说明
 * 
 * @author 作者:自动生成
 * @version 日期(用日期代替版本号)+版本备注
 */
public interface FarmWormUrlfilterManagerInter {
	/**
	 *新增URL过滤器实体
	 * 
	 * @param entity
	 */
	public FarmWormUrlfilter insertFarmWormUrlfilterEntity(
			FarmWormUrlfilter entity, LoginUser user);

	/**
	 *修改URL过滤器实体
	 * 
	 * @param entity
	 */
	public FarmWormUrlfilter editFarmWormUrlfilterEntity(
			FarmWormUrlfilter entity, LoginUser user);

	/**
	 *删除URL过滤器实体
	 * 
	 * @param entity
	 */
	public void deleteFarmWormUrlfilterEntity(String entity, LoginUser user);

	/**
	 *获得URL过滤器实体
	 * 
	 * @param id
	 * @return
	 */
	public FarmWormUrlfilter getFarmWormUrlfilterEntity(String id);

	/**
	 * 创建一个基本查询用来查询当前URL过滤器实体
	 * 
	 * @param query
	 *            传入的查询条件封装
	 * @return
	 */
	public DataQuery createFarmWormUrlfilterSimpleQuery(DataQuery query);

	/**
	 * 获得项目的所有过滤器
	 * 
	 * @param proId
	 * @return
	 */
	public List<FarmWormUrlfilter> getFiltersByProId(String proId);
}