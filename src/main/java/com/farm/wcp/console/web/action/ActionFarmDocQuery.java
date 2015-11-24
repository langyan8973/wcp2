package com.farm.wcp.console.web.action;

import com.farm.doc.domain.FarmDoc;
import com.farm.doc.server.FarmDocManagerInter;
import com.farm.lucene.FarmLuceneFace;
import com.farm.lucene.server.DocIndexInter;

import java.io.IOException;

import com.farm.wcp.know.common.LuceneDocUtil;
import com.farm.wcp.know.server.WcpKnowManagerInter;
import com.farm.wcp.website.server.WcpWebSiteManagerInter;
import com.farm.web.WebSupport;
import com.farm.web.easyui.EasyUiUtils;

import java.sql.SQLException;
import java.util.Map;
import com.farm.core.page.CommitType;
import com.farm.core.page.PageSet;
import com.farm.core.page.PageType;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.web.spring.BeanFactory;

/**
 * 知识管理
 * 
 * @author autoCode
 * 
 */
public class ActionFarmDocQuery extends WebSupport {
	private Map<String, Object> jsonResult;// 结果集合
	private DataQuery query;// 条件查询
	private FarmDoc entity;// 实体封装
	private PageSet pageset;// 请求状态
	private String ids;// 主键集合
	private FarmLuceneFace luceneImpl = FarmLuceneFace.inctance();
	private static int currentDocs = 0;//索引文档计数器
	private int cdocs;

	/**
	 * 查询结果集合
	 * 
	 * @return
	 */
	public String queryall() {
		try {
			query = EasyUiUtils.formatGridQuery(getRequest(), query);
			query = DataQuery
					.init(
							query,
							"farm_doc",
							"'1',TITLE,DOCDESCRIBE,AUTHOR,PUBTIME,DOMTYPE,SHORTTITLE,TAGKEY,SOURCE,TOPLEVE,IMGID,STATE,CTIME,ETIME,PCONTENT,READPOP,WRITEPOP,RUNINFOID");
			DataResult result = query.search();
			result.runDictionary("1:HTML文档,2:txt,3:html站点", "DOMTYPE");
			result.runDictionary("1:公开,0:本人,2:小组,3:禁止编辑", "WRITEPOP");
			result.runDictionary("1:公开,0:本人,2:小组,3:禁止编辑", "READPOP");
			result.runDictionary("1:开放,0:禁用,2:待审核", "STATE");
			jsonResult = EasyUiUtils.formatGridData(result);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 重做索引
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String reIndex() {
		currentDocs=0;
		DataResult result;
		query = DataQuery.init(query, "farm_doc", "id,title");
		query.setCurrentPage(1);
		query.addRule(new DBRule("STATE", "1", "="));
		query.addRule(new DBRule("READPOP", "1", "="));
		int i = 1;
		int doNum = 0;
		int doNum_error = 0;
		DocIndexInter indexKnow = null;
		DocIndexInter indexWebsite = null;
		DocIndexInter indexWebFile=null;
		try {
			indexKnow = luceneImpl.getDocIndex(luceneImpl
					.getIndexPathFile(WcpKnowManagerInter.LUCENE_DIR));
			indexWebsite = luceneImpl.getDocIndex(luceneImpl
					.getIndexPathFile(WcpWebSiteManagerInter.LUCENE_DIR));
			indexWebFile = luceneImpl.getDocIndex(luceneImpl
					.getIndexPathFile(WcpWebSiteManagerInter.LUCENE_DIR));
			while (true) {
				try {
					query.setPagesize(100);
					query.setCurrentPage(i++);
					result = query.search();
					if (result.getResultList().size() <= 0) {
						break;
					}
					for (Map<String, Object> node : result.getResultList()) {
						FarmDoc doc = aloneIMP
								.getDoc(node.get("ID").toString());
						DocIndexInter curentIndex = null;
						curentIndex = indexKnow;
						if (doc.getDomtype().equals("3")) {
							curentIndex = indexWebsite;
						}
						if (doc.getDomtype().equals("5")) {
							curentIndex = indexWebFile;
						}
						try {
							currentDocs++;
							curentIndex.deleteFhysicsIndex(doc.getId());
							if ("1".equals(doc.getReadpop())
									&& "1".equals(doc.getState())) {
								curentIndex.indexDoc(LuceneDocUtil
										.getDocMap(doc));
							}
							doNum++;
						} catch (Exception e) {
							e.printStackTrace();
							doNum_error++;
							continue;
						}
					}
				} catch (SQLException e1) {
					e1.printStackTrace();
					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				indexKnow.close();
				indexWebsite.close();
			} catch (Exception e) {
			}
		}
		pageset = new PageSet(PageType.OTHER, CommitType.TRUE);
		pageset.setMessage("共完成索引" + doNum + "个，失败" + doNum_error + "个");
		return SUCCESS;
	}

	/**
	 * 获取当前索引状态
	 * 
	 * @return
	 */
	public String loadIndexStatr() {
		cdocs=currentDocs;
		return SUCCESS;
	}

	/**
	 * 跳转
	 * 
	 * @return
	 */
	public String forSend() {
		return SUCCESS;
	}

	private final static FarmDocManagerInter aloneIMP = (FarmDocManagerInter) BeanFactory
			.getBean("farm_docProxyId");

	// ----------------------------------------------------------------------------------
	public DataQuery getQuery() {
		return query;
	}

	public void setQuery(DataQuery query) {
		this.query = query;
	}

	public FarmDoc getEntity() {
		return entity;
	}

	public void setEntity(FarmDoc entity) {
		this.entity = entity;
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

	public Map<String, Object> getJsonResult() {
		return jsonResult;
	}

	public void setJsonResult(Map<String, Object> jsonResult) {
		this.jsonResult = jsonResult;
	}
	
	public int getCdocs() {
		return cdocs;
	}

	public void setCdocs(int cdocs) {
		this.cdocs = cdocs;
	}

//	private static final Logger log = Logger
//			.getLogger(ActionFarmDocQuery.class);
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
}
