package com.farm.worm.domain;

/**
 * FarmWormProject entity. @author MyEclipse Persistence Tools
 */

public class FarmWormProject implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -6393502179275305687L;
	private String id;
	private String ctime;
	private String etime;
	private String cusername;
	private String cuser;
	private String eusername;
	private String euser;
	private String pstate;
	private String pcontent;
	private String name;
	private String seedurl;
	private String agent;
	private Integer timeout;
	private String baseurl;
	private Integer waittime;
	private String handleclass;
	private String handlepara;

	// Constructors

	/** default constructor */
	public FarmWormProject() {
	}

	/** minimal constructor */
	public FarmWormProject(String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String pstate,
			String name, String seedurl, String urlfilter) {
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pstate = pstate;
		this.name = name;
		this.seedurl = seedurl;
	}

	/** full constructor */
	public FarmWormProject(String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String pstate,
			String pcontent, String name, String seedurl, 
			String agent, Integer timeout) {
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pstate = pstate;
		this.pcontent = pcontent;
		this.name = name;
		this.seedurl = seedurl;
		this.agent = agent;
		this.timeout = timeout;
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

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSeedurl() {
		return this.seedurl;
	}

	public void setSeedurl(String seedurl) {
		this.seedurl = seedurl;
	}


	public String getAgent() {
		return this.agent;
	}

	public void setAgent(String agent) {
		this.agent = agent;
	}

	public Integer getTimeout() {
		return this.timeout;
	}

	public void setTimeout(Integer timeout) {
		this.timeout = timeout;
	}

	public String getBaseurl() {
		return baseurl;
	}

	public void setBaseurl(String baseurl) {
		this.baseurl = baseurl;
	}

	public Integer getWaittime() {
		return waittime;
	}

	public void setWaittime(Integer waittime) {
		this.waittime = waittime;
	}

	public String getHandleclass() {
		return handleclass;
	}

	public void setHandleclass(String handleclass) {
		this.handleclass = handleclass;
	}

	public String getHandlepara() {
		return handlepara;
	}

	public void setHandlepara(String handlepara) {
		this.handlepara = handlepara;
	}
	
}