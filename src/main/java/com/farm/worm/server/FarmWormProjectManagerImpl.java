package com.farm.worm.server;

import java.util.ArrayList;
import java.util.List;

import com.farm.core.auth.domain.LoginUser;
import com.farm.core.time.TimeTool;
import org.apache.log4j.Logger;

import com.farm.worm.dao.FarmWormAttrparseDaoInter;
import com.farm.worm.dao.FarmWormDocattrDaoInter;
import com.farm.worm.dao.FarmWormProjectDaoInter;
import com.farm.worm.dao.FarmWormTaskDaoInter;
import com.farm.worm.dao.FarmWormUrlfilterDaoInter;
import com.farm.worm.domain.FarmWormProject;
import com.farm.worm.server.FarmWormProjectManagerInter;
import com.farm.worm.server.common.WormUtilsImpl;
import com.farm.worm.server.common.WormUtilsInter;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;

/**
 * 下载项目
 * 
 * @author MAC_wd
 */
public class FarmWormProjectManagerImpl implements FarmWormProjectManagerInter {
	private FarmWormProjectDaoInter farmWormProjectDao;
	private FarmWormTaskDaoInter farmWormTaskDao;
	private FarmWormDocattrDaoInter farmWormDocattrDao;
	private FarmWormAttrparseDaoInter farmWormAttrparseDao;
	private FarmWormUrlfilterDaoInter farmWormUrlfilterDao;

	@SuppressWarnings("unused")
	private WormUtilsInter worms = WormUtilsImpl.getInstance();
	@SuppressWarnings("unused")
	private static final Logger log = Logger
			.getLogger(FarmWormProjectManagerImpl.class);

	@Override
	public FarmWormProject insertFarmWormProjectEntity(FarmWormProject entity,
			LoginUser user) {
		entity.setCuser(user.getId());
		entity.setCtime(TimeTool.getTimeDate14());
		entity.setCusername(user.getName());
		entity.setEuser(user.getId());
		entity.setEusername(user.getName());
		entity.setEtime(TimeTool.getTimeDate14());
		entity.setPstate("1");
		entity = setWormHandleClass(entity);
		// 1.未执行、2.扫描URL、3下载页面中、4完成、5异常
		return farmWormProjectDao.insertEntity(entity);
	}

