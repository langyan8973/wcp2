package com.farm.doc.dao;

import java.math.BigInteger;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import com.farm.doc.domain.FarmDocgroup;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.core.sql.utils.HibernateSQLTools;
import java.util.List;
import java.util.Map;

/**
 * 工作小组
 * 
 * @author MAC_wd
 * 
 */
public class FarmDocgroupDao implements FarmDocgroupDaoInter {
	private SessionFactory sessionFatory;
	private HibernateSQLTools<FarmDocgroup> sqlTools;

	public void deleteEntity(FarmDocgroup entity) {
		Session session = sessionFatory.getCurrentSession();
		session.delete(entity);
	}

	public int getAllListNum() {
		Session session = sessionFatory.getCurrentSession();
		SQLQuery sqlquery = session
				.createSQLQuery("select count(*) from farm_docgroup");
		BigInteger num = (BigInteger) sqlquery.list().get(0);
		return num.intValue();
	}

	public FarmDocgroup getEntity(String id) {
		Session session = sessionFatory.getCurrentSession();
		return (FarmDocgroup) session.get(FarmDocgroup.class, id);
	}

	public FarmDocgroup insertEntity(FarmDocgroup entity) {
		Session session = sessionFatory.getCurrentSession();
		session.save(entity);
		return entity;
	}

	public void editEntity(FarmDocgroup entity) {
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
	public List<FarmDocgroup> selectEntitys(List<DBRule> rules) {
		return sqlTools.selectSqlFromFunction(
				sessionFatory.getCurrentSession(), rules);
	}

	@Override
	public void updataEntitys(Map<String, Object> values, List<DBRule> rules) {
		sqlTools.updataSqlFromFunction(sessionFatory.getCurrentSession(),
				values, rules);
	}

	public SessionFactory getSessionFatory() {
		return sessionFatory;
	}

	public void setSessionFatory(SessionFactory sessionFatory) {
		this.sessionFatory = sessionFatory;
	}

	public HibernateSQLTools<FarmDocgroup> getSqlTools() {
		return sqlTools;
	}

	public void setSqlTools(HibernateSQLTools<FarmDocgroup> sqlTools) {
		this.sqlTools = sqlTools;
	}

	@Override
	public int getGroupDocNum(String groupId) {
		Session session = sessionFatory.getCurrentSession();
		SQLQuery sqlquery = session
				.createSQLQuery("select count(*) from FARM_DOC where DOCGROUPID=?");
		sqlquery.setString(0, groupId);
		BigInteger num = (BigInteger) sqlquery.list().get(0);
		return num.intValue();
	}
}
