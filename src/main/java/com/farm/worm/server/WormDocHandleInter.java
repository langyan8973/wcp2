package com.farm.worm.server;

import java.util.Map;

import com.farm.worm.domain.FarmWormProject;

/**
 * 下载器下载某个文档时执行的监听事件方法
 * 
 * @author wangdong
 * @version 201410
 */
public interface WormDocHandleInter {
	/**
	 * 下载器下载某个文档时执行的监听事件方法
	 * 
	 * @param doc
	 *            文档内容
	 * @param pro
	 *            下载项目信息
	 */
	public void handle(Map<String, String> doc, FarmWormProject pro,
			WormDocHandlePara appPara);

	/**
	 * 传递参数格式，将在页面上进行收集
	 * 
	 * @return
	 */
	public WormDocHandlePara getParaFormat();
}
