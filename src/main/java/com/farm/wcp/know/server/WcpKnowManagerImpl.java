package com.farm.wcp.know.server;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.farm.core.FarmService;
import com.farm.core.auth.domain.LoginUser;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DBSort;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.query.DataQuery.CACHE_UNIT;
import com.farm.core.sql.result.DataResult;
import com.farm.doc.domain.FarmDoc;
import com.farm.doc.domain.FarmDocfile;
import com.farm.doc.exception.CanNoWriteException;
import com.farm.doc.server.FarmDocManagerInter;
import com.farm.doc.server.FarmDocOperateRightInter;
import com.farm.doc.server.FarmFileManagerInter;
import com.farm.doc.server.FarmDocOperateRightInter.POP_TYPE;
import com.farm.lucene.FarmLuceneFace;
import com.farm.lucene.face.WordAnalyzerFace;
import com.farm.lucene.server.DocIndexInter;
import com.farm.util.web.FarmFormatUnits;
import com.farm.wcp.know.common.DocTagUtils;
import com.farm.wcp.know.common.LuceneDocUtil;
import com.farm.wcp.know.common.HttpResourceHandle;
import com.farm.wcp.know.server.WebDocInter.DOC_TYPE;

/**
 * 文档管理
 * 
 * @author MAC_wd
 */
public class WcpKnowManagerImpl implements WcpKnowManagerInter {
	private FarmDocManagerInter DocServer;
	private FarmFileManagerInter fileServer;
	private FarmLuceneFace luceneImpl = FarmLuceneFace.inctance();
	private FarmDocOperateRightInter farmDocOperate;

	public FarmDocOperateRightInter getFarmDocOperate() {
		return farmDocOperate;
	}

