package com.farm.wcp.index.web.action;

import java.sql.SQLException;
import java.util.Map;


import com.farm.authority.domain.User;
import com.farm.authority.service.UserServiceInter;
import com.farm.core.FarmService;
import com.farm.core.auth.domain.LoginUser;
import com.farm.core.auth.util.AuthenticateProvider;
import com.farm.core.page.CommitType;
import com.farm.core.page.PageSet;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DBSort;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.query.DataQuery.CACHE_UNIT;
import com.farm.core.sql.result.DataResult;
import com.farm.doc.impl.FarmDocService;
import com.farm.doc.server.FarmDocRunInfoInter;
import com.farm.doc.server.FarmDocmessageManagerInter;
import com.farm.doc.server.FarmFileManagerInter;
import com.farm.util.validate.ValidUtils;
import com.farm.web.WebSupport;
import com.farm.web.action.FarmAction;
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
	private int messagenum;
	private String name;
	private String loginname;
	private String password;
	private String newPassword;
	private String orgid;
	private String photoid;
	private String orgname;
	private String photourl;
	private String url;
	private int plantasknum;// 待办任务数
	private int todaytasknum;// 待办任务数
	private String userid;// 目标用户id
	private String text;// 消息详细内容&权限机器码
	private String title;// 消息主题
	private boolean showOk;
	private boolean authTrue;// 是否有专业版授权

	/**
	 * 授权信息
	 * 
	 * @return
	 */
	public String authInfo() {
		// 授权是否正确
		String isTrue = "1";
		if (isTrue == null || isTrue.equals("0")) {
			authTrue = false;
		} else {
			authTrue = true;
			orgname = "开源版本";
		}
		initCase();
		return SUCCESS;
	}

	private void initCase() {
	}

	public String authInfoCommit() {
		// FarmService manager = FarmService.getInstance();
		// manager.setConfigValue(FarmConstant.SYS_LICENCE, ids,
		// getCurrentUser());
		// manager.setConfigValue(FarmConstant.SYS_USERNAME, orgname,
		// getCurrentUser());
		// manager.setConfigValue(FarmConstant.SYS_LICENCE_ISTRUE, "0",
		// getCurrentUser());
		// if (!manager.initLicence(getCurrentUser())) {
		// pageset = PageSets.initPageSet(pageset, CommitType.FALSE);
		// pageset.setMessage("许可证号错误");
		// manager.initConfig();
		// initCase();
		// return "input";
		// } else {
		// manager.initConfig();
		// FarmConstant.LICENCE_FLAG = "1";
		// return SUCCESS;
		// }
		return SUCCESS;
	}

	/**
	 * 发送短消息
	 * 
	 * @return
	 */
	public String sendMessage() {
		for (String id : parseIds(userid)) {
			LoginUser user = FarmService.getInstance().getAuthorityService()
					.getUserById(id);
			if (name == null) {
				name = user.getName();
			} else {
				name = name + "," + user.getName();
			}
		}
		return SUCCESS;
	}

	/**
	 * 图片墙
	 * 
	 * @return
	 */
	public String imgWall() {
		try {
			query = DataQuery
					.init(
							query,
							"FARM_RF_DOCTEXTFILE a LEFT JOIN FARM_DOC b ON a.DOCID=b.ID LEFT JOIN FARM_DOCFILE c ON a.FILEID=c.ID ",
							" B.ID AS DOCID,B.TITLE as TITLE,C.EXNAME  AS EXNAME,C.NAME as NAME,C.ID AS FILEID,C.PSTATE ");
			query.setPagesize(30);
			query.addRule(new DBRule("b.READPOP", "1", "="));
			query.setDistinct(true);
			query.setCache(Integer.valueOf(FarmService.getInstance()
					.getParameterService().getParameter(
							"config.wcp.cache.imgwall")), CACHE_UNIT.minute);
			if (name != null && name.trim().length() > 0) {
				query.addSqlRule(" and (b.TITLE LIKE '%" + name
						+ "%' OR b.DOCDESCRIBE LIKE '%" + name
						+ "%' OR b.TAGKEY LIKE '%" + name + "%')");
			}
			query
					.addSqlRule(" AND REPLACE(UPPER(c.EXNAME),'.','')  IN ('PNG','JPG','GIF')");
			result = query.search();
			for (Map<String, Object> node : result.getResultList()) {
				node.put("URL", fileIMP.getFileURL(node.get("FILEID")
						.toString()));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	/**
	 * 发送短消息 (提交)
	 * 
	 * @return
	 */
	public String sendMessageCommit() {
		try {
			for (String id : parseIds(userid)) {
				messageIMP.sendMessage(id, text, title, "用户消息",
						getCurrentUser());
			}
			pageset = PageSet.initPageSet(pageset, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, CommitType.FALSE);
			pageset.setMessage(e.getMessage());
			e.printStackTrace();
			return "FAIL";
		}
		return SUCCESS;
	}

	/**
	 * 加载组织机构的选择框
	 * 
	 * @return
	 */
	public String loadOrgs() {
		try {
			query = DataQuery.init(query, "alone_auth_organization",
					"ID,NAME,PARENTID");
			query.addRule(new DBRule("STATE", "1", "="));
			query.addSort(new DBSort("SORT", "ASC"));
			result = query.search();
		} catch (Exception e) {
		}
		return SUCCESS;
	}

	public String loginCommit() {
		if (name == null && password == null) {
			return SUCCESS;
		}
		FarmAction action = new FarmAction();
		action.setPassword(password);
		action.setName(name);
		String index = action.loginCommit();
		if (!index.equals(SUCCESS)) {
			pageset = action.getPage();
			return index;
		}
		if (url != null && url.trim().length() > 0) {
			return "BACK";
		}
		return SUCCESS;
	}

	/**
	 * 用户注册提交
	 * 
	 * @return
	 * @throws UserNoExistException
	 */
	public String registSubmit() {
		LoginUser logtor = new LoginUser() {
			@Override
			public String getName() {
				return name;
			}

			@Override
			public String getLoginname() {
				return loginname;
			}

			@Override
			public String getId() {
				return "NONE";
			}
		};
		User user = new User();
		try {
			if (FarmService.getInstance().getParameterService().getParameter(
					"config.sys.registable ").equals("false")) {
				throw new RuntimeException("该操作已经被管理员禁用!");
			}
			user.setImgid(photoid);
			user.setLoginname(loginname);
			user.setName(name);
			user.setState("1");
			user.setType("1");
			user = userIMP.insertUserEntity(user, logtor);
			userIMP.editLoginPassword(loginname, FarmService.getInstance()
					.getParameterService().getParameter(
							"config.default.password"), password);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, CommitType.FALSE);
			pageset.setMessage(e.getMessage());
			return "error";
		}
		FarmAction userQuery = new FarmAction();
		userQuery.setName(loginname);
		userQuery.setPassword(AuthenticateProvider.getInstance()
				.encodeLoginPasswordOnMd5(password, loginname));
		userQuery.loginCommit();
		return SUCCESS;
	}

	/**
	 * 首页
	 * 
	 * @return
	 */
	public String index() {
		try {
			//首页巨幕显示文档
			ids = FarmService.getInstance().getParameterService().getParameter(
					"config.web.home.topdoc");
		} catch (Exception e) {
		}
		return SUCCESS;
	}

	public String userInfo() {
		try {
			User user = userIMP.getUserEntity(getCurrentUser().getId());
			if (!ValidUtils.isEmptyString(user.getImgid())) {
				photourl = fileIMP.getFileURL(user.getImgid());
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	/**
	 * 用户注册
	 * 
	 * @return
	 */
	public String regist() {
		try {
		} catch (Exception e) {

		}
		return SUCCESS;
	}

	public String editUser() {
		try {
			User user = userIMP.getUserEntity(getCurrentUser().getId());
			name = user.getName();
			photoid = user.getImgid();
			if (photoid != null && photoid.trim().length() > 0) {
				photourl = fileIMP.getFileURL(photoid);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	public String editPassword() {
		try {
		} catch (Exception e) {
		}
		return SUCCESS;
	}

	public String editUserCommit() {
		try {
			User user = userIMP.getUserEntity(getCurrentUser().getId());
			user.setName(name);
			user.setImgid(photoid);
			if (photoid != null && photoid.trim().length() > 0) {
				photourl = fileIMP.getFileURL(photoid);
			}
			// if (orgid != null && orgid.trim().length() > 0) {
			// userIMP.editUserEntity(user, user);
			// }
			userIMP.editUserEntity(user, user);
			pageset = PageSet.initPageSet(pageset, CommitType.TRUE);
		} catch (Exception e) {
			pageset = PageSet.initPageSet(pageset, CommitType.FALSE);
			pageset.setMessage(e.getMessage() + e);
		}
		return SUCCESS;
	}

	public String editPasswordCommit() {
		if (userIMP.editLoginPassword(getCurrentUser().getLoginname(),
				password, newPassword)) {
			pageset = PageSet.initPageSet(pageset, CommitType.TRUE);
		} else {
			pageset = PageSet.initPageSet(pageset, CommitType.FALSE);
			pageset.setMessage("密码修改失败，请核实数据");
		}
		return SUCCESS;
	}

	/**
	 * 首页
	 * 
	 * @return
	 */
	public String userMenu() {
		try {
			// TITLE、ID
			query = docRunInfoIMP.getUserEnjoyDoc(getCurrentUser().getId());
			result = query.search();
			messagenum = FarmDocService.getInstance().getMessageService()
					.getNoReadMessageNum(getCurrentUser());
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}

	private final FarmFileManagerInter fileIMP = (FarmFileManagerInter) BeanFactory
			.getBean("farm_docFileProxyId");
	private final static FarmDocRunInfoInter docRunInfoIMP = (FarmDocRunInfoInter) BeanFactory
			.getBean("farm_docRunInfoProxyId");
	private final static FarmDocmessageManagerInter messageIMP = (FarmDocmessageManagerInter) BeanFactory
			.getBean("farm_docmessageProxyId");
	private final static UserServiceInter userIMP = (UserServiceInter) BeanFactory
			.getBean("farm_authority_user_ProxyId");

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

	public int getMessagenum() {
		return messagenum;
	}

	public void setMessagenum(int messagenum) {
		this.messagenum = messagenum;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLoginname() {
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	public String getPassword() {
		return password;
	}

	public int getPlantasknum() {
		return plantasknum;
	}

	public void setPlantasknum(int plantasknum) {
		this.plantasknum = plantasknum;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public String getPhotoid() {
		return photoid;
	}

	public void setPhotoid(String photoid) {
		this.photoid = photoid;
	}

	public String getOrgname() {
		return orgname;
	}

	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	public String getPhotourl() {
		return photourl;
	}

	public void setPhotourl(String photourl) {
		this.photourl = photourl;
	}

	public boolean isAuthTrue() {
		return authTrue;
	}

	public void setAuthTrue(boolean authTrue) {
		this.authTrue = authTrue;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getTodaytasknum() {
		return todaytasknum;
	}

	public void setTodaytasknum(int todaytasknum) {
		this.todaytasknum = todaytasknum;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public boolean isShowOk() {
		return showOk;
	}

	public void setShowOk(boolean showOk) {
		this.showOk = showOk;
	}

	// private static final Logger log = Logger.getLogger(ActionIndex.class);
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
