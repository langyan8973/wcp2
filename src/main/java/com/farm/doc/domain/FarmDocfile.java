package com.farm.doc.domain;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

/**
 * FarmDocfile entity. @author MyEclipse Persistence Tools
 */

public class FarmDocfile implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 3911185369411888075L;
	private String id;
	private String dir;
	private String serverid;
	private String type;
	private String name;
	private String filename;
	private String ctime;
	private String etime;
	private String cusername;
	private String cuser;
	private String eusername;
	private String euser;
	private String pstate;
	private String pcontent;
	private String exname;
	private Float len;
	private String url;
	private File file;

	// Constructors

	/** default constructor */
	public FarmDocfile() {
	}

	/** minimal constructor */
	public FarmDocfile(String dir, String serverid, String type, String name,
			String filename, String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String pstate) {
		this.dir = dir;
		this.serverid = serverid;
		this.type = type;
		this.name = name;
		this.filename = filename;
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pstate = pstate;
	}

	/** full constructor */
	public FarmDocfile(String dir, String serverid, String type, String name,
			String filename, String ctime, String etime, String cusername,
			String cuser, String eusername, String euser, String pstate,
			String pcontent,String exname,Float len) {
		this.dir = dir;
		this.serverid = serverid;
		this.type = type;
		this.name = name;
		this.filename = filename;
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pstate = pstate;
		this.exname=exname;
		this.len=len;
		this.pcontent = pcontent;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDir() {
		return this.dir;
	}

	public void setDir(String dir) {
		this.dir = dir;
	}

	public String getServerid() {
		return this.serverid;
	}

	public void setServerid(String serverid) {
		this.serverid = serverid;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFilename() {
		return this.filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
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

	public String getExname() {
		return exname;
	}

	public void setExname(String exname) {
		this.exname = exname;
	}

	public Float getLen() {
		return len;
	}

	public void setLen(Float len) {
		this.len = len;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public InputStream getInputStream() throws FileNotFoundException {
		return new FileInputStream(file);
	}
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}
	
}