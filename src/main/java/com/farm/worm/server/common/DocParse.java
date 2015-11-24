package com.farm.worm.server.common;

/**
 * 解析描述（需要文档的那些部分）
 * 
 * @author Administrator
 * 
 */
public class DocParse {
	private String attrSelector;// 选择器 如 #id
	private String attrSelecttype;// 类型4inner-html，1inner-text，2all，3value
	private String key;
	private String id;

	public DocParse(String attrSelector, String attrSelecttype, String id,
			String key) {
		this.attrSelector = attrSelector;
		this.attrSelecttype = attrSelecttype;
		this.id = id;
		this.key = key;
	}

	public String getAttrSelector() {
		return attrSelector;
	}

	public void setAttrSelector(String attrSelector) {
		this.attrSelector = attrSelector;
	}

	public String getAttrSelecttype() {
		return attrSelecttype;
	}

	public void setAttrSelecttype(String attrSelecttype) {
		this.attrSelecttype = attrSelecttype;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}
