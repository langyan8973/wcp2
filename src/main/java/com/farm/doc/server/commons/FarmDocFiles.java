package com.farm.doc.server.commons;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import com.farm.core.FarmService;
import com.farm.core.time.TimeTool;

public class FarmDocFiles {
	private static final Logger log = Logger.getLogger(FarmDocFiles.class);

	/**
	 * 生成文件目录
	 * 
	 * @return
	 */
	public static String generateDir() {
		// 把临时文件拷贝到上传目录下
		String dirPath = File.separator
				+ TimeTool.getTimeDate12().substring(0, 4) + File.separator
				+ TimeTool.getTimeDate12().substring(4, 6) + File.separator
				+ TimeTool.getTimeDate12().substring(6, 8) + File.separator
				+ TimeTool.getTimeDate12().substring(8, 10) + File.separator;
		File accessFile = new File(getFileDirPath() + dirPath);
		accessFile.mkdirs();
		return dirPath;
	}

	public static String getFileDirPath() {
		String path = FarmService.getInstance().getParameterService()
				.getParameter("config.doc.dir");
		try {
			if (path.startsWith("WEBROOT")) {
				path = path.replace("WEBROOT", FarmService.getInstance()
						.getParameterService().getParameter(
								"farm.constant.webroot.path "));

			}
			String separator = File.separator;
			if (separator.equals("\\")) {
				separator = "\\\\";
			}
			path = path.replaceAll("\\\\", "/").replaceAll("/", separator);
		} catch (Exception e) {
			log.warn(path + ":路径地址有误！");
			path = DocumentConfig.getString("config.doc.dir");
		}
		return path;
	}

	/**
	 * 获得文件的扩展名
	 * 
	 * @param fileName
	 * @return
	 */
	public static String getExName(String fileName) {
		return fileName.substring(fileName.lastIndexOf("."));
	}

	public static List<String> getFilesId(String html) {
		List<String> list = new ArrayList<String>();
		Document doc = Jsoup.parse(html);
		for (Element node : doc.getElementsByTag("img")) {
			String urlStr = node.attr("src");
			if (urlStr.indexOf(DocumentConfig
					.getString("config.doc.download.url")) >= 0) {
				String splits = urlStr.substring(urlStr.indexOf(DocumentConfig
						.getString("config.doc.download.url"))
						+ DocumentConfig.getString("config.doc.download.url")
								.length());
				list.add(splits);
			}
		}
		for (Element node : doc.getElementsByTag("a")) {
			String urlStr = node.attr("href");
			if (urlStr.indexOf(DocumentConfig
					.getString("config.doc.download.url")) >= 0) {
				String splits = urlStr.substring(urlStr.indexOf(DocumentConfig
						.getString("config.doc.download.url"))
						+ DocumentConfig.getString("config.doc.download.url")
								.length());
				list.add(splits);
			}
		}
		return list;
	}

	/**
	 * 拷贝一个文件到新的地址
	 * 
	 * @param file
	 * @param newPath
	 */
	public static void copyFile(File file, String newPath) {
		int bytesum = 0;
		int byteread = 0;
		File oldfile = file;
		if (oldfile.exists()) { // 文件存在时
			InputStream inStream = null;
			FileOutputStream fs = null;
			try {
				inStream = new FileInputStream(file);
				fs = new FileOutputStream(newPath + file.getName());
				byte[] buffer = new byte[1444];
				while ((byteread = inStream.read(buffer)) != -1) {
					bytesum += byteread; // 字节数 文件大小
					fs.write(buffer, 0, byteread);
				}
			} catch (FileNotFoundException e) {
				log.error(e.getMessage());
			} catch (IOException e) {
				log.error(e.getMessage());
			} finally {
				try {
					inStream.close();
					fs.close();
				} catch (IOException e) {
				}
			}
		}
	}

	/**
	 * 将文件流保存到一个地址
	 * 
	 * @param file
	 * @param newPath
	 */
	public static Long saveFile(InputStream inStream, String filename,
			String newPath) {
		int bytesum = 0;
		int byteread = 0;
		FileOutputStream fs = null;
		try {
			fs = new FileOutputStream(newPath + filename);
			byte[] buffer = new byte[1444];
			while ((byteread = inStream.read(buffer)) != -1) {
				bytesum += byteread; // 字节数 文件大小
				fs.write(buffer, 0, byteread);
			}
		} catch (FileNotFoundException e) {
			log.error(e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
		} finally {
			try {
				inStream.close();
				fs.close();
			} catch (IOException e) {
			}
		}
		File file = new File(newPath + filename);
		return file.length();
	}

	/**
	 * 删除Html标签
	 * 
	 * @param inputString
	 * @return
	 */
	public static String HtmlRemoveTag(String html) {
		if (html == null)
			return null;
		String htmlStr = html; // 含html标签的字符串
		String textStr = "";
		java.util.regex.Pattern p_script;
		java.util.regex.Matcher m_script;
		java.util.regex.Pattern p_style;
		java.util.regex.Matcher m_style;
		java.util.regex.Pattern p_html;
		java.util.regex.Matcher m_html;

		try {
			String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; // 定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script>
			// }
			String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>"; // 定义style的正则表达式{或<style[^>]*?>[\\s\\S]*?<\\/style>
			// }
			String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式

			p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
			m_script = p_script.matcher(htmlStr);
			htmlStr = m_script.replaceAll(""); // 过滤script标签

			p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
			m_style = p_style.matcher(htmlStr);
			htmlStr = m_style.replaceAll(""); // 过滤style标签

			p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
			m_html = p_html.matcher(htmlStr);
			htmlStr = m_html.replaceAll(""); // 过滤html标签

			textStr = htmlStr;

		} catch (Exception e) {
			// System.err.println("Html2Text: " + e.getMessage());
		}

		return textStr.replaceAll("\\s*", "");// 返回文本字符串
	}
}
