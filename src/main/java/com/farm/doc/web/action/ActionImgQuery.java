package com.farm.doc.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

import com.farm.core.FarmService;
import com.farm.doc.domain.FarmDocfile;
import com.farm.doc.server.FarmFileManagerInter;
import com.farm.doc.server.FarmFileManagerInter.FILE_TYPE;

import com.farm.web.WebSupport;
import com.farm.web.spring.BeanFactory;

/**
 * 文档管理
 * 
 * @author autoCode
 * 
 */
public class ActionImgQuery extends WebSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private File imgFile;
	private int error;
	private String url;
	private String message;
	private InputStream inputStream;
	private String id;
	private String filename;
	private String imgFileFileName;
	private String imgFileContentType;
	private static final Logger log = Logger.getLogger(ActionImgQuery.class);

	@Override
	public void addActionError(String anErrorMessage) {
		// 这里要先判断一下，是我们要替换的错误，才处理
		if (anErrorMessage
				.startsWith("Request exceeded allowed size limit! Max size allowed is")) {
			Pattern pattern = Pattern.compile("[,|\\d]+");
			Matcher m = pattern.matcher(anErrorMessage);
			// 匹配一次
			m.find();
			String s1 = m.group().replaceAll(",", "");// 上传的文件大小
			// 再匹配一次
			m.find();
			String s2 = m.group().replaceAll(",", "");// 所限制的大小
			String fileUploadErrorMessage = null;
			if (!s1.equals("") && !s2.equals("")) {
				fileUploadErrorMessage = "你上传的文件大小（" + Long.valueOf(s2) / 1024
						/ 1024 + "M）超过允许的大小（" + Long.valueOf(s1) / 1024 / 1024
						+ "M）";
				getRequest().setAttribute("fileUploadErrorMessage",
						fileUploadErrorMessage);
				// 将信息替换掉
				super.addActionError(fileUploadErrorMessage);
			}
		} else {// 否则按原来的方法处理
			super.addActionError(anErrorMessage);
		}
	}

	/**
	 * 上传文件
	 * 
	 * @return
	 */
	public String upload() {
		try {
			String fileid = null;
			// 验证大小
			String maxLength = FarmService.getInstance().getParameterService()
					.getParameter("config.doc.upload.length.max");
			if (imgFile.length() > Integer.valueOf(maxLength)) {
				throw new Exception("文件不能超过" + Integer.valueOf(maxLength)
						/ 1024 + "kb");
			}
			// 验证类型
			List<String> types = parseIds(FarmService.getInstance()
					.getParameterService().getParameter(
							"config.doc.upload.types").toUpperCase()
					.replaceAll("，", ","));
			if (!types.contains(imgFileFileName.substring(
					imgFileFileName.lastIndexOf(".") + 1,
					imgFileFileName.length()).toUpperCase())) {
				throw new Exception("文件类型错误，允许的类型为："
						+ FarmService.getInstance().getParameterService()
								.getParameter("config.doc.upload.types")
								.toUpperCase().replaceAll("，", ","));
			}
			fileid = fileIMP.saveFile(imgFile, FILE_TYPE.HTML_INNER_IMG,
					imgFileFileName, getCurrentUser());
			error = 0;
			url = fileIMP.getFileURL(fileid);
			message = "";
			id = fileid;
		} catch (Exception e) {
			error = 1;
			message = e.getMessage();
		}
		return SUCCESS;
	}

	/**
	 * 下载文件
	 * 
	 * @return
	 */
	public String download() {
		String webPath = FarmService.getInstance().getParameterService()
				.getParameter("farm.constant.webroot.path");
		String filePath = "/WEB-FACE/img/style/nullImg.png".replaceAll("/",
				File.separator.equals("/") ? "/" : "\\\\");
		File nullFile = new File(webPath + filePath);
		try {
			FarmDocfile file = fileIMP.getFile(id);
			if (file == null) {
				return "error";
			}
			filename = file.getName();
			inputStream = new FileInputStream(file.getFile());

		} catch (FileNotFoundException e) {
			filename = "该文件不存在";
			try {
				inputStream = new FileInputStream(nullFile);
			} catch (FileNotFoundException e1) {
				log.error(e.getMessage());
			}
			log.error(e.getMessage());
		}
		return SUCCESS;
	}

	private final static FarmFileManagerInter fileIMP = (FarmFileManagerInter) BeanFactory
			.getBean("farm_docFileProxyId");

	public File getImgFile() {
		return imgFile;
	}

	public void setImgFile(File imgFile) {
		this.imgFile = imgFile;
	}

	public int getError() {
		return error;
	}

	public void setError(int error) {
		this.error = error;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFilename() {
		try {
			filename = new String(filename.getBytes("GBK"), "ISO-8859-1");
		} catch (UnsupportedEncodingException e) {

		}// 中文乱码解决
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getImgFileFileName() {
		return imgFileFileName;
	}

	public void setImgFileFileName(String imgFileFileName) {
		this.imgFileFileName = imgFileFileName;
	}

	public String getImgFileContentType() {
		return imgFileContentType;
	}

	public void setImgFileContentType(String imgFileContentType) {
		this.imgFileContentType = imgFileContentType;
	}

}
