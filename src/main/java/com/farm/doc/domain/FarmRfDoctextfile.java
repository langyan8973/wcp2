package com.farm.doc.domain;

/**
 * FarmRfDoctextfile entity. @author MyEclipse Persistence Tools
 */

public class FarmRfDoctextfile implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -1477046610638487000L;
	private String id;
	private String docid;
	private String fileid;

	// Constructors

	/** default constructor */
	public FarmRfDoctextfile() {
	}

	/** full constructor */
	public FarmRfDoctextfile(String docid, String fileid) {
		this.docid = docid;
		this.fileid = fileid;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}


	public String getDocid() {
		return docid;
	}

	public void setDocid(String docid) {
		this.docid = docid;
	}

	public String getFileid() {
		return this.fileid;
	}

	public void setFileid(String fileid) {
		this.fileid = fileid;
	}

}