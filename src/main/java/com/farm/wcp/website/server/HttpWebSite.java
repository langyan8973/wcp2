package com.farm.wcp.website.server;

import org.apache.commons.beanutils.BeanUtils;

import com.farm.doc.domain.FarmDoc;

/**
 * 集成doc类的站点类实体
 * 
 * @author Administrator
 * 
 */
public class HttpWebSite extends FarmDoc {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public String indexUrl;// 访问站点的url

	public HttpWebSite(FarmDoc doc) {
		try {
			if (!doc.getDomtype().equals("3")) {
				throw new RuntimeException("此文档不是一个htmlWeb站点");
			}
			BeanUtils.copyProperties(this, doc);
		} catch (Exception e) {
			throw new RuntimeException();
		}
	}

	@Deprecated
	public HttpWebSite() {
	}

	public String getIndexUrl() {
		return indexUrl;
	}

	public void setIndexUrl(String indexUrl) {
		this.indexUrl = indexUrl;
	}

}
