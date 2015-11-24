package com.farm.doc.domain;

/**
 * FarmDocruninfoDetail entity. @author MyEclipse Persistence Tools
 */

public class FarmDocruninfoDetail implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -1072894738374171580L;
	private String id;
	private String ctime;
	private String cusername;
	private String cuser;
	private String pstate;
	private String pcontent;
	private String vtype;
	private String doctextid;
	private String runinfoid;
	private String userip;

	// Constructors

	/** default constructor */
	public FarmDocruninfoDetail() {
	}

	/** minimal constructor */
	public FarmDocruninfoDetail(String ctime, String pstate, String vtype,
			String doctextid, String runinfoid, String userip) {
		this.ctime = ctime;
		this.pstate = pstate;
		this.vtype = vtype;
		this.doctextid = doctextid;
		this.runinfoid = runinfoid;
		this.userip = userip;
	}

	/** full constructor */
	public FarmDocruninfoDetail(String ctime, String cusername, String cuser,
			String pstate, String pcontent, String vtype, String doctextid,
			String runinfoid, String userip) {
		this.ctime = ctime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.pstate = pstate;
		this.pcontent = pcontent;
		this.vtype = vtype;
		this.doctextid = doctextid;
		this.runinfoid = runinfoid;
		this.userip = userip;
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

	public String getCuser() {
		return this.cuser;
	}

	public void setCuser(String cuser) {
		this.cuser = cuser;
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

	public String getVtype() {
		return this.vtype;
	}

	public void setVtype(String vtype) {
		this.vtype = vtype;
	}

	public String getDoctextid() {
		return this.doctextid;
	}

	public void setDoctextid(String doctextid) {
		this.doctextid = doctextid;
	}

	public String getRuninfoid() {
		return this.runinfoid;
	}

	public void setRuninfoid(String runinfoid) {
		this.runinfoid = runinfoid;
	}

	public String getUserip() {
		return this.userip;
	}

	public void setUserip(String userip) {
		this.userip = userip;
	}

}