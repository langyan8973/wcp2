package com.farm.doc.domain;

/**
 * FarmDocruninfo entity. @author MyEclipse Persistence Tools
 */

public class FarmDocruninfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -1319699378324590263L;
	private String id;
	private Integer visitnum;
	private Integer hotnum;
	private String lastvtime;
	private Integer praiseyes;
	private Integer praiseno;
	private Integer evaluate;
	private Integer answeringnum;

	// Constructors

	/** default constructor */
	public FarmDocruninfo() {
	}

	/** full constructor */
	public FarmDocruninfo(Integer visitnum, Integer hotnum, String lastvtime,
			Integer praiseyes, Integer praiseno, Integer evaluate) {
		this.visitnum = visitnum;
		this.hotnum = hotnum;
		this.lastvtime = lastvtime;
		this.praiseyes = praiseyes;
		this.praiseno = praiseno;
		this.evaluate = evaluate;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getVisitnum() {
		return this.visitnum;
	}

	public void setVisitnum(Integer visitnum) {
		this.visitnum = visitnum;
	}

	public Integer getHotnum() {
		return this.hotnum;
	}

	public void setHotnum(Integer hotnum) {
		this.hotnum = hotnum;
	}

	public String getLastvtime() {
		return this.lastvtime;
	}

	public void setLastvtime(String lastvtime) {
		this.lastvtime = lastvtime;
	}

	public Integer getPraiseyes() {
		return this.praiseyes;
	}

	public void setPraiseyes(Integer praiseyes) {
		this.praiseyes = praiseyes;
	}

	public Integer getPraiseno() {
		return this.praiseno;
	}

	public void setPraiseno(Integer praiseno) {
		this.praiseno = praiseno;
	}

	public Integer getEvaluate() {
		return this.evaluate;
	}

	public void setEvaluate(Integer evaluate) {
		this.evaluate = evaluate;
	}

	public Integer getAnsweringnum() {
		return answeringnum;
	}

	public void setAnsweringnum(Integer answeringnum) {
		this.answeringnum = answeringnum;
	}
	
}