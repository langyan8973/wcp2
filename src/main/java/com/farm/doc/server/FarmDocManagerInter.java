package com.farm.doc.server;

import java.util.List;

import com.farm.doc.domain.FarmDoc;
import com.farm.doc.domain.FarmDoctype;
import com.farm.doc.exception.CanNoDeleteException;
import com.farm.doc.exception.CanNoReadException;
import com.farm.doc.exception.CanNoWriteException;
import com.farm.doc.exception.DocNoExistException;
import com.farm.core.auth.domain.LoginUser;
import com.farm.core.sql.query.DataQuery;

/**
 * 文档管理
 * 
 * @author MAC_wd
 * 
 */
public interface FarmDocManagerInter {

	/**
	 * 获得一个分类的所有上层节点序列（包含该分类，有排序）
	 * 
	 * @param typeid
	 * @return
	 */
	public List<FarmDoctype> getTypeAllParent(String typeid);

	/**
	 *修改文档(不做权限控制)
	 * 
	 * @param entity
	 *            标题、发布时间、内容类型是必填 texts中的TEXT1中存放超文本内容
	 * @param editNote
	 *            修改时的注释
	 * @param user
	 *            操作用户
	 * @return
	 */
	public FarmDoc editDoc(FarmDoc entity, String editNote, LoginUser user);

	/**
	 *带权限的修改实体
	 * 
	 * @param entity
	 *            标题、发布时间、内容类型是必填 texts中的TEXT1中存放超文本内容
	 * @param editNote
	 *            修改备注(记录为啥修改)
	 * @param user
	 * @return
	 * @throws CanNoWriteException
	 */
	public FarmDoc editDocByUser(FarmDoc entity, String editNote, LoginUser user)
			throws CanNoWriteException;

	/**
	 *删除文档
	 * 
	 * @param entity
	 */
	public void deleteDoc(String entity, LoginUser user)
			throws CanNoDeleteException;

	/**
	 * 创建一个基本查询用来查询当前实体
	 * 
	 * @param query
	 *            传入的查询条件封装
	 * @return
	 */
	public DataQuery createSimpleDocQuery(DataQuery query);

	/**
	 * 创建文档
	 * 
	 * @param entity
	 *            标题、发布时间、内容类型是必填 texts中的TEXT1中存放超文本内容
	 * @param currentUser
	 * @return
	 */
	public FarmDoc createDoc(FarmDoc entity, LoginUser currentUser);

	/**
	 * 创建文档
	 * 
	 * @param entity
	 *            标题、发布时间、内容类型是必填 texts中的TEXT1中存放超文本内容
	 * @param type
	 *            文档的分类
	 * @param currentUser
	 * @return
	 */
	public FarmDoc createDoc(FarmDoc entity, FarmDoctype type,
			LoginUser currentUser);

	/**
	 * 创建文档
	 * 
	 * @param entity
	 *            标题、发布时间、内容类型是必填 texts中的TEXT1中存放超文本内容
	 * @param type
	 *            文档的分类
	 * @param currentUser
	 * @return
	 */
	public FarmDoc createDoc(FarmDoc entity, List<FarmDoctype> type,
			LoginUser currentUser);

	/**
	 * 获取文档数据(不判断权限)
	 * 
	 * @param id
	 * @return
	 */
	@Deprecated
	public FarmDoc getDoc(String id);

	/**
	 * 获取文档数据 判断权限
	 * 
	 * @param id
	 * @param user
	 *            阅读用户
	 * @return
	 */
	public FarmDoc getDoc(String id, LoginUser user) throws CanNoReadException,DocNoExistException;

	/**
	 * 获取文档数据
	 * 
	 * @param id
	 * @return
	 */
	public FarmDoc getDocOnlyBean(String id);


	/**
	 *新增实体
	 * 
	 * @param entity
	 */
	public FarmDoctype insertType(FarmDoctype entity, LoginUser user);

	/**
	 *修改分类
	 * 
	 * @param entity
	 */
	public FarmDoctype editType(FarmDoctype entity, LoginUser user);

	/**
	 *删除分类实体
	 * 
	 * @param entity
	 */
	public void deleteType(String entity, LoginUser user);

	/**
	 *获得分类实体
	 * 
	 * @param id
	 * @return
	 */
	public FarmDoctype getType(String id);

	/**
	 * 创建一个基本查询用来查询当前分类实体
	 * 
	 * @param query
	 *            传入的查询条件封装
	 * @return
	 */
	public DataQuery createSimpleTypeQuery(DataQuery query);

	/**
	 * 为文档对象赋初始值
	 * 
	 * @param doc
	 *            文档对象
	 * @param currentUser
	 *            当前用户
	 */
	public FarmDoc initDoc(FarmDoc doc, LoginUser currentUser);

	/**
	 * 更新文档的分类（唯一分类）将会清空doc的其它分类
	 * 
	 * @param docid
	 * @param typeId
	 */
	public void updateDocTypeOnlyOne(String docid, String typeId);

	

	/**
	 * 获得文档的版本信息
	 * 
	 * @param docId
	 * @return ID,ETIME,CUSERNAME,DOCID,PCONTENT
	 */
	public DataQuery getDocVersions(String docId);

	/**
	 * 获得文档版本信息
	 * 
	 * @param textId
	 * @param currentUser
	 * @return
	 */
	public FarmDoc getDocVersion(String textId, LoginUser currentUser);


}