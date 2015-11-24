package com.farm.worm.server;


import com.farm.worm.domain.FarmWormProject;
import com.farm.core.auth.domain.LoginUser;
import com.farm.core.sql.query.DataQuery;

/**
 * 下载项目
 * 
 * @author MAC_wd
 * 
 */
public interface FarmWormProjectManagerInter {
	/**
	 *新增下载项目实体
	 * 
	 * @param entity
	 */
	public FarmWormProject insertFarmWormProjectEntity(FarmWormProject entity,
			LoginUser user);

	/**
	 *修改下载项目实体
	 * 
	 * @param entity
	 */
	public FarmWormProject editFarmWormProjectEntity(FarmWormProject entity,
			LoginUser user);

	/**
	 *删除下载项目实体
	 * 
	 * @param entity
	 */
	public void deleteFarmWormProjectEntity(String entity, LoginUser user);

	/**
	 *获得下载项目实体
	 * 
	 * @param id
	 * @return
	 */
	public FarmWormProject getFarmWormProjectEntity(String id);

	/**
	 * 创建一个基本查询用来查询当前下载项目实体
	 * 
	 * @param query
	 *            传入的查询条件封装
	 * @return
	 */
	public DataQuery createFarmWormProjectSimpleQuery(DataQuery query);


	
	/**
	 * 修改项目状态 1.未执行、2.扫描URL完成、3下载页面中、4完成、5异常
	 * 
	 * @param proId
	 * @param type
	 */
	public void editProjectState(String proId, String type);

	
}