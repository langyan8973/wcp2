package com.farm.doc.exception;

import com.farm.doc.DocI18N;

/**
 * 知识没有存在异常
 * 
 * @author Administrator
 * 
 */
public class DocNoExistException extends Exception {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public DocNoExistException(String message) {
		super(message);
	}

	public DocNoExistException() {
		super(DocI18N.getData("title.com.farm.doc.exception.docnoexist"));
	}
}
