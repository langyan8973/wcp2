package com.farm.worm.server;

import java.util.HashMap;
import java.util.Map.Entry;

public class WormDocHandlePara extends HashMap<String, Object> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4334469502545102648L;

	public WormDocHandlePara() {
		super();
	}

	public WormDocHandlePara(String paraStr) {
		super();
		if (paraStr != null) {
			String[] para2 = paraStr.split(",");
			for (String para : para2) {
				String[] paraA = para.split(":");
				this.put(paraA[0], paraA[1], null);
			}
		}
	}

	@Deprecated
	public String[] put(String key, String value, String title) {
		String[] vals = { value, title };
		this.put(key, vals);
		return vals;
	}

	/**
	 * 增加参数格式
	 * 
	 * @param key
	 *            参数key
	 * @param title
	 *            参数title
	 * @return
	 */
	public String[] put(String key, String title) {
		String[] vals = { null, title };
		this.put(key, vals);
		return vals;
	}

	/**
	 * 获得参数值
	 * 
	 * @param key
	 * @return
	 */
	public String get(String key) {
		String[] vals = (String[]) super.get(key);
		return vals[0];
	}

	/**
	 * 获取参数格式
	 * 
	 * @return
	 */
	@Deprecated
	public String getformat() {
		StringBuffer str = new StringBuffer();
		for (Entry<String, Object> node : this.entrySet()) {
			if (str.length() > 0) {
				str.append(",");
			}
			String[] val = (String[]) node.getValue();
			str.append(node.getKey() + ":[" + val[1] + "]");
		}
		return str.toString();
	}

	@Deprecated
	public Object put(String key, Object value) {
		super.put(key, value);
		return value;
	}

	@Deprecated
	public Object get(Object key) {
		return super.get(key);
	}
}
