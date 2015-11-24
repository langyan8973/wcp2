package com.farm.doc.web.action;

import java.util.Map;

import com.farm.doc.domain.FarmDocfile;
import com.farm.doc.server.FarmFileManagerInter;

import com.farm.core.page.CommitType;
import com.farm.core.page.PageSet;
import com.farm.core.page.PageType;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.core.sql.result.DataResults;
import com.farm.web.WebSupport;
import com.farm.web.easyui.EasyUiUtils;
import com.farm.web.spring.BeanFactory;

/**
 * 文件
 * 
 * @author autoCode
 * 
 */
public class ActionFarmDocfileQuery extends WebSupport {
	private Map<String, Object> jsonResult;// 结果集合
	private DataResult result;// 结果集合
	private DataQuery query;// 条件查询
	private FarmDocfile entity;// 实体封装
	private PageSet pageset;// 请求状态
	private String ids;// 主键集合

	/**
	 * 查询结果集合
	 * 
	 * @return
	 */
	public String queryall() {
		try {
			query = EasyUiUtils.formatGridQuery(getRequest(), query);
			DataQuery dbQuery = DataQuery.init(query, "farm_docfile",
					"id,DIR,TYPE,NAME,EXNAME,LEN,FILENAME,PSTATE,PCONTENT");
			result = dbQuery.search();
			result.runDictionary("1:使用,0:临时", "PSTATE");
			result.runDictionary("1:图片,2:资源,3:压缩,0:其他", "TYPE");
			jsonResult = EasyUiUtils.formatGridData(result);
		} catch (Exception e) {
			result = DataResults.setException(result, e);
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
				fileIMP.delFile(id, getCurrentUser());
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
				entity = fileIMP.getFile(ids);
				entity.setUrl(fileIMP.getFileURL(ids));
				return SUCCESS;
			}
			case (2): {// 修改
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

	private final static FarmFileManagerInter fileIMP = (FarmFileManagerInter) BeanFactory
			.getBean("farm_docFileProxyId");

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

	public FarmDocfile getEntity() {
		return entity;
	}

	public void setEntity(FarmDocfile entity) {
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
