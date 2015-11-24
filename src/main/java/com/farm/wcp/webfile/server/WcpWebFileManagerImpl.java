package com.farm.wcp.webfile.server;

import com.farm.core.auth.domain.LoginUser;
import com.farm.doc.domain.FarmDoc;
import com.farm.doc.exception.CanNoWriteException;
import com.farm.doc.server.FarmDocManagerInter;
import com.farm.doc.server.FarmDocOperateRightInter;
import com.farm.doc.server.FarmFileManagerInter;
import com.farm.doc.server.FarmDocOperateRightInter.POP_TYPE;
import com.farm.lucene.FarmLuceneFace;
import com.farm.lucene.server.DocIndexInter;
import com.farm.wcp.know.common.LuceneDocUtil;

public class WcpWebFileManagerImpl implements WcpWebFileManagerInter {
	private FarmDocManagerInter DocServer;
	private FarmFileManagerInter fileServer;
	private FarmLuceneFace luceneImpl = FarmLuceneFace.inctance();
	private FarmDocOperateRightInter farmDocOperate;

	@Override
	public String creatWebFile(String fileid, String typeId, String fileName,
			String tag, String groupId, POP_TYPE editPop, POP_TYPE readPop,
			LoginUser currentUser) {
		FarmDoc doc = new FarmDoc();
		doc.setTitle(fileName);
		doc.setTagkey(tag);
		doc.setDomtype("5");
		doc.setDocgroupid(groupId);
		doc.setReadpop(readPop.getValue());
		doc.setWritepop(editPop.getValue());
		doc.setTexts(fileName, currentUser);
		doc = DocServer.initDoc(doc, currentUser);
		doc = DocServer.createDoc(doc, DocServer.getType(typeId), currentUser);
		fileServer.addFileForDoc(doc.getId(), fileid, currentUser);
		fileServer.submitFile(fileid);
		if (farmDocOperate.isAllUserRead(doc)) {
			try {
				DocIndexInter index = luceneImpl.getDocIndex(luceneImpl
						.getIndexPathFile(LUCENE_DIR));
				index.indexDoc(LuceneDocUtil.getDocMap(doc));
				index.close();
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		return doc.getId();
	}

	public FarmDocManagerInter getDocServer() {
		return DocServer;
	}

	public void setDocServer(FarmDocManagerInter docServer) {
		DocServer = docServer;
	}

	public FarmFileManagerInter getFileServer() {
		return fileServer;
	}

	public void setFileServer(FarmFileManagerInter fileServer) {
		this.fileServer = fileServer;
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
	public String editWebFile(String docid, String fileid, String typeId,
			String fileName, String tag, String groupId, POP_TYPE editPop,
			POP_TYPE readPop, LoginUser currentUser) {
		FarmDoc doc = DocServer.getDoc(docid);
		doc.setTitle(fileName);
		doc.setTagkey(tag);
		doc.setDomtype("5");
		doc.setDocgroupid(groupId);
		doc.setReadpop(readPop.getValue());
		doc.setWritepop(editPop.getValue());
		doc.setTexts(fileName, currentUser);
		try {
			doc = DocServer.editDocByUser(doc, "用户修改", currentUser);
		} catch (CanNoWriteException e) {
			throw new RuntimeException(e);
		}
		if (!fileid.equals(doc.getFiles().get(0).getId())) {
			fileServer.delFile(doc.getFiles().get(0).getId(), currentUser);
			fileServer.cancelFile(doc.getFiles().get(0).getId());
			fileServer.addFileForDoc(doc.getId(), fileid, currentUser);
			fileServer.submitFile(fileid);
		}
		if (farmDocOperate.isAllUserRead(doc)) {
			DocIndexInter index = null;
			try {
				index = luceneImpl.getDocIndex(luceneImpl
						.getIndexPathFile(LUCENE_DIR));
				index.deleteFhysicsIndex(doc.getId());
				if ("1".equals(doc.getReadpop()) && "1".equals(doc.getState())) {
					index.indexDoc(LuceneDocUtil.getDocMap(doc));
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
		return doc.getId();
	}

}
