package com.farm.wcp.statis.web.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.farm.doc.server.FarmFileManagerInter;

import com.farm.authority.domain.User;
import com.farm.authority.service.UserServiceInter;
import com.farm.core.FarmService;
import com.farm.core.page.CommitType;
import com.farm.core.page.PageSet;
import com.farm.core.page.PageType;
import com.farm.core.sql.query.DBSort;
import com.farm.core.sql.query.DataQuery;
import com.farm.core.sql.query.DataQuery.CACHE_UNIT;
import com.farm.core.sql.result.DataResult;
import com.farm.web.WebSupport;
import com.farm.web.spring.BeanFactory;

/**
 * 统计
 * 
 * @author autoCode
 * 
 */
public class ActionIndex extends WebSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private DataResult result;// 结果集合
	private DataQuery query;// 条件查询
	private PageSet pageset;// 请求状态
	private String ids;// 主键集合
	private String id;
	private String photourl;
	private List<List<Object>> jsonResultTotalNum;
	private List<List<Object>> jsonResultDayNum;
	private List<List<Object>> jsonResultTotalGoodNum;
	private List<List<Object>> jsonResultTotalBadNum;

	public String timeLineStatisAjaxData() {
		try {
			query = DataQuery
					.init(query,
							"(SELECT COUNT(id) AS num,LEFT(ctime,8) AS DATE FROM farm_doc GROUP BY DATE) AS a",
							"NUM,DATE");
			query.setPagesize(10000);
			query.addSort(new DBSort("DATE", "ASC"));
			query.setCache(
					Integer.valueOf(FarmService.getInstance()
							.getParameterService()
							.getParameter("config.wcp.cache.statis")),
					CACHE_UNIT.minute);
			result = query.search();

			DataQuery queryGood = DataQuery
					.init(query,
							"(SELECT COUNT(a.id) AS num,LEFT(a.ctime,8) AS DATE FROM farm_doc a LEFT JOIN farm_docruninfo b ON a.RUNINFOID=b.ID WHERE b.EVALUATE>0  GROUP BY DATE) AS a",
							"NUM,DATE");
			queryGood.setPagesize(10000);
			queryGood.addSort(new DBSort("DATE", "ASC"));
			DataResult resultGood = queryGood.search();
			DataQuery queryBad = DataQuery
					.init(query,
							"(SELECT COUNT(a.id) AS num,LEFT(a.ctime,8) AS DATE FROM farm_doc a LEFT JOIN farm_docruninfo b ON a.RUNINFOID=b.ID WHERE b.EVALUATE<0  GROUP BY DATE) AS a",
							"NUM,DATE");
			queryBad.setPagesize(10000);
			queryBad.addSort(new DBSort("DATE", "ASC"));
			DataResult resultBad = queryBad.search();
			query = DataQuery
					.init(query,
							"(SELECT COUNT(id) AS num,LEFT(ctime,8) AS DATE FROM farm_doc GROUP BY DATE) AS a",
							"NUM,DATE");
			query.setPagesize(10000);
			query.addSort(new DBSort("DATE", "ASC"));
			result = query.search();

			jsonResultDayNum = new ArrayList<List<Object>>();
			jsonResultTotalNum = new ArrayList<List<Object>>();
			jsonResultTotalGoodNum = new ArrayList<List<Object>>();
			jsonResultTotalBadNum = new ArrayList<List<Object>>();

			for (Map<String, Object> node : result.getResultList()) {
				List<Object> nodeList = new ArrayList<Object>();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				nodeList.add(Long.valueOf(sdf
						.parse(node.get("DATE").toString()).getTime()));
				nodeList.add(Float.valueOf(node.get("NUM").toString()));
				jsonResultDayNum.add(nodeList);
			}
			Float TotalNum = Float.valueOf(0);
			for (Map<String, Object> node : result.getResultList()) {
				List<Object> nodeList = new ArrayList<Object>();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				nodeList.add(Long.valueOf(sdf
						.parse(node.get("DATE").toString()).getTime()));
				TotalNum = TotalNum + Float.valueOf(node.get("NUM").toString());
				nodeList.add(TotalNum);
				jsonResultTotalNum.add(nodeList);
			}
			Float TotalGoodNum = Float.valueOf(0);
			for (Map<String, Object> node : resultGood.getResultList()) {
				List<Object> nodeList = new ArrayList<Object>();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				nodeList.add(Long.valueOf(sdf
						.parse(node.get("DATE").toString()).getTime()));
				TotalGoodNum = TotalGoodNum
						+ Float.valueOf(node.get("NUM").toString());
				nodeList.add(TotalGoodNum);
				jsonResultTotalGoodNum.add(nodeList);
			}
			Float TotalBadNum = Float.valueOf(0);
			for (Map<String, Object> node : resultBad.getResultList()) {
				List<Object> nodeList = new ArrayList<Object>();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				nodeList.add(Long.valueOf(sdf
						.parse(node.get("DATE").toString()).getTime()));
				TotalBadNum = TotalBadNum
						+ Float.valueOf(node.get("NUM").toString());
				nodeList.add(TotalBadNum);
				jsonResultTotalBadNum.add(nodeList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	public String index() {
		try {
			pageset = new PageSet(PageType.OTHER, CommitType.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			pageset = PageSet.setError(pageset, e, "");
		}
		return SUCCESS;
	}

	/**
	 * 好评文章排名
	 * 
	 * @return
	 */
	public String loadgoodDocStatis() {
		try {
			query.setPagesize(10);
			query = DataQuery
					.init(query,
							"FARM_DOC a LEFT JOIN FARM_DOCRUNINFO b ON a.RUNINFOID=b.ID LEFT JOIN FARM_DOCGROUP c ON a.DOCGROUPID=c.ID LEFT JOIN ALONE_AUTH_USER d ON a.CUSER=d.ID",
							"a.title AS title,a.id AS id,c.JOINCHECK AS JOINCHECK,b.EVALUATE AS EVALUATE,c.GROUPIMG AS GROUPIMG,d.IMGID AS PHOTOID,d.NAME AS USERNAME,c.GROUPNAME AS GROUPNAME,a.DOCGROUPID AS GROUPID");
			query.addSort(new DBSort("b.EVALUATE", "DESC"));
			query.setCache(
					Integer.valueOf(FarmService.getInstance()
							.getParameterService()
							.getParameter("config.wcp.cache.statis")),
					CACHE_UNIT.minute);
			result = query.search();
			pageset = new PageSet(PageType.OTHER, CommitType.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			pageset = PageSet.setError(pageset, e, "");
		}
		return SUCCESS;
	}

	public String loadbadDocStatis() {
		try {
			query.setPagesize(10);
			query = DataQuery
					.init(query,
							"FARM_DOC a LEFT JOIN FARM_DOCRUNINFO b ON a.RUNINFOID=b.ID LEFT JOIN FARM_DOCGROUP c ON a.DOCGROUPID=c.ID LEFT JOIN ALONE_AUTH_USER d ON a.CUSER=d.ID",
							"a.title AS title,a.id AS id,c.JOINCHECK AS JOINCHECK,b.EVALUATE AS EVALUATE,c.GROUPIMG AS GROUPIMG,d.IMGID AS PHOTOID,d.NAME AS USERNAME,c.GROUPNAME AS GROUPNAME,a.DOCGROUPID AS GROUPID");
			query.addSort(new DBSort("b.EVALUATE", "ASC"));
			query.setCache(
					Integer.valueOf(FarmService.getInstance()
							.getParameterService()
							.getParameter("config.wcp.cache.statis")),
					CACHE_UNIT.minute);
			result = query.search();
			pageset = new PageSet(PageType.OTHER, CommitType.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			pageset = PageSet.setError(pageset, e, "");
		}
		return SUCCESS;
	}

	public String goodGroupStatis() {
		try {
			query.setPagesize(10);
			query = DataQuery
					.init(query,
							"( SELECT d.ID   AS ID, d.GROUPNAME AS NAME,d.JOINCHECK as JOINCHECK, SUM(b.PRAISEYES) AS SUMYES FROM FARM_DOC a LEFT JOIN FARM_DOCRUNINFO b ON a.RUNINFOID = b.ID LEFT JOIN FARM_DOCGROUP d ON d.id=a.DOCGROUPID WHERE d.ID IS NOT NULL GROUP BY d.ID,d.GROUPNAME,d.JOINCHECK) g",
							"ID,NAME,SUMYES,JOINCHECK");
			query.addSort(new DBSort("g.SUMYES", "DESC"));
			query.setCache(
					Integer.valueOf(FarmService.getInstance()
							.getParameterService()
							.getParameter("config.wcp.cache.statis")),
					CACHE_UNIT.minute);
			result = query.search();
			pageset = new PageSet(PageType.OTHER, CommitType.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			pageset = PageSet.setError(pageset, e, "");
		}
		return SUCCESS;
	}

	public String loadgoodUserStatis() {
		try {
			query.setPagesize(10);
			query = DataQuery
					.init(query,
							"( SELECT d.ID AS ID,d.NAME AS NAME,SUM(b.PRAISEYES) AS SUMYES FROM FARM_DOC a LEFT JOIN FARM_DOCRUNINFO b ON a.RUNINFOID = b.ID LEFT JOIN ALONE_AUTH_USER d ON a.CUSER = d.ID GROUP BY d.ID,d.NAME) g",
							"ID,NAME,SUMYES");
			query.addSort(new DBSort("g.SUMYES", "DESC"));
			query.setCache(
					Integer.valueOf(FarmService.getInstance()
							.getParameterService()
							.getParameter("config.wcp.cache.statis")),
					CACHE_UNIT.minute);
			result = query.search();
			pageset = new PageSet(PageType.OTHER, CommitType.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			pageset = PageSet.setError(pageset, e, "");
		}
		return SUCCESS;
	}

	public String manyDocUserStatis() {
		try {
			query.setPagesize(10);
			query = DataQuery
					.init(query,
							"( SELECT b.ID AS ID, b.name AS NAME, COUNT(*) AS NUM FROM FARM_DOC a LEFT JOIN ALONE_AUTH_USER b ON a.CUSER = b.ID GROUP BY b.id,b.NAME) g",
							"ID,NAME,NUM");
			query.addSort(new DBSort("g.NAME", "DESC"));
			query.setCache(
					Integer.valueOf(FarmService.getInstance()
							.getParameterService()
							.getParameter("config.wcp.cache.statis")),
					CACHE_UNIT.minute);
			result = query.search();
			pageset = new PageSet(PageType.OTHER, CommitType.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			pageset = PageSet.setError(pageset, e, "");
		}
		return SUCCESS;
	}

	public String loadmyStatis() {
		try {
			User user;
			if (id != null && id.trim().length() > 0) {
				user = userIMP.getUserEntity(id);
			} else {
				user = userIMP.getUserEntity(getCurrentUser().getId());
			}
			if (user.getImgid() != null && user.getImgid().trim().length() > 0) {
				photourl = fileIMP.getFileURL(user.getImgid());
			}
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT a.NAME AS NAME,a.ID AS ID,a.ctime AS ctime,(SELECT COUNT(*) FROM FARM_DOC WHERE cuser=a.ID) num,(SELECT MIN(ctime) FROM FARM_DOC WHERE cuser=a.ID) stime,(SELECT MAX(ctime) FROM FARM_DOC WHERE cuser=a.ID) etime,");
			sql.append("(SELECT SUM(pb.PRAISEYES) FROM FARM_DOC pa LEFT JOIN FARM_DOCRUNINFO pb ON pb.id=pa.RUNINFOID WHERE cuser=a.ID) AS OKNUM,");
			sql.append("(SELECT SUM(pb.PRAISENO) FROM FARM_DOC pa LEFT JOIN FARM_DOCRUNINFO pb ON pb.id=pa.RUNINFOID WHERE cuser=a.ID) AS NONUM,");
			sql.append("(SELECT SUM(pb.EVALUATE) FROM FARM_DOC pa LEFT JOIN FARM_DOCRUNINFO pb ON pb.id=pa.RUNINFOID WHERE cuser=a.ID) AS EVANUM,");
			sql.append("(SELECT SUM(pb.VISITNUM) FROM FARM_DOC pa LEFT JOIN FARM_DOCRUNINFO pb ON pb.id=pa.RUNINFOID WHERE cuser=a.ID) AS VINUM,");
			sql.append("(SELECT COUNT(*) FROM FARM_DOC pa LEFT JOIN FARM_DOCRUNINFO pb ON pb.id=pa.RUNINFOID WHERE cuser=a.ID AND pb.EVALUATE>0) AS GOODNUM,");
			sql.append("(SELECT COUNT(*) FROM FARM_DOC pa LEFT JOIN FARM_DOCRUNINFO pb ON pb.id=pa.RUNINFOID WHERE cuser=a.ID AND pb.EVALUATE<0) AS BADNUM");
			sql.append(" FROM ALONE_AUTH_USER a WHERE a.ID='"
					+ user.getId() + "'");
			query.setPagesize(10);
			query = DataQuery
					.init(query, "(" + sql.toString() + ") g",
							"ID,NAME,NUM,OKNUM,NONUM,EVANUM,VINUM,GOODNUM,BADNUM,STIME,ETIME,CTIME");
			query.setNoCount();
			query.setCache(
					Integer.valueOf(FarmService.getInstance()
							.getParameterService()
							.getParameter("config.wcp.cache.statis")),
					CACHE_UNIT.minute);
			result = query.search();
			if (result.getResultList().get(0).get("EVANUM") == null) {
				result.getResultList().get(0).put("EVANUM", 0);
			}
			if (result.getResultList().get(0).get("VINUM") == null) {
				result.getResultList().get(0).put("VINUM", 0);
			}
			if (result.getResultList().get(0).get("OKNUM") == null) {
				result.getResultList().get(0).put("OKNUM", 0);
			}
			if (result.getResultList().get(0).get("NONUM") == null) {
				result.getResultList().get(0).put("NONUM", 0);
			}
			float eva = new Float(result.getResultList().get(0).get("EVANUM")
					.toString());
			float startRight = 5;
			int L4 = (int) Math.floor(eva
					/ (startRight * startRight * startRight));// 125
			float L4m = eva % (startRight * startRight * startRight);
			int L3 = (int) Math.floor(L4m / (startRight * startRight));// 25
			float L3m = L4m % (startRight * startRight);// 25
			int L2 = (int) Math.floor(L3m / startRight);// 5
			float L2m = L3m % startRight;// 5
			int L1 = (int) Math.floor(L2m);// 1
			result.getResultList().get(0).put("L4", L4);
			result.getResultList().get(0).put("L3", L3);
			result.getResultList().get(0).put("L2", L2);
			result.getResultList().get(0).put("L1", L1);
			pageset = new PageSet(PageType.OTHER, CommitType.TRUE);
		} catch (Exception e) {
			e.printStackTrace();
			pageset = PageSet.setError(pageset, e, "");
		}
		return SUCCESS;
	}

	private final FarmFileManagerInter fileIMP = (FarmFileManagerInter) BeanFactory
			.getBean("farm_docFileProxyId");
	private final static UserServiceInter userIMP = (UserServiceInter) BeanFactory
			.getBean("farm_authority_user_ProxyId");

	public DataResult getResult() {
		return result;
	}

	public void setResult(DataResult result) {
		this.result = result;
	}

	public DataQuery getQuery() {
		return query;
	}

	public void setQuery(DataQuery query) {
		this.query = query;
	}

	public PageSet getPageset() {
		return pageset;
	}

	public void setPageset(PageSet pageset) {
		this.pageset = pageset;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getId() {
		return id;
	}

	public String getPhotourl() {
		return photourl;
	}

	public void setPhotourl(String photourl) {
		this.photourl = photourl;
	}

	public void setId(String id) {
		this.id = id;
	}

	public List<List<Object>> getJsonResultTotalNum() {
		return jsonResultTotalNum;
	}

	public void setJsonResultTotalNum(List<List<Object>> jsonResultTotalNum) {
		this.jsonResultTotalNum = jsonResultTotalNum;
	}

	public List<List<Object>> getJsonResultDayNum() {
		return jsonResultDayNum;
	}

	public void setJsonResultDayNum(List<List<Object>> jsonResultDayNum) {
		this.jsonResultDayNum = jsonResultDayNum;
	}

	public List<List<Object>> getJsonResultTotalGoodNum() {
		return jsonResultTotalGoodNum;
	}

	public void setJsonResultTotalGoodNum(
			List<List<Object>> jsonResultTotalGoodNum) {
		this.jsonResultTotalGoodNum = jsonResultTotalGoodNum;
	}

	public List<List<Object>> getJsonResultTotalBadNum() {
		return jsonResultTotalBadNum;
	}

	public void setJsonResultTotalBadNum(
			List<List<Object>> jsonResultTotalBadNum) {
		this.jsonResultTotalBadNum = jsonResultTotalBadNum;
	}
	// ----------------------------------------------------------------------------------

}
