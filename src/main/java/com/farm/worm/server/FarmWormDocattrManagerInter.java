package com.farm.worm.server;

import com.farm.worm.domain.FarmWormDocattr;
import com.farm.core.auth.domain.LoginUser;
import com.farm.core.sql.query.DataQuery;
/**下载内容
 * @author MAC_wd
 *
 */
public interface FarmWormDocattrManagerInter {
	/**
	 *新增下载内容实体
	 * 
	 * @param entity
	 */
	public FarmWormDocattr insertFarmWormDocattrEntity(FarmWormDocattr entity,LoginUser user);
	/**
	 *修改下载内容实体
	 * 
	 * @param entity
	 */
	public FarmWormDocattr editFarmWormDocattrEntity(FarmWormDocattr entity,LoginUser user);
	/**
	 *删除下载内容实体
	 * 
	 * @param entity
	 */
	public void deleteFarmWormDocattrEntity(String entity,LoginUser user);
	/**
	 *获得下载内容实体
	 * 
	 * @param id
	 * @return
	 */
	public FarmWormDocattr getFarmWormDocattrEntity(String id);
	/**
	 * 创建一个基本查询用来查询当前下载内容实体
	 * 
	 * @param query
	 *            传入的查询条件封装
	 * @return
	 */
	public DataQuery createFarmWormDocattrSimpleQuery(DataQuery query);
}