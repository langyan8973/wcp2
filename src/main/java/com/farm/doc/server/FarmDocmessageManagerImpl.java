package com.farm.doc.server;

import com.farm.core.auth.domain.LoginUser;
import com.farm.core.time.TimeTool;

import com.farm.doc.dao.FarmDocDaoInter;
import com.farm.doc.dao.FarmDocmessageDaoInter;
import com.farm.doc.dao.FarmDocruninfoDaoInter;
import com.farm.doc.domain.FarmDoc;
import com.farm.doc.domain.FarmDocmessage;
import com.farm.doc.domain.FarmDocruninfo;
import com.farm.doc.server.FarmDocmessageManagerInter;
import com.farm.core.sql.query.DataQuery;

/**
 * 留言板
 * 
 * @author MAC_wd
 */
public class FarmDocmessageManagerImpl implements FarmDocmessageManagerInter {
	private FarmDocmessageDaoInter farmDocmessageDao;
	private FarmDocruninfoDaoInter farmDocruninfoDao;
	private FarmDocDaoInter farmDocDao;
//	private static final Logger log = Logger
//			.getLogger(FarmDocmessageManagerImpl.class);

	public FarmDocmessage sendMessage(String readUserId, String text,
			String title, String note, String appId, LoginUser sendUser) {
		FarmDocmessage message = new FarmDocmessage();
		message.setCtime(TimeTool.getTimeDate14());
		message.setCuser(sendUser.getId());
		message.setCusername(sendUser.getName());
		message.setAppid(appId);
		message.setContent(text);
		message.setPcontent(note);
		message.setPstate("1");
		message.setReadstate("0");
		message.setReaduserid(readUserId);
		message.setTitle(title);
		return farmDocmessageDao.insertEntity(message);
	}

	public FarmDocmessage reSendMessage(String messageId, String text,
			LoginUser sendUser) {
		FarmDocmessage obMes = farmDocmessageDao.getEntity(messageId);
		FarmDocmessage message = new FarmDocmessage();
		message.setCtime(TimeTool.getTimeDate14());
		message.setCuser(sendUser.getId());
		message.setCusername(sendUser.getName());
		message.setAppid(obMes.getAppid());
		message.setContent(text);
		message.setPcontent(obMes.getPcontent());
		message.setPstate("1");
		message.setReadstate("0");
		message.setReaduserid(obMes.getCuser());
		message.setTitle(obMes.getTitle());
		return farmDocmessageDao.insertEntity(message);
	}

	public void deleteMessage(String entity, LoginUser user) {
		farmDocmessageDao.deleteEntity(farmDocmessageDao.getEntity(entity));
	}

	public FarmDocmessage getMessage(String id) {
		if (id == null) {
			return null;
		}
		return farmDocmessageDao.getEntity(id);
	}

	public FarmDocmessage readMessage(String id) {
		if (id == null) {
			return null;
		}
		FarmDocmessage obMes = farmDocmessageDao.getEntity(id);
		obMes.setReadstate("1");
		farmDocmessageDao.editEntity(obMes);
		return obMes;
	}

	@Override
	public DataQuery createMessageQuery(DataQuery query) {
		DataQuery dbQuery = DataQuery
				.init(
						query,
						"farm_docmessage a left join alone_auth_user c on c.id=a.READUSERID ",
						"a.id as id,a.CTIME as CTIME,a.CUSERNAME as CUSERNAME,a.CUSER as CUSER,a.PSTATE as PSTATE,a.PCONTENT as PCONTENT,a.READUSERID as READUSERID,c.name as READUSERNAME,a.CONTENT as CONTENT,a.TITLE as TITLE,a.APPID as APPID,a.READSTATE as READSTATE");
		return dbQuery;
	}

	// ----------------------------------------------------------------------------------
	public FarmDocmessageDaoInter getfarmDocmessageDao() {
		return farmDocmessageDao;
	}

	public void setfarmDocmessageDao(FarmDocmessageDaoInter dao) {
		this.farmDocmessageDao = dao;
	}

	public FarmDocruninfoDaoInter getFarmDocruninfoDao() {
		return farmDocruninfoDao;
	}

	public void setFarmDocruninfoDao(FarmDocruninfoDaoInter farmDocruninfoDao) {
		this.farmDocruninfoDao = farmDocruninfoDao;
	}

	public FarmDocDaoInter getFarmDocDao() {
		return farmDocDao;
	}

	public void setFarmDocDao(FarmDocDaoInter farmDocDao) {
		this.farmDocDao = farmDocDao;
	}

	@Override
	public FarmDocmessage sendMessage(String readUserId, String text,
			String title, String note, LoginUser sendUser) {
		return sendMessage(readUserId, text, title, note, null, sendUser);
	}

	@Override
	public int getNoReadMessageNum(LoginUser user) {
		return farmDocmessageDao.getNoReadMessageNum(user.getId());
	}

	@Override
	public FarmDocmessage sendAnswering(String content, String title,
			String mark, String appid, LoginUser sendUser) {
		FarmDocmessage message = new FarmDocmessage();
		message.setCtime(TimeTool.getTimeDate14());
		message.setCuser(sendUser.getId());
		message.setCusername(sendUser.getName());
		message.setAppid(appid);
		message.setContent(content);
		message.setPcontent(mark);
		message.setPstate("1");
		message.setReadstate("0");
		message.setTitle(title);
		message.setReaduserid("NONE");
		// 如果是文档就刷新文档的用量信息
		FarmDoc doc = farmDocDao.getEntity(appid);
		if (doc != null) {
			FarmDocruninfo info = farmDocruninfoDao.getEntity(doc
					.getRuninfoid());
			int num = farmDocmessageDao.getAppMessageNum(appid);
			info.setAnsweringnum(num + 1);
			farmDocruninfoDao.editEntity(info);
		}
		return farmDocmessageDao.insertEntity(message);
	}

}
