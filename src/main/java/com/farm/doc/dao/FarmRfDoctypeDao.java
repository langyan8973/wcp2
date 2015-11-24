package com.farm.doc.dao;

import java.math.BigInteger;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.farm.doc.domain.FarmDoctype;
import com.farm.doc.domain.FarmRfDoctype;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.core.sql.utils.HibernateSQLTools;
import java.util.List;
import java.util.Map;

/**
 * 中间表-分类文档
 * 
 * @author MAC_wd
 * 
 */
public class FarmRfDoctypeDao implements FarmRfDoctypeDaoInter {
	private SessionFactory sessionFatory;
	private HibernateSQLTools<FarmRfDoctype> sqlTools;

	public void deleteEntity(FarmRfDoctype entity) {
		Session session = sessionFatory.getCurrentSession();
		session.delete(entity);
	}

	public int getAllListNum() {
		Session session = sessionFatory.getCurrentSession();
		SQLQuery sqlquery = session
				.createSQLQuery("select count(*) from farm_rf_doctype");
		BigInteger num = (BigInteger) sqlquery.list().get(0);
		return num.intValue();
	}

	public FarmRfDoctype getEntity(String id) {
		Session session = sessionFatory.getCurrentSession();
		return (FarmRfDoctype) session.get(FarmRfDoctype.class, id);
	}

	public FarmRfDoctype insertEntity(FarmRfDoctype entity) {
		Session session = sessionFatory.getCurrentSession();
		session.save(entity);
		return entity;
	}

	public void editEntity(FarmRfDoctype entity) {
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
	public List<FarmRfDoctype> selectEntitys(List<DBRule> rules) {
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

	public HibernateSQLTools<FarmRfDoctype> getSqlTools() {
		return sqlTools;
	}

	public void setSqlTools(HibernateSQLTools<FarmRfDoctype> sqlTools) {
		this.sqlTools = sqlTools;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<FarmDoctype> getDocType(String docId) {
		Session session = sessionFatory.getCurrentSession();
		SQLQuery sqlquery = (SQLQuery) session
				.createSQLQuery(
						"select a.NAME AS NAME,a.TYPEMOD AS TYPEMOD,a.CONTENTMOD AS CONTENTMOD,a.SORT AS SORT,a.TYPE AS TYPE,a.METATITLE AS METATITLE,a.METAKEY AS METAKEY,a.METACONTENT AS METACONTENT,a.LINKURL AS LINKURL,a.ID AS ID,a.CTIME AS CTIME,a.ETIME AS ETIME,a.CUSERNAME AS CUSERNAME,a.CUSER AS CUSER,a.EUSERNAME AS EUSERNAME,a.EUSER AS EUSER,a.PCONTENT AS PCONTENT,a.PSTATE,a.PARENTID,a.TAGS,a.TREECODE FROM farm_doctype a LEFT JOIN farm_rf_doctype b ON a.ID=b.TYPEID where b.docid=?")
				.addEntity(FarmDoctype.class).setString(0, docId);
		return (List<FarmDoctype>) sqlquery.list();
	}
}
