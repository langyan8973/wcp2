package com.farm.worm.server;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.farm.core.auth.domain.LoginUser;

import com.farm.worm.dao.FarmWormDocattrDaoInter;
import com.farm.worm.dao.FarmWormTaskDaoInter;
import com.farm.worm.domain.FarmWormProject;
import com.farm.worm.domain.FarmWormTask;
import com.farm.worm.server.FarmWormTaskManagerInter;
import com.farm.worm.server.common.Consoles;
import com.farm.worm.server.common.WebPage;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.time.TimeTool;

/**
 * 任务
 * 
 * @author MAC_wd
 */
public class FarmWormTaskManagerImpl implements FarmWormTaskManagerInter {
	private FarmWormTaskDaoInter farmWormTaskDao;
	private FarmWormDocattrDaoInter farmWormDocattrDao;
//	private static final Logger log = Logger
//			.getLogger(FarmWormTaskManagerImpl.class);
	private static Set<String> urlcatch = new HashSet<String>();
	private final static int urlcatch_max_size = 2000;

	public FarmWormTask insertFarmWormTaskEntity(FarmWormTask entity,
			LoginUser user) {
		// entity.setCuser(user.getId());
		// entity.setCtime(TimeTool.getTimeDate14());
		// entity.setCusername(user.getName());
		// entity.setEuser(user.getId());
		// entity.setEusername(user.getName());
		// entity.setEtime(TimeTool.getTimeDate14());
		// entity.setPstate("1");
		return farmWormTaskDao.insertEntity(entity);
	}

	public FarmWormTask editFarmWormTaskEntity(FarmWormTask entity,
			LoginUser user) {
		FarmWormTask entity2 = farmWormTaskDao.getEntity(entity.getId());
		// entity2.setEuser(user.getId());
		// entity2.setEusername(user.getName());
		// entity2.setEtime(TimeTool.getTimeDate14());
		entity2.setPcontent(entity.getPcontent());
		entity2.setUrl(entity.getUrl());
		entity2.setTitle(entity.getTitle());
		entity2.setPstate(entity.getPstate());
		entity2.setType(entity.getType());
		farmWormTaskDao.editEntity(entity2);
		return entity2;
	}

	public void deleteFarmWormTaskEntity(String taskId, LoginUser user) {
		List<DBRule> rules = new ArrayList<DBRule>();
		rules.add(new DBRule("TASKID", taskId, "="));
		farmWormDocattrDao.deleteEntitys(rules);
		farmWormTaskDao.deleteEntity(farmWormTaskDao.getEntity(taskId));
	}

	public FarmWormTask getFarmWormTaskEntity(String id) {
		if (id == null) {
			return null;
		}
		return farmWormTaskDao.getEntity(id);
	}

	@Override
	public DataQuery createFarmWormTaskSimpleQuery(DataQuery query) {
		DataQuery dbQuery = DataQuery.init(query, "farm_worm_task",
				"id,PCONTENT,URL,TITLE,PSTATE,TYPE");
		return dbQuery;
	}

	// ----------------------------------------------------------------------------------
	public FarmWormTaskDaoInter getfarmWormTaskDao() {
		return farmWormTaskDao;
	}

	public void setfarmWormTaskDao(FarmWormTaskDaoInter dao) {
		this.farmWormTaskDao = dao;
	}

	public FarmWormDocattrDaoInter getFarmWormDocattrDao() {
		return farmWormDocattrDao;
	}

	public void setFarmWormDocattrDao(FarmWormDocattrDaoInter farmWormDocattrDao) {
		this.farmWormDocattrDao = farmWormDocattrDao;
	}

	@Override
	public int getDocTaskNum(String proId) {
		List<DBRule> rules3 = new ArrayList<DBRule>();
		rules3.add(new DBRule("TYPE", "2", "="));
		rules3.add(new DBRule("PROJECTID", proId, "="));
		return farmWormTaskDao.countEntitys(rules3);
	}

	@Override
	public int getDownLoadedNum(String proId) {
		List<DBRule> rules3 = new ArrayList<DBRule>();
		rules3.add(new DBRule("TYPE", "2", "="));
		rules3.add(new DBRule("PSTATE", "3", "="));
		rules3.add(new DBRule("PROJECTID", proId, "="));
		return farmWormTaskDao.countEntitys(rules3);
	}

