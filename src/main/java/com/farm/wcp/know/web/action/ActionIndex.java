package com.farm.wcp.know.web.action;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.farm.doc.domain.FarmDoc;
import com.farm.doc.domain.FarmDocfile;
import com.farm.doc.domain.FarmDocmessage;
import com.farm.doc.domain.FarmDocruninfo;
import com.farm.doc.domain.FarmDoctype;
import com.farm.doc.exception.CanNoReadException;
import com.farm.doc.exception.DocNoExistException;
import com.farm.doc.impl.FarmDocService;
import com.farm.doc.server.FarmDocManagerInter;
import com.farm.doc.server.FarmDocOperateRightInter;
import com.farm.doc.server.FarmDocRunInfoInter;
import com.farm.doc.server.FarmFileManagerInter;
import com.farm.doc.server.FarmDocOperateRightInter.POP_TYPE;
import com.farm.lucene.FarmLuceneFace;
import com.farm.lucene.server.DocIndexInter;
import com.farm.authority.domain.User;
import com.farm.authority.service.UserServiceInter;
import com.farm.core.FarmService;
import com.farm.core.page.CommitType;
import com.farm.core.page.PageSet;
import com.farm.core.page.PageType;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DBSort;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.query.DataQuery.CACHE_UNIT;
import com.farm.core.sql.result.DataResult;
import com.farm.core.sql.result.DataResults;
import com.farm.util.validate.ValidUtils;
import com.farm.util.web.FarmFormatUnits;
import com.farm.wcp.know.common.LuceneDocUtil;
import com.farm.wcp.know.server.WcpKnowManagerImpl;
import com.farm.wcp.know.server.WcpKnowManagerInter;
import com.farm.wcp.webfile.server.WcpWebFileManagerInter;
import com.farm.web.WebSupport;
import com.farm.web.spring.BeanFactory;

/**
 * 文件
 * 
 * @author autoCode
 * 
 */
public class ActionIndex extends WebSupport {
	private DataResult result;// 结果集合
	private DataQuery query;// 条件查询
	private PageSet pageset;// 请求状态
	private String ids;// 主键集合
	private String id;
	private String knowtitle;
	private String knowtype;
	private String knowtag;
	private String readtype;
	private String currentTypeid;
	private String writetype;
	private String text;
	private FarmDoc doc;
	private FarmDoctype doctype;
	private String url;
	private String typeid;
	private FarmDocmessage message;
	private FarmDocruninfo runinfo;
	private boolean isenjoy;
	private String editNote;
	private int praise;
	private String docgroup;
	private Set<String> fileTypes;
	private User user;
	private String whsize;
	private HashMap<Integer, List<Map<String, Object>>> yearWenhao;
	private List<Integer> years;

	/**
	 * 添加分类
	 * 
	 * @return
	 */
	public String typeAdd() {
		if (id != null && !id.equals("NONE")) {
			knowtype = docIMP.getType(id).getName();
		} else {
			knowtype = "无";
		}
		pageset = new PageSet(PageType.ADD, CommitType.NONE);
		return SUCCESS;
	}

