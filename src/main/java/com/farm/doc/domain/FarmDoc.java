package com.farm.doc.domain;

import java.util.List;

import com.farm.core.auth.domain.LoginUser;
import com.farm.core.time.TimeTool;

/**
 * FarmDoc entity. @author MyEclipse Persistence Tools
 */

public class FarmDoc implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 9052510559842813002L;
	private String id;
	private String title;
	private String docdescribe;
	private String author;
	private String pubtime;
	private String domtype;
	private String shorttitle;
	private String tagkey;
	private String source;
	private Integer topleve;
	private String imgid;
	private String state;
	private String ctime;
	private String etime;
	private String cusername;
	private String cuser;
	private String eusername;
	private String euser;
	private String pcontent;
	private String textid;
	private List<String> tags;
	private String runinfoid;
	private List<FarmDocfile> files;
	private FarmDoctext texts;
	private List<FarmDoctype> types;
	private String writepop;
	private String readpop;
	private FarmDocruninfo runinfo;
	private List<FarmDoctype> currenttypes;
	private String docgroupid;
	private FarmDocgroup group;
	private String imgUrl;

	// Constructors

	/** default constructor */
	public FarmDoc() {
	}

	/** minimal constructor */
	public FarmDoc(String title, String pubtime, String domtype, String state,
			String ctime, String etime, String cusername, String cuser,
			String eusername, String euser, String textid) {
		this.title = title;
		this.pubtime = pubtime;
		this.domtype = domtype;
		this.state = state;
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.textid = textid;
	}

	/** full constructor */
	public FarmDoc(String title, String docdescribe, String author,
			String pubtime, String domtype, String shorttitle, String tagkey,
			String source, Integer topleve, String imgid, String state,
			String ctime, String etime, String cusername, String cuser,
			String eusername, String euser, String pcontent, String textid) {
		this.title = title;
		this.docdescribe = docdescribe;
		this.author = author;
		this.pubtime = pubtime;
		this.domtype = domtype;
		this.shorttitle = shorttitle;
		this.tagkey = tagkey;
		this.source = source;
		this.topleve = topleve;
		this.imgid = imgid;
		this.state = state;
		this.ctime = ctime;
		this.etime = etime;
		this.cusername = cusername;
		this.cuser = cuser;
		this.eusername = eusername;
		this.euser = euser;
		this.pcontent = pcontent;
		this.textid = textid;
	}

	// Property accessors

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDocdescribe() {
		return this.docdescribe;
	}

	public void setDocdescribe(String docdescribe) {
		this.docdescribe = docdescribe;
	}

	public String getAuthor() {
		return this.author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPubtime() {
		return this.pubtime;
	}

	public void setPubtime(String pubtime) {
		this.pubtime = pubtime;
	}

	public String getDomtype() {
		return this.domtype;
	}

	public void setDomtype(String domtype) {
		this.domtype = domtype;
	}

	public String getShorttitle() {
		return shorttitle;
	}

	public void setShorttitle(String shorttitle) {
		this.shorttitle = shorttitle;
	}

	public String getTagkey() {
		return this.tagkey;
	}

	public void setTagkey(String tagkey) {
		this.tagkey = tagkey;
	}

	public String getSource() {
		return this.source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public Integer getTopleve() {
		return this.topleve;
	}

	public void setTopleve(Integer topleve) {
		this.topleve = topleve;
	}

	public String getImgid() {
		return this.imgid;
	}

	public void setImgid(String imgid) {
		this.imgid = imgid;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
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

	public String getTextid() {
		return this.textid;
	}

	public void setTextid(String textid) {
		this.textid = textid;
	}

	public List<FarmDocfile> getFiles() {
		return files;
	}

	public void setFiles(List<FarmDocfile> files) {
		this.files = files;
	}

	public FarmDoctext getTexts() {
		return texts;
	}

	public void setTexts(String text, LoginUser user) {
		FarmDoctext ntexts = new FarmDoctext();
		ntexts.setCtime(TimeTool.getTimeDate14());
		ntexts.setCuser(user.getId());
		ntexts.setCusername(user.getName());
		ntexts.setEtime(TimeTool.getTimeDate14());
		ntexts.setEuser(user.getId());
		ntexts.setEusername(user.getName());
		ntexts.setPstate("1");
		ntexts.setText1(text);
		this.texts = ntexts;
	}

	public void setTexts(FarmDoctext texts) {
		this.texts = texts;
	}

	public List<FarmDoctype> getTypes() {
		return types;
	}

	public void setTypes(List<FarmDoctype> types) {
		this.types = types;
	}

	public String getWritepop() {
		return writepop;
	}

	public void setWritepop(String writepop) {
		this.writepop = writepop;
	}

	public String getReadpop() {
		return readpop;
	}

	public void setReadpop(String readpop) {
		this.readpop = readpop;
	}

	public String getRuninfoid() {
		return runinfoid;
	}

	public void setRuninfoid(String runinfoid) {
		this.runinfoid = runinfoid;
	}

	public FarmDocruninfo getRuninfo() {
		return runinfo;
	}

	public void setRuninfo(FarmDocruninfo runinfo) {
		this.runinfo = runinfo;
	}

	public List<String> getTags() {
		return tags;
	}

	public void setTags(List<String> tags) {
		this.tags = tags;
	}

	public List<FarmDoctype> getCurrenttypes() {
		return currenttypes;
	}

	public void setCurrenttypes(List<FarmDoctype> currenttypes) {
		this.currenttypes = currenttypes;
	}

	public String getDocgroupid() {
		return docgroupid;
	}

	public void setDocgroupid(String docgroupid) {
		this.docgroupid = docgroupid;
	}

	public FarmDocgroup getGroup() {
		return group;
	}
	
	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public void setGroup(FarmDocgroup group) {
		this.group = group;
	}
	
}