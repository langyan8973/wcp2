package com.farm.worm.server;

import java.util.List;

import com.farm.worm.domain.FarmWormProject;
import com.farm.worm.domain.FarmWormTask;
import com.farm.worm.server.common.WebPage;
import com.farm.core.auth.domain.LoginUser;
import com.farm.core.sql.query.DataQuery;

/**
 * 任务
 * 
 * @author MAC_wd
 * 
 */
public interface FarmWormTaskManagerInter {
	/**
	 *新增任务实体
	 * 
	 * @param entity
	 */
	public FarmWormTask insertFarmWormTaskEntity(FarmWormTask entity,
			LoginUser user);

	/**
	 *修改任务实体
	 * 
	 * @param entity
	 */
	public FarmWormTask editFarmWormTaskEntity(FarmWormTask entity,
			LoginUser user);

	/**
	 *删除任务实体
	 * 
	 * @param entity
	 */
	public void deleteFarmWormTaskEntity(String entity, LoginUser user);

	/**
	 *获得任务实体
	 * 
	 * @param id
	 * @return
	 */
	public FarmWormTask getFarmWormTaskEntity(String id);

	/**
	 * 创建一个基本查询用来查询当前任务实体
	 * 
	 * @param query
	 *            传入的查询条件封装
	 * @return
	 */
	public DataQuery createFarmWormTaskSimpleQuery(DataQuery query);

	/**
	 * 获得下载完成的任务数
	 * 
	 * @param proId
	 * @return
	 */
	public int getDownLoadedNum(String proId);

	/**
	 * 获得扫描完成的种子数
	 * 
	 * @param proId
	 * @return
	 */
	public int getScanedNum(String proId);

	/**
	 * 获得种子任务数
	 * 
	 * @param id
	 * @return
	 */
	public int getSeedTaskNum(String proId);

	/**
	 * 获得下载任务数
	 * 
	 * @param id
	 * @return
	 */
	public int getDocTaskNum(String proId);

	/**
	 * 生成一个任务页面到数据库
	 * 
	 * @param page
	 *            页面对象
	 * @param pro
	 *            抓取项目对象
	 * @param currentUser
	 */
	public void insertTaskPage(WebPage page, FarmWormProject pro,
			LoginUser currentUser);

	/**
	 * 获取等待扫描的任务
	 * 
	 * @param proid
	 * @return
	 */
	public List<FarmWormTask> getInitTasks(String proid);

	/**
	 * 获取等待下载的任务
	 * 
	 * @param proid
	 * @return
	 */
	public List<FarmWormTask> getDocTaskings(String proid);

	/**
	 * 修改任务状态 1.未开始，2正在，3完成,4异常
	 * 
	 * @param proId
	 * @param type
	 */
	public void editTaskState(String proId, String type);
	/**
	 * 删除项目的所有任务
	 * 
	 * @param proId
	 */
	public void clearTask(String proId);
	/**
	 * 清除URL过滤缓存缓存
	 */
	public void clearUrlCatch();

	/**初始化异常任务为未开始任务
	 * @param proid
	 */
	public void initErrorTask(String proid);
}