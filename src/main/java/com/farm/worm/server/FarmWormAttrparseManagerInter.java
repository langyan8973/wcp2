package com.farm.worm.server;

import java.util.List;

import com.farm.worm.domain.FarmWormAttrparse;
import com.farm.core.auth.domain.LoginUser;
import com.farm.core.sql.query.DataQuery;
/**任务属性
 * @author MAC_wd
 *
 */
public interface FarmWormAttrparseManagerInter {
	/**
	 *新增任务属性实体
	 * 
	 * @param entity
	 */
	public FarmWormAttrparse insertFarmWormAttrparseEntity(FarmWormAttrparse entity,LoginUser user);
	/**
	 *修改任务属性实体
	 * 
	 * @param entity
	 */
	public FarmWormAttrparse editFarmWormAttrparseEntity(FarmWormAttrparse entity,LoginUser user);
	/**
	 *删除任务属性实体
	 * 
	 * @param entity
	 */
	public void deleteFarmWormAttrparseEntity(String entity,LoginUser user);
	/**
	 *获得任务属性实体
	 * 
	 * @param id
	 * @return
	 */
	public FarmWormAttrparse getFarmWormAttrparseEntity(String id);
	/**
	 * 创建一个基本查询用来查询当前任务属性实体
	 * 
	 * @param query
	 *            传入的查询条件封装
	 * @return
	 */
	public DataQuery createFarmWormAttrparseSimpleQuery(DataQuery query);
	/**获得项目的解析器描述
	 * @param proId
	 * @return
	 */
	public List<FarmWormAttrparse> getParseByProId(String proId);
}