	/**
	 * 按照名称查询知识（数据库查询）
	 * 
	 * @return
	 */
	public String searchKnowByName() {
		DataQuery query = DataQuery.getInstance(1, "TITLE,ID,DOMTYPE", "FARM_DOC");
		if (knowtitle != null) {
			query.addRule(new DBRule("TITLE", knowtitle, "like"));
		} else {
			query.addSort(new DBSort("ctime", "desc"));
		}
		query.addRule(new DBRule("STATE", "1", "="));
		query.addSqlRule(" and (READPOP='1' or READPOP='2')");
		try {
			result = query.search();
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (SQLException e) {
			e.printStackTrace();
			pageset = new PageSet(PageType.ADD, CommitType.FALSE);
		}
		return SUCCESS;
	}

	/**
	 * 修改分类
	 * 
	 * @return
	 */
	public String typeEdit() {
		if (id != null && !id.equals("NONE")) {
			doctype = docIMP.getType(id);
			knowtype = doctype.getName();
		} else {
			knowtype = "无";
		}
		pageset = new PageSet(PageType.UPDATE, CommitType.NONE);
		return SUCCESS;
	}

	/**
	 * 删除分类
	 * 
	 * @return
	 */
	public String typeDel() {
		try {
			String pid = docIMP.getType(id).getParentid();
			docIMP.deleteType(id, getCurrentUser());
			id = pid;
		} catch (Exception e) {
			pageset = PageSet.setError(pageset, e, "");
			return INPUT;
		}
		return SUCCESS;
	}

	/**
	 * 添加分类-提交
	 * 
	 * @return
	 */
	public String typeSaveCommit() {
		try {
			if (pageset.getPageType() == PageType.ADD.value) {
				doctype.setType("3");
				doctype.setPstate("1");
				doctype.setParentid(id);
				docIMP.insertType(doctype, getCurrentUser());
			}
			if (pageset.getPageType() == PageType.UPDATE.value) {
				FarmDoctype type = docIMP.getType(id);
				type.setSort(doctype.getSort());
				type.setName(doctype.getName());
				docIMP.editType(type, getCurrentUser());
			}
		} catch (Exception e) {
			pageset = PageSet.setError(pageset, e, "");
			return INPUT;
		}
		return SUCCESS;
	}

	/**
	 * 好评给文档
	 * 
	 * @return
	 */
	public String praiseYes() {
		try {
			if (getCurrentUser() != null) {
				docRunInfoIMP.praiseDoc(id, getCurrentUser(), getCurrentIp());
			} else {
				docRunInfoIMP.praiseDoc(id, getCurrentIp());
			}
			runinfo = docRunInfoIMP.loadRunInfo(id);
			pageset = new PageSet(PageType.OTHER, CommitType.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			pageset = PageSet.setError(pageset, e, "");
		}
		return SUCCESS;
	}

	/**
	 * 差评给文档
	 * 
	 * @return
	 */
	public String praiseNo() {
		try {
			if (getCurrentUser() != null) {
				docRunInfoIMP.criticalDoc(id, getCurrentUser(), getCurrentIp());
			} else {
				docRunInfoIMP.criticalDoc(id, getCurrentIp());
			}
			runinfo = docRunInfoIMP.loadRunInfo(id);
			pageset = new PageSet(PageType.OTHER, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.setError(pageset, e, "");
		}
		return SUCCESS;
	}

	/**
	 * 提交网络文档URL
	 * 
	 * @return
	 */
	public String downWebCommit() {
		try {
			doc = knowIMP.getDocByWeb(url, getCurrentUser());
			if (typeid != null && !typeid.toUpperCase().trim().equals("NONE")
					&& !typeid.toUpperCase().trim().equals("")) {
				doctype = docIMP.getType(typeid);
				List<FarmDoctype> typelist = new ArrayList<FarmDoctype>();
				typelist.add(doctype);
				doc.setTypes(typelist);
			}
			pageset = PageSet.initPageSet(pageset, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, CommitType.FALSE, e);
			pageset.setMessage("加载网络资源失败请检查链接地址或重新尝试");
			return INPUT;
		}
		return SUCCESS;
	}

	/**
	 * 分类展示页面(单页)
	 * 
	 * @return
	 */
	public String typePage() {
		typeid = id;
		return SUCCESS;
	}

	/**
	 * 文档留言页面
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String docMessage() {
		doc = docIMP.getDoc(id);
		query = FarmDocService.getInstance().getMessageService().createMessageQuery(query);
		query.addRule(new DBRule("APPID", id, "="));
		query.addSort(new DBSort("CTIME", "DESC"));
		try {
			result = query.search();
			result.runformatTime("CTIME", "yyyy-MM-dd HH:mm:ss");
		} catch (Exception e) {
			pageset.setCommitType(CommitType.FALSE.value);
		}

		return SUCCESS;
	}

	/**
	 * 我收到
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String myMessageList() {
		doc = docIMP.getDoc(id);
		query = FarmDocService.getInstance().getMessageService().createMessageQuery(query);
		query.addRule(new DBRule("READUSERID", getCurrentUser().getId(), "="));
		query.addSort(new DBSort("CTIME", "DESC"));
		try {
			result = query.search();
			result.runformatTime("CTIME", "yyyy-MM-dd HH:mm:ss");
			for (Map<String, Object> node : result.getResultList()) {
				if ("0".equals(node.get("READSTATE"))) {
					FarmDocService.getInstance().getMessageService().readMessage(node.get("ID").toString());
				}
			}
		} catch (Exception e) {
			pageset.setCommitType(CommitType.FALSE.value);
		}
		return SUCCESS;
	}

	/**
	 * 我发表
	 * 
	 * @return
	 */
	public String mySendMessageList() {
		query = FarmDocService.getInstance().getMessageService().createMessageQuery(query);
		query.addRule(new DBRule("a.CUSER", getCurrentUser().getId(), "="));
		query.addSort(new DBSort("a.CTIME", "DESC"));
		try {
			result = query.search();
			result.runformatTime("CTIME", "yyyy-MM-dd HH:mm:ss");
		} catch (Exception e) {
			pageset.setCommitType(CommitType.FALSE.value);
		}

		return SUCCESS;
	}

	/**
	 * 发送留言提交
	 * 
	 * @return
	 */
	public String docMessageSubmit() {
		id = message.getAppid();
		message = FarmDocService.getInstance().getMessageService()
				.sendAnswering(message.getContent(), message.getTitle(), "知识留言", message.getAppid(), getCurrentUser());
		return SUCCESS;
	}

	/**
	 * 收藏
	 * 
	 * @return
	 */
	public String enjoy() {
		pageset = new PageSet();
		try {
			docRunInfoIMP.enjoyDoc(getCurrentUser().getId(), id);
		} catch (Exception e) {
			pageset.setCommitType(CommitType.FALSE.value);
		}
		pageset.setCommitType(CommitType.TRUE.value);
		return SUCCESS;
	}

	/**
	 * 取消收藏
	 * 
	 * @return
	 */
	public String unenjoy() {
		pageset = new PageSet();
		try {
			docRunInfoIMP.unEnjoyDoc(getCurrentUser().getId(), id);
		} catch (Exception e) {
			pageset.setCommitType(CommitType.FALSE.value);
		}
		pageset.setCommitType(CommitType.TRUE.value);
		return SUCCESS;
	}

	/**
	 * 分类信息页面
	 * 
	 * @return
	 */
	public String typeKnowInfo() {
		typeid = id;
		return SUCCESS;
	}

	/**
	 * 文档版本
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String docVersions() {
		query = docIMP.getDocVersions(id);
		doc = docIMP.getDoc(id);
		query.setPagesize(100);
		try {
			result = query.search();
			result.runformatTime("ETIME", "yyyy/MM/dd HH:mm:ss");
		} catch (SQLException e) {
			e.printStackTrace();
			result = DataResult.getInstance(new ArrayList<Map<String, Object>>(), 0, 0, 0);
		}
		return SUCCESS;
	}

	/**
	 * 进入创建知识
	 * 
	 * @return
	 */
	public String index() {
		if (typeid != null && !typeid.toUpperCase().trim().equals("NONE") && !typeid.toUpperCase().trim().equals("")) {
			doctype = docIMP.getType(typeid);
			doc = new FarmDoc();
			List<FarmDoctype> typelist = new ArrayList<FarmDoctype>();
			typelist.add(doctype);
			doc.setTypes(typelist);
		}
		return SUCCESS;
	}

	/**
	 * 下载网页并创建文档
	 * 
	 * @return
	 */
	public String downWeb() {
		return SUCCESS;
	}

	/**
	 * 进入修改知识
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String edit() {
		try {
			doc = docIMP.getDoc(id);
			// 解决kindedit中HTML脚本被转义的问题
			doc.getTexts().setText1(
					doc.getTexts().getText1().replaceAll("&gt;", "&amp;gt;").replaceAll("&lt;", "&amp;lt;"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	/**
	 * 显示公开的最新知识
	 * 
	 * @return
	 */
	public String showNewDocList() {
		result = knowIMP.getNewKnowList(10);
		for (Map<String, Object> node : result.getResultList()) {
			if (node.get("PHOTOID") != null) {
				node.put("PHOTOURL", fileIMP.getFileURL(node.get("PHOTOID").toString()));
			}
		}
		return SUCCESS;
	}

	/**
	 * 显示公开的最新知识图片
	 * 
	 * @return
	 */
	public String showNewImageList() {

		try {
			query = DataQuery
					.init(query,
							"FARM_RF_DOCTEXTFILE a LEFT JOIN FARM_DOC b ON a.DOCID=b.ID LEFT JOIN FARM_DOCFILE c ON a.FILEID=c.ID ",
							" B.ID AS DOCID,B.TITLE as TITLE,C.EXNAME  AS EXNAME,C.NAME as NAME,C.ID AS FILEID,C.PSTATE ");
			query.setPagesize(30);
			query.addRule(new DBRule("b.READPOP", "1", "="));
			query.addSort(new DBSort("b.ETIME", "desc"));
			query.setDistinct(true);
			query.setCache(
					Integer.valueOf(FarmService.getInstance().getParameterService()
							.getParameter("config.wcp.cache.imgwall")), CACHE_UNIT.minute);
			query.addSqlRule(" AND REPLACE(UPPER(c.EXNAME),'.','')  IN ('PNG','JPG','GIF')");
			result = query.search();
			List<String> docids = new ArrayList<String>();
			for (Map<String, Object> node : result.getResultList()) {
				node.put("URL", fileIMP.getFileURL(node.get("FILEID").toString()));
				if (docids.size() == 0) {
					docids.add(node.get("DOCID").toString());
					node.put("DISPLAY", 1);
				} else {
					if (docids.size() <= 5 && !docids.contains(node.get("DOCID").toString())) {
						docids.add(node.get("DOCID").toString());
						node.put("DISPLAY", 1);
					} else {
						node.put("DISPLAY", 0);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}

	/**
	 * 显示公开的最热知识
	 * 
	 * @return
	 */
	public String showhotDocList() {
		DataQuery query = DataQuery.getInstance("1",
				"A.ID AS ID,A.AUTHOR AS AUTHOR, A.TITLE  AS TITLE, DOMTYPE, B.HOTNUM AS HOTNUM",
				"farm_doc a LEFT JOIN farm_docruninfo b ON a.RUNINFOID = b.ID");
		query.addRule(new DBRule("a.READPOP", "1", "="));
		query.addSort(new DBSort("b.HOTNUM", "desc"));
		query.setNoCount();
		query.setCache(Integer.valueOf(FarmService.getInstance().getParameterService()
				.getParameter("config.wcp.cache.hotdoc")), CACHE_UNIT.minute);
		query.setPagesize(10);
		result = null;
		try {
			result = query.search();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// for (Map<String, Object> node : result.getResultList()) {
		// node.put("PUBTIME", FarmFormatUnits.getFormateTime(node.get(
		// "PUBTIME").toString(), true));
		// String tags = node.get("TAGKEY") != null ? node.get("TAGKEY")
		// .toString() : null;
		// if (tags != null && tags.trim().length() > 0) {
		// String[] tags1 = tags.trim().replaceAll("，", ",").replaceAll(
		// "、", ",").split(",");
		// node.put("TAGKEY", Arrays.asList(tags1));
		// } else {
		// node.put("TAGKEY", new ArrayList<String>());
		// }
		// }
		return SUCCESS;
	}

	/**
	 * 显示分类知识列表
	 * 
	 * @return
	 */
	public String showTypeDocList() {
		doctype = docIMP.getType(typeid);
		if (doctype == null) {
			return SUCCESS;
		}
		String userid = "none";
		if (getCurrentUser() != null) {
			userid = getCurrentUser().getId();
		}
		try {

			query = knowIMP.getTypeDocQuery(query).addRule(new DBRule("d.TREECODE", doctype.getTreecode(), "like-"))
			// 文章三种情况判断
			// 1.文章阅读权限为公共
			// 2.文章的创建者为当前登录用户
			// 3.文章的阅读权限为小组，并且当前登陆用户为组内成员.(使用子查询处理)
					.addSqlRule(
							"and (a.READPOP='1' or a.CUSER='"
									+ userid
									+ "' OR (a.READPOP = '2' AND 0 < (SELECT e.ID FROM farm_docgroup_user e WHERE e.PSTATE = 1 AND e.GROUPID = a.DOCGROUPID AND e.CUSER = '"
									+ userid + "')))");
			query.setPagesize(20);
			result = query.search();

			for (Map<String, Object> node : result.getResultList()) {
				String tags = node.get("TAGKEY").toString();
				if (tags != null && tags.trim().length() > 0) {
					String[] tags1 = tags.trim().replaceAll("，", ",").replaceAll("、", ",").split(",");
					node.put("TAGKEY", Arrays.asList(tags1));
				} else {
					node.put("TAGKEY", new ArrayList<String>());
				}
			}
		} catch (Exception e) {
			result = DataResults.setException(result, e);
		}
		return SUCCESS;
	}

	/**
	 * 显示我发布的知识
	 * 
	 * @return
	 */
	public String showMyDocList() {
		try {
			result = knowIMP.getMyDocQuery(query, getCurrentUser()).search();
			for (Map<String, Object> node : result.getResultList()) {
				node.put("PUBTIME", FarmFormatUnits.getFormateTime(node.get("PUBTIME").toString(), true));
				String tags = node.get("TAGKEY").toString();
				if (tags != null && tags.trim().length() > 0) {
					String[] tags1 = tags.trim().replaceAll("，", ",").replaceAll("、", ",").split(",");
					node.put("TAGKEY", Arrays.asList(tags1));
				} else {
					node.put("TAGKEY", new ArrayList<String>());
				}
			}
		} catch (Exception e) {
			result = DataResults.setException(result, e);
		}
		return SUCCESS;
	}

	/**
	 * 用户首页
	 * 
	 * @return
	 */
	public String showUserHome() {
		try {
			user = userIMP.getUserEntity(getCurrentUser().getId());
			result = knowIMP.getMyDocQuery(query, user).search();
			for (Map<String, Object> node : result.getResultList()) {
				node.put("PUBTIME", FarmFormatUnits.getFormateTime(node.get("PUBTIME").toString(), true));
				String tags = node.get("TAGKEY").toString();
				if (tags != null && tags.trim().length() > 0) {
					String[] tags1 = tags.trim().replaceAll("，", ",").replaceAll("、", ",").split(",");
					node.put("TAGKEY", Arrays.asList(tags1));
				} else {
					node.put("TAGKEY", new ArrayList<String>());
				}
			}
		} catch (Exception e) {
			result = DataResults.setException(result, e);
		}
		return SUCCESS;
	}

	/**
	 * 显示公共知识分类
	 * 
	 * @return
	 */
	public String showPubTypeList() {
		try {
			if (ValidUtils.isEmptyString(id) || id.equals("NONE")) {
				id = "NONE";
				typeid = "NONE";
			} else {
				FarmDoctype docType = docIMP.getType(id);
				knowtype = docType.getName();
				if (docType.getParentid().equals("NONE")) {
					typeid = "NONE";
				} else {
					typeid = docIMP.getType(docType.getParentid()).getId();
				}
			}
			query = DataQuery.init(query, "", "");
			query = knowIMP.getTypeInfos(id);
			result = query.search();
			currentTypeid = id;
		} catch (Exception e) {
			result = DataResults.setException(result, e);
		}
		return SUCCESS;
	}

	/**
	 * 查询3层分类
	 * 
	 * @return
	 */
	public String showPubAllTypeList() {
		try {
			query = knowIMP.getTypes(query);
			result = query.search();
		} catch (Exception e) {
			result = DataResults.setException(result, e);
		}
		return SUCCESS;
	}

	/**
	 * 显示可选择的知识分类
	 * 
	 * @return
	 */
	public String showChooseTypeList() {
		try {
			DataQuery query = DataQuery.getInstance("1", "NAME,ID,PARENTID", "farm_doctype ");
			query.setPagesize(1000);
			query.addSqlRule("and (TYPE='1' OR TYPE='3') AND PSTATE ='1'");
			query.addSort(new DBSort("SORT", "ASC"));
			result = query.search();
		} catch (Exception e) {
			result = DataResults.setException(result, e);
		}
		return SUCCESS;
	}

	/**
	 * 提交创建知识
	 * 
	 * @return
	 */
	public String submitAdd() {
		try {
			if ("0".equals(docgroup)) {
				docgroup = null;
			}
			id = knowIMP.creatKnow(knowtitle, knowtype, text, knowtag, POP_TYPE.getEnum(writetype),
					POP_TYPE.getEnum(readtype), docgroup, getCurrentUser()).getId();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 提交修改知识
	 * 
	 * @return
	 */
	public String editCommit() {
		try {
			if ("0".equals(docgroup)) {
				docgroup = null;
			}
			// 高级权限用户修改
			if (operateIMP.isDel(getCurrentUser(), docIMP.getDocOnlyBean(id))) {
				id = knowIMP.editKnow(id, knowtitle, knowtype, text, knowtag, POP_TYPE.getEnum(writetype),
						POP_TYPE.getEnum(readtype), docgroup, getCurrentUser(), editNote).getId();
				return SUCCESS;

			}
			// 低级权限用户修改
			{
				id = knowIMP.editKnow(id, text, knowtag, getCurrentUser(), editNote).getId();
			}

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 删除知识
	 * 
	 * @return
	 */
	public String delCommit() {
		try {
			docIMP.deleteDoc(id, getCurrentUser());
			try {
				DocIndexInter index = FarmLuceneFace.inctance().getDocIndex(
						FarmLuceneFace.inctance().getIndexPathFile(WcpKnowManagerImpl.LUCENE_DIR));
				DocIndexInter webFileIndex = FarmLuceneFace.inctance().getDocIndex(
						FarmLuceneFace.inctance().getIndexPathFile(WcpWebFileManagerInter.LUCENE_DIR));
				index.deleteFhysicsIndex(id);
				webFileIndex.deleteFhysicsIndex(id);
			} catch (Exception e) {
				throw new RuntimeException();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	/**
	 * 公开文档（将该文档开放阅读和编辑权限，同时如果是小组文档将删除小组所有权）
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String flyKnow() {
		try {
			FarmDocService.getInstance().getOperateRightService().flyDoc(id, getCurrentUser());
			try {
				DocIndexInter index = FarmLuceneFace.inctance().getDocIndex(
						FarmLuceneFace.inctance().getIndexPathFile(WcpKnowManagerImpl.LUCENE_DIR));
				index.indexDoc(LuceneDocUtil.getDocMap(docIMP.getDoc(id)));
				index.close();
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	public String showDoc() throws Exception {
		try {
			doc = docIMP.getDoc(id, getCurrentUser());
			if (doc.getDomtype().equals("3")) {
				return "WEBSITE";
			}
			if (doc.getDomtype().equals("5")) {
				return "WEBFILE";
			}
			docRunInfoIMP.visitDoc(id, getCurrentUser(), getCurrentIp());
			if (getCurrentUser() != null) {
				isenjoy = docRunInfoIMP.isEnjoyDoc(getCurrentUser().getId(), id);
			}
			List<FarmDoctype> types = doc.getTypes();
			if (types != null && types.size() > 0) {
				typeid = types.get(0).getId();
			}
			fileTypes = new HashSet<String>();
			for (FarmDocfile node : doc.getFiles()) {
				fileTypes.add(node.getExname().trim().replace(".", "").toUpperCase());
			}
		} catch (CanNoReadException e) {
			pageset = PageSet.setError(pageset, e, e.getMessage());
			pageset.setMessage(e.getMessage());
			// 权限异常
			return "ERROR";
		} catch (DocNoExistException e) {
			DocIndexInter index = FarmLuceneFace.inctance().getDocIndex(
					FarmLuceneFace.inctance().getIndexPathFile(WcpKnowManagerInter.LUCENE_DIR));
			index.deleteFhysicsIndex(id);
			DocIndexInter webfileindex = FarmLuceneFace.inctance().getDocIndex(
					FarmLuceneFace.inctance().getIndexPathFile(WcpWebFileManagerInter.LUCENE_DIR));
			webfileindex.deleteFhysicsIndex(id);

			pageset = PageSet.setError(pageset, e, e.getMessage());
			pageset.setMessage(e.getMessage());
			return "ERROR";
		}
		return SUCCESS;
	}

	public String byNumber() {
		DataQuery query = DataQuery
				.getInstance(
						"1",
						"a.ID as ID,a.TITLE AS title,a.CUSER as CUSER,a.DOCDESCRIBE AS DOCDESCRIBE,DOMTYPE,a.AUTHOR AS AUTHOR,a.PUBTIME AS PUBTIME,a.TAGKEY AS TAGKEY ,a.IMGID AS IMGID,b.VISITNUM AS VISITNUM,b.PRAISEYES AS PRAISEYES,b.PRAISENO AS PRAISENO,b.HOTNUM AS HOTNUM,d.NAME AS TYPENAME,e.IMGID AS PHOTOID,A.ETIME AS ETIME",
						"farm_doc a LEFT JOIN farm_docruninfo b ON a.RUNINFOID=b.ID LEFT JOIN farm_rf_doctype c ON c.DOCID=a.ID LEFT JOIN farm_doctype d ON d.ID=c.TYPEID   LEFT JOIN ALONE_AUTH_USER e ON e.ID=a.CUSER");
		query.addRule(new DBRule("a.READPOP", "1", "="));
		query.addRule(new DBRule("a.STATE", "1", "="));
		query.addSort(new DBSort("a.etime", "desc"));
		query.setNoCount();
		try {
			result = query.search();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> node : result.getResultList()) {

			String year = id.split("-")[0].toString();
			String num = id.split("-")[1].toString();

			if (node.get("TAGKEY").toString().contains(year) && node.get("TAGKEY").toString().contains(num)) {
				node.put("PUBTIME", FarmFormatUnits.getFormateTime(node.get("PUBTIME").toString(), true));
				String tags = node.get("TAGKEY") != null ? node.get("TAGKEY").toString() : null;
				if (tags != null && tags.trim().length() > 0) {
					String[] tags1 = tags.trim().replaceAll("，", ",").replaceAll("、", ",").split(",");
					node.put("TAGKEY", Arrays.asList(tags1));
				} else {
					node.put("TAGKEY", new ArrayList<String>());
				}
				node.put("DOCDESCRIBE", node.get("DOCDESCRIBE").toString().replaceAll("<", "").replaceAll(">", ""));
				resultList.add(node);
			}

		}
		result.setResultList(resultList);
		return SUCCESS;
	}

	public String showDocVersion() throws Exception {
		try {
			doc = docIMP.getDocVersion(id, getCurrentUser());
			if (!doc.getState().equals("1")) {
				throw new RuntimeException("没有权限访问该文档");
			}
			List<FarmDoctype> types = doc.getTypes();
			if (types != null && types.size() > 0) {
				typeid = types.get(0).getId();
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 显示Tag列表
	 * 
	 * @return
	 */
	public String showTopTagList() {
		List<Map<String, Object>> all = knowIMP.getAllTags().getResultList();
		setYearWenhao(new HashMap<Integer, List<Map<String, Object>>>());

		setYears(new ArrayList<Integer>());
		for (Map<String, Object> node : all) {
			String tag = node.get("TAGKEY").toString();
			String year = tag.toString().substring(4, 8);
			Integer y = Integer.parseInt(year);

			if (getYearWenhao().containsKey(y)) {
				getYearWenhao().get(y).add(node);
			} else {
				List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				list.add(node);
				getYearWenhao().put(y, list);
			}
		}
		getYears().addAll(getYearWenhao().keySet());
		Collections.sort(getYears(), Collections.reverseOrder());
		return SUCCESS;
	}

	private final FarmFileManagerInter fileIMP = (FarmFileManagerInter) BeanFactory.getBean("farm_docFileProxyId");
	private final static WcpKnowManagerInter knowIMP = (WcpKnowManagerInter) BeanFactory.getBean("wcp_KnowProxyId");
	private final static FarmDocManagerInter docIMP = (FarmDocManagerInter) BeanFactory.getBean("farm_docProxyId");
	private final static FarmDocRunInfoInter docRunInfoIMP = (FarmDocRunInfoInter) BeanFactory
			.getBean("farm_docRunInfoProxyId");
	private final static FarmDocOperateRightInter operateIMP = (FarmDocOperateRightInter) BeanFactory
			.getBean("farm_DocOperateProxyId");
	private final static UserServiceInter userIMP = (UserServiceInter) BeanFactory
			.getBean("farm_authority_user_ProxyId");

	// ----------------------------------------------------------------------------------
	public DataQuery getQuery() {
		return query;
	}

	public void setQuery(DataQuery query) {
		this.query = query;
	}

	public DataResult getResult() {
		return result;
	}

	public void setResult(DataResult result) {
		this.result = result;
	}

	public PageSet getPageset() {
		return pageset;
	}

	public void setPageset(PageSet pageset) {
		this.pageset = pageset;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	// private static final Logger log = Logger.getLogger(ActionIndex.class);
	private static final long serialVersionUID = 1L;

	/**
	 * 加载树节点 public String loadTreeNode() { treeNodes =
	 * EasyUiTreeNode.formatAjaxTree(EasyUiTreeNode .queryTreeNodeOne(id,
	 * "SORT", "alone_menu", "ID", "PARENTID", "NAME").getResultList(),
	 * EasyUiTreeNode .queryTreeNodeTow(id, "SORT", "alone_menu", "ID",
	 * "PARENTID", "NAME").getResultList(), "PARENTID", "ID", "NAME"); return
	 * SUCCESS; }
	 * 
	 * @return
	 */

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getKnowtitle() {
		return knowtitle;
	}

	public void setKnowtitle(String knowtitle) {
		this.knowtitle = knowtitle;
	}

	public String getKnowtype() {
		return knowtype;
	}

	public void setKnowtype(String knowtype) {
		this.knowtype = knowtype;
	}

	public String getKnowtag() {
		return knowtag;
	}

	public void setKnowtag(String knowtag) {
		this.knowtag = knowtag;
	}

	public String getReadtype() {
		return readtype;
	}

	public void setReadtype(String readtype) {
		this.readtype = readtype;
	}

	public String getWritetype() {
		return writetype;
	}

	public void setWritetype(String writetype) {
		this.writetype = writetype;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public FarmDoc getDoc() {
		return doc;
	}

	public void setDoc(FarmDoc doc) {
		this.doc = doc;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public FarmDoctype getDoctype() {
		return doctype;
	}

	public void setDoctype(FarmDoctype doctype) {
		this.doctype = doctype;
	}

	public String getTypeid() {
		return typeid;
	}

	public void setTypeid(String typeid) {
		this.typeid = typeid;
	}

	public boolean isIsenjoy() {
		return isenjoy;
	}

	public void setIsenjoy(boolean isenjoy) {
		this.isenjoy = isenjoy;
	}

	public FarmDocmessage getMessage() {
		return message;
	}

	public void setMessage(FarmDocmessage message) {
		this.message = message;
	}

	public String getEditNote() {
		return editNote;
	}

	public void setEditNote(String editNote) {
		this.editNote = editNote;
	}

	public int getPraise() {
		return praise;
	}

	public void setPraise(int praise) {
		this.praise = praise;
	}

	public FarmDocruninfo getRuninfo() {
		return runinfo;
	}

	public void setRuninfo(FarmDocruninfo runinfo) {
		this.runinfo = runinfo;
	}

	public String getDocgroup() {
		return docgroup;
	}

	public String getCurrentTypeid() {
		return currentTypeid;
	}

	public void setCurrentTypeid(String currentTypeid) {
		this.currentTypeid = currentTypeid;
	}

	public void setDocgroup(String docgroup) {
		this.docgroup = docgroup;
	}

	public Set<String> getFileTypes() {
		return fileTypes;
	}

	public void setFileTypes(Set<String> fileTypes) {
		this.fileTypes = fileTypes;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public HashMap<Integer, List<Map<String, Object>>> getYearWenhao() {
		return yearWenhao;
	}

	public void setYearWenhao(HashMap<Integer, List<Map<String, Object>>> yearWenhao) {
		this.yearWenhao = yearWenhao;
	}

	public List<Integer> getYears() {
		return years;
	}

	public void setYears(List<Integer> years) {
		this.years = years;
	}

}
