package com.farm.worm.server;

import java.util.ArrayList;
import java.util.List;

import com.farm.core.auth.domain.LoginUser;
import com.farm.worm.dao.FarmWormUrlfilterDaoInter;
import com.farm.worm.domain.FarmWormUrlfilter;
import com.farm.worm.server.FarmWormUrlfilterManagerInter;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;

/**
 * URL过滤器类功能说明
 * 
 * @author 作者:自动生成
 * @version 日期(用日期代替版本号)+版本备注
 */
public class FarmWormUrlfilterManagerImpl implements
		FarmWormUrlfilterManagerInter {
	private FarmWormUrlfilterDaoInter farmWormUrlfilterDao;
//	private static final Logger log = Logger
//			.getLogger(FarmWormUrlfilterManagerImpl.class);

	public FarmWormUrlfilter insertFarmWormUrlfilterEntity(
			FarmWormUrlfilter entity, LoginUser user) {
		// entity.setCuser(user.getId());
		// entity.setCtime(TimeTool.getTimeDate14());
		// entity.setCusername(user.getName());
		// entity.setEuser(user.getId());
		// entity.setEusername(user.getName());
		// entity.setEtime(TimeTool.getTimeDate14());
		// entity.setPstate("1");
		return farmWormUrlfilterDao.insertEntity(entity);
	}

	public FarmWormUrlfilter editFarmWormUrlfilterEntity(
			FarmWormUrlfilter entity, LoginUser user) {
		FarmWormUrlfilter entity2 = farmWormUrlfilterDao.getEntity(entity
				.getId());
		// entity2.setEuser(user.getId());
		// entity2.setEusername(user.getName());
		// entity2.setEtime(TimeTool.getTimeDate14());
		entity2.setPcontent(entity.getPcontent());
		entity2.setPatenstr(entity.getPatenstr());
		entity2.setPtype(entity.getPtype());
		entity2.setFuntype(entity.getFuntype());
		farmWormUrlfilterDao.editEntity(entity2);
		return entity2;
	}

	public void deleteFarmWormUrlfilterEntity(String entity, LoginUser user) {
		farmWormUrlfilterDao.deleteEntity(farmWormUrlfilterDao
				.getEntity(entity));
	}

	public FarmWormUrlfilter getFarmWormUrlfilterEntity(String id) {
		if (id == null) {
			return null;
		}
		return farmWormUrlfilterDao.getEntity(id);
	}

	@Override
	public DataQuery createFarmWormUrlfilterSimpleQuery(DataQuery query) {
		DataQuery dbQuery = DataQuery.init(query, "farm_worm_urlfilter",
				"id,PCONTENT,PATENSTR,PTYPE,FUNTYPE");
		return dbQuery;
	}

	// ----------------------------------------------------------------------------------
	public FarmWormUrlfilterDaoInter getfarmWormUrlfilterDao() {
		return farmWormUrlfilterDao;
	}

	public void setfarmWormUrlfilterDao(FarmWormUrlfilterDaoInter dao) {
		this.farmWormUrlfilterDao = dao;
	}

	@Override
	public List<FarmWormUrlfilter> getFiltersByProId(String proId) {
		List<DBRule> rules = new ArrayList<DBRule>();
		rules.add(new DBRule("PROJECTID", proId, "="));
		List<FarmWormUrlfilter> tasklist = farmWormUrlfilterDao
				.selectEntitys(rules);
		return tasklist;
	}

}
