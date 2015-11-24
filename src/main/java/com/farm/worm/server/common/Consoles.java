package com.farm.worm.server.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.farm.core.time.TimeTool;

public class Consoles {
	private final static Map<String, List<String>> messages = new HashMap<String, List<String>>();
	private List<String> message = null;
	private final static int Message_Max_Num = 50;// 每个控制台实例最多保存的消息数量
	private final static boolean Los_is_show = false;// 每个控制台实例最多保存的消息数量

	/**
	 * 实例化
	 * 
	 * @param key控制台实例的唯一key
	 * @return
	 */
	public static Consoles getInstance(String key) {
		if (messages.size() > 20) {
			messages.clear();
		}
		Consoles obj = new Consoles();
		obj.message = messages.get(key);
		if (obj.message == null) {
			obj.message = new ArrayList<String>();
			messages.put(key, obj.message);
			obj.info("控制台准备...");
		}
		return obj;
	}

	/**
	 * 记录信息
	 * 
	 * @param string
	 */
	public void info(String string) {
		if (message.size() > Message_Max_Num - 1) {
			message.subList(0, Message_Max_Num - 1);
		}
		if (Los_is_show) {
			System.out.println(string);
		}
		message.add("INFO8220信息:"
				+ string
				+ "["
				+ TimeTool.getFormatTimeDate12(TimeTool.getTimeDate14(),
						"yyyy-MM-dd HH:mm:ss") + "]");
	}

	/**
	 * 记录错误
	 * 
	 * @param string
	 */
	public void error(String string) {
		if (message.size() > Message_Max_Num - 1) {
			message.subList(0, Message_Max_Num - 1);
		}
		if (Los_is_show) {
			System.out.println(string);
		}
		message.add("ERROR2692信息:" + string+ "["
				+ TimeTool
				.getFormatTimeDate12(TimeTool.getTimeDate14(),
						"yyyy-MM-dd HH:mm:ss") + "]");
	}

	/**
	 * 记录警告
	 * 
	 * @param string
	 */
	public void warn(String string) {
		if (message.size() > Message_Max_Num - 1) {
			message.subList(0, Message_Max_Num - 1);
		}
		if (Los_is_show) {
			System.out.println(string);
		}
		message.add("WARN4086警告:" + string+ "["
				+ TimeTool
				.getFormatTimeDate12(TimeTool.getTimeDate14(),
						"yyyy-MM-dd HH:mm:ss") + "]");
	}

	/**
	 * 获得控制台日志
	 * 
	 * @return
	 */
	public List<String> getLogsAndClear() {
		List<String> mes = new ArrayList<String>();
		mes.addAll(message);
		message.clear();
		return mes;
	}
}
