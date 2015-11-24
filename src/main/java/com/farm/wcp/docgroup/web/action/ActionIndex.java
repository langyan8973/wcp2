package com.farm.wcp.docgroup.web.action;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.farm.core.page.CommitType;
import com.farm.core.page.PageSet;
import com.farm.core.page.PageType;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DBSort;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.core.sql.result.DataResults;
import com.farm.doc.domain.FarmDoc;
import com.farm.doc.domain.FarmDocgroup;
import com.farm.doc.domain.FarmDocgroupUser;
import com.farm.doc.exception.CanNoWriteException;
import com.farm.doc.exception.NoGroupAuthForLicenceException;
import com.farm.doc.server.FarmDocManagerInter;
import com.farm.doc.server.FarmDocgroupManagerInter;
import com.farm.doc.server.FarmFileManagerInter;
import com.farm.util.web.FarmFormatUnits;
import com.farm.web.WebSupport;
import com.farm.web.easyui.EasyUiUtils;
import com.farm.web.spring.BeanFactory;

/**
 * 文件
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
	private String id;// 主键集合
	private FarmDocgroup group;
	private FarmDocgroupUser usergroup;
	private int adminNum;// 小组的管理员数量
	private List<FarmDocgroupUser> userList;// 小组成员
	private String searchGroupKey;// 小组查询条件
	private String searchDocKey;// 文档查询条件
	private int docnum;
	private FarmDoc doc;
	private String text;
	private String editNote;// 修改备注

	/**
	 * 查询我的小组文档
	 * 
	 * @return
	 */
	public String queryGroupDoc() {
		try {
			if (searchDocKey != null && searchDocKey.trim().length() > 0) {
				query.addRule(new DBRule("a.TITLE", searchDocKey, "like"));
			}
			result = docGroupIMP.createUserGroupDocQuery(query,
					getCurrentUser().getId()).search();
			for (Map<String, Object> node : result.getResultList()) {
				if (node.get("GROUPIMG") != null) {
					node.put("GROUPIMG",
							fileIMP.getFileURL(node.get("GROUPIMG").toString()));
				}
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 初始化小组首页数据
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String loadGroupHome() {
		// 获取小组首页
		FarmDocgroup group = docGroupIMP.getFarmDocgroupEntity(id);
		doc = docIMP.getDoc(group.getHomedocid());
		return SUCCESS;
	}

	/**
	 * 提交小组首页修改
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String editGroupHomeCommit() {
		doc = docIMP.getDoc(doc.getId());
		doc.getTexts().setText1(text);
		try {
			docIMP.editDocByUser(doc, editNote, getCurrentUser());
		} catch (CanNoWriteException e) {
			return "error";
		}
		return SUCCESS;
	}

	/**
	 * 编辑小组首页
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public String editGroupHome() {
		// 获取小组首页
		group = docGroupIMP.getFarmDocgroupEntity(id);
		doc = docIMP.getDoc(group.getHomedocid());
		return SUCCESS;
	}

	/**
	 * 首页我的小组动态
	 * 
	 * @return
	 */
	public String loadHomeMyGroup() {
		try {
			result = docGroupIMP.createUserGroupDocQuery(query,
					getCurrentUser().getId()).search();
			for (Map<String, Object> node : result.getResultList()) {
				if (node.get("GROUPIMG") != null) {
					node.put("GROUPIMG",
							fileIMP.getFileURL(node.get("GROUPIMG").toString()));
				}
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 加载用户小组动态
	 * 
	 * @return
	 */
	public String loadUserGroup() {
		try {
			query = EasyUiUtils.formatGridQuery(getRequest(), query);
			query.setPagesize(3);
			result = docGroupIMP
					.createFarmDocgroupQueryJoinUser(query)
					.addRule(new DBRule("a.PSTATE", "1", "="))
					.addRule(new DBRule("b.PSTATE", "1", "="))
					.addRule(
							new DBRule("b.USERID", id,
									"="))
					.addSort(new DBSort("SHOWSORT,a.CTIME", "ASC")).search();
			for (Map<String, Object> node : result.getResultList()) {
				if (node.get("GROUPIMG") != null) {
					node.put("GROUPIMG",
							fileIMP.getFileURL(node.get("GROUPIMG").toString()));
				}
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 首页公共小组
	 * 
	 * @return
	 */
	public String loadHomePubGroup() {
		try {
			query = EasyUiUtils.formatGridQuery(getRequest(), query);
			query.setPagesize(4);
			if (getCurrentUser() != null) {
				query = docGroupIMP.createFarmDocgroupQueryNuContainUser(query,
						getCurrentUser().getId());
				result = query.addRule(new DBRule("a.PSTATE", "1", "="))
						.search();
			} else {
				query = docGroupIMP.createFarmDocgroupQuery(query);
				result = query.addRule(new DBRule("PSTATE", "1", "=")).search();

			}
			query.addSort(new DBSort("USERNUM", "desc"));
			for (Map<String, Object> node : result.getResultList()) {
				if (node.get("GROUPIMG") != null) {
					node.put("GROUPIMG",
							fileIMP.getFileURL(node.get("GROUPIMG").toString()));
				}
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 加载小组的最新文档
	 * 
	 * @return
	 */
	public String loadGroupNewDoc() {
		try {
			result = docGroupIMP.getGroupNewDocQuery(query, id,
					getCurrentUser()).search();
			for (Map<String, Object> node : result.getResultList()) {
				node.put("PUBTIME", FarmFormatUnits.getFormateTime(
						node.get("PUBTIME").toString(), true));
			}
		} catch (Exception e) {
			result = DataResults.setException(result, e);
		}
		return SUCCESS;
	}

	/**
	 * 加载小组的优质文档
	 * 
	 * @return
	 */
	public String loadGroupGoodDoc() {
		try {
			result = docGroupIMP.getGroupGoodDocQuery(query, id,
					getCurrentUser()).search();
			for (Map<String, Object> node : result.getResultList()) {
				node.put("PUBTIME", FarmFormatUnits.getFormateTime(
						node.get("PUBTIME").toString(), true));
			}
		} catch (Exception e) {
			result = DataResults.setException(result, e);
		}
		return SUCCESS;
	}

	/**
	 * 加载小组的待改善文档
	 * 
	 * @return
	 */
	public String loadGroupBadDoc() {
		try {
			result = docGroupIMP.getGroupBadDocQuery(query, id,
					getCurrentUser()).search();
			for (Map<String, Object> node : result.getResultList()) {
				node.put("PUBTIME", FarmFormatUnits.getFormateTime(
						node.get("PUBTIME").toString(), true));
			}
		} catch (Exception e) {
			result = DataResults.setException(result, e);
		}
		return SUCCESS;
	}

	/**
	 * 加载小组的最热文档
	 * 
	 * @return
	 */
	public String loadGroupHotDoc() {
		try {
			result = docGroupIMP.getGroupHotDocQuery(query, id,
					getCurrentUser()).search();
			for (Map<String, Object> node : result.getResultList()) {
				node.put("PUBTIME", FarmFormatUnits.getFormateTime(
						node.get("PUBTIME").toString(), true));
			}
		} catch (Exception e) {
			result = DataResults.setException(result, e);
		}
		return SUCCESS;
	}

	/**
	 * 小组首页显示
	 * 
	 * @return
	 */
	public String groupHomeShow() {
		try {
			docGroupIMP.setGroupHomeShow(id, getCurrentUser().getId());
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.ADD,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 小组首页隐藏
	 * 
	 * @return
	 */
	public String groupHomeHide() {
		try {
			docGroupIMP.setGroupHomeHide(id, getCurrentUser().getId());
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.ADD,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 小组显示排序上移
	 * 
	 * @return
	 */
	public String groupSortUp() {
		try {
			docGroupIMP.setGroupSortUp(id, getCurrentUser().getId());
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.ADD,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 设置为小组管理员
	 * 
	 * @return
	 */
	public String groupSetAdmin() {
		try {
			docGroupIMP.setAdminForGroup(id, getCurrentUser());
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.ADD,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 设置小组编辑权限
	 * 
	 * @return
	 */
	public String groupSetEditor() {
		try {
			docGroupIMP.setEditorForGroup(id, getCurrentUser());
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.ADD,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 去除小组编辑权限
	 * 
	 * @return
	 */
	public String groupWipeEditor() {
		try {
			docGroupIMP.wipeEditorForGroup(id, getCurrentUser());
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.ADD,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 取消用户管理员权限
	 * 
	 * @return
	 */
	public String groupWipeAdmin() {
		try {
			docGroupIMP.wipeAdminFromGroup(id, getCurrentUser());
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.ADD,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 将用户退出小组
	 * 
	 * @return
	 */
	public String groupQuit() {
		try {
			docGroupIMP.leaveGroup(id, getCurrentUser());
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.ADD,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 同意加入申请
	 * 
	 * @return
	 */
	public String groupAgreeApply() {
		try {
			docGroupIMP.agreeJoinApply(id, getCurrentUser());
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.ADD,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 拒绝加入申请
	 * 
	 * @return
	 */
	public String groupRefuseApply() {
		try {
			docGroupIMP.refuseJoinApply(id, getCurrentUser());
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.ADD,
					CommitType.FALSE, e);
		}
		return SUCCESS;
	}

	/**
	 * 管理员管理页面
	 * 
	 * @return
	 */
	public String GroupAdministratorMng() {
		query = DataQuery
				.init(query,
						"farm_docgroup_user a LEFT JOIN ALONE_AUTH_USER b ON a.userid=b.id",
						"b.name as name,a.id as id,a.PSTATE as state,EDITIS,LEADIS,APPLYNOTE,userid");
		query.addRule(new DBRule("LEADIS", "1", "="));
		query.addRule(new DBRule("GROUPID", id, "="));
		query.addRule(new DBRule("a.PSTATE", "1", "="));
		try {
			result = query.search();
			result.runDictionary("1:是,0:否", "EDITIS");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	/**
	 * 申请人员管理页面
	 * 
	 * @return
	 */
	public String GroupApplyMng() {
		query = DataQuery
				.init(query,
						"farm_docgroup_user a LEFT JOIN ALONE_AUTH_USER b ON a.userid=b.id",
						"b.name as name,a.id as id,a.PSTATE as state,EDITIS,LEADIS,APPLYNOTE,userid");
		query.addRule(new DBRule("GROUPID", id, "="));
		query.addRule(new DBRule("a.PSTATE", "3", "="));
		try {
			result = query.search();
			result.runDictionary("1:是,0:否", "EDITIS");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	/**
	 * 小组成员管理页面
	 * 
	 * @return
	 */
	public String GroupUserMng() {
		query = DataQuery
				.init(query,
						"farm_docgroup_user a LEFT JOIN ALONE_AUTH_USER b ON a.userid=b.id",
						"b.name as name,a.id as id,a.PSTATE as state,EDITIS,EDITIS as EDITISTITLE,LEADIS,APPLYNOTE,userid");
		query.addRule(new DBRule("LEADIS", "0", "="));
		query.addRule(new DBRule("GROUPID", id, "="));
		query.addRule(new DBRule("a.PSTATE", "1", "="));
		try {
			result = query.search();
			result.runDictionary("1:是,0:否", "EDITISTITLE");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	/**
	 * 小组详情页面
	 * 
	 * @return
	 */
	public String groupShow() {
		try {
			group = docGroupIMP.getFarmDocgroupEntity(id);
			// 如果小组时需要验证的则不允许没有授权的用户查看小组
			{
				if (group.getJoincheck().equals("1")) {
					if (getCurrentUser().getLoginname() == null
							|| !docGroupIMP.isJoinGroupByUser(id,
									getCurrentUser().getId())) {
						throw new RuntimeException("您没有访问权限");
					}
				}
			}
			query = DataQuery
					.getInstance("1",
							"b.NAME AS NAME,a.ID AS id,b.id as USERID",
							" FARM_DOCGROUP_USER a  LEFT JOIN ALONE_AUTH_USER b ON a.USERID = b.id")
					.addRule(new DBRule("A.PSTATE", "1", "="))
					.addRule(new DBRule("A.LEADIS", "1", "="))
					.addRule(new DBRule("a.GROUPID", id, "="));
			result = query.search();
			if (getCurrentUser() != null) {
				if (docGroupIMP.isJoinGroupByUser(id, getCurrentUser().getId())) {
					usergroup = docGroupIMP.getFarmDocgroupUser(id,
							getCurrentUser().getId());
				}
			}
			docnum = docGroupIMP.getGroupDocNum(id);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 进入小组成员管理页面
	 * 
	 * @return
	 */
	public String groupAdministratorConsole() {
		try {
			group = docGroupIMP.getFarmDocgroupEntity(id);
			usergroup = docGroupIMP.getFarmDocgroupUser(id, getCurrentUser()
					.getId());
		} catch (Exception e) {
		}
		return SUCCESS;
	}

	/**
	 * 是否有小组管理员存在,通过小组管理员数量判断
	 * 
	 * @return
	 */
	public String haveAdministratorIs() {
		adminNum = docGroupIMP.getAllAdministratorByGroup(id).size();
		return SUCCESS;
	}

	/**
	 * 退出小组
	 * 
	 * @return
	 */
	public String leaveGroup() {
		docGroupIMP.leaveGroup(id, getCurrentUser().getId());
		pageset = new PageSet(PageType.OTHER, CommitType.TRUE);
		pageset.setMessage("成功退出小组");
		index();
		return SUCCESS;
	}

	/**
	 * 加入工作小组
	 * 
	 * @return
	 */
	public String groupjoin() {
		if (docGroupIMP.isJoinGroupByUser(id, getCurrentUser().getId())) {
			index();
			pageset = new PageSet(PageType.OTHER, CommitType.FALSE);
			pageset.setMessage("已经加入该小组,或者正在审核中");
			return "error";
		}
		String applyNote = null;
		if (docGroupIMP.isJoinCheck(id)) {
			if (usergroup == null || usergroup.getApplynote() == null) {
				// 如果，小组需要验证才能加入，而且此时还没有输入验证信息则去填写验证信息
				group = docGroupIMP.getFarmDocgroupEntity(id);
				return "FORM";
			}
			applyNote = usergroup.getApplynote();
		} else {
			applyNote = "用户加入小组";
		}
		docGroupIMP.applyGroup(id, getCurrentUser().getId(), applyNote,
				getCurrentUser());
		pageset = new PageSet(PageType.OTHER, CommitType.TRUE);
		index();
		if (docGroupIMP.isJoinCheck(id)) {
			pageset.setMessage("成功提交加入申请");
		} else {
			pageset.setMessage("成功加入小组");
		}
		return SUCCESS;
	}

	/**
	 * 进入管理页面
	 * 
	 * @return
	 */
	public String index() {
		try {
			query = EasyUiUtils.formatGridQuery(getRequest(), query);
			query.setPagesize(5);
			query = docGroupIMP.createFarmDocgroupQuery(query);
			query.addSort(new DBSort("DOCNUM", "desc"));
			if (searchGroupKey != null) {
				query.addRule(new DBRule("GROUPNAME", searchGroupKey, "like"));
			}
			result = query.addRule(new DBRule("PSTATE", "1", "=")).search();
			for (Map<String, Object> node : result.getResultList()) {
				if (node.get("GROUPIMG") != null) {
					node.put("GROUPIMG",
							fileIMP.getFileURL(node.get("GROUPIMG").toString()));
				}
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 加载我的小组
	 * 
	 * @return
	 */
	public String loadGroups() {
		try {
			query = EasyUiUtils.formatGridQuery(getRequest(), query);
			query.setPagesize(3);
			result = docGroupIMP
					.createFarmDocgroupQueryJoinUser(query)
					.addRule(new DBRule("a.PSTATE", "1", "="))
					.addRule(new DBRule("b.PSTATE", "1", "="))
					.addRule(
							new DBRule("b.USERID", getCurrentUser().getId(),
									"="))
					.addSort(new DBSort("SHOWSORT,a.CTIME", "ASC")).search();
			for (Map<String, Object> node : result.getResultList()) {
				if (node.get("GROUPIMG") != null) {
					node.put("GROUPIMG",
							fileIMP.getFileURL(node.get("GROUPIMG").toString()));
				}
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 修改或增加一个小组
	 * 
	 * @return
	 */
	public String edit() {
		try {
			if (id != null) {
				group = docGroupIMP.getFarmDocgroupEntity(id);

			}
		} catch (Exception e) {
		}
		return SUCCESS;
	}

	/**
	 * 增加一个小组
	 * 
	 * @return
	 */
	public String addCommit() {
		try {
			if (group != null && group.getId() != null
					&& group.getId().trim().length() <= 0) {
				group.setId(null);
			}
			group = docGroupIMP.creatDocGroup(group.getGroupname(), group
					.getGrouptag(), group.getGroupimg(), group.getJoincheck()
					.equals("1") ? true : false, group.getGroupnote(),
					getCurrentUser());

			id = group.getId();
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (NoGroupAuthForLicenceException e) {
			return "NOPOP";
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.ADD,
					CommitType.FALSE, e);
			return "ERRORS";
		}
		return SUCCESS;
	}

	/**
	 * 修改一个小组
	 * 
	 * @return
	 */
	public String editCommit() {
		try {
			group = docGroupIMP.editDocGroup(group.getId(), group
					.getGroupname(), group.getGrouptag(), group.getGroupimg(),
					group.getJoincheck().equals("1") ? true : false, group
							.getGroupnote(), getCurrentUser());
			id = group.getId();
			pageset = new PageSet(PageType.ADD, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, PageType.ADD,
					CommitType.FALSE, e);
			return "ERRORS";
		}
		return SUCCESS;
	}

	private final FarmFileManagerInter fileIMP = (FarmFileManagerInter) BeanFactory
			.getBean("farm_docFileProxyId");
	private final static FarmDocgroupManagerInter docGroupIMP = (FarmDocgroupManagerInter) BeanFactory
			.getBean("farm_docgroupProxyId");
	private final static FarmDocManagerInter docIMP = (FarmDocManagerInter) BeanFactory
			.getBean("farm_docProxyId");

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

	public void setPageset(PageSet pageset) {
		this.pageset = pageset;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public FarmDocgroup getGroup() {
		return group;
	}

	public void setGroup(FarmDocgroup group) {
		this.group = group;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public FarmDocgroupUser getUsergroup() {
		return usergroup;
	}

	public void setUsergroup(FarmDocgroupUser usergroup) {
		this.usergroup = usergroup;
	}

	public int getAdminNum() {
		return adminNum;
	}

	public void setAdminNum(int adminNum) {
		this.adminNum = adminNum;
	}

	public List<FarmDocgroupUser> getUserList() {
		return userList;
	}

	public void setUserList(List<FarmDocgroupUser> userList) {
		this.userList = userList;
	}

	public String getSearchGroupKey() {
		return searchGroupKey;
	}

	public void setSearchGroupKey(String searchGroupKey) {
		this.searchGroupKey = searchGroupKey;
	}

	public String getSearchDocKey() {
		return searchDocKey;
	}

	public void setSearchDocKey(String searchDocKey) {
		this.searchDocKey = searchDocKey;
	}

	public int getDocnum() {
		return docnum;
	}

	public void setDocnum(int docnum) {
		this.docnum = docnum;
	}

	public FarmDoc getDoc() {
		return doc;
	}

	public void setDoc(FarmDoc doc) {
		this.doc = doc;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	// ----------------------------------------------------------------------------------

}
