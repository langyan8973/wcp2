package com.farm.doc.server;

import com.farm.core.auth.domain.LoginUser;
import com.farm.core.sql.query.DataQuery;
import com.farm.doc.domain.FarmDocruninfo;

/**
 * 文档用量接口
 * 
 * @author 王东
 * @version 20140902
 */
public interface FarmDocRunInfoInter {
	/**
	 * 用户访问知识
	 * 
	 * @param docId
	 */
	public void visitDoc(String docId, LoginUser user,String ip);

	/**
	 * 收藏一片文章
	 */
	public void enjoyDoc(String userId, String docId);

	/**
	 * 取消收藏一片文章
	 */
	public void unEnjoyDoc(String userId, String docId);

	/**
	 * 用户是否收藏一篇文章
	 * 
	 * @return
	 */
	public boolean isEnjoyDoc(String userId, String docId);

	/**
	 * 获得用户收藏的文章
	 * 
	 * @return
	 */
	public DataQuery getUserEnjoyDoc(String userId);

	/**
	 * 重新计算文章热度
	 * 
	 * @param userId
	 * @param docId
	 */
	public void reCountDocHotNum(String docId);

	/**
	 * 给文档一个好评（登录用户）必须配合loadRunInfo使用
	 * 
	 * @param docId
	 * @param user
	 */
	public void praiseDoc(String docId, LoginUser user, String IP);

	/**
	 * 给文档一个好评（未登录用户）必须配合loadRunInfo使用
	 * 
	 * @param docId
	 * @param IP
	 */
	public void praiseDoc(String docId, String IP);

	/**
	 * 给文档一个差评（登录用户）必须配合loadRunInfo使用
	 * 
	 * @param docId
	 * @param user
	 */
	public void criticalDoc(String docId, LoginUser user, String IP);

	/**
	 * 给文档一个差评（未登录用户）必须配合loadRunInfo使用
	 * 
	 * @param docId
	 * @param IP
	 */
	public void criticalDoc(String docId, String IP);

	/**
	 * 更新和加载计算用量信息
	 * 
	 * @param docId
	 * @return
	 */
	public FarmDocruninfo loadRunInfo(String docId);
}
