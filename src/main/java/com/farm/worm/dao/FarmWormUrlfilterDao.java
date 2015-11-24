package  com.farm.worm.dao;

import java.math.BigInteger;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import com.farm.worm.domain.FarmWormUrlfilter;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.result.DataResult;
import com.farm.core.sql.utils.HibernateSQLTools;
import java.util.List;
import java.util.Map;

/**URL过滤器
 * @author MAC_wd
 * 
 */
public class FarmWormUrlfilterDao implements  FarmWormUrlfilterDaoInter {
	private SessionFactory sessionFatory;
	private HibernateSQLTools<FarmWormUrlfilter> sqlTools ;

	public void deleteEntity(FarmWormUrlfilter entity) {
		Session session=sessionFatory.getCurrentSession();
		session.delete(entity);
	}
	public int getAllListNum(){
		Session session= sessionFatory.getCurrentSession();
		SQLQuery sqlquery= session.createSQLQuery("select count(*) from farm_worm_urlfilter");
		BigInteger num=(BigInteger)sqlquery.list().get(0);
		return num.intValue() ;
	}
	public FarmWormUrlfilter getEntity(String id) {
		Session session= sessionFatory.getCurrentSession();
		return (FarmWormUrlfilter)session.get(FarmWormUrlfilter.class, id);
	}
	public FarmWormUrlfilter insertEntity(FarmWormUrlfilter entity) {
		Session session= sessionFatory.getCurrentSession();
		session.save(entity);
		return entity;
	}
	public void editEntity(FarmWormUrlfilter entity) {
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
	public List<FarmWormUrlfilter> selectEntitys(List<DBRule> rules) {
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
	public HibernateSQLTools<FarmWormUrlfilter> getSqlTools() {
		return sqlTools;
	}
	public void setSqlTools(HibernateSQLTools<FarmWormUrlfilter> sqlTools) {
		this.sqlTools = sqlTools;
	}
}
