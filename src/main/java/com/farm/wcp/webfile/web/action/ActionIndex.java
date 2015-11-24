package com.farm.wcp.webfile.web.action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.farm.core.page.PageSet;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.doc.domain.FarmDoc;
import com.farm.doc.domain.FarmDocfile;
import com.farm.doc.domain.FarmDoctype;
import com.farm.doc.exception.CanNoReadException;
import com.farm.doc.exception.DocNoExistException;
import com.farm.doc.server.FarmDocManagerInter;
import com.farm.doc.server.FarmDocRunInfoInter;
import com.farm.doc.server.FarmDocOperateRightInter.POP_TYPE;
import com.farm.lucene.FarmLuceneFace;
import com.farm.lucene.server.DocIndexInter;
import com.farm.wcp.know.server.WcpKnowManagerInter;
import com.farm.wcp.webfile.server.WcpWebFileManagerInter;
import com.farm.web.WebSupport;
import com.farm.web.spring.BeanFactory;

/**
 * 资源文件
 * 
 * @author autoCode
 * 
 */
public class ActionIndex extends WebSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private DataResult result;// 结果集合
	private DataQuery query;// 条件查询
	private PageSet pageset;// 请求状态
	private String ids;// 主键集合
	private String id;
	private FarmDoctype doctype;
	private FarmDoc doc;
	private String typeid;
	private String docgroup;
	private String fileId;
	private String fileName;
	private String knowtype;
	private String knowtitle;
	private String knowtag;
	private String writetype;
	private String readtype;
	private boolean isenjoy;
	private Set<String> fileTypes;

	public String creatWebFile() {
		if (typeid != null && !typeid.toUpperCase().trim().equals("NONE")
				&& !typeid.toUpperCase().trim().equals("")) {
			doctype = docIMP.getType(typeid);
			doc = new FarmDoc();
			List<FarmDoctype> typelist = new ArrayList<FarmDoctype>();
			typelist.add(doctype);
			doc.setTypes(typelist);
		}
		return SUCCESS;
	}

	public String editWebfile() {
		try {
			show();
		} catch (Exception e) {
			pageset = PageSet.setError(pageset, e, e.getMessage());
			pageset.setMessage(e.getMessage());
			return "ERROR";
		}
		return SUCCESS;
	}

	public String editWebfileSubmit() {
		id = webfileIMP.editWebFile(id, fileId, knowtype, knowtitle, knowtag,
				docgroup, POP_TYPE.getEnum(writetype),
				POP_TYPE.getEnum(readtype), getCurrentUser());
		return SUCCESS;
	}

	public String show() throws Exception {
		try {
			doc = docIMP.getDoc(id, getCurrentUser());
			docRunInfoIMP.visitDoc(id, getCurrentUser(), getCurrentIp());
			if (getCurrentUser() != null) {
				isenjoy = docRunInfoIMP
						.isEnjoyDoc(getCurrentUser().getId(), id);
			}
			List<FarmDoctype> types = doc.getTypes();
			if (types != null && types.size() > 0) {
				typeid = types.get(0).getId();
			}
			fileTypes = new HashSet<String>();
			for (FarmDocfile node : doc.getFiles()) {
				fileTypes.add(node.getExname().trim().replace(".", "")
						.toUpperCase());
			}
			fileId = doc.getFiles().get(0).getId();
			fileName = doc.getFiles().get(0).getName();
		} catch (CanNoReadException e) {
			pageset = PageSet.setError(pageset, e, e.getMessage());
			pageset.setMessage(e.getMessage());
			// 权限异常
			return "ERROR";
		} catch (DocNoExistException e) {
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

	public String creatWebFileSubmit() {
		id = webfileIMP.creatWebFile(fileId, knowtype, knowtitle, knowtag,
				docgroup, POP_TYPE.getEnum(writetype),
				POP_TYPE.getEnum(readtype), getCurrentUser());
		return SUCCESS;
	}

	private final static FarmDocManagerInter docIMP = (FarmDocManagerInter) BeanFactory
			.getBean("farm_docProxyId");

	private final static WcpWebFileManagerInter webfileIMP = (WcpWebFileManagerInter) BeanFactory
			.getBean("wcp_WebFileProxyId");
	private final static FarmDocRunInfoInter docRunInfoIMP = (FarmDocRunInfoInter) BeanFactory
			.getBean("farm_docRunInfoProxyId");

	public DataResult getResult() {
		return result;
	}

	public void setResult(DataResult result) {
		this.result = result;
	}

	public DataQuery getQuery() {
		return query;
	}

	public void setQuery(DataQuery query) {
		this.query = query;
	}

	public PageSet getPageset() {
		return pageset;
	}

	public FarmDoctype getDoctype() {
		return doctype;
	}

	public void setDoctype(FarmDoctype doctype) {
		this.doctype = doctype;
	}

	public FarmDoc getDoc() {
		return doc;
	}

	public void setDoc(FarmDoc doc) {
		this.doc = doc;
	}

	public String getTypeid() {
		return typeid;
	}

	public void setTypeid(String typeid) {
		this.typeid = typeid;
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

	public String getDocgroup() {
		return docgroup;
	}

	public void setDocgroup(String docgroup) {
		this.docgroup = docgroup;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getKnowtype() {
		return knowtype;
	}

	public void setKnowtype(String knowtype) {
		this.knowtype = knowtype;
	}

	public String getKnowtitle() {
		return knowtitle;
	}

	public void setKnowtitle(String knowtitle) {
		this.knowtitle = knowtitle;
	}

	public String getKnowtag() {
		return knowtag;
	}

	public void setKnowtag(String knowtag) {
		this.knowtag = knowtag;
	}

	public String getWritetype() {
		return writetype;
	}

	public void setWritetype(String writetype) {
		this.writetype = writetype;
	}

	public String getReadtype() {
		return readtype;
	}

	public void setReadtype(String readtype) {
		this.readtype = readtype;
	}

	public boolean isIsenjoy() {
		return isenjoy;
	}

	public void setIsenjoy(boolean isenjoy) {
		this.isenjoy = isenjoy;
	}

	public Set<String> getFileTypes() {
		return fileTypes;
	}

	public void setFileTypes(Set<String> fileTypes) {
		this.fileTypes = fileTypes;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

}
