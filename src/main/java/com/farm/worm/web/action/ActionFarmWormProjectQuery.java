package com.farm.worm.web.action;

import com.farm.worm.Worm;
import com.farm.worm.domain.FarmWormProject;
import com.farm.worm.server.FarmWormProjectManagerInter;
import com.farm.worm.server.WormDocHandlePara;

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
 * 下载项目
 * 
 * @author autoCode
 * 
 */
public class ActionFarmWormProjectQuery extends WebSupport {
	private Map<String, Object> jsonResult;// 结果集合
	private DataQuery query;// 条件查询
	private FarmWormProject entity;// 实体封装
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
			DataResult result = aloneIMP
					.createFarmWormProjectSimpleQuery(query).search();
			result
					.runDictionary(
							"1:未执行,2:扫描URL,3:下载页面中,4:完成,5:异常,6:下载任务就绪,7:手动停止",
							"PSTATE");
			jsonResult = EasyUiUtils.formatGridData(result);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 进入运行时界面
	 * 
	 * @return
	 */
	public String runtime() {
		entity = aloneIMP.getFarmWormProjectEntity(ids);
		return SUCCESS;
	}

	/**
	 * 解析参数
	 * 
	 * @return
	 */
	public String checkPara() {
		WormDocHandlePara para = new WormDocHandlePara(ids);
		ids = "";
		for (String key : para.keySet()) {
			ids = ids + "参数" + key + "的值为" + para.get(key) + ";";
		}
		return SUCCESS;
	}

	/**
	 * 初始化项目状态
	 * 
	 * @return
	 */
	public String intiPro() {
		aloneIMP.editProjectState(ids, "1");
		return SUCCESS;
	}

	/**
	 * 初始化任务
	 * 
	 * @return
	 */
	public String initPro() {
		Worm.newInstance(ids, getCurrentUser()).runScanUrlTask();
		return SUCCESS;
	}

	/**
	 * 开始下载任务
	 * 
	 * @return
	 */
	public String startPro() {
		Worm.newInstance(ids, getCurrentUser()).runDownloadTask();
		return SUCCESS;
	}

	/**
	 * 停止任务
	 * 
	 * @return
	 */
	public String waitPro() {
		Worm.newInstance(ids, getCurrentUser()).stop();
		return SUCCESS;
	}

	/**
	 * 获取项目当前运行状态
	 * 
	 * @return
	 */
	public String loadStat() {
		jsonResult = Worm.newInstance(ids, getCurrentUser()).getStatNum();
		jsonResult.put("MESSAGE", Worm.newInstance(ids, getCurrentUser())
				.getLogs());
		return SUCCESS;
	}

	/**
	 * 提交修改数据
	 * 
	 * @return
	 */
	public String editSubmit() {
		try {
			entity = aloneIMP.editFarmWormProjectEntity(entity,
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
			entity = aloneIMP.insertFarmWormProjectEntity(entity,
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
				aloneIMP.deleteFarmWormProjectEntity(id, getCurrentUser());
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
				entity = aloneIMP.getFarmWormProjectEntity(ids);
				return SUCCESS;
			}
			case (2): {// 修改
				entity = aloneIMP.getFarmWormProjectEntity(ids);
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

	private final static FarmWormProjectManagerInter aloneIMP = (FarmWormProjectManagerInter) BeanFactory
			.getBean("farm_worm_projectProxyId");

	// ----------------------------------------------------------------------------------
	public DataQuery getQuery() {
		return query;
	}

	public void setQuery(DataQuery query) {
		this.query = query;
	}

	public FarmWormProject getEntity() {
		return entity;
	}

	public void setEntity(FarmWormProject entity) {
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

//	private static final Logger log = Logger
//			.getLogger(ActionFarmWormProjectQuery.class);
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