	/**
	 * 在新增项目时处理监听class参数
	 * 
	 * @param entity
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "deprecation" })
	private FarmWormProject setWormHandleClass(FarmWormProject entity) {
		{
			// 处理接口CLASS
			try {
				if (entity.getHandleclass() != null
						&& entity.getHandleclass().trim().length() > 0) {
					boolean isTrueClass = false;

					Class handleClass = Class.forName(entity.getHandleclass()
							.trim());
					for (Class cla : handleClass.getInterfaces()) {
						if (cla.equals(WormDocHandleInter.class)) {
							isTrueClass = true;
							break;
						}
					}
					if (isTrueClass == false) {
						throw new RuntimeException("未实现要求接口");
					}
					WormDocHandleInter handle = (WormDocHandleInter) handleClass
							.newInstance();
					if (handle.getParaFormat() != null
							&& handle.getParaFormat().getformat() != null) {
						entity
								.setHandlepara(handle.getParaFormat()
										.getformat());
					}
				}
			} catch (Exception e) {
				throw new RuntimeException(
						"com.farm.worm.server.WormDocHandleInter接口没有被正确实现:" + e);
			}
		}
		return entity;
	}

	@Override
	public FarmWormProject editFarmWormProjectEntity(FarmWormProject entity,
			LoginUser user) {
		FarmWormProject entity2 = farmWormProjectDao.getEntity(entity.getId());
		entity2.setEuser(user.getId());
		entity2.setEusername(user.getName());
		entity2.setEtime(TimeTool.getTimeDate14());
		entity2.setPcontent(entity.getPcontent());
		entity2.setName(entity.getName());
		entity2.setSeedurl(entity.getSeedurl());
		entity2.setAgent(entity.getAgent());
		entity2.setWaittime(entity.getWaittime());
		entity2.setTimeout(entity.getTimeout());
		entity2.setBaseurl(entity.getBaseurl());
		entity2.setHandlepara(entity.getHandlepara());
		if (entity2.getHandleclass() == null||entity2.getHandleclass().trim().length()<=0) {
			entity2.setHandleclass(entity.getHandleclass());
			setWormHandleClass(entity2);
		}else{
			entity2.setHandleclass(entity.getHandleclass());
		}
		farmWormProjectDao.editEntity(entity2);
		return entity2;
	}

	@Override
	public void deleteFarmWormProjectEntity(String proid, LoginUser user) {
		if (proid == null || proid.trim().length() <= 0) {
			throw new RuntimeException("主键不能为空");
		}
		List<DBRule> rules = new ArrayList<DBRule>();
		rules.add(new DBRule("PROJECTID", proid, "="));
		farmWormUrlfilterDao.deleteEntitys(rules);
		farmWormDocattrDao.deleteEntitys(rules);
		farmWormTaskDao.deleteEntitys(rules);
		farmWormAttrparseDao.deleteEntitys(rules);
		farmWormProjectDao.deleteEntity(farmWormProjectDao.getEntity(proid));
	}

	@Override
	public FarmWormProject getFarmWormProjectEntity(String id) {
		if (id == null) {
			return null;
		}
		return farmWormProjectDao.getEntity(id);
	}

	@Override
	public DataQuery createFarmWormProjectSimpleQuery(DataQuery query) {
		DataQuery dbQuery = DataQuery.init(query, "farm_worm_project",
				"id,PSTATE,PCONTENT,NAME,SEEDURL,AGENT,TIMEOUT");
		return dbQuery;
	}

	// ----------------------------------------------------------------------------------
	public FarmWormProjectDaoInter getfarmWormProjectDao() {
		return farmWormProjectDao;
	}

	public void setfarmWormProjectDao(FarmWormProjectDaoInter dao) {
		this.farmWormProjectDao = dao;
	}

	public FarmWormProjectDaoInter getFarmWormProjectDao() {
		return farmWormProjectDao;
	}

	public void setFarmWormProjectDao(FarmWormProjectDaoInter farmWormProjectDao) {
		this.farmWormProjectDao = farmWormProjectDao;
	}

	public FarmWormTaskDaoInter getFarmWormTaskDao() {
		return farmWormTaskDao;
	}

	public void setFarmWormTaskDao(FarmWormTaskDaoInter farmWormTaskDao) {
		this.farmWormTaskDao = farmWormTaskDao;
	}

	public FarmWormDocattrDaoInter getFarmWormDocattrDao() {
		return farmWormDocattrDao;
	}

	public void setFarmWormDocattrDao(FarmWormDocattrDaoInter farmWormDocattrDao) {
		this.farmWormDocattrDao = farmWormDocattrDao;
	}

	public FarmWormAttrparseDaoInter getFarmWormAttrparseDao() {
		return farmWormAttrparseDao;
	}

	public void setFarmWormAttrparseDao(
			FarmWormAttrparseDaoInter farmWormAttrparseDao) {
		this.farmWormAttrparseDao = farmWormAttrparseDao;
	}

	// ----------------------------------------------------------------------------------

	public FarmWormUrlfilterDaoInter getFarmWormUrlfilterDao() {
		return farmWormUrlfilterDao;
	}

	public void setFarmWormUrlfilterDao(
			FarmWormUrlfilterDaoInter farmWormUrlfilterDao) {
		this.farmWormUrlfilterDao = farmWormUrlfilterDao;
	}

	public void editProjectState(String proId, String type) {
		FarmWormProject pro = farmWormProjectDao.getEntity(proId);
		pro.setPstate(type);
		farmWormProjectDao.editEntity(pro);

	}

}
