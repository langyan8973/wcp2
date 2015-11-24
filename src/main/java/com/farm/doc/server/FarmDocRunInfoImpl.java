package com.farm.doc.server;

import java.util.ArrayList;
import java.util.List;

import com.farm.core.auth.domain.LoginUser;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.time.TimeTool;
import com.farm.doc.dao.FarmDocDaoInter;
import com.farm.doc.dao.FarmDocenjoyDaoInter;
import com.farm.doc.dao.FarmDocfileDaoInter;
import com.farm.doc.dao.FarmDocmessageDaoInter;
import com.farm.doc.dao.FarmDocruninfoDaoInter;
import com.farm.doc.dao.FarmDocruninfoDetailDaoInter;
import com.farm.doc.dao.FarmDoctextDaoInter;
import com.farm.doc.dao.FarmDoctypeDaoInter;
import com.farm.doc.dao.FarmRfDoctextfileDaoInter;
import com.farm.doc.dao.FarmRfDoctypeDaoInter;
import com.farm.doc.domain.FarmDoc;
import com.farm.doc.domain.FarmDocenjoy;
import com.farm.doc.domain.FarmDocruninfo;
import com.farm.doc.domain.FarmDocruninfoDetail;
import com.farm.doc.server.commons.DocumentConfig;
import com.farm.util.web.FarmproHotnum;
import com.farm.util.web.WebVisitBuff;

/**
 * @author Administrator
 * 
 */
public class FarmDocRunInfoImpl implements FarmDocRunInfoInter {
	private FarmDocDaoInter farmDocDao;
	private FarmDocfileDaoInter farmDocfileDao;
	private FarmDoctextDaoInter farmDoctextDao;
	private FarmRfDoctextfileDaoInter farmRfDoctextfileDao;
	private FarmRfDoctypeDaoInter farmRfDoctypeDao;
	private FarmDoctypeDaoInter farmDoctypeDao;
	private FarmDocmessageDaoInter farmDocmessageDao;
	private FarmDocruninfoDaoInter farmDocruninfoDao;
	private FarmDocenjoyDaoInter farmDocenjoyDao;
	private FarmDocOperateRightInter farmDocOperate;
	private FarmDocruninfoDetailDaoInter farmDocruninfoDetailDao;

	public FarmDocDaoInter getFarmDocDao() {
		return farmDocDao;
	}

	public void setFarmDocDao(FarmDocDaoInter farmDocDao) {
		this.farmDocDao = farmDocDao;
	}

	public FarmDocfileDaoInter getFarmDocfileDao() {
		return farmDocfileDao;
	}

	public void setFarmDocfileDao(FarmDocfileDaoInter farmDocfileDao) {
		this.farmDocfileDao = farmDocfileDao;
	}

	public FarmDoctextDaoInter getFarmDoctextDao() {
		return farmDoctextDao;
	}

	public void setFarmDoctextDao(FarmDoctextDaoInter farmDoctextDao) {
		this.farmDoctextDao = farmDoctextDao;
	}

	public FarmRfDoctextfileDaoInter getFarmRfDoctextfileDao() {
		return farmRfDoctextfileDao;
	}

	public void setFarmRfDoctextfileDao(
			FarmRfDoctextfileDaoInter farmRfDoctextfileDao) {
		this.farmRfDoctextfileDao = farmRfDoctextfileDao;
	}

	public FarmRfDoctypeDaoInter getFarmRfDoctypeDao() {
		return farmRfDoctypeDao;
	}

	public void setFarmRfDoctypeDao(FarmRfDoctypeDaoInter farmRfDoctypeDao) {
		this.farmRfDoctypeDao = farmRfDoctypeDao;
	}

	public FarmDoctypeDaoInter getFarmDoctypeDao() {
		return farmDoctypeDao;
	}

	public void setFarmDoctypeDao(FarmDoctypeDaoInter farmDoctypeDao) {
		this.farmDoctypeDao = farmDoctypeDao;
	}

	public FarmDocmessageDaoInter getFarmDocmessageDao() {
		return farmDocmessageDao;
	}

