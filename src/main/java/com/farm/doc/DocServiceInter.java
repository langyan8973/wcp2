package com.farm.doc;

import com.farm.doc.server.FarmDocManagerInter;
import com.farm.doc.server.FarmDocOperateRightInter;
import com.farm.doc.server.FarmDocRunInfoInter;
import com.farm.doc.server.FarmDocgroupManagerInter;
import com.farm.doc.server.FarmDocmessageManagerInter;
import com.farm.doc.server.FarmFileManagerInter;

public interface DocServiceInter {
	/**
	 * 获得文档的小组服务
	 * 
	 * @return
	 */
	public FarmDocgroupManagerInter getGroupService();

	/**
	 * 获得文章服务
	 * 
	 * @return
	 */
	public FarmDocManagerInter getDocService();

	/**
	 * 获得文档留言等消息服务
	 * 
	 * @return
	 */
	public FarmDocmessageManagerInter getMessageService();

	/**
	 * 获得文章权限服务
	 * 
	 * @return
	 */
	public FarmDocOperateRightInter getOperateRightService();

	/**
	 * 获得文章使用信息服务
	 * 
	 * @return
	 */
	public FarmDocRunInfoInter getRunInfoService();

	/**
	 * 获得附件服务
	 * 
	 * @return
	 */
	public FarmFileManagerInter getFileService();

}
