package com.farm.wcp.website.server;

import java.io.IOException;

import com.farm.core.auth.domain.LoginUser;
import com.farm.core.sql.query.DataQuery;
import com.farm.doc.domain.FarmDocfile;
import com.farm.doc.exception.CanNoWriteException;
import com.farm.doc.server.FarmDocOperateRightInter.POP_TYPE;
import com.farm.doc.server.exception.NotIsHttpZipException;

public interface WcpWebSiteManagerInter {
	public static final String LUCENE_DIR = "HTTPSITE";

	/**
	 * 创建站点
	 * 
	 * @param describe
	 *            描述
	 * @param writetype
	 *            写入权限
	 * @param readtype
	 *            读取权限
	 * @param type
	 *            分类
	 * @param tags
	 *            标签
	 * @param title
	 *            标题
	 * @param zipfileId
	 *            zip文件id
	 * @param user
	 *            当前用户
	 */
	public HttpWebSite creatWebSite(String zipfileId, String title,
			String tags, String type, POP_TYPE POP_TYPE_read,
			POP_TYPE POP_TYPE_write, String describe, String groupId,
			LoginUser user) throws NotIsHttpZipException;

	/**
	 * 访问站点
	 * 
	 * @param docid
	 *            站点id
	 * @pdOid f1a28c5e-89a8-4884-8f1f-143090593c8b
	 */
	public HttpWebSite getWebSite(String docid, LoginUser user);

	/**
	 * 查询现有站点
	 * 
	 * @pdOid 848a3196-6339-4553-bbfb-5e8236305731
	 */
	public DataQuery queryAll();

	/**
	 * 反回站点首页地址,如果未存在则将站点解析为可访问的临时目录()
	 * 
	 * @param zipfile
	 * @param doc
	 * @return url地址
	 * @throws IOException
	 */
	public String initWebSite(FarmDocfile zipfile) throws IOException;

	/**
	 * 删除站点
	 * 
	 * @pdOid b10c6ccb-af20-4606-83ed-c2d7bb94dc8e
	 */
	public void delWebSite();

	/**
	 * 高级权限用户更新站点
	 * 
	 * @param docid
	 *            文档Id
	 * @param zipfileId
	 *            站点压缩包
	 * @param knowtitle
	 *            站点标题
	 * @param knowtag
	 *            站点标签
	 * @param knowtype
	 *            站点分类
	 * @param POP_TYPE_read
	 *            阅读权限
	 * @param POP_TYPE_write
	 *            修改权限
	 * @param text
	 *            描述
	 * @param aloneUser
	 *            当前用户
	 * @param groupId
	 *            小组ID
	 * @param editNote
	 *            (修改备注，为什么要修改)
	 * @return
	 * @throws NotIsHttpZipException
	 * @throws CanNoWriteException
	 */
	public HttpWebSite editSite(String docid, String zipfileId,
			String knowtitle, String knowtag, String knowtype,
			POP_TYPE POP_TYPE_read, POP_TYPE POP_TYPE_write, String text,
			LoginUser aloneUser, String groupId, String editNote)
			throws NotIsHttpZipException, CanNoWriteException;

	/**
	 * 低级权限用户更新站点
	 * 
	 * @param docid
	 *            文档Id
	 * @param zipfileId
	 *            站点压缩包
	 * @param knowtag
	 *            知识标签
	 * @param text
	 *            描述
	 * @param aloneUser
	 *            当前用户
	 * @param groupId
	 *            小组ID
	 * @param editNote
	 *            (修改备注，为什么要修改)
	 * @return
	 * @throws NotIsHttpZipException
	 * @throws CanNoWriteException
	 */
	public HttpWebSite editSite(String docid, String zipfileId, String knowtag,
			String text, LoginUser aloneUser, String editNote)
			throws NotIsHttpZipException, CanNoWriteException;
}
