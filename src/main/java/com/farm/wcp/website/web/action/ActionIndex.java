package com.farm.wcp.website.web.action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.farm.doc.domain.FarmDoc;
import com.farm.doc.domain.FarmDocfile;
import com.farm.doc.domain.FarmDoctype;
import com.farm.doc.exception.CanNoWriteException;
import com.farm.doc.impl.FarmDocService;
import com.farm.doc.server.FarmDocManagerInter;
import com.farm.doc.server.FarmDocOperateRightInter;
import com.farm.doc.server.FarmDocRunInfoInter;
import com.farm.doc.server.FarmDocOperateRightInter.POP_TYPE;
import com.farm.doc.server.exception.NotIsHttpZipException;
import com.farm.lucene.FarmLuceneFace;
import com.farm.lucene.server.DocIndexInter;
import com.farm.core.page.CommitType;
import com.farm.core.page.PageSet;
import com.farm.core.page.PageType;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.wcp.know.server.WcpKnowManagerInter;
import com.farm.wcp.website.server.HttpWebSite;
import com.farm.wcp.website.server.WcpWebSiteManagerInter;
import com.farm.web.WebSupport;
import com.farm.web.spring.BeanFactory;

/**
 * html静态站点
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
	private String zipfileId;
	private String knowtag;
	private String knowtitle;
	private String knowtype;
	private String readtype;
	private String writetype;
	private FarmDoctype doctype;
	private String text;
	private HttpWebSite doc;
	private boolean isenjoy;
	private String typeid;
	private String editNote;
	private String docgroup;
	private Set<String> fileTypes;

	/**
	 * 请求创建站点页面
	 * 
	 */
	@SuppressWarnings("deprecation")
	public String showPage() {
		if (typeid != null && !typeid.toUpperCase().trim().equals("NONE")
				&& !typeid.toUpperCase().trim().equals("")) {
			doctype = docIMP.getType(typeid);
			doc = new HttpWebSite();
			List<FarmDoctype> typelist = new ArrayList<FarmDoctype>();
			typelist.add(doctype);
			doc.setTypes(typelist);
		}
		return SUCCESS;
	}

	@SuppressWarnings("deprecation")
	public String showEditPage() {
		doc = new HttpWebSite(docIMP.getDoc(id));
		id = doc.getId();
		knowtag = doc.getTagkey();
		knowtitle = doc.getTitle();
		readtype = doc.getReadpop();
		writetype = doc.getWritepop();
		knowtype = doc.getTypes().get(0).getId();
		text = doc.getTexts().getText1();
		List<FarmDocfile> files = FarmDocService.getInstance().getFileService()
				.getAllTypeFileForDoc(id, ".zip");
		if (files.size() > 0) {
			zipfileId = files.get(0).getId();
		}
		return SUCCESS;
	}

	/**
	 * 提交站点创建请求
	 * 
	 * @throws NotIsHttpZipException
	 * 
	 */
	public String creatSiteCommit() throws NotIsHttpZipException {
		try {
			doc = webSiteIMP.creatWebSite(zipfileId, knowtitle, knowtag,
					knowtype, POP_TYPE.getEnum(readtype), POP_TYPE
							.getEnum(writetype), text, docgroup,
					getCurrentUser());
			id = doc.getId();
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.setError(pageset, e, e.getMessage());
			return "INPUT";
		}
		return SUCCESS;
	}

	/**
	 * 提交站点更新请求
	 * 
	 * @throws CanNoWriteException
	 * @throws NotIsHttpZipException
	 * 
	 */
	public String editSiteCommit() throws NotIsHttpZipException,
			CanNoWriteException {
		try {
			if ("0".equals(docgroup)) {
				docgroup = null;
			}
			// 高级权限用户修改
			if (operateIMP.isDel(getCurrentUser(), docIMP.getDocOnlyBean(id))) {
				doc = webSiteIMP.editSite(id, zipfileId, knowtitle, knowtag,
						knowtype, POP_TYPE.getEnum(readtype), POP_TYPE
								.getEnum(writetype), text, getCurrentUser(),
						docgroup, editNote);
				return SUCCESS;
			}
			// 低级权限用户修改
			{
				doc = webSiteIMP.editSite(id, zipfileId, knowtag, text,
						getCurrentUser(), editNote);
			}
			id = doc.getId();
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.setError(pageset, e, e.getMessage());
			return "INPUT";
		}
		return SUCCESS;
	}

	/**
	 * 提交删除站点请求
	 * 
	 */
	public String delSiteCommit() {
		// TODO: implement
		return SUCCESS;
	}

	/**
	 * 请求站点列表页面
	 * 
	 */
	public String visitPotal() {
		// TODO: implement
		return SUCCESS;
	}

	/**
	 * ajax列表请求
	 * 
	 */
	public String queryAllList() {
		// TODO: implement
		return SUCCESS;
	}

	/**
	 * 访问站点
	 * 
	 * @throws Exception
	 * 
	 */
	public String visitSite() throws Exception {
		try {
			doc = webSiteIMP.getWebSite(id, getCurrentUser());
			docRunInfoIMP.visitDoc(id, getCurrentUser(), getCurrentIp());
			String userId = "noLogin";
			if (getCurrentUser() != null) {
				userId = getCurrentUser().getId();
			}
			isenjoy = docRunInfoIMP.isEnjoyDoc(userId, id);
			List<FarmDoctype> types = doc.getTypes();
			if (types != null && types.size() > 0) {
				typeid = types.get(0).getId();
			}
			fileTypes = new HashSet<String>();
			for (FarmDocfile node : doc.getFiles()) {
				fileTypes.add(node.getExname().trim().replace(".", "")
						.toUpperCase());
			}
		} catch (Exception e) {
			DocIndexInter index = FarmLuceneFace.inctance().getDocIndex(
					FarmLuceneFace.inctance().getIndexPathFile(
							WcpKnowManagerInter.LUCENE_DIR));
			index.deleteFhysicsIndex(id);
			pageset = PageSet.setError(pageset, e, e.getMessage());
			pageset.setMessage(e.getMessage());
			return "ERROR";
		}
		return SUCCESS;
	}

	private final static WcpWebSiteManagerInter webSiteIMP = (WcpWebSiteManagerInter) BeanFactory
			.getBean("wcp_WebSiteProxyId");
	private final static FarmDocManagerInter docIMP = (FarmDocManagerInter) BeanFactory
			.getBean("farm_docProxyId");
	private static final long serialVersionUID = 1L;
	private final static FarmDocRunInfoInter docRunInfoIMP = (FarmDocRunInfoInter) BeanFactory
			.getBean("farm_docRunInfoProxyId");
	private final static FarmDocOperateRightInter operateIMP = (FarmDocOperateRightInter) BeanFactory
			.getBean("farm_DocOperateProxyId");

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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getZipfileId() {
		return zipfileId;
	}

	public void setZipfileId(String zipfileId) {
		this.zipfileId = zipfileId;
	}

	public String getKnowtag() {
		return knowtag;
	}

	public void setKnowtag(String knowtag) {
		this.knowtag = knowtag;
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

	public HttpWebSite getDoc() {
		return doc;
	}

	public void setDoc(HttpWebSite doc) {
		this.doc = doc;
	}

	public boolean isIsenjoy() {
		return isenjoy;
	}

	public void setIsenjoy(boolean isenjoy) {
		this.isenjoy = isenjoy;
	}

	public String getTypeid() {
		return typeid;
	}

	public void setTypeid(String typeid) {
		this.typeid = typeid;
	}

	public String getEditNote() {
		return editNote;
	}

	public void setEditNote(String editNote) {
		this.editNote = editNote;
	}

	public String getDocgroup() {
		return docgroup;
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

	public FarmDoctype getDoctype() {
		return doctype;
	}

	public void setDoctype(FarmDoctype doctype) {
		this.doctype = doctype;
	}

}
