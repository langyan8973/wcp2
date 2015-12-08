package com.farm.wcp.lucene.web.action;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.farm.doc.domain.FarmDoc;
import com.farm.doc.server.FarmDocManagerInter;
import com.farm.doc.server.commons.FarmDocFiles;
import com.farm.lucene.FarmLuceneFace;
import com.farm.lucene.server.DocQueryImpl;
import com.farm.lucene.server.DocQueryInter;
import com.farm.core.FarmService;
import com.farm.core.page.PageSet;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DBSort;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.query.DataQuery.CACHE_UNIT;
import com.farm.core.sql.result.DataResult;
import com.farm.util.web.FarmFormatUnits;
import com.farm.util.web.WebHotCase;
import com.farm.wcp.know.server.WcpKnowManagerInter;
import com.farm.wcp.webfile.server.WcpWebFileManagerInter;
import com.farm.wcp.website.server.WcpWebSiteManagerInter;
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
	private String word;//
	private Integer pagenum;
	private List<String> hotCase;

	public String search() {
		try {
			// TITLE,PUBTIME,VISITNUM,TYPENAME,AUTHOR,TAGKEY,DOCDESCRIBE,TEXT
			hotCase = WebHotCase.getCases(10);
			if (word == null || word.trim().length() <= 0) {
				result = DataResult.getInstance(
						new ArrayList<Map<String, Object>>(), 0, 1, 10);
				return SUCCESS;
			}
			List<File> file = new ArrayList<File>();
			file.add(FarmLuceneFace.inctance().getIndexPathFile(
					WcpKnowManagerInter.LUCENE_DIR));
			file.add(FarmLuceneFace.inctance().getIndexPathFile(
					WcpWebSiteManagerInter.LUCENE_DIR));
			file.add(FarmLuceneFace.inctance().getIndexPathFile(
					WcpWebFileManagerInter.LUCENE_DIR));
			DocQueryInter query = DocQueryImpl.getInstance(file);
			String iql = null;
			word = FarmDocFiles.HtmlRemoveTag(word.trim());
			if (word.indexOf("TYPE:") >= 0 && iql == null) {
				word = word.substring(word.indexOf("TYPE:") + 5).replaceAll(
						":", "");
				iql = "WHERE(TAGKEY,TYPENAME=" + word + ")";
			}
			if (word.indexOf("AUTHOR:") >= 0 && iql == null) {
				word = word.substring(word.indexOf("AUTHOR:") + 7).replaceAll(
						":", "");

				iql = "WHERE(AUTHOR=" + word + ")";
			}
			if (iql == null) {
				// word.substring(word.indexOf("TYPE:"));
				iql = "WHERE(TITLE,TEXT,TAGKEY,TYPENAME,AUTHOR="
						+ word.replaceAll(":", "") + ")";
			}
			if (pagenum == null) {
				pagenum = 1;
			}
			WebHotCase.putCase(word);
			result = query.queryByMultiIndex(iql, pagenum, 10).getDataResult();
			for (Map<String, Object> node : result.getResultList()) {
				node.put("PUBTIME", FarmFormatUnits.getFormateTime(node.get(
						"PUBTIME").toString(), true));
				String tags = node.get("TAGKEY").toString();
				String text = node.get("TEXT").toString();
				node.put("DOCDESCRIBE", text.length() > 256 ? text.substring(0,
						256) : text);
				if (tags != null && tags.trim().length() > 0) {
					String[] tags1 = tags.trim().replaceAll("，", ",")
							.replaceAll("、", ",").split(",");
					node.put("TAGKEY", Arrays.asList(tags1));
				} else {
					node.put("TAGKEY", new ArrayList<String>());
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	

	public String docRelationsearch() {
		try {
			FarmDoc doc = docIMP.getDocOnlyBean(id);
			if (doc == null) {
				result = DataResult.getInstance(
						new ArrayList<Map<String, Object>>(), 0, 1, 5);
				return SUCCESS;
			}
			// TITLE,PUBTIME,VISITNUM,TYPENAME,AUTHOR,TAGKEY,DOCDESCRIBE,TEXT
			
			List<File> file = new ArrayList<File>();
			file.add(FarmLuceneFace.inctance().getIndexPathFile(
					WcpKnowManagerInter.LUCENE_DIR));
			file.add(FarmLuceneFace.inctance().getIndexPathFile(
					WcpWebSiteManagerInter.LUCENE_DIR));
			file.add(FarmLuceneFace.inctance().getIndexPathFile(
					WcpWebFileManagerInter.LUCENE_DIR));
			DocQueryInter query = DocQueryImpl.getInstance(file);
			String iql = null;
			if (iql == null) {
				iql = "WHERE(TITLE,TEXT,TAGKEY,TYPENAME,AUTHOR="
						+ FarmDocFiles.HtmlRemoveTag(doc.getTitle().trim())
								.replaceAll(":", "") + ")";
			}
			result = query.queryByMultiIndex(iql, 1, 5).getDataResult();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	// private final static WcpKnowManagerInter knowIMP = (WcpKnowManagerInter)
	// BeanFactory
	// .getBean("wcp_KnowProxyId");
	// private final static FarmDocManagerInter docIMP = (FarmDocManagerInter)
	// BeanFactory
	// .getBean("farm_docProxyId");
	// ----------------------------------------------------------------------------------
	// private static final Logger log = Logger.getLogger(ActionIndex.class);
	private final static FarmDocManagerInter docIMP = (FarmDocManagerInter) BeanFactory
			.getBean("farm_docProxyId");
	private static final long serialVersionUID = 1L;

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

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	public Integer getPagenum() {
		return pagenum;
	}

	public void setPagenum(Integer pagenum) {
		this.pagenum = pagenum;
	}

	public List<String> getHotCase() {
		return hotCase;
	}

	public void setHotCase(List<String> hotCase) {
		this.hotCase = hotCase;
	}

}
