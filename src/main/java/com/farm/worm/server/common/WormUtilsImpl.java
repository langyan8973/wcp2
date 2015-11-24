package com.farm.worm.server.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


public class WormUtilsImpl implements WormUtilsInter {
	private final static WormUtilsInter obj = new WormUtilsImpl();
	private static final Logger log = Logger.getLogger(WormUtilsImpl.class);
	public static WormUtilsInter getInstance() {
		return obj;
	}

	@Override
	public List<WebPage> parsePageUrl(String seedurl, String baseurl,
			List<UrlPattern> urlPatterns, int timeout, int waitTime,
			String userAgent) throws IOException {
		Document doc = Jsoup.connect(seedurl).userAgent(userAgent).timeout(
				timeout).get();
		Elements elements = doc.select("a");
		List<WebPage> list = new ArrayList<WebPage>();
		for (Element node : elements) {
			String url = node.attr("href");
			if (url.indexOf("http:") < 0) {
				if (baseurl == null || baseurl.trim().length() <= 0) {
					baseurl = seedurl;
					if (baseurl.lastIndexOf("/") + 1 == baseurl.length()) {
						baseurl = baseurl.substring(0, baseurl.length() - 1);
					}
				}
				if (url.indexOf("/") == 0) {
					url = baseurl + url;
				} else {
					url = baseurl + "/" + url;
				}
			}
			boolean isSeed = false;
			boolean isDoc = false;
			{// 判断种子,是白名单变true，是黑名单变false且退出循环
				for (UrlPattern urlpattern : urlPatterns) {
					if (urlpattern.getFunctype().equals("1")) {
						Pattern pattern = Pattern.compile(urlpattern
								.getPatenstr());
						Matcher matcher = pattern.matcher(url);
						if (urlpattern.getPtype().equals("1")) {
							// 黑名单
							if (matcher.matches()) {
								isSeed = false;
								break;
							}
						}
						if (urlpattern.getPtype().equals("2")) {
							// 白名单
							if (matcher.matches()) {
								isSeed = true;
							}
						}
					}
				}
			}
			{// 判断文档,是变true，不是变false且退出循环
				for (UrlPattern urlpattern : urlPatterns) {
					if (urlpattern.getFunctype().equals("2")) {
						Pattern pattern = Pattern.compile(urlpattern
								.getPatenstr());
						Matcher matcher = pattern.matcher(url);
						if (urlpattern.getPtype().equals("1")) {
							// 黑名单
							if (matcher.matches()) {
								isDoc = false;
								break;
							}
						}
						if (urlpattern.getPtype().equals("2")) {
							// 白名单
							if (matcher.matches()) {
								isDoc = true;
							}
						}
					}
				}
			}
			if (isSeed) {
				WebPage page = new WebPage();
				page.setTitle(node.text());
				page.setUrl(url);
				page.setType("1");
				list.add(page);
			}
			if (isDoc) {
				WebPage page = new WebPage();
				page.setTitle(node.text());
				page.setUrl(url);
				page.setType("2");
				list.add(page);
			}
		}
		try {
			Thread.sleep(waitTime);
		} catch (InterruptedException e) {
			log.error(e.getMessage());
			throw new RuntimeException(e);
		}
		return list;
	}

	public static void main(String[] args) {
		Pattern pattern = Pattern.compile("^http://www.iteye.com/blogs.*");
		Matcher matcher = pattern
				.matcher("http://demon614.iteye.com/blog/2144451");
		System.out.println(matcher.matches());
	}

	@Override
	public List<Map<String, String>> parsePageDoc(String url,
			List<DocParse> docparse, int timeout, int waitTime, String userAgent)
			throws IOException {
		List<Map<String, String>> returnList = new ArrayList<Map<String, String>>();
		Document doc = Jsoup.connect(url).userAgent(userAgent).timeout(timeout)
				.get();
		for (DocParse parse : docparse) {
			Elements elements = doc.select(parse.getAttrSelector());
			Map<String, String> map = new HashMap<String, String>();
			map.put("ID", parse.getId());
			map.put("KEY", parse.getKey());
			String text = null;
			for (Element ele : elements) {
				if (text == null) {
					text = "";
				} else {
					text = text + "<!--25767-->";
				}
				// 取值方式 4inner-html，1inner-text，2all，3value
				if (parse.getAttrSelecttype().equals("1")) {
					text = text + ele.text();
				}
				if (parse.getAttrSelecttype().equals("2")) {
					text = text + ele.outerHtml();
				}
				if (parse.getAttrSelecttype().equals("3")) {
					text = text + ele.val();
				}
				if (parse.getAttrSelecttype().equals("4")) {
					text = text + ele.html();
				}
			}
			map.put("TEXT", text);
			returnList.add(map);
		}

		try {
			Thread.sleep(waitTime);
		} catch (InterruptedException e) {
			log.error(e.getMessage());
			throw new RuntimeException(e);
		}
		return returnList;
	}
}