	@Override
	public int getScanedNum(String proId) {
		List<DBRule> rules3 = new ArrayList<DBRule>();
		rules3.add(new DBRule("TYPE", "1", "="));
		rules3.add(new DBRule("PSTATE", "3", "="));
		rules3.add(new DBRule("PROJECTID", proId, "="));
		return farmWormTaskDao.countEntitys(rules3);
	}

	@Override
	public int getSeedTaskNum(String proId) {
		List<DBRule> rules3 = new ArrayList<DBRule>();
		rules3.add(new DBRule("TYPE", "1", "="));
		rules3.add(new DBRule("PROJECTID", proId, "="));
		return farmWormTaskDao.countEntitys(rules3);
	}

	@Override
	public void editTaskState(String taskId, String type) {
		FarmWormTask pro = farmWormTaskDao.getEntity(taskId);
		pro.setPstate(type);
		farmWormTaskDao.editEntity(pro);

	}

	@Override
	public List<FarmWormTask> getInitTasks(String proid) {
		List<DBRule> rules = new ArrayList<DBRule>();
		rules.add(new DBRule("PSTATE", "1", "="));
		rules.add(new DBRule("TYPE", "1", "="));
		rules.add(new DBRule("PROJECTID", proid, "="));
		List<FarmWormTask> tasklist = farmWormTaskDao.selectEntitys(rules);
		return tasklist;
	}

	@Override
	public void insertTaskPage(WebPage page, FarmWormProject pro,
			LoginUser currentUser) {
		if (page.getUrl().indexOf("/") == 0) {
			page.setUrl(pro.getBaseurl() + page.getUrl());
		}
		Consoles console = Consoles.getInstance(pro.getId());
		if (urlcatch.contains(page.getUrl() + ":" + page.getType() + ":"
				+ pro.getId())) {
			return;
		}
		List<DBRule> rules = new ArrayList<DBRule>();
		rules.add(new DBRule("URL", page.getUrl(), "="));
		rules.add(new DBRule("PROJECTID", pro.getId(), "="));
		int num = farmWormTaskDao.countEntitys(rules);
		if (num > 0) {
			// console.warn("页面" + page.getTitle() + "已经存在！");
			return;
		}
		FarmWormTask task = new FarmWormTask();
		task.setCuser(currentUser.getId());
		task.setCtime(TimeTool.getTimeDate14());
		task.setCusername(currentUser.getName());
		task.setEuser(currentUser.getId());
		task.setEusername(currentUser.getName());
		task.setEtime(TimeTool.getTimeDate14());
		// 1.未开始，2正在，3完成
		task.setPstate("1");
		task.setType(page.getType());
		task.setTitle(page.getTitle());
		task.setUrl(page.getUrl());
		task.setProjectid(pro.getId());
		console.info("页面" + page.getTitle() + "准备就绪");
		try {
			farmWormTaskDao.insertEntity(task);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		if (urlcatch.size() > urlcatch_max_size) {
			urlcatch.clear();
		}
		urlcatch.add(page.getUrl() + ":" + page.getType() + ":" + pro.getId());
	}

	@Override
	public void clearUrlCatch() {
		urlcatch.clear();
	}

	@Override
	public List<FarmWormTask> getDocTaskings(String proid) {
		List<DBRule> rules = new ArrayList<DBRule>();
		rules.add(new DBRule("PSTATE", "1", "="));
		rules.add(new DBRule("TYPE", "2", "="));
		rules.add(new DBRule("PROJECTID", proid, "="));
		List<FarmWormTask> tasklist = farmWormTaskDao.selectEntitys(rules);
		return tasklist;
	}

	@Override
	public void clearTask(String proId) {
		if (proId == null || proId.trim().length() <= 0) {
			return;
		}
		List<DBRule> rules = new ArrayList<DBRule>();
		rules.add(new DBRule("PROJECTID", proId, "="));
		farmWormDocattrDao.deleteEntitys(rules);
		farmWormTaskDao.deleteEntitys(rules);
	}

	@Override
	public void initErrorTask(String proid) {
		if (proid == null || proid.trim().length() <= 0) {
			return;
		}
		List<DBRule> rules = new ArrayList<DBRule>();
		rules.add(new DBRule("PSTATE", "4", "="));
		rules.add(new DBRule("PROJECTID", proid, "="));
		Map<String, Object> values = new HashMap<String, Object>();
		values.put("PSTATE", "1");
		farmWormTaskDao.updataEntitys(values, rules);
	}
}