	public void setFarmDocOperate(FarmDocOperateRightInter farmDocOperate) {
		this.farmDocOperate = farmDocOperate;
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

	@Override
	public FarmDoc creatKnow(String knowtitle, String knowtypeId, String text, String knowtag, POP_TYPE pop_type_edit,
			POP_TYPE pop_type_read, String groupId, LoginUser currentUser) {
		FarmDoc doc = new FarmDoc();
		doc.setTitle(knowtitle);
		doc.setTexts(text, currentUser);
		doc.setWritepop(pop_type_edit.getValue());
		doc.setDocgroupid(groupId);
		doc.setReadpop(pop_type_read.getValue());
		if (knowtag == null || knowtag.trim().length() <= 0) {// 自动生成tag
			doc.setTagkey(DocTagUtils.getTags(text));
		} else {
			doc.setTagkey(knowtag);
		}
		doc = DocServer.initDoc(doc, currentUser);
		doc = DocServer.createDoc(doc, DocServer.getType(knowtypeId), currentUser);
		if (knowtypeId != null && knowtypeId.trim().length() > 0) {
			doc.setCurrenttypes(DocServer.getTypeAllParent(knowtypeId));
		}
		if (farmDocOperate.isAllUserRead(doc)) {
			try {
				DocIndexInter index = luceneImpl.getDocIndex(luceneImpl.getIndexPathFile(LUCENE_DIR));
				index.indexDoc(LuceneDocUtil.getDocMap(doc));
				index.close();
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		return doc;
	}

	@Override
	public DataResult getNewKnowList(int pagesize) {
		DataQuery query = DataQuery
				.getInstance(
						"1",
						"a.ID as ID,a.TITLE AS title,a.CUSER as CUSER,a.DOCDESCRIBE AS DOCDESCRIBE,DOMTYPE,a.AUTHOR AS AUTHOR,a.PUBTIME AS PUBTIME,a.TAGKEY AS TAGKEY ,a.IMGID AS IMGID,b.VISITNUM AS VISITNUM,b.PRAISEYES AS PRAISEYES,b.PRAISENO AS PRAISENO,b.HOTNUM AS HOTNUM,d.NAME AS TYPENAME,e.IMGID AS PHOTOID,A.ETIME AS ETIME",
						"farm_doc a LEFT JOIN farm_docruninfo b ON a.RUNINFOID=b.ID LEFT JOIN farm_rf_doctype c ON c.DOCID=a.ID LEFT JOIN farm_doctype d ON d.ID=c.TYPEID   LEFT JOIN ALONE_AUTH_USER e ON e.ID=a.CUSER");
		query.addRule(new DBRule("a.READPOP", "1", "="));
		query.addRule(new DBRule("a.STATE", "1", "="));
		query.addSort(new DBSort("a.etime", "desc"));
		query.setPagesize(pagesize);
		query.setNoCount();
		DataResult result = null;
		try {
			result = query.search();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		for (Map<String, Object> node : result.getResultList()) {
			node.put("PUBTIME", FarmFormatUnits.getFormateTime(node.get("PUBTIME").toString(), true));
			String tags = node.get("TAGKEY") != null ? node.get("TAGKEY").toString() : null;
			if (tags != null && tags.trim().length() > 0) {
				String[] tags1 = tags.trim().replaceAll("，", ",").replaceAll("、", ",").split(",");
				node.put("TAGKEY", Arrays.asList(tags1));
			} else {
				node.put("TAGKEY", new ArrayList<String>());
			}
			node.put("DOCDESCRIBE", node.get("DOCDESCRIBE").toString().replaceAll("<", "").replaceAll(">", ""));
		}
		return result;
	}

	@Override
	public FarmDoc editKnow(String docid, String text, String knowtag, LoginUser currentUser, String editNote)
			throws CanNoWriteException {
		FarmDoc doc = DocServer.getDocOnlyBean(docid);
		return editKnow(docid, doc.getTitle(), null, text, knowtag, POP_TYPE.getEnum(doc.getWritepop()),
				POP_TYPE.getEnum(doc.getReadpop()), doc.getDocgroupid(), currentUser, editNote);
	}

	@SuppressWarnings("deprecation")
	@Override
	public FarmDoc editKnow(String id, String knowtitle, String knowtype, String text, String knowtag,
			POP_TYPE pop_type_edit, POP_TYPE pop_type_read, String groupId, LoginUser currentUser, String editNote)
			throws CanNoWriteException {
		FarmDoc entity = DocServer.getDoc(id);
		if (entity.getDocgroupid() == null) {
			entity.setDocgroupid(groupId);
		}
		entity.setTitle(knowtitle);
		entity.setTexts(text, currentUser);
		entity.setTagkey(knowtag);
		entity.setWritepop(pop_type_edit.getValue());
		entity.setReadpop(pop_type_read.getValue());
		entity = DocServer.editDocByUser(entity, editNote, currentUser);
		if (knowtype != null && knowtype.trim().length() > 0) {
			DocServer.updateDocTypeOnlyOne(id, knowtype);
			entity.setCurrenttypes(DocServer.getTypeAllParent(knowtype));
		}
		// 公开阅读就做索引，否则不做索引(删除索引)
		if (farmDocOperate.isAllUserRead(entity)) {
			DocIndexInter index = null;
			try {
				index = luceneImpl.getDocIndex(luceneImpl.getIndexPathFile(LUCENE_DIR));
				index.deleteFhysicsIndex(entity.getId());
				if ("1".equals(entity.getReadpop()) && "1".equals(entity.getState())) {
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
		} else {
			DocIndexInter index = null;
			try {
				index = luceneImpl.getDocIndex(luceneImpl.getIndexPathFile(LUCENE_DIR));
				index.deleteFhysicsIndex(entity.getId());
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					index.close();
				} catch (Exception e) {
				}
			}
		}
		return entity;
	}

	@Override
	public FarmDoc getDocByWeb(String url, LoginUser user) {
		FarmDoc doc = new FarmDoc();
		try {
			String[] webdocs = WebDocImpl.instance().crawlerWebDocTempFileId(new URL(url), DOC_TYPE.HTML,
					new HttpResourceHandle() {
						@Override
						public String handle(String eurl, URL baseUrl) {
							// eurl=http://img.baidu.com/img/baike/logo-baike.png
							String exname = null;
							try {
								if (eurl.lastIndexOf("?") > 0) {
									exname = eurl.substring(0, eurl.lastIndexOf("?"));
								} else {
									exname = eurl;
								}
								if (eurl.lastIndexOf(".") > 0) {
									exname = eurl.substring(eurl.lastIndexOf(".") + 1);
								} else {
									exname = eurl;
								}
								if (exname.length() > 10) {
									exname = "gif";
								}
								if (exname == null) {
									exname = "gif";
								}
							} catch (Exception e) {
								exname = "gif";
							}
							LoginUser thisuser = new LoginUser() {
								@Override
								public String getName() {
									return "NONE";
								}

								@Override
								public String getLoginname() {
									return "NONE";
								}

								@Override
								public String getId() {
									return "NONE";
								}
							};
							if (eurl.toUpperCase().indexOf("HTTP") < 0) {
								eurl = baseUrl.toString().substring(0, baseUrl.toString().lastIndexOf("/") + 1) + eurl;
							}
							try {
								URL innerurl = new URL(eurl);
								// 创建连接的地址
								HttpURLConnection connection = (HttpURLConnection) innerurl.openConnection();
								// 返回Http的响应状态码
								InputStream input = null;
								try {
									input = connection.getInputStream();
								} catch (Exception e) {
									System.out.println(e + e.getMessage());
									return eurl;
								}
								FarmDocfile file = fileServer.openFile(exname,
										eurl.length() > 128 ? eurl.substring(0, 128) : eurl, thisuser);
								OutputStream fos = new FileOutputStream(file.getFile());
								// 获取输入流
								try {
									int bytesRead = 0;
									byte[] buffer = new byte[8192];
									while ((bytesRead = input.read(buffer, 0, 8192)) != -1) {
										fos.write(buffer, 0, bytesRead);
									}
								} finally {
									input.close();
									fos.close();
								}
								// config.file.client.html.resource.url
								eurl = fileServer.getFileURL(file.getId());
							} catch (IOException e) {
								log.error(e + "网络图片文件保存失败");
							}
							System.out.println(eurl);
							return eurl;
						}
					});
			doc.setTitle(webdocs[1]);
			String tag = null;
			List<Object[]> taglist = WordAnalyzerFace.parseHtmlWordCaseForSortList(webdocs[0]);
			for (Object[] Object : taglist.size() > 10 ? taglist.subList(0, 10) : taglist) {
				if (tag != null) {
					tag = tag + ",";
				} else {
					tag = "";
				}
				tag = tag + Object[0];
			}
			doc.setTagkey(tag);
			doc.setTexts(webdocs[2], user);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return doc;
	}

	private static final Logger log = Logger.getLogger(WcpKnowManagerImpl.class);

	@Override
	public DataQuery getTypeDocQuery(DataQuery query) {
		query = DataQuery
				.init(query,
						"farm_doc a LEFT JOIN farm_docruninfo b ON a.RUNINFOID=b.ID LEFT JOIN farm_rf_doctype c ON c.DOCID=a.ID LEFT JOIN farm_doctype d ON d.ID=c.TYPEID",
						"a.ID as ID,a.TITLE AS title,a.DOCDESCRIBE AS DOCDESCRIBE,a.AUTHOR AS AUTHOR,a.PUBTIME AS PUBTIME,a.TAGKEY AS TAGKEY ,a.IMGID AS IMGID,b.VISITNUM AS VISITNUM,b.PRAISEYES AS PRAISEYES,b.PRAISENO AS PRAISENO,b.HOTNUM AS HOTNUM,b.EVALUATE as EVALUATE,b.ANSWERINGNUM as ANSWERINGNUM,d.NAME AS TYPENAME");
		query.addSort(new DBSort("a.etime", "desc"));
		query.addRule(new DBRule("a.STATE", "1", "="));
		return query;
	}

	@Override
	public DataQuery getTypes(DataQuery query) {
		query = DataQuery
				.init(query,
						"(SELECT a.NAME as NAME, a.ID as ID, a.PARENTID as PARENTID, (SELECT COUNT(B1.ID) FROM FARM_DOC B1 LEFT JOIN FARM_RF_DOCTYPE B2 ON B1.ID = B2.DOCID LEFT JOIN FARM_DOCTYPE B3 ON B3.ID = B2.TYPEID WHERE B3.TREECODE  LIKE CONCAT(A.TREECODE,'%') AND B1.STATE='1') AS NUM FROM farm_doctype AS a WHERE 1 = 1 AND (TYPE = '1' OR TYPE = '3') AND PSTATE = '1' ORDER BY SORT ASC) AS e",
						"NAME,ID,PARENTID,NUM");
		query.setPagesize(1000);
		query.setNoCount();
		query.setCache(
				Integer.valueOf(FarmService.getInstance().getParameterService().getParameter("config.wcp.cache.type")),
				CACHE_UNIT.minute);
		return query;
	}

	@Override
	public DataQuery getMyDocQuery(DataQuery query, LoginUser user) {
		query = DataQuery
				.init(query,
						"farm_doc a LEFT JOIN farm_docruninfo b ON a.RUNINFOID=b.ID LEFT JOIN farm_rf_doctype c ON c.DOCID=a.ID LEFT JOIN farm_doctype d ON d.ID=c.TYPEID",
						"a.ID as ID,a.STATE as STATE,a.TITLE AS title,a.DOCDESCRIBE AS DOCDESCRIBE,a.AUTHOR AS AUTHOR,a.PUBTIME AS PUBTIME,a.TAGKEY AS TAGKEY ,a.IMGID AS IMGID,b.VISITNUM AS VISITNUM,b.PRAISEYES AS PRAISEYES,b.PRAISENO AS PRAISENO,b.HOTNUM AS HOTNUM,b.EVALUATE as EVALUATE,b.ANSWERINGNUM as ANSWERINGNUM,d.NAME AS TYPENAME");
		query.addRule(new DBRule("a.STATE", "0", "!="));
		query.addRule(new DBRule("a.CUSER", user.getId(), "="));
		query.addSort(new DBSort("a.ctime", "desc"));
		return query;
	}

	@Override
	public DataQuery getTypeInfos(String parentId) {
		DataQuery query = null;
		query = DataQuery
				.init(query,
						"(SELECT a.NAME as NAME, a.ID as ID, a.PARENTID as PARENTID, (SELECT COUNT(B1.ID) FROM FARM_DOC B1 LEFT JOIN FARM_RF_DOCTYPE B2 ON B1.ID = B2.DOCID LEFT JOIN FARM_DOCTYPE B3 ON B3.ID = B2.TYPEID WHERE B3.TREECODE  LIKE CONCAT(A.TREECODE,'%') AND B1.STATE='1') AS NUM FROM farm_doctype AS a LEFT JOIN farm_doctype AS b ON b.ID = a.PARENTID WHERE 1 = 1 AND (a.TYPE = '1' OR a.TYPE = '3') AND a.PSTATE = '1' and (a.PARENTID='"
								+ parentId + "' or b.PARENTID='" + parentId + "') ORDER BY a.SORT ASC) AS e",
						"NAME,ID,PARENTID,NUM");
		query.setDistinct(true);
		query.setPagesize(1000);
		query.setNoCount();
		query.setCache(
				Integer.valueOf(FarmService.getInstance().getParameterService().getParameter("config.wcp.cache.type")),
				CACHE_UNIT.minute);
		return query;
	}

	// zhaofei
	@Override
	public DataResult getAllTags( ) {
		DataQuery query = DataQuery.init(null,
				"(SELECT TAGKEY, count(TAGKEY) as DOCNUM FROM FARM_DOC WHERE DOMTYPE=1 group by TAGKEY) AS a", "TAGKEY,DOCNUM");
		query.addSort(new DBSort("DOCNUM", "desc"));
//		query.setPagesize(pagesize);
		query.setNoCount();
		DataResult result = null;
		try {
			result = query.search();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		for (Map<String, Object> node : result.getResultList()) {
			
			String tag = node.get("TAGKEY").toString();
			String year = tag.toString().substring(4, 8);
			String num = tag.toString().substring(9, tag.toString().length()-1);
			node.put("WH", year+"-"+num);
			
		}
		return result;
	}

}
