package com.farm.doc.server;

import com.farm.core.auth.domain.LoginUser;
import com.farm.core.time.TimeTool;
import com.farm.doc.dao.FarmDocDaoInter;
import com.farm.doc.domain.FarmDoc;

public class FarmDocOperateRightImpl implements FarmDocOperateRightInter {
	private FarmDocDaoInter farmDocDao;
	private FarmDocgroupManagerInter farmdocgroupServer;
	private FarmDocManagerInter farmdocServer;
	@Override
	public boolean isDel(LoginUser user, FarmDoc doc) {
		if (user == null) {
			return false;
		}
		// 非小组权限只允许本人删除
		if (!doc.getWritepop().equals("2")
				&& doc.getCuser().equals(user.getId())) {
			return true;
		}
		// 如果编辑权限是小组的，只有管理员可以删除
		if (doc.getWritepop().equals("2")) {
			if (doc.getDocgroupid() == null) {
				return false;
			}
			// 本人可以删除
			// if(doc.getCuser().equals(user.getId())){
			// return true;
			// }
			if (farmdocgroupServer.isAdminForGroup(user.getId(), doc
					.getDocgroupid())) {
				return true;
			}
		}
		return false;
	}

	@Override
	public boolean isRead(LoginUser user, FarmDoc doc) {
		// 公开权限允许任何人阅读
		if (doc.getReadpop().equals("1")) {
			return true;
		}
		if (user == null) {
			return false;
		}
		// 权限是本人的时候,允许本人阅读
		if ((doc.getReadpop().equals("0") && doc.getCuser()
				.equals(user.getId()))) {
			return true;
		}
		// 当阅读权限被指定到小组，且用户加入小组时允许其阅读该文档
		if (doc.getReadpop().equals("2")) {
			if (doc.getDocgroupid() != null
					&& farmdocgroupServer.isJoinGroupByUser(
							doc.getDocgroupid(), user.getId())) {
				return true;
			}
		}
		return false;
	}

	@Override
	public boolean isAllUserRead(FarmDoc doc) {
		return isRead(null, doc);
	}

	@Override
	public boolean isWrite(LoginUser user, FarmDoc doc) {
		if (user == null) {
			return false;
		}
		// 公开写权限或权限是本人的时候
		if (doc.getWritepop().equals("1")
				|| (doc.getWritepop().equals("0") && doc.getCuser().equals(
						user.getId()))) {
			return true;
		}
		// 小组文档且文档赋予了小组编辑权限时，如果当前用户拥有小组编辑权限则允许其修改文档
		if (doc.getWritepop().equals("2")) {
			if (doc.getDocgroupid() != null
					&& farmdocgroupServer.isGroupEditor(doc.getDocgroupid(),
							user.getId())) {
				return true;
			}
		}
		return false;
	}

	@Override
	public FarmDoc editDocRight(String docId, POP_TYPE pop_type_read,
			POP_TYPE pop_type_write, LoginUser currentUser) {
		FarmDoc entity2 = farmDocDao.getEntity(docId);
		entity2.setWritepop(pop_type_write.getValue());
		entity2.setReadpop(pop_type_read.getValue());
		entity2.setEuser(currentUser.getId());
		entity2.setEusername(currentUser.getName());
		entity2.setEtime(TimeTool.getTimeDate14());
		farmDocDao.editEntity(entity2);
		return entity2;
	}

	@Override
	public void flyDoc(String id, LoginUser currentUser) {
		FarmDoc doc = farmdocServer.getDocOnlyBean(id);
		if (isDel(currentUser, doc)) {
			flyDoc(doc);
		} else {
			throw new RuntimeException("您没有此权限");
		}
	}

	@Override
	public void flyDoc(FarmDoc doc) {
		doc.setDocgroupid(null);
		doc.setReadpop(POP_TYPE.PUB.getValue());
		doc.setWritepop(POP_TYPE.PUB.getValue());
		farmDocDao.editEntity(doc);
	}

	public FarmDocDaoInter getFarmDocDao() {
		return farmDocDao;
	}

	public void setFarmDocDao(FarmDocDaoInter farmDocDao) {
		this.farmDocDao = farmDocDao;
	}

	public FarmDocgroupManagerInter getFarmdocgroupServer() {
		return farmdocgroupServer;
	}

	public void setFarmdocgroupServer(
			FarmDocgroupManagerInter farmdocgroupServer) {
		this.farmdocgroupServer = farmdocgroupServer;
	}

	public FarmDocManagerInter getFarmdocServer() {
		return farmdocServer;
	}

	public void setFarmdocServer(FarmDocManagerInter farmdocServer) {
		this.farmdocServer = farmdocServer;
	}

}
