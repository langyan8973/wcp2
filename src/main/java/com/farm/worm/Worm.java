package com.farm.worm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.farm.core.auth.domain.LoginUser;
import com.farm.web.spring.BeanFactory;
import com.farm.worm.domain.FarmWormProject;
import com.farm.worm.server.FarmWormProjectManagerInter;
import com.farm.worm.server.FarmWormTaskManagerInter;
import com.farm.worm.server.common.Consoles;

public class Worm implements WormInter {
	private final static Map<String, Worm> worms = new HashMap<String, Worm>();
	private WORM_STATE state = WORM_STATE.STOPED;
	private Consoles console;
	private String projectId;
	private FarmWormProject project;
	private LoginUser currentUser;
	private Thread scanerThread;
	private Thread dowonerThread;

	public static WormInter newInstance(String proId, LoginUser user) {
		Worm worm = worms.get(proId);
		if (worm == null) {
			worm = new Worm();
			worm.console = Consoles.getInstance(proId);
			worm.projectId = proId;
			worm.project = projects.getFarmWormProjectEntity(proId);
			worms.put(proId, worm);
		}
		worm.currentUser = user;
		return worm;
	}

	@Override
	public String getState() {
		return state.getState();
	}

	@Override
	public String getStateTitle() {
		return state.getTitle();
	}

	@Override
	public List<String> getLogs() {
		List<String> list = console.getLogsAndClear();
		if (list.size() <= 0) {
			if (state.equals(WORM_STATE.STOPED)) {
				console.info(state.getTitle());
			} else {
				console.info(state.getTitle() + "...");
			}
		}
		return list;
	}

	@Override
	public Map<String, Object> getStatNum() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("DOCS", tasks.getDocTaskNum(projectId));// 文档任务数
		map.put("SEEDS", tasks.getSeedTaskNum(projectId));// 种子任务数
		map.put("DOWNLOADS", tasks.getDownLoadedNum(projectId));// 文档下载完成数
		map.put("SCANEDS", tasks.getScanedNum(projectId));// 种子扫描完成数
		map.put("STA", state.getState());
		return map;
	}

	@Override
	public void runScanUrlTask() {
		if (state.equals(WORM_STATE.STOPED)) {
			UrlScaner scaner = new UrlScaner(project, console, currentUser,
					this);
			scanerThread = new Thread(scaner);
			scanerThread.start();
		} else {
			console.error("项目正在运行中" + getRunNote());
		}
	}

	/**
	 * 当前线程状态
	 * 
	 * @return
	 */
	private String getRunNote() {
		String mes = "";
		boolean isScan = scanerThread != null ? scanerThread.isAlive() : false;
		boolean isDown = dowonerThread != null ? dowonerThread.isAlive()
				: false;
		if (isScan) {
			mes = mes + "扫描线程正在启动";
		}
		if (isDown) {
			mes = mes + "下载线程正在启动";
		}
		return mes;
	}

	@Override
	public void runDownloadTask() {
		if (state.equals(WORM_STATE.STOPED)) {
			UrlDowner downer = new UrlDowner(project, console, currentUser,
					this);
			scanerThread = new Thread(downer);
			scanerThread.start();
		} else {
			console.error("项目正在运行中" + getRunNote());
		}
	}

	@Override
	public void stop() {
		if (scanerThread != null || dowonerThread != null) {
			state = WORM_STATE.STOPING;
		}
	}

	@Override
	public void setState(WORM_STATE state) {
		this.state = state;
	}

	private final static FarmWormProjectManagerInter projects = (FarmWormProjectManagerInter) BeanFactory
			.getBean("farm_worm_projectProxyId");
	private final static FarmWormTaskManagerInter tasks = (FarmWormTaskManagerInter) BeanFactory
			.getBean("farm_worm_taskProxyId");

	/**
	 * 爬虫运行状态RUNING运行中, STOPED已经停止, STOPING停止中;
	 * 
	 * @author wangdong
	 * 
	 */
	public enum WORM_STATE {
		RUNING("1", "运行中"), STOPED("0", "已停止"), STOPING("2", "正在停止");
		private String state;
		private String title;

		public String getState() {
			return this.state;
		}

		public String getTitle() {
			return this.title;
		}

		private WORM_STATE(String state, String title) {
			this.state = state;
			this.title = title;
		}
	}

}
