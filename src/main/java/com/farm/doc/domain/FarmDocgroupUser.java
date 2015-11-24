package com.farm.doc.domain;

/**
 * FarmDocgroupUser entity. @author MyEclipse Persistence Tools
 */

public class FarmDocgroupUser implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 7544385072910373437L;
	private String id;
	private String ctime;
	private String etime;
	private String cusername;
	private String cuser;
	private String eusername;
	private String euser;
	private String pstate;
	private String pcontent;
	private String groupid;
	private String userid;
	private String leadis;
	private String editis;
	private String showhome;
	private Integer showsort;
	private String applynote;

	// Constructors

	/** default constructor */
	public FarmDocgroupUser() {
	}

	/** minimal constructor */
	public FarmDocgroupUser(String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String pstate,
			String groupid, String userid, String leadis, String editis,
			String showhome, Integer showsort) {
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pstate = pstate;
		this.groupid = groupid;
		this.userid = userid;
		this.leadis = leadis;
		this.editis = editis;
		this.showhome = showhome;
		this.showsort = showsort;
	}

	/** full constructor */
	public FarmDocgroupUser(String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String pstate,
			String pcontent, String groupid, String userid, String leadis,
			String editis, String showhome, Integer showsort) {
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pstate = pstate;
		this.pcontent = pcontent;
		this.groupid = groupid;
		this.userid = userid;
		this.leadis = leadis;
		this.editis = editis;
		this.showhome = showhome;
		this.showsort = showsort;
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
	
	public String getApplynote() {
		return applynote;
	}

	public void setApplynote(String applynote) {
		this.applynote = applynote;
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

	public String getGroupid() {
		return this.groupid;
	}

	public void setGroupid(String groupid) {
		this.groupid = groupid;
	}

	public String getUserid() {
		return this.userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getLeadis() {
		return this.leadis;
	}

	public void setLeadis(String leadis) {
		this.leadis = leadis;
	}

	public String getEditis() {
		return this.editis;
	}

	public void setEditis(String editis) {
		this.editis = editis;
	}

	public String getShowhome() {
		return this.showhome;
	}

	public void setShowhome(String showhome) {
		this.showhome = showhome;
	}

	public Integer getShowsort() {
		return this.showsort;
	}

	public void setShowsort(Integer showsort) {
		this.showsort = showsort;
	}

}