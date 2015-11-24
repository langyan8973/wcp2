package com.farm.worm;

import java.util.List;
import java.util.Map;

import com.farm.worm.Worm.WORM_STATE;

public interface WormInter {

	/**
	 * 获得当前项目运行状态
	 * 
	 * @param proId
	 *            项目ID
	 * @param currentUser
	 *            当前状态
	 * @return {message日志,num1扫描完成,num2全部任务,num3下载完成}
	 */
	public String getState();

	public String getStateTitle();

	/**
	 * 获得当前爬虫日志
	 * 
	 * @return
	 */
	public List<String> getLogs();

	/**
	 * 获得当前任务统计DOCS待下载文档数、SEEDS待扫描种子数、DOWNLOADS已下载文档、SCANEDS已扫描文档、STA当前项目状态
	 * 
	 * @return
	 */
	public Map<String, Object> getStatNum();

	/**
	 * 初始化下载任务
	 * 
	 * @param proId
	 *            项目ID
	 * @param currentUser
	 *            当前用户
	 */
	public void runScanUrlTask();

	/**
	 * 开始下载任务
	 * 
	 * @param proId
	 *            项目ID
	 * @param currentUser
	 *            当前用户
	 */
	public void runDownloadTask();

	/**
	 * 停止任务
	 * 
	 * @param proId
	 *            项目ID
	 * @param currentUser
	 *            当前用户
	 */
	public void stop();

	/**
	 * 设置项目状态
	 * 
	 * @param state
	 */
	public void setState(WORM_STATE state);
}
