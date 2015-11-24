package  com.farm.doc.dao;

import java.math.BigInteger;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import com.farm.doc.domain.FarmDocgroupUser;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.core.sql.utils.HibernateSQLTools;
import java.util.List;
import java.util.Map;

/**工作小组成员
 * @author MAC_wd
 * 
 */
public class FarmDocgroupUserDao implements  FarmDocgroupUserDaoInter {
	private SessionFactory sessionFatory;
	private HibernateSQLTools<FarmDocgroupUser> sqlTools ;

	public void deleteEntity(FarmDocgroupUser entity) {
		Session session=sessionFatory.getCurrentSession();
		session.delete(entity);
	}
	public int getAllListNum(){
		Session session= sessionFatory.getCurrentSession();
		SQLQuery sqlquery= session.createSQLQuery("select count(*) from farm_docgroup_user");
		BigInteger num=(BigInteger)sqlquery.list().get(0);
		return num.intValue() ;
	}
	public FarmDocgroupUser getEntity(String id) {
		Session session= sessionFatory.getCurrentSession();
		return (FarmDocgroupUser)session.get(FarmDocgroupUser.class, id);
	}
	public FarmDocgroupUser insertEntity(FarmDocgroupUser entity) {
		Session session= sessionFatory.getCurrentSession();
		session.save(entity);
		return entity;
	}
	public void editEntity(FarmDocgroupUser entity) {
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
	public List<FarmDocgroupUser> selectEntitys(List<DBRule> rules) {
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
	public HibernateSQLTools<FarmDocgroupUser> getSqlTools() {
		return sqlTools;
	}
	public void setSqlTools(HibernateSQLTools<FarmDocgroupUser> sqlTools) {
		this.sqlTools = sqlTools;
	}
}
