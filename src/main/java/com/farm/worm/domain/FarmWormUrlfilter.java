package com.farm.worm.domain;

/**
 * FarmWormUrlfilter entity. @author MyEclipse Persistence Tools
 */

public class FarmWormUrlfilter implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 7402198993089523693L;
	private String id;
	private String pcontent;
	private String patenstr;
	private String ptype;
	private String projectid;
	private String funtype;

	// Constructors

	/** default constructor */
	public FarmWormUrlfilter() {
	}

	/** minimal constructor */
	public FarmWormUrlfilter(String patenstr, String ptype, String projectid,
			String funtype) {
		this.patenstr = patenstr;
		this.ptype = ptype;
		this.projectid = projectid;
		this.funtype = funtype;
	}

	/** full constructor */
	public FarmWormUrlfilter(String pcontent, String patenstr, String ptype,
			String projectid, String funtype) {
		this.pcontent = pcontent;
		this.patenstr = patenstr;
		this.ptype = ptype;
		this.projectid = projectid;
		this.funtype = funtype;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPcontent() {
		return this.pcontent;
	}

	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}

	public String getPatenstr() {
		return this.patenstr;
	}

	public void setPatenstr(String patenstr) {
		this.patenstr = patenstr;
	}

	public String getPtype() {
		return this.ptype;
	}

	public void setPtype(String ptype) {
		this.ptype = ptype;
	}

	public String getProjectid() {
		return this.projectid;
	}

	public void setProjectid(String projectid) {
		this.projectid = projectid;
	}

	public String getFuntype() {
		return this.funtype;
	}

	public void setFuntype(String funtype) {
		this.funtype = funtype;
	}

}