package com.farm.doc.dao;

import java.math.BigInteger;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import com.farm.doc.domain.FarmDocruninfoDetail;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.core.sql.utils.HibernateSQLTools;
import java.util.List;
import java.util.Map;

/**
 * 用户用量明细
 * 
 * @author MAC_wd
 * 
 */
public class FarmDocruninfoDetailDao implements FarmDocruninfoDetailDaoInter {
	private SessionFactory sessionFatory;
	private HibernateSQLTools<FarmDocruninfoDetail> sqlTools;

	public void deleteEntity(FarmDocruninfoDetail entity) {
		Session session = sessionFatory.getCurrentSession();
		session.delete(entity);
	}

	public int getAllListNum() {
		Session session = sessionFatory.getCurrentSession();
		SQLQuery sqlquery = session
				.createSQLQuery("select count(*) from farm_docruninfo_detail");
		BigInteger num = (BigInteger) sqlquery.list().get(0);
		return num.intValue();
	}

	public FarmDocruninfoDetail getEntity(String id) {
		Session session = sessionFatory.getCurrentSession();
		return (FarmDocruninfoDetail) session.get(FarmDocruninfoDetail.class,
				id);
	}

	public FarmDocruninfoDetail insertEntity(FarmDocruninfoDetail entity) {
		Session session = sessionFatory.getCurrentSession();
		session.save(entity);
		return entity;
	}

	public void editEntity(FarmDocruninfoDetail entity) {
		Session session = sessionFatory.getCurrentSession();
		session.update(entity);
	}

	@Override
	public Session getSession() {
		return sessionFatory.getCurrentSession();
	}

	public DataResult runSqlQuery(DataQuery query) {
		try {
			return query.search(sessionFatory.getCurrentSession());
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public void deleteEntitys(List<DBRule> rules) {
		sqlTools
				.deleteSqlFromFunction(sessionFatory.getCurrentSession(), rules);
	}

	@Override
	public List<FarmDocruninfoDetail> selectEntitys(List<DBRule> rules) {
		return sqlTools.selectSqlFromFunction(
				sessionFatory.getCurrentSession(), rules);
	}

	@Override
	public void updataEntitys(Map<String, Object> values, List<DBRule> rules) {
		sqlTools.updataSqlFromFunction(sessionFatory.getCurrentSession(),
				values, rules);
	}

	@Override
	public int countEntitys(List<DBRule> rules) {
		return sqlTools.countSqlFromFunction(sessionFatory.getCurrentSession(),
				rules);
	}

	public SessionFactory getSessionFatory() {
		return sessionFatory;
	}

	public void setSessionFatory(SessionFactory sessionFatory) {
		this.sessionFatory = sessionFatory;
	}

	public HibernateSQLTools<FarmDocruninfoDetail> getSqlTools() {
		return sqlTools;
	}

	public void setSqlTools(HibernateSQLTools<FarmDocruninfoDetail> sqlTools) {
		this.sqlTools = sqlTools;
	}

}
