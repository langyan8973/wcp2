package com.farm.doc.server;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

import com.farm.core.auth.domain.LoginUser;
import com.farm.core.time.TimeTool;
import com.farm.doc.dao.FarmDocDaoInter;
import com.farm.doc.dao.FarmDocenjoyDaoInter;
import com.farm.doc.dao.FarmDocfileDaoInter;
import com.farm.doc.dao.FarmDocgroupDaoInter;
import com.farm.doc.dao.FarmDocmessageDaoInter;
import com.farm.doc.dao.FarmDocruninfoDaoInter;
import com.farm.doc.dao.FarmDocruninfoDetailDaoInter;
import com.farm.doc.dao.FarmDoctextDaoInter;
import com.farm.doc.dao.FarmDoctypeDaoInter;
import com.farm.doc.dao.FarmRfDoctextfileDaoInter;
import com.farm.doc.dao.FarmRfDoctypeDaoInter;
import com.farm.doc.domain.FarmDoc;
import com.farm.doc.domain.FarmDocfile;
import com.farm.doc.domain.FarmDocruninfo;
import com.farm.doc.domain.FarmDoctext;
import com.farm.doc.domain.FarmDoctype;
import com.farm.doc.domain.FarmRfDoctextfile;
import com.farm.doc.domain.FarmRfDoctype;
import com.farm.doc.exception.CanNoDeleteException;
import com.farm.doc.exception.CanNoReadException;
import com.farm.doc.exception.CanNoWriteException;
import com.farm.doc.exception.DocNoExistException;
import com.farm.doc.server.FarmDocManagerInter;
import com.farm.doc.server.FarmDocOperateRightInter.POP_TYPE;
import com.farm.doc.server.commons.DocumentConfig;
import com.farm.doc.server.commons.FarmDocFiles;
import com.farm.core.sql.query.DBRule;
import com.farm.core.sql.query.DBSort;
import com.farm.core.sql.query.DataQuery;

/**
 * 文档管理
 * 
 * @author MAC_wd
 */
public class FarmDocManagerImpl implements FarmDocManagerInter {
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
	private FarmDocgroupDaoInter farmDocgroupDao;
	private FarmDocruninfoDetailDaoInter farmDocruninfoDetailDao;
	private FarmFileManagerInter farmFileServer;

	public FarmDoctypeDaoInter getFarmDoctypeDao() {
		return farmDoctypeDao;
	}

	public void setFarmDoctypeDao(FarmDoctypeDaoInter farmDoctypeDao) {
		this.farmDoctypeDao = farmDoctypeDao;
	}

	// ----------------------------------------------------------------------------------
	public FarmDocDaoInter getfarmDocDao() {
		return farmDocDao;
	}

	public void setfarmDocDao(FarmDocDaoInter dao) {
		this.farmDocDao = dao;
	}

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

	public FarmDocmessageDaoInter getFarmDocmessageDao() {
		return farmDocmessageDao;
	}

	public FarmDocgroupDaoInter getFarmDocgroupDao() {
		return farmDocgroupDao;
	}

	public void setFarmDocgroupDao(FarmDocgroupDaoInter farmDocgroupDao) {
		this.farmDocgroupDao = farmDocgroupDao;
	}

	public FarmDocruninfoDetailDaoInter getFarmDocruninfoDetailDao() {
		return farmDocruninfoDetailDao;
	}

