package com.farm.worm.domain;

/**
 * FarmWormAttrparse entity. @author MyEclipse Persistence Tools
 */

public class FarmWormAttrparse implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -4680277397171458943L;
	private String id;
	private String ctime;
	private String etime;
	private String cusername;
	private String cuser;
	private String eusername;
	private String euser;
	private String pstate;
	private String pcontent;
	private String attrname;
	private String attrselect;
	private String attrselecttype;
	private String handletype;
	private String projectid;
	private String attrkey;

	// Constructors

	/** default constructor */
	public FarmWormAttrparse() {
	}

	/** minimal constructor */
	public FarmWormAttrparse(String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String pstate,
			String attrname, String attrselect, String attrselecttype,
			String handletype, String projectid) {
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pstate = pstate;
		this.attrname = attrname;
		this.attrselect = attrselect;
		this.attrselecttype = attrselecttype;
		this.handletype = handletype;
		this.projectid = projectid;
	}

	/** full constructor */
	public FarmWormAttrparse(String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String pstate,
			String pcontent, String attrname, String attrselect,
			String attrselecttype, String handletype, String projectid) {
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pstate = pstate;
		this.pcontent = pcontent;
		this.attrname = attrname;
		this.attrselect = attrselect;
		this.attrselecttype = attrselecttype;
		this.handletype = handletype;
		this.projectid = projectid;
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

	public String getAttrname() {
		return this.attrname;
	}

	public void setAttrname(String attrname) {
		this.attrname = attrname;
	}

	public String getAttrselect() {
		return this.attrselect;
	}

	public void setAttrselect(String attrselect) {
		this.attrselect = attrselect;
	}

	public String getAttrselecttype() {
		return this.attrselecttype;
	}

	public void setAttrselecttype(String attrselecttype) {
		this.attrselecttype = attrselecttype;
	}

	public String getHandletype() {
		return this.handletype;
	}

	public void setHandletype(String handletype) {
		this.handletype = handletype;
	}

	public String getProjectid() {
		return this.projectid;
	}

	public void setProjectid(String projectid) {
		this.projectid = projectid;
	}

	public String getAttrkey() {
		return attrkey;
	}

	public void setAttrkey(String attrkey) {
		this.attrkey = attrkey;
	}
	
}