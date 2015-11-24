package com.farm.worm.server;

import java.util.ArrayList;
import java.util.List;

import com.farm.core.auth.domain.LoginUser;
import com.farm.core.time.TimeTool;
import com.farm.worm.dao.FarmWormAttrparseDaoInter;
import com.farm.worm.domain.FarmWormAttrparse;
import com.farm.worm.server.FarmWormAttrparseManagerInter;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;

/**
 * 任务属性
 * 
 * @author MAC_wd
 */
public class FarmWormAttrparseManagerImpl implements
		FarmWormAttrparseManagerInter {
	private FarmWormAttrparseDaoInter farmWormAttrparseDao;
//	private static final Logger log = Logger
//			.getLogger(FarmWormAttrparseManagerImpl.class);

	public FarmWormAttrparse insertFarmWormAttrparseEntity(
			FarmWormAttrparse entity, LoginUser user) {
		entity.setCuser(user.getId());
		entity.setCtime(TimeTool.getTimeDate14());
		entity.setCusername(user.getName());
		entity.setEuser(user.getId());
		entity.setEusername(user.getName());
		entity.setEtime(TimeTool.getTimeDate14());
		return farmWormAttrparseDao.insertEntity(entity);
	}

	public FarmWormAttrparse editFarmWormAttrparseEntity(
			FarmWormAttrparse entity, LoginUser user) {
		FarmWormAttrparse entity2 = farmWormAttrparseDao.getEntity(entity
				.getId());
		entity2.setEuser(user.getId());
		entity2.setEusername(user.getName());
		entity2.setEtime(TimeTool.getTimeDate14());
		entity2.setPstate(entity.getPstate());
		entity2.setAttrname(entity.getAttrname());
		entity2.setAttrselect(entity.getAttrselect());
		entity2.setAttrselecttype(entity.getAttrselecttype());
		entity2.setAttrkey(entity.getAttrkey());
		entity2.setHandletype(entity.getHandletype());
		farmWormAttrparseDao.editEntity(entity2);
		return entity2;
	}

	public void deleteFarmWormAttrparseEntity(String entity, LoginUser user) {
		farmWormAttrparseDao.deleteEntity(farmWormAttrparseDao
				.getEntity(entity));
	}

	public FarmWormAttrparse getFarmWormAttrparseEntity(String id) {
		if (id == null) {
			return null;
		}
		return farmWormAttrparseDao.getEntity(id);
	}

	@Override
	public DataQuery createFarmWormAttrparseSimpleQuery(DataQuery query) {
		DataQuery dbQuery = DataQuery.init(query, "farm_worm_attrparse",
				"id,PSTATE,ATTRNAME,ATTRKEY,ATTRSELECT,ATTRSELECTTYPE,HANDLETYPE");
		return dbQuery;
	}

	// ----------------------------------------------------------------------------------
	public FarmWormAttrparseDaoInter getfarmWormAttrparseDao() {
		return farmWormAttrparseDao;
	}

	public void setfarmWormAttrparseDao(FarmWormAttrparseDaoInter dao) {
		this.farmWormAttrparseDao = dao;
	}

	@Override
	public List<FarmWormAttrparse> getParseByProId(String proId) {
		List<DBRule> rules = new ArrayList<DBRule>();
		rules.add(new DBRule("PROJECTID", proId, "="));
		List<FarmWormAttrparse> tasklist = farmWormAttrparseDao
				.selectEntitys(rules);
		return tasklist;
	}

}
