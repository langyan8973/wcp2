package com.farm.doc.dao;

import java.math.BigInteger;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import com.farm.doc.domain.FarmDocfile;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.core.sql.utils.HibernateSQLTools;
import java.util.List;
import java.util.Map;

/**
 * 文档附件
 * 
 * @author MAC_wd
 * 
 */
public class FarmDocfileDao implements FarmDocfileDaoInter {
	private SessionFactory sessionFatory;
	private HibernateSQLTools<FarmDocfile> sqlTools;

	public void deleteEntity(FarmDocfile entity) {
		Session session = sessionFatory.getCurrentSession();
		session.delete(entity);
	}

	public int getAllListNum() {
		Session session = sessionFatory.getCurrentSession();
		SQLQuery sqlquery = session
				.createSQLQuery("select count(*) from farm_docfile");
		BigInteger num = (BigInteger) sqlquery.list().get(0);
		return num.intValue();
	}

	public FarmDocfile getEntity(String id) {
		Session session = sessionFatory.getCurrentSession();
		return (FarmDocfile) session.get(FarmDocfile.class, id);
	}

	public FarmDocfile insertEntity(FarmDocfile entity) {
		Session session = sessionFatory.getCurrentSession();
		session.save(entity);
		return entity;
	}

	public void editEntity(FarmDocfile entity) {
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
	public List<FarmDocfile> selectEntitys(List<DBRule> rules) {
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

	public HibernateSQLTools<FarmDocfile> getSqlTools() {
		return sqlTools;
	}

	public void setSqlTools(HibernateSQLTools<FarmDocfile> sqlTools) {
		this.sqlTools = sqlTools;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<FarmDocfile> getEntityByDocId(String id) {
		Session session = sessionFatory.getCurrentSession();
		SQLQuery sqlquery = session
				.createSQLQuery("SELECT DISTINCT b.* FROM farm_rf_doctextfile a LEFT JOIN farm_docfile b ON a.FILEID=b.ID WHERE  PSTATE='1' AND a.DOCID=? order by b.etime desc");
		sqlquery.setString(0, id);
		sqlquery.addEntity(FarmDocfile.class);
		return sqlquery.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<FarmDocfile> getEntityByDocIdAndExName(String docid,
			String exname) {
		Session session = sessionFatory.getCurrentSession();
		SQLQuery sqlquery = session
				.createSQLQuery("SELECT DISTINCT b.* FROM farm_rf_doctextfile a LEFT JOIN farm_docfile b ON a.FILEID=b.ID WHERE  PSTATE='1' AND a.DOCID=? AND b.EXNAME=? order by b.etime desc");
		sqlquery.setString(0, docid);
		sqlquery.setString(1, exname);
		sqlquery.addEntity(FarmDocfile.class);
		return sqlquery.list();
	}
}
