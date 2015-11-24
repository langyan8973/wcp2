package com.farm.doc.exception;

import com.farm.doc.DocI18N;

/**
 * 没有删除权限异常
 * 
 * @author Administrator
 * 
 */
public class NoGroupAuthForLicenceException extends Exception {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public NoGroupAuthForLicenceException(String message) {
		super(message);
	}

	public NoGroupAuthForLicenceException() {
		super(DocI18N.getData("title.com.farm.doc.exception.licence.error"));
	}
}
