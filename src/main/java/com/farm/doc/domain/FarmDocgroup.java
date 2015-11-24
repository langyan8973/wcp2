package com.farm.doc.domain;

import java.util.List;

/**
 * FarmDocgroup entity. @author MyEclipse Persistence Tools
 */

public class FarmDocgroup implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 4755308225486515753L;
	private String id;
	private String ctime;
	private String etime;
	private String cusername;
	private String cuser;
	private String eusername;
	private String euser;
	private String pstate;
	private String pcontent;
	private String groupname;
	private String groupnote;
	private String grouptag;
	private String groupimg;
	private String joincheck;
	private String imgurl;
	private List<String> tags;
	private Integer usernum;
	private String homedocid;

	// Constructors

	/** default constructor */
	public FarmDocgroup() {
	}

	/** minimal constructor */
	public FarmDocgroup(String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String pstate,
			String groupname, String groupnote, String grouptag,
			String groupimg, String joincheck) {
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pstate = pstate;
		this.groupname = groupname;
		this.groupnote = groupnote;
		this.grouptag = grouptag;
		this.groupimg = groupimg;
		this.joincheck = joincheck;
	}

	/** full constructor */
	public FarmDocgroup(String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String pstate,
			String pcontent, String groupname, String groupnote,
			String grouptag, String groupimg, String joincheck) {
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pstate = pstate;
		this.pcontent = pcontent;
		this.groupname = groupname;
		this.groupnote = groupnote;
		this.grouptag = grouptag;
		this.groupimg = groupimg;
		this.joincheck = joincheck;
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

	public String getGroupname() {
		return this.groupname;
	}

	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}

	public String getGroupnote() {
		return this.groupnote;
	}

	public void setGroupnote(String groupnote) {
		this.groupnote = groupnote;
	}

	public String getGrouptag() {
		return this.grouptag;
	}

	public void setGrouptag(String grouptag) {
		this.grouptag = grouptag;
	}

	public String getGroupimg() {
		return this.groupimg;
	}

	public void setGroupimg(String groupimg) {
		this.groupimg = groupimg;
	}

	public String getJoincheck() {
		return this.joincheck;
	}

	public void setJoincheck(String joincheck) {
		this.joincheck = joincheck;
	}

	public String getImgurl() {
		return imgurl;
	}

	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}

	public List<String> getTags() {
		return tags;
	}

	public void setTags(List<String> tags) {
		this.tags = tags;
	}

	public Integer getUsernum() {
		return usernum;
	}

	public void setUsernum(Integer usernum) {
		this.usernum = usernum;
	}

	public String getHomedocid() {
		return homedocid;
	}

	public void setHomedocid(String homedocid) {
		this.homedocid = homedocid;
	}

}