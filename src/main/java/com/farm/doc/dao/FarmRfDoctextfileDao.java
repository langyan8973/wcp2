package  com.farm.doc.dao;

import java.math.BigInteger;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import com.farm.doc.domain.FarmRfDoctextfile;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.core.sql.utils.HibernateSQLTools;
import java.util.List;
import java.util.Map;

/**中间表-内容-附件
 * @author MAC_wd
 * 
 */
public class FarmRfDoctextfileDao implements  FarmRfDoctextfileDaoInter {
	private SessionFactory sessionFatory;
	private HibernateSQLTools<FarmRfDoctextfile> sqlTools ;

	public void deleteEntity(FarmRfDoctextfile entity) {
		Session session=sessionFatory.getCurrentSession();
		session.delete(entity);
	}
	public int getAllListNum(){
		Session session= sessionFatory.getCurrentSession();
		SQLQuery sqlquery= session.createSQLQuery("select count(*) from farm_rf_doctextfile");
		BigInteger num=(BigInteger)sqlquery.list().get(0);
		return num.intValue() ;
	}
	public FarmRfDoctextfile getEntity(String id) {
		Session session= sessionFatory.getCurrentSession();
		return (FarmRfDoctextfile)session.get(FarmRfDoctextfile.class, id);
	}
	public FarmRfDoctextfile insertEntity(FarmRfDoctextfile entity) {
		Session session= sessionFatory.getCurrentSession();
		session.save(entity);
		return entity;
	}
	public void editEntity(FarmRfDoctextfile entity) {
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
	public List<FarmRfDoctextfile> selectEntitys(List<DBRule> rules) {
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
	public HibernateSQLTools<FarmRfDoctextfile> getSqlTools() {
		return sqlTools;
	}
	public void setSqlTools(HibernateSQLTools<FarmRfDoctextfile> sqlTools) {
		this.sqlTools = sqlTools;
	}
}
