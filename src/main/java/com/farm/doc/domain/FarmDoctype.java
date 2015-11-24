package com.farm.doc.domain;

/**
 * FarmDoctype entity. @author MyEclipse Persistence Tools
 */

public class FarmDoctype implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -5923061100793233002L;
	private String id;
	private String name;
	private String typemod;
	private String contentmod;
	private Integer sort;
	private String type;
	private String metatitle;
	private String metakey;
	private String metacontent;
	private String linkurl;
	private String ctime;
	private String etime;
	private String cusername;
	private String cuser;
	private String eusername;
	private String euser;
	private String pcontent;
	private String pstate;
	private String parentid;
	private String treecode;
	private String tags;

	// Constructors

	/** default constructor */
	public FarmDoctype() {
	}

	/** minimal constructor */
	public FarmDoctype(String name, Integer sort, String type, String ctime,
			String etime, String cusername, String cuser, String eusername,
			String euser, String pstate) {
		this.name = name;
		this.sort = sort;
		this.type = type;
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pstate = pstate;
	}

	/** full constructor */
	public FarmDoctype(String name, String typemod, String contentmod,
			Integer sort, String type, String metatitle, String metakey,
			String metacontent, String linkurl, String ctime, String etime,
			String cusername, String cuser, String eusername, String euser,
			String pcontent, String pstate) {
		this.name = name;
		this.typemod = typemod;
		this.contentmod = contentmod;
		this.sort = sort;
		this.type = type;
		this.metatitle = metatitle;
		this.metakey = metakey;
		this.metacontent = metacontent;
		this.linkurl = linkurl;
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pcontent = pcontent;
		this.pstate = pstate;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTypemod() {
		return this.typemod;
	}

	public void setTypemod(String typemod) {
		this.typemod = typemod;
	}

	public String getContentmod() {
		return this.contentmod;
	}

	public void setContentmod(String contentmod) {
		this.contentmod = contentmod;
	}

	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getMetatitle() {
		return this.metatitle;
	}

	public void setMetatitle(String metatitle) {
		this.metatitle = metatitle;
	}

	public String getMetakey() {
		return this.metakey;
	}

	public void setMetakey(String metakey) {
		this.metakey = metakey;
	}

	public String getMetacontent() {
		return this.metacontent;
	}

	public void setMetacontent(String metacontent) {
		this.metacontent = metacontent;
	}

	public String getLinkurl() {
		return this.linkurl;
	}

	public void setLinkurl(String linkurl) {
		this.linkurl = linkurl;
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

	public String getPcontent() {
		return this.pcontent;
	}

	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}

	public String getPstate() {
		return this.pstate;
	}

	public void setPstate(String pstate) {
		this.pstate = pstate;
	}

	public String getParentid() {
		return parentid;
	}

	public void setParentid(String parentid) {
		this.parentid = parentid;
	}

	public String getTreecode() {
		return treecode;
	}

	public void setTreecode(String treecode) {
		this.treecode = treecode;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}
	
}