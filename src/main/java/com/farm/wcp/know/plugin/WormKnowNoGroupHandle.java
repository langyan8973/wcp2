package com.farm.wcp.know.plugin;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

import org.apache.log4j.Logger;

import com.farm.core.FarmService;
import com.farm.core.auth.domain.LoginUser;
import com.farm.doc.domain.FarmDocfile;
import com.farm.doc.server.FarmFileManagerInter;
import com.farm.doc.server.FarmDocOperateRightInter.POP_TYPE;
import com.farm.wcp.know.common.HttpDocument;
import com.farm.wcp.know.common.HttpResourceHandle;
import com.farm.wcp.know.server.WcpKnowManagerInter;
import com.farm.web.spring.BeanFactory;
import com.farm.worm.domain.FarmWormProject;
import com.farm.worm.server.WormDocHandleInter;
import com.farm.worm.server.WormDocHandlePara;

public class WormKnowNoGroupHandle implements WormDocHandleInter {
	private final static WcpKnowManagerInter knowIMP = (WcpKnowManagerInter) BeanFactory
			.getBean("wcp_KnowProxyId");
	private static final Logger log = Logger
			.getLogger(WormKnowNoGroupHandle.class);
	private final static FarmFileManagerInter fileIMP = (FarmFileManagerInter) BeanFactory
	.getBean("farm_docFileProxyId");
	@Override
	public WormDocHandlePara getParaFormat() {
		WormDocHandlePara para = new WormDocHandlePara();
		para.put("LOGINNAME", "用户登录名");
		para.put("TYPEID", "分类ID");
		return para;
	}

	@Override
	public void handle(Map<String, String> doc, FarmWormProject pro,
			WormDocHandlePara appPara) {
		FarmService manager = FarmService.getInstance();
		HttpDocument httpdoc = HttpDocument.instance(doc.get("CONTENT"));
		httpdoc.removeOutContent();
		httpdoc.rewriteResources(new HttpResourceHandle() {
			@Override
			public String handle(String eurl, URL baseUrl) {
				// eurl=http://img.baidu.com/img/baike/logo-baike.png
				String exname = null;
				try {
					if (eurl.lastIndexOf("?") > 0) {
						exname = eurl.substring(0, eurl.lastIndexOf("?"));
					} else {
						exname = eurl;
					}
					if (eurl.lastIndexOf(".") > 0) {
						exname = eurl.substring(eurl.lastIndexOf(".") + 1);
					} else {
						exname = eurl;
					}
					if (exname.length() > 10) {
						exname = "gif";
					}
					if (exname == null) {
						exname = "gif";
					}
				} catch (Exception e) {
					exname = "gif";
				}
				LoginUser thisuser = new LoginUser() {
					@Override
					public String getName() {
						return "NONE";
					}

					@Override
					public String getLoginname() {
						return "NONE";
					}

					@Override
					public String getId() {
						return "NONE";
					}
				};
				if (eurl.toUpperCase().indexOf("HTTP") < 0 && baseUrl != null) {
					eurl = baseUrl.toString().substring(0,
							baseUrl.toString().lastIndexOf("/") + 1)
							+ eurl;
				}
				try {
					URL innerurl = new URL(eurl);
					// 创建连接的地址
					HttpURLConnection connection = (HttpURLConnection) innerurl
							.openConnection();
					// 返回Http的响应状态码
					InputStream input = null;
					connection.setReadTimeout(3000);
					try {
						input = connection.getInputStream();
					} catch (Exception e) {
						System.out.println(e + e.getMessage());
						return eurl;
					}
					FarmDocfile file = fileIMP
							.openFile(exname, eurl.length() > 128 ? eurl
									.substring(0, 128) : eurl, thisuser);
					OutputStream fos = new FileOutputStream(file.getFile());
					// 获取输入流
					try {
						int bytesRead = 0;
						byte[] buffer = new byte[8192];
						while ((bytesRead = input.read(buffer, 0, 8192)) != -1) {
							fos.write(buffer, 0, bytesRead);
						}
					} finally {
						input.close();
						fos.close();
					}
					// config.file.client.html.resource.url
					eurl = fileIMP.getFileURL(file.getId());

				} catch (Exception e) {
					log.error(e + "网络图片文件保存失败");
				}
				System.out.println(eurl);
				return eurl;
			}
		});
		knowIMP.creatKnow(doc.get("TITLE"), appPara
				.get("TYPEID"), httpdoc.getDocument().html(), null,
				POP_TYPE.PUB, POP_TYPE.PUB, null, manager.getAuthorityService()
						.getUserByLoginName(appPara.get("LOGINNAME")));
	}
}
