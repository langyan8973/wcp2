package com.farm.wcp.know.server;

import com.farm.core.auth.domain.LoginUser;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.doc.domain.FarmDoc;
import com.farm.doc.exception.CanNoWriteException;
import com.farm.doc.server.FarmDocOperateRightInter.POP_TYPE;

/**
 * 知识管理
 * 
 * @author MAC_wd
 * 
 */
public interface WcpKnowManagerInter {
	public static final String LUCENE_DIR = "KNOW";

	/**
	 * 用户创建一条知识
	 * 
	 * @param knowtitle
	 *            知识标题
	 * @param knowtype
	 *            知识分类
	 * @param text
	 *            知识内容
	 * @param knowtag
	 *            知识标签
	 * @param pop_type_edit
	 *            编辑权限
	 * @param pop_type_read
	 *            阅读权限
	 * @param groupId
	 *            小组id（可以为空）
	 * @param currentUser
	 *            当前操作用户
	 * @return 文档对象
	 */
	public FarmDoc creatKnow(String knowtitle, String knowtypeId, String text,
			String knowtag, POP_TYPE pop_type_edit, POP_TYPE pop_type_read,
			String groupId, LoginUser currentUser);

	/**
	 * 高级用户修改一条知识
	 * 
	 * @param id
	 *            知识主键
	 * @param knowtitle
	 *            标题
	 * @param knowtype
	 *            类型
	 * @param text
	 *            内容
	 * @param knowtag
	 * @param isWritePublic
	 * @param isReadPublic
	 * @param currentUser
	 * @param editNote
	 *            修改备注
	 * @return
	 */
	public FarmDoc editKnow(String id, String knowtitle, String knowtype,
			String text, String knowtag, POP_TYPE pop_type_edit,
			POP_TYPE pop_type_read, String groupId, LoginUser currentUser,
			String editNote) throws CanNoWriteException;
	/**
	 * 普通用户修改知识标签和内容
	 * 
	 * @param docid
	 *            知识主键
	 * @param text
	 *            内容
	 * @param knowtag
	 * @param currentUser
	 * @param editNote
	 *            修改备注
	 * @return
	 */
	public FarmDoc editKnow(String docid,
			String text, String knowtag, LoginUser currentUser,
			String editNote) throws CanNoWriteException;
	/**
	 * 展示最新知识
	 */
	public DataResult getNewKnowList(int pagesize);

	/**
	 * 展示分类下的知识
	 * 
	 * @param query
	 * @return
	 */
	public DataQuery getTypeDocQuery(DataQuery query);

	/**
	 * 展示当前用户的知识
	 * 
	 * @param query
	 * @return
	 */
	public DataQuery getMyDocQuery(DataQuery query, LoginUser user);

	/**
	 * 由网页获得一条知识
	 * 
	 * @param url
	 * @return
	 */
	public FarmDoc getDocByWeb(String url, LoginUser user);

	/**
	 * 获取知识分类信息（带分类下知识数量）
	 * 
	 * @param query
	 * @return
	 */
	public DataQuery getTypes(DataQuery query);

	/**获取知识分类详细信息（带分类下知识数量）（下级分类和下下级别分类）
	 * @param query
	 * @return
	 */
	public DataQuery getTypeInfos(String parentId);

}