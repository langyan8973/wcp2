package com.farm.doc.domain;

/**
 * FarmRfDoctype entity. @author MyEclipse Persistence Tools
 */

public class FarmRfDoctype implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -7356242435450759526L;
	private String id;
	private String typeid;
	private String docid;

	// Constructors

	/** default constructor */
	public FarmRfDoctype() {
	}

	/** full constructor */
	public FarmRfDoctype(String typeid, String docid) {
		this.typeid = typeid;
		this.docid = docid;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTypeid() {
		return this.typeid;
	}

	public void setTypeid(String typeid) {
		this.typeid = typeid;
	}

	public String getDocid() {
		return this.docid;
	}

	public void setDocid(String docid) {
		this.docid = docid;
	}

}