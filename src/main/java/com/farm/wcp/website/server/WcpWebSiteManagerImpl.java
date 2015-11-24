package com.farm.wcp.website.server;

import java.io.File;
import java.io.IOException;

import com.farm.core.FarmService;
import com.farm.core.auth.domain.LoginUser;
import com.farm.core.sql.query.DataQuery;
import com.farm.doc.domain.FarmDoc;
import com.farm.doc.domain.FarmDocfile;
import com.farm.doc.exception.CanNoWriteException;
import com.farm.doc.server.FarmDocManagerInter;
import com.farm.doc.server.FarmDocOperateRightInter;
import com.farm.doc.server.FarmFileManagerInter;
import com.farm.doc.server.FarmDocOperateRightInter.POP_TYPE;
import com.farm.doc.server.exception.NotIsHttpZipException;
import com.farm.lucene.FarmLuceneFace;
import com.farm.lucene.server.DocIndexInter;
import com.farm.wcp.know.common.DocTagUtils;
import com.farm.wcp.know.common.LuceneDocUtil;

public class WcpWebSiteManagerImpl implements WcpWebSiteManagerInter {
	private FarmDocManagerInter DocServer;
	private FarmFileManagerInter fileServer;
	private FarmLuceneFace luceneImpl = FarmLuceneFace.inctance();
	private FarmDocOperateRightInter farmDocOperate;

	public FarmDocManagerInter getDocServer() {
		return DocServer;
	}
	
	public FarmFileManagerInter getFileServer() {
		return fileServer;
	}

	public void setFileServer(FarmFileManagerInter fileServer) {
		this.fileServer = fileServer;
	}

	public void setDocServer(FarmDocManagerInter docServer) {
		DocServer = docServer;
	}

	public FarmLuceneFace getLuceneImpl() {
		return luceneImpl;
	}

	public void setLuceneImpl(FarmLuceneFace luceneImpl) {
		this.luceneImpl = luceneImpl;
	}

	public FarmDocOperateRightInter getFarmDocOperate() {
		return farmDocOperate;
	}

	public void setFarmDocOperate(FarmDocOperateRightInter farmDocOperate) {
		this.farmDocOperate = farmDocOperate;
	}

