package com.farm.doc.exception;

import com.farm.doc.DocI18N;

/**
 * 没有删除权限异常
 * 
 * @author Administrator
 * 
 */
public class CanNoDeleteException extends Exception {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public CanNoDeleteException(String message) {
		super(message);
	}

	public CanNoDeleteException() {
		super(DocI18N.getData("title.com.farm.doc.exception.nowdel"));
	}
}