	public void setFarmDocruninfoDetailDao(
			FarmDocruninfoDetailDaoInter farmDocruninfoDetailDao) {
		this.farmDocruninfoDetailDao = farmDocruninfoDetailDao;
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

	// private static final Logger log = Logger
	// .getLogger(FarmDocManagerImpl.class);

	public FarmDoc createDoc(FarmDoc entity, LoginUser user) {
		try {
			// 保存用量信息
			FarmDocruninfo runinfo = new FarmDocruninfo();
			{
				runinfo.setHotnum(0);
				runinfo.setLastvtime(TimeTool.getTimeDate14());
				runinfo.setPraiseno(0);
				runinfo.setPraiseyes(0);
				runinfo.setVisitnum(0);
				runinfo.setAnsweringnum(0);
				runinfo.setEvaluate(0);
				runinfo = farmDocruninfoDao.insertEntity(runinfo);
				entity.setRuninfoid(runinfo.getId());
			}
			// 先保存text
			{
				if (entity.getDocdescribe() == null
						|| entity.getDocdescribe().trim().length() <= 0) {
					if(entity.getTexts()!=null){
						String html = FarmDocFiles.HtmlRemoveTag(entity.getTexts()
								.getText1());
						entity.setDocdescribe(html.length() > 128 ? html.substring(
								0, 128) : html);
					}
				}
				entity.setCtime(TimeTool.getTimeDate14());
				entity.setEtime(TimeTool.getTimeDate14());
				entity.setCuser(user.getId());
				entity.setEuser(user.getId());
				entity.setCusername(user.getName());
				entity.setEusername(user.getName());
				entity.setPubtime(entity.getPubtime().replaceAll("-", "")
						.replaceAll(":", "").replaceAll(" ", ""));
				entity.getTexts().setPstate("1");// 1在用内容。2.版本存档
				entity.getTexts().setPcontent("CREAT");
				entity.setTexts(farmDoctextDao.insertEntity(entity.getTexts()));
				entity.setTextid(entity.getTexts().getId());
				if (entity.getReadpop() == null) {
					entity.setReadpop(POP_TYPE.PUB.getValue());
				}
				if (entity.getWritepop() == null) {
					entity.setWritepop(POP_TYPE.PUB.getValue());
				}
				entity = initDoc(entity, user);
				entity = farmDocDao.insertEntity(entity);
			}
			// 保存分类信息
			{
				if (entity.getTypes() != null) {
					for (FarmDoctype type : entity.getTypes()) {
						farmRfDoctypeDao.insertEntity(new FarmRfDoctype(type
								.getId(), entity.getId()));
					}
				}
			}
			entity = farmDocDao.insertEntity(entity);
			// 保存关联附件信息（中间表）
			{
				List<String> files = FarmDocFiles.getFilesId(entity.getTexts()
						.getText1());
				for (String id : files) {
					farmRfDoctextfileDao.insertEntity(new FarmRfDoctextfile(
							entity.getId(), id));
					farmFileServer.submitFile(id);
				}
			}
		} catch (Exception e) {
			throw new RuntimeException("farmDoc文档创建失败：" + e + e.getMessage());
		}
		return entity;
	}

	public FarmDoc editDocByUser(FarmDoc entity, String editNote, LoginUser user)
			throws CanNoWriteException {
		FarmDoc entity2 = farmDocDao.getEntity(entity.getId());
		if (!farmDocOperate.isWrite(user, entity2)) {
			throw new CanNoWriteException();
		}
		FarmDoc doc = editDoc(entity, editNote, user);
		return doc;
	}

	public FarmDoc editDoc(FarmDoc entity, String editNote, LoginUser user) {
		FarmDoc entity2 = farmDocDao.getEntity(entity.getId());
		entity2.setTitle(entity.getTitle());
		entity2.setDocdescribe(entity.getDocdescribe());
		entity2.setAuthor(entity.getAuthor());
		entity2.setDomtype(entity.getDomtype());
		entity2.setShorttitle(entity.getShorttitle());
		entity2.setTagkey(entity.getTagkey());
		entity2.setSource(entity.getSource());
		entity2.setPubtime(entity.getPubtime().replaceAll(" ", "").replaceAll(
				"-", "").replaceAll(":", ""));
		entity2.setTopleve(entity.getTopleve());
		entity2.setImgid(entity.getImgid());
		entity2.setDocgroupid(entity.getDocgroupid());
		entity2.setState(entity.getState());
		entity2.setWritepop(entity.getWritepop());
		entity2.setReadpop(entity.getReadpop());
		entity2.setPcontent(entity.getPcontent());
		entity2.setEtime(TimeTool.getTimeDate14());
		entity2.setEuser(user.getId());
		entity2.setEusername(user.getName());
		initDoc(entity2, user);
		farmDocDao.editEntity(entity2);
		{// 直接更新，处理text和版本信息,
			FarmDoctext text = farmDoctextDao.getEntity(entity2.getTextid());
			try {
				FarmDoctext histext = (FarmDoctext) BeanUtils.cloneBean(text);
				histext.setId(null);
				histext.setPstate("2");
				histext.setDocid(entity2.getId());
				farmDoctextDao.insertEntity(histext);
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			text.setText1(entity.getTexts().getText1());
			text.setCtime(TimeTool.getTimeDate14());
			text.setEtime(TimeTool.getTimeDate14());
			text.setCuser(user.getId());
			text.setPcontent(editNote);
			text.setCusername(user.getName());
			text.setEuser(user.getId());
			text.setEusername(user.getName());
			farmDoctextDao.editEntity(text);
		}
		List<String> files = FarmDocFiles.getFilesId(entity.getTexts()
				.getText1());
		for (String id : files) {
			// 删除掉重复的附件
			List<DBRule> listRules = new ArrayList<DBRule>();
			listRules.add(new DBRule("FILEID", id, "="));
			listRules.add(new DBRule("DOCID", entity2.getId(), "="));
			farmRfDoctextfileDao.deleteEntitys(listRules);
			farmRfDoctextfileDao.insertEntity(new FarmRfDoctextfile(entity2
					.getId(), id));
			// 处理附件
			farmFileServer.submitFile(id);
		}
		return entity2;
	}

	public void deleteDoc(String entity, LoginUser user)
			throws CanNoDeleteException {
		FarmDoc doc = farmDocDao.getEntity(entity);
		if (!farmDocOperate.isDel(user, doc)) {
			throw new CanNoDeleteException("当前用户无此权限！");
		}
		FarmDoctext text = farmDoctextDao.getEntity(doc.getTextid());
		// 删除收藏
		List<DBRule> joylist = new ArrayList<DBRule>();
		joylist.add(new DBRule("DOCID", doc.getId(), "="));
		farmDocenjoyDao.deleteEntitys(joylist);
		// 删除分类中间表
		List<DBRule> rulesDelType = new ArrayList<DBRule>();
		rulesDelType.add(new DBRule("DOCID", doc.getId(), "="));
		farmRfDoctypeDao.deleteEntitys(rulesDelType);
		// 删除文档
		farmDocDao.deleteEntity(farmDocDao.getEntity(entity));
		// 删除附件中间表
		List<DBRule> rulesDelFile = new ArrayList<DBRule>();
		rulesDelFile.add(new DBRule("DOCID", text.getId(), "="));
		List<FarmRfDoctextfile> files = farmRfDoctextfileDao
				.selectEntitys(rulesDelFile);
		for (FarmRfDoctextfile node : files) {
			farmFileServer.delFile(node.getFileid(), user);
		}
		// 删除中间表文档和附件表
		List<DBRule> rulesDelText = new ArrayList<DBRule>();
		rulesDelText.add(new DBRule("DOCID", doc.getId(), "="));
		farmRfDoctextfileDao.deleteEntitys(rulesDelText);
		// 删除附件
		if (doc.getImgid() != null && doc.getImgid().trim().length() > 0) {
			farmDocfileDao.deleteEntity(farmDocfileDao
					.getEntity(doc.getImgid()));
		}
		// 删除用量明细
		{
			List<DBRule> rulesDelruninfoDetail = new ArrayList<DBRule>();
			rulesDelruninfoDetail.add(new DBRule("RUNINFOID", doc
					.getRuninfoid(), "="));
			farmDocruninfoDetailDao.deleteEntitys(rulesDelruninfoDetail);
		}
		// 删除用量信息
		farmDocruninfoDao.deleteEntity(farmDocruninfoDao.getEntity(doc
				.getRuninfoid()));
		// 删除大文本信息
		farmDoctextDao.deleteEntity(text);
	}

	@Override
	public DataQuery createSimpleDocQuery(DataQuery query) {
		DataQuery dbQuery = DataQuery
				.init(
						query,
						"FARM_DOC  A LEFT JOIN FARM_RF_DOCTYPE B ON B.DOCID =A.ID LEFT JOIN FARM_DOCTYPE C ON C.ID=B.TYPEID LEFT JOIN farm_docgroup d ON d.ID=a.DOCGROUPID",
						"A.ID AS ID,A.DOCDESCRIBE as DOCDESCRIBE,A.WRITEPOP as WRITEPOP,A.READPOP as READPOP,A.TITLE AS TITLE,A.AUTHOR AS AUTHOR,A.PUBTIME AS PUBTIME,A.DOMTYPE AS DOMTYPE,A.SHORTTITLE AS SHORTTITLE,A.TAGKEY AS TAGKEY,A.STATE AS STATE,D.GROUPNAME AS GROUPNAME ");
		return dbQuery;
	}

	@Override
	public FarmDoc getDoc(String id) {
		if (id == null) {
			return null;
		}
		FarmDoc doc = farmDocDao.getEntity(id);
		doc.setTexts(farmDoctextDao.getEntity(doc.getTextid()));
		doc.setTypes(farmRfDoctypeDao.getDocType(id));
		if (doc.getTypes().size() > 0) {
			doc.setCurrenttypes(this.getTypeAllParent(doc.getTypes().get(0)
					.getId()));
		}
		doc.setRuninfo(farmDocruninfoDao.getEntity(doc.getRuninfoid()));
		if (doc.getTagkey() != null) {
			String tags = doc.getTagkey();
			String[] tags1 = tags.trim().replaceAll("，", ",").replaceAll("、",
					",").split(",");
			doc.setTags(Arrays.asList(tags1));
		}
		if (doc.getDocgroupid() != null) {
			doc.setGroup(farmDocgroupDao.getEntity(doc.getDocgroupid()));
			doc.getGroup().setImgurl(
					farmFileServer.getFileURL(doc.getGroup().getGroupimg()));
		}
		// 处理附件
		List<FarmDocfile> files = farmDocfileDao.getEntityByDocId(id);
		for (FarmDocfile file : files) {
			file.setUrl(farmFileServer.getFileURL(file.getId()));
		}
		doc.setFiles(files);
		if (doc.getImgid() != null && doc.getImgid().trim().length() > 0) {
			String url = DocumentConfig.getString("config.doc.download.url")
					+ doc.getImgid();
			doc.setImgUrl(url);
		}
		return doc;
	}

	@Override
	public FarmDoc getDoc(String id, LoginUser user) throws CanNoReadException, DocNoExistException {
		FarmDoc docbean = farmDocDao.getEntity(id);
		if(docbean== null){
			throw new DocNoExistException();
		}
		if (!farmDocOperate.isRead(user, docbean)) {
			throw new CanNoReadException();
		}
		FarmDoc doc = getDoc(id);
		return doc;
	}

	@Override
	public FarmDoc getDocOnlyBean(String id) {
		return farmDocDao.getEntity(id);
	}

	public FarmDoctype insertType(FarmDoctype entity, LoginUser user) {
		entity.setCtime(TimeTool.getTimeDate14());
		entity.setEtime(TimeTool.getTimeDate14());
		entity.setCuser(user.getId());
		entity.setEuser(user.getId());
		entity.setCusername(user.getName());
		entity.setEusername(user.getName());
		if (entity.getParentid() == null
				|| entity.getParentid().trim().length() <= 0) {
			entity.setParentid("NONE");
		}
		entity.setTreecode("NONE");
		entity = farmDoctypeDao.insertEntity(entity);
		if (entity.getParentid().equals("NONE")) {
			entity.setTreecode(entity.getId());
		} else {
			entity.setTreecode(farmDoctypeDao.getEntity(entity.getParentid())
					.getTreecode()
					+ entity.getId());
		}
		return farmDoctypeDao.insertEntity(entity);
	}

	public FarmDoctype editType(FarmDoctype entity, LoginUser user) {
		FarmDoctype entity2 = farmDoctypeDao.getEntity(entity.getId());
		entity2.setEtime(TimeTool.getTimeDate14());
		entity2.setEuser(user.getId());
		entity2.setEusername(user.getName());
		entity2.setName(entity.getName());
		entity2.setTypemod(entity.getTypemod());
		entity2.setContentmod(entity.getContentmod());
		entity2.setSort(entity.getSort());
		entity2.setTags(entity.getTags());
		entity2.setType(entity.getType());
		entity2.setMetatitle(entity.getMetatitle());
		entity2.setMetakey(entity.getMetakey());
		entity2.setMetacontent(entity.getMetacontent());
		entity2.setLinkurl(entity.getLinkurl());
		entity2.setPcontent(entity.getPcontent());
		entity2.setPstate(entity.getPstate());
		farmDoctypeDao.editEntity(entity2);
		return entity2;
	}

	public void deleteType(String typeId, LoginUser user) {
		// 删除分类中间表
		List<DBRule> rulesDelType = new ArrayList<DBRule>();
		rulesDelType.add(new DBRule("TYPEID", typeId, "="));
		farmRfDoctypeDao.deleteEntitys(rulesDelType);
		farmDoctypeDao.deleteEntity(farmDoctypeDao.getEntity(typeId));
	}

	public FarmDoctype getType(String id) {
		if (id == null) {
			return null;
		}
		return farmDoctypeDao.getEntity(id);
	}

	@Override
	public DataQuery createSimpleTypeQuery(DataQuery query) {
		DataQuery dbQuery = DataQuery
				.init(
						query,
						"farm_doctype a LEFT JOIN farm_doctype b ON a.PARENTID=b.id",
						"a.ID AS id,a.NAME AS NAME,a.TYPEMOD AS TYPEMOD,a.CONTENTMOD AS CONTENTMOD,a.SORT AS SORT,a.TYPE AS TYPE, a.METATITLE AS METATITLE,a.METAKEY AS METAKEY,a.METACONTENT AS METACONTENT,a.LINKURL AS LINKURL,a.PCONTENT AS PCONTENT,a.PSTATE AS PSTATE");
		return dbQuery;
	}

	@Override
	public FarmDoc initDoc(FarmDoc doc, LoginUser currentUser) {
		if (doc.getAuthor() == null) {
			doc.setAuthor(currentUser.getName());
		}
		if (doc.getCtime() == null) {
			doc.setCtime(TimeTool.getTimeDate14());
		}
		if (doc.getCuser() == null) {
			doc.setCuser(currentUser.getId());
		}
		if (doc.getCusername() == null) {
			doc.setCusername(currentUser.getName());
		}
		if (doc.getDocdescribe() == null) {
			doc.setDocdescribe(null);
		}
		if (doc.getDomtype() == null) {
			doc.setDomtype("1");
		}
		if (doc.getDocgroupid() != null && doc.getDocgroupid().length() < 32) {
			doc.setDocgroupid(null);
		}
		if (doc.getEtime() == null) {
			doc.setEtime(TimeTool.getTimeDate14());
		}
		if (doc.getEuser() == null) {
			doc.setEuser(currentUser.getId());
		}
		if (doc.getEusername() == null) {
			doc.setEusername(currentUser.getName());
		}
		if (doc.getImgid() == null) {
		} else {
			if (doc.getImgid().trim().length() <= 0) {
				doc.setImgid(null);
			}
		}
		if (doc.getFiles() == null) {
			doc.setFiles(null);
		}
		if (doc.getPcontent() == null) {
			doc.setPcontent(null);
		}
		if (doc.getPubtime() == null) {
			doc.setPubtime(TimeTool.getTimeDate14());
		}
		if (doc.getReadpop() == null) {
			doc.setReadpop("1");
		}
		if (doc.getShorttitle() == null) {
			doc.setShorttitle(null);
		}
		if (doc.getSource() == null) {
			doc.setSource("原创");
		}
		if (doc.getState() == null) {
			doc.setState("1");
		}
		if (doc.getTagkey() == null) {
			doc.setTagkey(null);
		}
		if (doc.getTextid() == null) {
			doc.setTextid(null);
		}
		if (doc.getTexts() == null) {
			// doc.setTexts(null);
		}
		if (doc.getTitle() == null) {
			doc.setTitle(null);
		}
		if (doc.getTopleve() == null) {
			doc.setTopleve(10);
		}
		if (doc.getTypes() == null) {
			doc.setTypes(null);
		}
		if (doc.getWritepop() == null) {
			doc.setWritepop("1");
		}
		return doc;
	}

	@Override
	public FarmDoc createDoc(FarmDoc entity, FarmDoctype type,
			LoginUser currentUser) {
		List<FarmDoctype> list = new ArrayList<FarmDoctype>();
		list.add(type);
		entity.setTypes(list);
		return this.createDoc(entity, currentUser);
	}

	@Override
	public FarmDoc createDoc(FarmDoc entity, List<FarmDoctype> type,
			LoginUser currentUser) {
		entity.setTypes(type);
		return this.createDoc(entity, currentUser);
	}

	@Override
	public void updateDocTypeOnlyOne(String docid, String typeId) {
		List<DBRule> list = new ArrayList<DBRule>();
		list.add(new DBRule("DOCID", docid, "="));
		farmRfDoctypeDao.deleteEntitys(list);
		farmRfDoctypeDao.insertEntity(new FarmRfDoctype(typeId, docid));
	}

	@Override
	public List<FarmDoctype> getTypeAllParent(String typeid) {
		String id = typeid;
		List<FarmDoctype> types = new ArrayList<FarmDoctype>();
		while (id != null) {
			FarmDoctype centity = farmDoctypeDao.getEntity(id);
			if (centity == null || centity.getParentid() == null
					|| centity.getParentid().trim().length() <= 0) {
				id = null;
			} else {
				id = centity.getParentid();

			}
			if (centity != null) {
				types.add(centity);
			}
		}
		Collections.reverse(types);
		return types;
	}

	// WHERE PSTATE='2' AND DOCID=''
	@Override
	public DataQuery getDocVersions(String docId) {
		DataQuery dbQuery = DataQuery.getInstance("1",
				"ID,ETIME,CUSERNAME,DOCID,PCONTENT,PSTATE", "farm_doctext");
		dbQuery.addRule(new DBRule("PSTATE", "1", "!="));
		dbQuery.addRule(new DBRule("DOCID", docId, "="));
		dbQuery.setPagesize(100);
		dbQuery.addSort(new DBSort("CTIME", "DESC"));
		return dbQuery;
	}

	@Override
	public FarmDoc getDocVersion(String textId, LoginUser currentUser) {
		if (textId == null) {
			return null;
		}
		FarmDoctext text = farmDoctextDao.getEntity(textId);
		FarmDoc doc = farmDocDao.getEntity(text.getDocid());
		if (doc.getReadpop().equals("0")
				&& !doc.getCuser().equals(currentUser.getId())) {
			throw new RuntimeException("没有阅读权限");
		}
		doc.setTexts(text);
		doc.setTypes(farmRfDoctypeDao.getDocType(doc.getId()));
		if (doc.getTypes().size() > 0) {
			doc.setCurrenttypes(this.getTypeAllParent(doc.getTypes().get(0)
					.getId()));
		}
		if (doc.getTagkey() != null) {
			String tags = doc.getTagkey();
			String[] tags1 = tags.trim().replaceAll("，", ",").replaceAll("、",
					",").split(",");
			doc.setTags(Arrays.asList(tags1));
		}
		return doc;
	}

	public FarmDocOperateRightInter getFarmDocOperate() {
		return farmDocOperate;
	}

	public void setFarmDocOperate(FarmDocOperateRightInter farmDocOperate) {
		this.farmDocOperate = farmDocOperate;
	}

	public FarmFileManagerInter getFarmFileServer() {
		return farmFileServer;
	}

	public void setFarmFileServer(FarmFileManagerInter farmFileServer) {
		this.farmFileServer = farmFileServer;
	}

}