	@Override
	public HttpWebSite creatWebSite(String zipfileId, String title,
			String tags, String type, POP_TYPE POP_TYPE_read,
			POP_TYPE POP_TYPE_write, String describe, String groupId,
			LoginUser user) throws NotIsHttpZipException {
		FarmDoc entity = new FarmDoc();
		entity.setTitle(title);
		entity.setTagkey(tags);
		entity.setDocgroupid(groupId);
		entity.setTexts(describe, user);
		entity.setReadpop(POP_TYPE_read.getValue());
		entity.setWritepop(POP_TYPE_write.getValue());
		entity.setDomtype("3");
		FarmDocfile file = fileServer.getFile(zipfileId);
		// 验证zip是否可以解压是否有index.html
		if (!isHttpZip(file)) {
			throw new NotIsHttpZipException();
		}
		// 生成tags
		if (tags == null || tags.trim().length() <= 0) {// 自动生成tag
			entity.setTagkey(DocTagUtils.getTags(describe));
		} else {
			entity.setTagkey(tags);
		}
		DocServer.initDoc(entity, user);
		entity = DocServer.createDoc(entity, DocServer.getType(type), user);
		fileServer.addFileForDoc(entity.getId(), zipfileId, user);
		HttpWebSite website = new HttpWebSite(entity);
		try {
			website.indexUrl = initWebSite(file);
		} catch (IOException e) {
			throw new RuntimeException();
		}
		fileServer.submitFile(zipfileId);
		if (farmDocOperate.isAllUserRead(entity)) {
			try {
				DocIndexInter index = luceneImpl.getDocIndex(luceneImpl
						.getIndexPathFile(LUCENE_DIR));
				index.indexDoc(LuceneDocUtil.getDocMap(entity));
				index.close();
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		return website;
	}

	@Override
	public void delWebSite() {
		// TODO Auto-generated method stub

	}

	private boolean isHttpZip(FarmDocfile fileId) {
		if (fileId.getExname().toUpperCase().equals(".ZIP")) {
			return true;
		}
		return false;
	}

	@Override
	public String initWebSite(FarmDocfile zipfile) throws IOException {
		String directoryPath = FarmService.getInstance().getParameterService().getParameter("farm.constant.webroot.path")
				+ File.separator + "httpsite" + File.separator
				+ zipfile.getCtime().substring(0, 6) + File.separator
				+ zipfile.getId() + File.separator;// 解压目录
		if ((new File(directoryPath + "index.html")).isFile()) {
			return "httpsite" + "/" + zipfile.getCtime().substring(0, 6) + "/"
					+ zipfile.getId() + "/" + "index.html";
		}
		try {
			ZipUtils.unHtmlZipFiles(zipfile, directoryPath);
		} catch (IOException ex) {
			throw ex;
		}
		if (!(new File(directoryPath + "index.html")).isFile()) {
			throw new RuntimeException("压缩文件中未包含index.html文件");
		}
		return "httpsite" + "/" + zipfile.getCtime().substring(0, 6) + "/"
				+ zipfile.getId() + "/" + "index.html";
	}

	@Override
	public DataQuery queryAll() {
		// TODO Auto-generated method stub
		return null;
	}

	public static File buildFile(String fileName, boolean isDirectory) {
		File target = new File(fileName);
		if (isDirectory) {
			target.mkdirs();
		} else {
			if (!target.getParentFile().exists()) {
				target.getParentFile().mkdirs();
				target = new File(target.getAbsolutePath());
			}
		}
		return target;
	}

	@Override
	public HttpWebSite getWebSite(String docid, LoginUser user) {
		HttpWebSite website = null;
		try {
			website = new HttpWebSite(DocServer.getDoc(docid, user));
			// 获得站点首页地址
			for (FarmDocfile file : fileServer.getAllFileForDoc(website.getId())) {
				if (file.getExname().toUpperCase().equals(".ZIP")) {
					website.indexUrl = initWebSite(file);
				}
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return website;
	}

	@Override
	public HttpWebSite editSite(String docid, String zipfileId, String knowtag,
			String text, LoginUser aloneUser, String editNote)
			throws NotIsHttpZipException, CanNoWriteException {
		FarmDoc doc = DocServer.getDocOnlyBean(docid);
		return editSite(docid, zipfileId, doc.getTitle(), knowtag, null,
				POP_TYPE.getEnum(doc.getReadpop()), POP_TYPE.getEnum(doc
						.getWritepop()), text, aloneUser, doc.getDocgroupid(), editNote);
	}

	@SuppressWarnings("deprecation")
	@Override
	public HttpWebSite editSite(String docid, String zipfileId,
			String knowtitle, String knowtag, String knowtype,
			POP_TYPE POP_TYPE_read, POP_TYPE POP_TYPE_write, String text,
			LoginUser aloneUser, String groupId, String editNote)
			throws NotIsHttpZipException, CanNoWriteException {
		FarmDoc entity = DocServer.getDoc(docid);
		
		if (entity.getDocgroupid() == null) {
			entity.setDocgroupid(groupId);
		}
		entity.setTitle(knowtitle);
		entity.setTagkey(knowtag);
		entity.setTexts(text, aloneUser);
		entity.setReadpop(POP_TYPE_read.getValue());
		entity.setWritepop(POP_TYPE_write.getValue());
		entity.setDomtype("3");
		entity.setDocdescribe(text.length() > 250 ? text.substring(0, 250)
				: text);
		FarmDocfile file = fileServer.getFile(zipfileId);
		// 验证zip是否可以解压是否有index.jsp
		if (!isHttpZip(file)) {
			throw new NotIsHttpZipException();
		}
		// 生成tags
		if (knowtag == null || knowtag.trim().length() <= 0) {// 自动生成tag
			entity.setTagkey(DocTagUtils.getTags(text));
		} else {
			entity.setTagkey(knowtag);
		}
		DocServer.initDoc(entity, aloneUser);
		if (knowtype != null) {
			DocServer.updateDocTypeOnlyOne(entity.getId(), knowtype);
		}
		entity = DocServer.editDocByUser(entity, editNote, aloneUser);
		{
			// 附件操作
			if (fileServer.containFileByDoc(entity.getId(), zipfileId)) {

			} else {
				fileServer.delAllFileForDoc(docid, ".zip", aloneUser);
				fileServer.addFileForDoc(entity.getId(), zipfileId, aloneUser);
			}
			// 看目录id是否用附件id命名的
		}

		HttpWebSite website = new HttpWebSite(entity);
		try {
			website.indexUrl = initWebSite(file);
		} catch (IOException e) {
			throw new RuntimeException();
		}
		fileServer.submitFile(zipfileId);
		if (farmDocOperate.isAllUserRead(entity)) {
			DocIndexInter index = null;
			try {
				index = luceneImpl.getDocIndex(luceneImpl
						.getIndexPathFile(LUCENE_DIR));
				index.deleteFhysicsIndex(entity.getId());
				if ("1".equals(entity.getReadpop())
						&& "1".equals(entity.getState())) {
					index.indexDoc(LuceneDocUtil.getDocMap(entity));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					index.close();
				} catch (Exception e) {
				}
			}
		}
		return website;
	}

}
