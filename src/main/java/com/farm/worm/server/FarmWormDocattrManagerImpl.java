package com.farm.worm.server;

import com.farm.core.auth.domain.LoginUser;
import com.farm.core.time.TimeTool;
import com.farm.worm.dao.FarmWormDocattrDaoInter;
import com.farm.worm.domain.FarmWormDocattr;
import com.farm.worm.server.FarmWormDocattrManagerInter;
import com.farm.core.sql.query.DataQuery;

/**
 * 下载内容
 * 
 * @author MAC_wd
 */
public class FarmWormDocattrManagerImpl implements FarmWormDocattrManagerInter {
	private FarmWormDocattrDaoInter farmWormDocattrDao;
//	private static final Logger log = Logger
//			.getLogger(FarmWormDocattrManagerImpl.class);

	public FarmWormDocattr insertFarmWormDocattrEntity(FarmWormDocattr entity,
			LoginUser user) {
		entity.setCuser(user.getId());
		entity.setCtime(TimeTool.getTimeDate14());
		entity.setCusername(user.getName());
		entity.setEuser(user.getId());
		entity.setEusername(user.getName());
		entity.setEtime(TimeTool.getTimeDate14());
		entity.setPstate("1");
		return farmWormDocattrDao.insertEntity(entity);
	}

	public FarmWormDocattr editFarmWormDocattrEntity(FarmWormDocattr entity,
			LoginUser user) {
		FarmWormDocattr entity2 = farmWormDocattrDao.getEntity(entity.getId());
		// entity2.setEuser(user.getId());
		// entity2.setEusername(user.getName());
		// entity2.setEtime(TimeTool.getTimeDate14());
		entity2.setPcontent(entity.getPcontent());
		entity2.setAttrparseid(entity.getAttrparseid());
		entity2.setTaskid(entity.getTaskid());
		farmWormDocattrDao.editEntity(entity2);
		return entity2;
	}

	public void deleteFarmWormDocattrEntity(String entity, LoginUser user) {
		farmWormDocattrDao.deleteEntity(farmWormDocattrDao.getEntity(entity));
	}

	public FarmWormDocattr getFarmWormDocattrEntity(String id) {
		if (id == null) {
			return null;
		}
		return farmWormDocattrDao.getEntity(id);
	}

	@Override
	public DataQuery createFarmWormDocattrSimpleQuery(DataQuery query) {
		DataQuery dbQuery = DataQuery.init(query, "farm_worm_docattr a left join FARM_WORM_ATTRPARSE b on a.ATTRPARSEID=b.id",
				"a.id as id,a.PCONTENT as PCONTENT,a.ATTRPARSEID as ATTRPARSEID,a.TASKID as TASKID,b.ATTRNAME as ATTRNAME");
		return dbQuery;
	}

	// ----------------------------------------------------------------------------------
	public FarmWormDocattrDaoInter getfarmWormDocattrDao() {
		return farmWormDocattrDao;
	}

	public void setfarmWormDocattrDao(FarmWormDocattrDaoInter dao) {
		this.farmWormDocattrDao = dao;
	}

}
