package com.farm.worm.domain;

/**
 * FarmWormDocattr entity. @author MyEclipse Persistence Tools
 */

public class FarmWormDocattr implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 7854101127526388796L;
	private String id;
	private String ctime;
	private String etime;
	private String cusername;
	private String cuser;
	private String eusername;
	private String euser;
	private String pstate;
	private String pcontent;
	private String attrparseid;
	private String taskid;
	private String projectid;
	

	// Constructors

	/** default constructor */
	public FarmWormDocattr() {
	}

	/** minimal constructor */
	public FarmWormDocattr(String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String pstate,
			String attrparseid, String taskid) {
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pstate = pstate;
		this.attrparseid = attrparseid;
		this.taskid = taskid;
	}

	/** full constructor */
	public FarmWormDocattr(String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String pstate,
			String pcontent, String attrparseid, String taskid) {
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pstate = pstate;
		this.pcontent = pcontent;
		this.attrparseid = attrparseid;
		this.taskid = taskid;
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

	public String getAttrparseid() {
		return this.attrparseid;
	}

	public void setAttrparseid(String attrparseid) {
		this.attrparseid = attrparseid;
	}

	public String getTaskid() {
		return this.taskid;
	}

	public void setTaskid(String taskid) {
		this.taskid = taskid;
	}

	public String getProjectid() {
		return projectid;
	}

	public void setProjectid(String projectid) {
		this.projectid = projectid;
	}
	
}