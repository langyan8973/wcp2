package com.farm.worm.server.common;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface WormUtilsInter {

	/**
	 * 解析一个页面中的URL
	 * 
	 * @param seedurl
	 *            种子URL
	 * @param baseurl
	 *            如果url是相对路径的时候链接该前缀
	 * @param urlPatterns
	 *            URL过滤器集合
	 * @param timeout
	 *            超时时限
	 * @param waitTime
	 *            每次抓取间隔时间
	 * @param userAgent
	 * @return
	 * @throws IOException
	 */
	List<WebPage> parsePageUrl(String seedurl, String baseurl,
			List<UrlPattern> urlPatterns, int timeout, int waitTime,
			String userAgent) throws IOException;

	/**
	 * 解析一个页面内容
	 * 
	 * @param url
	 *            种子URL
	 * @param docparse
	 *            文档解析规则
	 * @param timeout
	 *            超时时限
	 * @param waitTime
	 *            每次抓取间隔时间
	 * @param userAgent
	 * @return
	 * @throws IOException
	 */
	List<Map<String, String>> parsePageDoc(String url, List<DocParse> docparse,
			int timeout, int waitTime, String userAgent) throws IOException;

}
