package com.farm.doc;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;


public class DocI18N {
	private static String PROPERTY_FILE = DocI18N.class.getResource("/")
			.getPath().toString()
			+ "doc-I18N.properties";
	private static final Logger log = Logger.getLogger(DocI18N.class);
	/**
	 * 根据Key 读取Value
	 */
	public static String getData(String key) {
		Properties props = new Properties();
		try {
			InputStream in = new BufferedInputStream(new FileInputStream(
					PROPERTY_FILE));
			props.load(in);
			in.close();
			String value = props.getProperty(key);
			return value;
		} catch (Exception e) {
			log.error(e.getMessage());
			return null;
		}
	}
}