	public void setFarmDocmessageDao(FarmDocmessageDaoInter farmDocmessageDao) {
		this.farmDocmessageDao = farmDocmessageDao;
	}

	public FarmDocruninfoDaoInter getFarmDocruninfoDao() {
		return farmDocruninfoDao;
	}

	public void setFarmDocruninfoDao(FarmDocruninfoDaoInter farmDocruninfoDao) {
		this.farmDocruninfoDao = farmDocruninfoDao;
	}

	public FarmDocenjoyDaoInter getFarmDocenjoyDao() {
		return farmDocenjoyDao;
	}

	public void setFarmDocenjoyDao(FarmDocenjoyDaoInter farmDocenjoyDao) {
		this.farmDocenjoyDao = farmDocenjoyDao;
	}

	public FarmDocOperateRightInter getFarmDocOperate() {
		return farmDocOperate;
	}

	public void setFarmDocOperate(FarmDocOperateRightInter farmDocOperate) {
		this.farmDocOperate = farmDocOperate;
	}

	@Override
	public void visitDoc(String docId, LoginUser user, String ip) {
		WebVisitBuff vbuff = WebVisitBuff.getInstance("KNOW", 1000);
		String userId = "noLogin";
		if (user != null) {
			userId = user.getId();
		}
		if (vbuff.canVisite(docId + ip + userId)) {
			FarmDoc doc = farmDocDao.getEntity(docId);
			doc.setRuninfo(farmDocruninfoDao.getEntity(doc.getRuninfoid()));
			doc.getRuninfo().setVisitnum(doc.getRuninfo().getVisitnum() + 1);
			doc.getRuninfo().setHotnum(countHotNum(doc));
			doc.getRuninfo().setLastvtime(TimeTool.getTimeDate12());
			farmDocruninfoDao.editEntity(doc.getRuninfo());
		}
	}

	/**
	 * 计算文章热度
	 * 
	 * @param doc
	 * @return
	 */
	private int countHotNum(FarmDoc doc) {
		int hotnum = FarmproHotnum.getHotnum(doc.getRuninfo().getLastvtime(),
				doc.getRuninfo().getHotnum(), 1, Integer.valueOf(DocumentConfig
						.getString("config.doc.hot.weight")));
		return hotnum;
	}

	@Override
	public void enjoyDoc(String userId, String docId) {
		farmDocenjoyDao.insertEntity(new FarmDocenjoy(docId.trim(), userId
				.trim()));
	}

	@Override
	public DataQuery getUserEnjoyDoc(String userId) {
		DataQuery query = DataQuery.getInstance("1", "TITLE,b.ID AS ID",
				"FARM_DOCENJOY a left join FARM_DOC b on a.DOCID=b.ID");
		query.addRule(new DBRule("a.USERID", userId, "="));
		query.setDistinct(true);
		return query;
	}

	@Override
	public boolean isEnjoyDoc(String userId, String docId) {
		List<DBRule> list = new ArrayList<DBRule>();
		list.add(new DBRule("DOCID", docId, "="));
		list.add(new DBRule("USERID", userId, "="));
		return farmDocenjoyDao.selectEntitys(list).size() > 0;
	}

	@Override
	public void unEnjoyDoc(String userId, String docId) {
		List<DBRule> list = new ArrayList<DBRule>();
		list.add(new DBRule("DOCID", docId, "="));
		list.add(new DBRule("USERID", userId, "="));
		farmDocenjoyDao.deleteEntitys(list);
	}

	@Override
	public void reCountDocHotNum(String docId) {
		FarmDoc doc = farmDocDao.getEntity(docId);
		doc.setRuninfo(farmDocruninfoDao.getEntity(doc.getRuninfoid()));
		doc.getRuninfo().setHotnum(countHotNum(doc));
		farmDocruninfoDao.editEntity(doc.getRuninfo());
	}

	public FarmDocruninfoDetailDaoInter getFarmDocruninfoDetailDao() {
		return farmDocruninfoDetailDao;
	}

