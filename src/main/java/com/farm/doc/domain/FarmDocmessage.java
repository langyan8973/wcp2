package com.farm.doc.domain;

/**
 * FarmDocmessage entity. @author MyEclipse Persistence Tools
 */

public class FarmDocmessage implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -3189959377075896325L;
	private String id;
	private String ctime;
	private String cusername;
	private String pstate;
	private String pcontent;
	private String readuserid;
	private String content;
	private String title;
	private String appid;
	private String readstate;
	private String cuser;

	// Constructors

	/** default constructor */
	public FarmDocmessage() {
	}

	/** minimal constructor */
	public FarmDocmessage(String ctime, String cusername, String pstate,
			String readuserid, String content, String title, String readstate) {
		this.ctime = ctime;
		this.cusername = cusername;
		this.pstate = pstate;
		this.readuserid = readuserid;
		this.content = content;
		this.title = title;
		this.readstate = readstate;
	}

	/** full constructor */
	public FarmDocmessage(String ctime, String cusername, String pstate,
			String pcontent, String readuserid, String content, String title,
			String appid, String readstate) {
		this.ctime = ctime;
		this.cusername = cusername;
		this.pstate = pstate;
		this.pcontent = pcontent;
		this.readuserid = readuserid;
		this.content = content;
		this.title = title;
		this.appid = appid;
		this.readstate = readstate;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCtime() {
		return this.ctime;
	}

	public void setCtime(String ctime) {
		this.ctime = ctime;
	}

	public String getCusername() {
		return this.cusername;
	}

	public void setCusername(String cusername) {
		this.cusername = cusername;
	}

	public String getPstate() {
		return this.pstate;
	}

	public void setPstate(String pstate) {
		this.pstate = pstate;
	}

	public String getPcontent() {
		return this.pcontent;
	}

	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}

	public String getReaduserid() {
		return this.readuserid;
	}

	public void setReaduserid(String readuserid) {
		this.readuserid = readuserid;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAppid() {
		return this.appid;
	}

	public void setAppid(String appid) {
		this.appid = appid;
	}

	public String getReadstate() {
		return this.readstate;
	}

	public void setReadstate(String readstate) {
		this.readstate = readstate;
	}

	public String getCuser() {
		return cuser;
	}

	public void setCuser(String cuser) {
		this.cuser = cuser;
	}

}