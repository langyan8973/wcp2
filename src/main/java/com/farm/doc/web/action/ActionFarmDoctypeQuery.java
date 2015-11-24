package com.farm.doc.web.action;

import java.util.List;
import java.util.Map;

import com.farm.doc.domain.FarmDoctype;
import com.farm.doc.server.FarmDocManagerInter;

import com.farm.core.page.CommitType;
import com.farm.core.page.PageSet;
import com.farm.core.page.PageType;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.core.sql.result.DataResults;
import com.farm.web.WebSupport;
import com.farm.web.easyui.EasyUiTreeNode;
import com.farm.web.easyui.EasyUiUtils;
import com.farm.web.spring.BeanFactory;

/**
 * 文档分类
 * 
 * @author autoCode
 * 
 */
public class ActionFarmDoctypeQuery extends WebSupport {
	private DataResult result;// 结果集合
	private DataQuery query;// 条件查询
	private FarmDoctype entity;// 实体封装
	private FarmDoctype fatherEntity;// 实体封装
	private PageSet pageset;// 请求状态
	private String ids;// 主键集合
	private String id;// 异步树传入的id
	private List<EasyUiTreeNode> treeNodes;// 异步树的封装
	private Map<String, Object> jsonResult;// 结果集合
	private FarmDoctype parent;// 实体封装

	/**
	 * 查询结果集合
	 * 
	 * @return
	 */
	public String queryall() {
		try {
			query = EasyUiUtils.formatGridQuery(getRequest(), query);
			result = aloneIMP.createSimpleTypeQuery(query).search()
					.runDictionary(getDictionary("FARM_DOCTYE_TYPEMOD"),
							"TYPEMOD").runDictionary(
							getDictionary("FARM_DOCTYE_DOCMOD"), "CONTENTMOD")
					.runDictionary("1:内容,2:建设,3:结构,4:链接,5:单页", "TYPE")
					.runDictionary("1:可用,0:禁用", "PSTATE");
			jsonResult = EasyUiUtils.formatGridData(result);
		} catch (Exception e) {
			result = DataResults.setException(result, e);
		}
		return SUCCESS;
	}

	/**
	 * 加载子节点
	 * 
	 * @return
	 */
	public String loadTreeNode() {
		treeNodes = EasyUiTreeNode.formatAsyncAjaxTree(EasyUiTreeNode
				.queryTreeNodeOne(id, "SORT", "FARM_DOCTYPE", "ID", "PARENTID",
						"NAME", "CTIME").getResultList(), EasyUiTreeNode
				.queryTreeNodeTow(id, "SORT", "FARM_DOCTYPE", "ID", "PARENTID",
						"NAME", "CTIME").getResultList(), "PARENTID", "ID",
				"NAME", "CTIME");
		return SUCCESS;
	}

	/**
	 * 提交修改数据
	 * 
	 * @return
	 */
	public String editSubmit() {
		try {
			entity = aloneIMP.editType(entity, getCurrentUser());
			pageset = new PageSet(PageType.UPDATE, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.UPDATE,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 提交新增数据
	 * 
	 * @return
	 */
	public String addSubmit() {
		try {
			entity = aloneIMP.insertType(entity, getCurrentUser());
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.ADD,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 删除数据
	 * 
	 * @return
	 */
	public String delSubmit() {
		try {
			for (String id : parseIds(ids)) {
				aloneIMP.deleteType(id, getCurrentUser());
			}
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.DEL,
					CommitType.FALSE, e);
		}
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

	/**
	 * 显示详细信息（修改或浏览时）
	 * 
	 * @return
	 */
	 public String view() {
	        try {
	             switch (pageset.getPageType()) {
	             case (1): {// 新增
	                 break;
	             }
	             case (0): {// 展示
	                 entity = aloneIMP.getType(ids);
	                 parent = new FarmDoctype();
	                 parent.setId(entity.getParentid());
	                 break;
	             }
	             case (2): {// 修改
	                 entity = aloneIMP.getType(ids);
	                 parent = new FarmDoctype();
	                 parent.setId(entity.getParentid());
	                 break;
	             }
	             default:
	                break;
	             }
	             if (parent != null) {
	                 parent = aloneIMP.getType(parent.getId());
	             }
	         } catch (Exception e) {
	             pageset = PageSet.initPageSet(pageset, PageType.OTHER,
	                 CommitType.FALSE, e);
	         }
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

	public DataResult getResult() {
		return result;
	}

	public void setResult(DataResult result) {
		this.result = result;
	}

	public FarmDoctype getEntity() {
		return entity;
	}

	public void setEntity(FarmDoctype entity) {
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

	public List<EasyUiTreeNode> getTreeNodes() {
		return treeNodes;
	}

	public void setTreeNodes(List<EasyUiTreeNode> treeNodes) {
		this.treeNodes = treeNodes;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public FarmDoctype getFatherEntity() {
		return fatherEntity;
	}

	public void setFatherEntity(FarmDoctype fatherEntity) {
		this.fatherEntity = fatherEntity;
	}

	public Map<String, Object> getJsonResult() {
		return jsonResult;
	}

	public void setJsonResult(Map<String, Object> jsonResult) {
		this.jsonResult = jsonResult;
	}

	public FarmDoctype getParent() {
		return parent;
	}

	public void setParent(FarmDoctype parent) {
		this.parent = parent;
	}

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