	public void setFarmDocruninfoDetailDao(
			FarmDocruninfoDetailDaoInter farmDocruninfoDetailDao) {
		this.farmDocruninfoDetailDao = farmDocruninfoDetailDao;
	}

	@Override
	public void criticalDoc(String docId, LoginUser user, String IP) {
		evaluateDoc(docId, user, IP, "3");
	}

	/**
	 * 评价一个文档
	 * 
	 * @param docId
	 *            文档id
	 * @param user
	 *            当前用户（可空）
	 * @param IP
	 *            用户IP
	 * @param type
	 *            评价类型（2好评、3差评）
	 * @return 文档评价值(好评减去差评)
	 */
	private void evaluateDoc(String docId, LoginUser user, String IP,
			String type) {
		FarmDoc doc = farmDocDao.getEntity(docId);
		FarmDocruninfo runinfo = farmDocruninfoDao
				.getEntity(doc.getRuninfoid());
		// 删除本用户对于该文档的评价(好评、差评)
		List<DBRule> list = new ArrayList<DBRule>();
		list.add(new DBRule("RUNINFOID", runinfo.getId(), "="));
		list.add(new DBRule("VTYPE", "2", "="));
		if (user != null) {
			list.add(new DBRule("CUSER", user.getId(), "="));
		} else {
			list.add(new DBRule("USERIP", IP, "="));
		}
		farmDocruninfoDetailDao.deleteEntitys(list);
		List<DBRule> list2 = new ArrayList<DBRule>();
		list2.add(new DBRule("RUNINFOID", runinfo.getId(), "="));
		list2.add(new DBRule("VTYPE", "3", "="));
		if (user != null) {
			list2.add(new DBRule("CUSER", user.getId(), "="));
		} else {
			list2.add(new DBRule("USERIP", IP, "="));
		}
		farmDocruninfoDetailDao.deleteEntitys(list2);
		// 增加一条好评
		FarmDocruninfoDetail infDetail = new FarmDocruninfoDetail();
		infDetail.setCtime(TimeTool.getTimeDate14());
		if (user != null) {
			infDetail.setCuser(user.getId());
			infDetail.setCusername(user.getName());
		}
		infDetail.setDoctextid(doc.getTextid());
		infDetail.setPstate("1");
		infDetail.setRuninfoid(runinfo.getId());
		infDetail.setUserip(IP);
		// 1访问、2好评、3差评
		infDetail.setVtype(type);
		farmDocruninfoDetailDao.insertEntity(infDetail);
	}

	@Override
	public void criticalDoc(String docId, String IP) {
		evaluateDoc(docId, null, IP, "3");
	}

	@Override
	public void praiseDoc(String docId, LoginUser user, String IP) {
		evaluateDoc(docId, user, IP, "2");
	}

	@Override
	public void praiseDoc(String docId, String IP) {
		evaluateDoc(docId, null, IP, "2");
	}

	@Override
	public FarmDocruninfo loadRunInfo(String docId) {
		FarmDoc doc = farmDocDao.getEntity(docId);
		FarmDocruninfo runinfo = farmDocruninfoDao
				.getEntity(doc.getRuninfoid());
		// 更新用量信息（好评、差评、评价）
		List<DBRule> listCount1 = new ArrayList<DBRule>();
		listCount1.add(new DBRule("RUNINFOID", runinfo.getId(), "="));
		listCount1.add(new DBRule("VTYPE", "2", "="));
		int good = farmDocruninfoDetailDao.countEntitys(listCount1);
		List<DBRule> listCount2 = new ArrayList<DBRule>();
		listCount2.add(new DBRule("RUNINFOID", runinfo.getId(), "="));
		listCount2.add(new DBRule("VTYPE", "3", "="));
		int bad = farmDocruninfoDetailDao.countEntitys(listCount2);
		// （2好评、3差评）
		runinfo.setPraiseyes(good);
		runinfo.setPraiseno(bad);
		runinfo.setEvaluate(good - bad);
		farmDocruninfoDao.editEntity(runinfo);
		return runinfo;
	}
}
