package com.farm.worm.web.action;

import com.farm.worm.domain.FarmWormAttrparse;
import com.farm.worm.server.FarmWormAttrparseManagerInter;

import com.farm.web.easyui.EasyUiUtils;
import java.util.Map;
import com.farm.core.page.CommitType;
import com.farm.core.page.PageSet;
import com.farm.core.page.PageType;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.web.WebSupport;
import com.farm.web.spring.BeanFactory;

/**
 * 任务属性
 * 
 * @author autoCode
 * 
 */
public class ActionFarmWormAttrparseQuery extends WebSupport {
	private Map<String, Object> jsonResult;// 结果集合
	private DataQuery query;// 条件查询
	private FarmWormAttrparse entity;// 实体封装
	private PageSet pageset;// 请求状态
	private String ids;// 主键集合
	private String proid;

	/**
	 * 查询结果集合
	 * 
	 * @return
	 */
	public String queryall() {
		try {
			query = EasyUiUtils.formatGridQuery(getRequest(), query);
			DataResult result = aloneIMP.createFarmWormAttrparseSimpleQuery(
					query).addRule(new DBRule("PROJECTID", proid, "="))
					.search();
			result.runDictionary("1:可用,0:禁用", "PSTATE");
			jsonResult = EasyUiUtils.formatGridData(result);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 提交修改数据
	 * 
	 * @return
	 */
	public String editSubmit() {
		try {
			entity = aloneIMP.editFarmWormAttrparseEntity(entity,
					getCurrentUser());
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
			entity = aloneIMP.insertFarmWormAttrparseEntity(entity,
					getCurrentUser());
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
				aloneIMP.deleteFarmWormAttrparseEntity(id, getCurrentUser());
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
				return SUCCESS;
			}
			case (0): {// 展示
				entity = aloneIMP.getFarmWormAttrparseEntity(ids);
				return SUCCESS;
			}
			case (2): {// 修改
				entity = aloneIMP.getFarmWormAttrparseEntity(ids);
				return SUCCESS;
			}
			default:
				break;
			}
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.OTHER,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	private final static FarmWormAttrparseManagerInter aloneIMP = (FarmWormAttrparseManagerInter) BeanFactory
			.getBean("farm_worm_attrparseProxyId");

	// ----------------------------------------------------------------------------------
	public DataQuery getQuery() {
		return query;
	}

	public void setQuery(DataQuery query) {
		this.query = query;
	}

	public FarmWormAttrparse getEntity() {
		return entity;
	}

	public void setEntity(FarmWormAttrparse entity) {
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

	public String getProid() {
		return proid;
	}

	public void setProid(String proid) {
		this.proid = proid;
	}

//	private static final Logger log = Logger
//			.getLogger(ActionFarmWormAttrparseQuery.class);
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
