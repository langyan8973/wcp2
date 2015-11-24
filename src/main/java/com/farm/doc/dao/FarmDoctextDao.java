package  com.farm.doc.dao;

import java.math.BigInteger;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import com.farm.doc.domain.FarmDoctext;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.core.sql.utils.HibernateSQLTools;
import java.util.List;
import java.util.Map;

/**文档内容
 * @author MAC_wd
 * 
 */
public class FarmDoctextDao implements  FarmDoctextDaoInter {
	private SessionFactory sessionFatory;
	private HibernateSQLTools<FarmDoctext> sqlTools ;

	public void deleteEntity(FarmDoctext entity) {
		Session session=sessionFatory.getCurrentSession();
		session.delete(entity);
	}
	public int getAllListNum(){
		Session session= sessionFatory.getCurrentSession();
		SQLQuery sqlquery= session.createSQLQuery("select count(*) from farm_doctext");
		BigInteger num=(BigInteger)sqlquery.list().get(0);
		return num.intValue() ;
	}
	public FarmDoctext getEntity(String id) {
		Session session= sessionFatory.getCurrentSession();
		return (FarmDoctext)session.get(FarmDoctext.class, id);
	}
	public FarmDoctext insertEntity(FarmDoctext entity) {
		Session session= sessionFatory.getCurrentSession();
		session.save(entity);
		return entity;
	}
	public void editEntity(FarmDoctext entity) {
		Session session= sessionFatory.getCurrentSession();
		session.update(entity);
	}
	
	@Override
	public Session getSession() {
		return sessionFatory.getCurrentSession();
	}
	public DataResult runSqlQuery(DataQuery query){
		try {
			return query.search(sessionFatory.getCurrentSession());
		} catch (Exception e) {
			return null;
		}
	}
	@Override
	public void deleteEntitys(List<DBRule> rules) {
		sqlTools.deleteSqlFromFunction(sessionFatory.getCurrentSession(), rules);
	}

	@Override
	public List<FarmDoctext> selectEntitys(List<DBRule> rules) {
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
	public HibernateSQLTools<FarmDoctext> getSqlTools() {
		return sqlTools;
	}
	public void setSqlTools(HibernateSQLTools<FarmDoctext> sqlTools) {
		this.sqlTools = sqlTools;
	}
}
