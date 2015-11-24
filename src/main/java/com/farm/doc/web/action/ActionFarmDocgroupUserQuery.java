package com.farm.doc.web.action;

import com.farm.doc.domain.FarmDocgroupUser;
import com.farm.doc.server.FarmDocgroupManagerInter;

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
 * 工作小组成员
 * 
 * @author autoCode
 * 
 */
public class ActionFarmDocgroupUserQuery extends WebSupport {
	private Map<String, Object> jsonResult;// 结果集合
	private DataQuery query;// 条件查询
	private FarmDocgroupUser entity;// 实体封装
	private PageSet pageset;// 请求状态
	private String ids;// 主键集合
	private String userids;

	/**
	 * 查询结果集合
	 * 
	 * @return
	 */
	public String queryall() {
		try {
			query = EasyUiUtils.formatGridQuery(getRequest(), query);
			if (ids != null) {
				query.addRule(new DBRule("GROUPID", ids, "="));
			}
			DataResult result = aloneIMP.createFarmDocgroupUserSimpleQuery(
					query).search();
			result.runDictionary("1:是,0:否", "LEADIS");
			result.runDictionary("1:是,0:否", "EDITIS");
			result.runDictionary("1:在用,0:邀请,2:删除,3:申请", "PSTATE");
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

			entity = aloneIMP.editMinFarmDocgroupUserEntity(entity,
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
			for (String uerId : parseIds(userids)) {
				if (!aloneIMP.isJoinGroupByUser(ids, uerId)) {
					FarmDocgroupUser groupUser = aloneIMP.applyGroup(ids,
							uerId, "系统管理员操作", getCurrentUser());
					aloneIMP
							.agreeJoinApply(groupUser.getId(), getCurrentUser());
					aloneIMP.setEditorForGroup(groupUser.getId(),
							getCurrentUser());
				}
			}
			pageset = new PageSet(PageType.UPDATE, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.UPDATE,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 设置管理员
	 * 
	 * @return
	 */
	public String adminSubmit() {
		try {
			aloneIMP.setAdminForGroup(ids, getCurrentUser());
			pageset = new PageSet(PageType.UPDATE, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.UPDATE,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 取消管理员
	 * 
	 * @return
	 */
	public String reAdminSubmit() {
		try {
			FarmDocgroupUser groupUser = aloneIMP
					.getFarmDocgroupUserEntity(ids);
			if (groupUser.getUserid().equals(getCurrentUser().getId())) {
				throw new RuntimeException("不能取消自己为管理员!");
			}
			aloneIMP.wipeAdminFromGroup(ids, getCurrentUser());
			pageset = new PageSet(PageType.UPDATE, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.UPDATE,
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
				FarmDocgroupUser groupUser = aloneIMP
						.getFarmDocgroupUserEntity(id);
				if (groupUser.getUserid().equals(getCurrentUser().getId())) {
					throw new RuntimeException("不能删除自己!");
				}
				aloneIMP.deleteFarmDocgroupUserEntity(id, getCurrentUser());
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
				entity = aloneIMP.getFarmDocgroupUserEntity(ids);
				return SUCCESS;
			}
			case (2): {// 修改
				entity = aloneIMP.getFarmDocgroupUserEntity(ids);
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

	private final static FarmDocgroupManagerInter aloneIMP = (FarmDocgroupManagerInter) BeanFactory
			.getBean("farm_docgroupProxyId");

	// ----------------------------------------------------------------------------------
	public DataQuery getQuery() {
		return query;
	}

	public void setQuery(DataQuery query) {
		this.query = query;
	}

	public FarmDocgroupUser getEntity() {
		return entity;
	}

	public void setEntity(FarmDocgroupUser entity) {
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

	public String getUserids() {
		return userids;
	}

	public void setUserids(String userids) {
		this.userids = userids;
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
