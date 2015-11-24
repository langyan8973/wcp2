package com.farm.worm.domain;

/**
 * FarmWormTask entity. @author MyEclipse Persistence Tools
 */

public class FarmWormTask implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 3385766783716084700L;
	private String id;
	private String ctime;
	private String etime;
	private String cusername;
	private String cuser;
	private String eusername;
	private String euser;
	private String pcontent;
	private String url;
	private String title;
	private String projectid;
	private String pstate;
	private String type;

	// Constructors

	/** default constructor */
	public FarmWormTask() {
	}

	/** minimal constructor */
	public FarmWormTask(String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String url,
			String title, String projectid, String pstate, String type) {
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.url = url;
		this.title = title;
		this.projectid = projectid;
		this.pstate = pstate;
		this.type = type;
	}

	/** full constructor */
	public FarmWormTask(String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String pcontent,
			String url, String title, String projectid, String pstate,
			String type) {
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pcontent = pcontent;
		this.url = url;
		this.title = title;
		this.projectid = projectid;
		this.pstate = pstate;
		this.type = type;
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

	public String getEtime() {
		return this.etime;
	}

	public void setEtime(String etime) {
		this.etime = etime;
	}

	public String getCusername() {
		return this.cusername;
	}

	public void setCusername(String cusername) {
		this.cusername = cusername;
	}

	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(String cuser) {
		this.cuser = cuser;
	}

	public String getEusername() {
		return this.eusername;
	}

	public void setEusername(String eusername) {
		this.eusername = eusername;
	}

	public String getEuser() {
		return this.euser;
	}

	public void setEuser(String euser) {
		this.euser = euser;
	}

	public String getPcontent() {
		return this.pcontent;
	}

	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getProjectid() {
		return this.projectid;
	}

	public void setProjectid(String projectid) {
		this.projectid = projectid;
	}

	public String getPstate() {
		return pstate;
	}

	public void setPstate(String pstate) {
		this.pstate = pstate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}


}