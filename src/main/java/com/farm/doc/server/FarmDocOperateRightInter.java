package com.farm.doc.server;

import com.farm.core.auth.domain.LoginUser;
import com.farm.doc.domain.FarmDoc;

/**
 * 文档权限操作接口
 * 
 * @author Administrator
 * 
 */
public interface FarmDocOperateRightInter {
	/**
	 * 权限类型（阅读/编辑）
	 * 
	 * @author 王东
	 * 
	 */
	public enum POP_TYPE {
		/**
		 * 1公开
		 */
		PUB("1"), /**
		 * 0本人
		 */
		PRI("0"), /**
		 * 2小组
		 */
		DOCGROUP("2"), /**
		 * 3禁止编辑
		 */
		NONE("3");
		private String value;

		public String getValue() {
			return value;
		}

		/**
		 * 获得枚举对象
		 * 
		 * @param val
		 * @return
		 */
		public static POP_TYPE getEnum(String val) {
			if (val.equals("1")) {
				return POP_TYPE.PUB;
			}
			if (val.equals("3")) {
				return POP_TYPE.NONE;
			}
			if (val.equals("2")) {
				return POP_TYPE.DOCGROUP;
			}
			return POP_TYPE.PRI;
		}

		public void setValue(String value) {
			this.value = value;
		}

		POP_TYPE(String value) {
			this.value = value;
		}
	}
	/**
	 * 是否允许读取文档
	 * 
	 * @param user
	 * @param doc 传入docBean即可
	 * @return
	 */
	public boolean isRead(LoginUser user, FarmDoc doc);

	/**
	 * 是否允许未登陆用户及所有人读取文档
	 * 
	 * @param doc 传入docBean即可
	 * @return
	 */
	public boolean isAllUserRead(FarmDoc doc);

	/**
	 * 是否允许编辑文档
	 * 
	 * @param user
	 * @param doc 传入docBean即可
	 * @return
	 */
	public boolean isWrite(LoginUser user, FarmDoc doc);

	/**
	 * 是否允许删除文档
	 * 
	 * @param user
	 * @param doc 传入docBean即可
	 * @return
	 */
	public boolean isDel(LoginUser user, FarmDoc doc);
	/**
	 * 修改文档权限
	 * 
	 * @param docId
	 * @param pop_type_read
	 * @param pop_type_write
	 * @param currentUser
	 * @return
	 */
	public FarmDoc editDocRight(String docId, POP_TYPE pop_type_read,
			POP_TYPE pop_type_write, LoginUser currentUser);
	/**
	 * 公开文档（将该文档开放阅读和编辑权限，同时如果是小组文档将删除小组所有权）
	 * 
	 * @param id
	 * @param currentUser
	 */
	public void flyDoc(String docID, LoginUser currentUser);

	/**
	 * 公开文档（不做权限验证）
	 * 
	 * @param id
	 * @param currentUser
	 */
	public void flyDoc(FarmDoc doc);
}
