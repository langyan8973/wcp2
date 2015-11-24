package com.farm.doc.domain;

/**
 * FarmDocenjoy entity. @author MyEclipse Persistence Tools
 */

public class FarmDocenjoy implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 7150663239596707410L;
	private String id;
	private String docid;
	private String userid;

	// Constructors

	/** default constructor */
	public FarmDocenjoy() {
	}

	/** full constructor */
	public FarmDocenjoy(String docid, String userid) {
		this.docid = docid;
		this.userid = userid;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDocid() {
		return this.docid;
	}

	public void setDocid(String docid) {
		this.docid = docid;
	}

	public String getUserid() {
		return this.userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

}