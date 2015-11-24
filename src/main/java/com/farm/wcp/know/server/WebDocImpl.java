package com.farm.wcp.know.server;

import java.io.IOException;
import java.net.URL;

import org.jsoup.Jsoup;
import org.jsoup.select.Elements;

import com.farm.wcp.know.common.HttpDocument;
import com.farm.wcp.know.common.HttpResourceHandle;

public class WebDocImpl implements WebDocInter {
	private static final WebDocInter thisObj = new WebDocImpl();

	/**
	 * 获得单例对象
	 * 
	 * @return
	 */
	public static WebDocInter instance() {
		return thisObj;
	}

	@Override
	public String[] crawlerWebDocTempFileId(URL url, DOC_TYPE type,
			HttpResourceHandle handle) throws IOException {
		String contentText = null;
		HttpDocument htmlDoc = HttpDocument.instance(Jsoup
				.connect(url.toString()));
		contentText = htmlDoc.getDocument().text();
		Elements body = htmlDoc.getDocument().getElementsByTag("body");
		htmlDoc.removeOutContent();
		htmlDoc.rewriteResources(handle);
		return new String[] { contentText, htmlDoc.getTitle(), body.html() };
	}

}
