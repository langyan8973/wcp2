package com.farm.worm.web.action;

import com.farm.worm.domain.FarmWormDocattr;
import com.farm.worm.server.FarmWormDocattrManagerInter;

import com.farm.web.easyui.EasyUiUtils;
import java.util.Map;
import com.farm.core.page.CommitType;
import com.farm.core.page.PageSet;
import com.farm.core.page.PageType;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.web.WebSupport;
import com.farm.web.spring.BeanFactory;

/**
 * 下载内容
 * 
 * @author autoCode
 * 
 */
public class ActionFarmWormDocattrQuery extends WebSupport {
	private Map<String, Object> jsonResult;// 结果集合
	private DataQuery query;// 条件查询
	private FarmWormDocattr entity;// 实体封装
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
			DataResult result=aloneIMP.createFarmWormDocattrSimpleQuery(query).search();
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
			entity = aloneIMP.editFarmWormDocattrEntity(entity, getCurrentUser());
			pageset = new PageSet(PageType.UPDATE, CommitType.TRUE);
		} catch (Exception e) {
			pageset=PageSet.initPageSet(pageset, PageType.UPDATE, CommitType.FALSE, e);
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
			entity = aloneIMP.insertFarmWormDocattrEntity(entity, getCurrentUser());
			pageset = new PageSet(PageType.ADD,CommitType.TRUE);
		} catch (Exception e) {
			pageset=PageSet.initPageSet(pageset, PageType.ADD, CommitType.FALSE, e);
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
				aloneIMP.deleteFarmWormDocattrEntity(id,getCurrentUser());
			}
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset=PageSet.initPageSet(pageset, PageType.DEL, CommitType.FALSE, e);
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
				entity = aloneIMP.getFarmWormDocattrEntity(ids);
				return SUCCESS;
			}
			case (2): {// 修改
				entity = aloneIMP.getFarmWormDocattrEntity(ids);
				return SUCCESS;
			}
			default:
				break;
			}
		} catch (Exception e) {
			pageset=PageSet.initPageSet(pageset, PageType.OTHER, CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	private final static FarmWormDocattrManagerInter aloneIMP = (FarmWormDocattrManagerInter) BeanFactory
			.getBean("farm_worm_docattrProxyId");

	// ----------------------------------------------------------------------------------
	public DataQuery getQuery() {
		return query;
	}

	public void setQuery(DataQuery query) {
		this.query = query;
	}

	public FarmWormDocattr getEntity() {
		return entity;
	}

	public void setEntity(FarmWormDocattr entity) {
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
//	private static final Logger log = Logger.getLogger(ActionFarmWormDocattrQuery.class);
	private static final long serialVersionUID = 1L;
	/**
	 * 加载树节点 public String loadTreeNode() { treeNodes =
	 * EasyUiTreeNode.formatAjaxTree(EasyUiTreeNode .queryTreeNodeOne(id,
	 * "SORT", "alone_menu", "ID", "PARENTID", "NAME").getResultList(),
	 * EasyUiTreeNode .queryTreeNodeTow(id, "SORT", "alone_menu", "ID",
	 * "PARENTID", "NAME").getResultList(), "PARENTID", "ID", "NAME"); return
	 * SUCCESS; }
	 * @return
	 */

	public String getProid() {
		return proid;
	}

	public void setProid(String proid) {
		this.proid = proid;
	}
	
}
