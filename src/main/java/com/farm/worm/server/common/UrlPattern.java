package com.farm.worm.server.common;

public class UrlPattern {
	private String ptype;// 1.黑名单，2白名单
	private String functype;// 1种子页面URL，2文档页面URL
	private String patenstr;

	public UrlPattern(String ptype, String functype, String patenstr) {
		this.ptype = ptype;
		this.functype = functype;
		this.patenstr = patenstr;
	}

	/**
	 * 1.黑名单，2白名单
	 * 
	 * @return
	 */
	public String getPtype() {
		return ptype;
	}

	/**
	 * 1.黑名单，2白名单
	 * 
	 * @param ptype
	 */
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}

	/**
	 * 1种子页面URL，2文档页面URL
	 * 
	 * @return
	 */
	public String getFunctype() {
		return functype;
	}

	/**
	 * 1种子页面URL，2文档页面URL
	 * 
	 * @param functype
	 */
	public void setFunctype(String functype) {
		this.functype = functype;
	}

	/**
	 * @return
	 */
	public String getPatenstr() {
		return patenstr;
	}

	/**
	 * @param patenstr
	 */
	public void setPatenstr(String patenstr) {
		this.patenstr = patenstr;
	}

}
