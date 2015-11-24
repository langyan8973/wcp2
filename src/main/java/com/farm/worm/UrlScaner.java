package com.farm.worm;

import java.util.ArrayList;
import java.util.List;

import com.farm.core.auth.domain.LoginUser;
import com.farm.web.spring.BeanFactory;
import com.farm.worm.Worm.WORM_STATE;
import com.farm.worm.domain.FarmWormProject;
import com.farm.worm.domain.FarmWormTask;
import com.farm.worm.domain.FarmWormUrlfilter;
import com.farm.worm.server.FarmWormProjectManagerInter;
import com.farm.worm.server.FarmWormTaskManagerInter;
import com.farm.worm.server.FarmWormUrlfilterManagerInter;
import com.farm.worm.server.common.Consoles;
import com.farm.worm.server.common.UrlPattern;
import com.farm.worm.server.common.WebPage;
import com.farm.worm.server.common.WormUtilsImpl;
import com.farm.worm.server.common.WormUtilsInter;

/**
 * URL扫描线程
 * 
 * @author 王东
 * 
 */
public class UrlScaner implements Runnable {
	private FarmWormProject project;
	private Consoles console;
	private LoginUser currentUser;
	private WormInter worm;

	public UrlScaner(FarmWormProject project, Consoles console,
			LoginUser currentUser, WormInter worm) {
		this.project = project;
		this.console = console;
		this.currentUser = currentUser;
		this.worm = worm;
	}

	@Override
	public void run() {
		project.setPstate("2");
		worm.setState(WORM_STATE.RUNING);
		console.info("扫描URL中");
		try {
			runScanUrls();
		} catch (Exception e) {
			console.error("项目异常" + e + ":" + e.getMessage());
		} finally {
			worm.setState(WORM_STATE.STOPED);
		}
		worm.setState(WORM_STATE.STOPED);
		console.info("项目已经停止");
	}

	private void runScanUrls() {
		List<UrlPattern> urlPatterns = new ArrayList<UrlPattern>();
		// 获取项目信息
		{
			tasks.clearUrlCatch();// 清除task的url过滤器缓存
			for (FarmWormUrlfilter node : urlFilter.getFiltersByProId(project
					.getId())) {
				urlPatterns.add(new UrlPattern(node.getPtype(), node
						.getFuntype(), node.getPatenstr()));
			}
		}
		// 解析项目种子
		{
			try {
				parsePageUrl(console, null, "种子页面", project.getSeedurl(),
						project.getBaseurl(), urlPatterns,
						project.getTimeout(), project.getWaittime(), project
								.getAgent(), project, currentUser);
			} catch (Exception e) {
				project.setPstate("5");
				console.error("项目异常终止" + e.toString() + "[" + e.getMessage()
						+ "]");
				return;
			}
		}
		// 如果：当前状态是运行中的话.循环从库里取种子并解析
		{
			while (worm.getState().equals(WORM_STATE.RUNING.getState())) {
				List<FarmWormTask> tasklist = tasks.getInitTasks(project
						.getId());
				if (tasklist.size() <= 0) {
					break;
				}
				for (FarmWormTask task : tasklist) {
					if (!worm.getState().equals(WORM_STATE.RUNING.getState())) {
						break;
					}
					try {
						parsePageUrl(console, task.getId(), task.getTitle(),
								task.getUrl(), project.getBaseurl(),
								urlPatterns, project.getTimeout(), project
										.getWaittime(), project.getAgent(),
								project, currentUser);
					} catch (Exception e) {
						console.warn("URL:" + task.getUrl()
								+ "解析失败【错误信息记录在任务备注中】" + e.toString() + "["
								+ e.getMessage() + "]");
						continue;
					}
				}
			}
		}
		if (worm.getState().equals(WORM_STATE.RUNING.getState())) {
			projects.editProjectState(project.getId(), "4");
			console.info("完成");
		} else {
			projects.editProjectState(project.getId(), "7");
			console.info("手动停止");
		}
	}

	/**
	 * 解析一个页面的URL（如果入参的task不等以null则表示,解析的是一个任务负责解析的是项目种子）
	 * 
	 * @param console
	 * @param taskId
	 * @param title
	 * @param url
	 * @param baseUrl
	 * @param patterns
	 * @param outTime
	 * @param waitTime
	 * @param agentStr
	 * @param pro
	 * @param currentUser
	 * @return
	 * @throws Exception
	 */
	private List<WebPage> parsePageUrl(Consoles console, String taskId,
			String title, String url, String baseUrl,
			List<UrlPattern> urlPatterns, int outTime, int waitTime,
			String agentStr, FarmWormProject pro, LoginUser currentUser)
			throws Exception {
		List<WebPage> pages = null;
		if (taskId != null) {
			tasks.editTaskState(taskId, "2");
		}
		try {
			console.info("扫描页面" + title);
			pages = wormUtils.parsePageUrl(url, baseUrl, urlPatterns, outTime,
					waitTime, agentStr);
		} catch (Exception e) {
			if (taskId != null) {
				try {
					FarmWormTask task = tasks.getFarmWormTaskEntity(taskId);
					task.setPstate("4");
					String error = e.toString() + e.getMessage();
					task.setPcontent(error.length() > 500 ? error.substring(0,
							499) : error);
					tasks.editFarmWormTaskEntity(task, currentUser);
				} catch (Exception e1) {
					tasks.editTaskState(taskId, "4");
				}
			}
			throw e;
		}
		// 种子的子页面入库
		for (WebPage page : pages) {
			tasks.insertTaskPage(page, pro, currentUser);
		}
		if (taskId != null) {
			tasks.editTaskState(taskId, "3");
		}
		return pages;
	}

	private final static FarmWormProjectManagerInter projects = (FarmWormProjectManagerInter) BeanFactory
			.getBean("farm_worm_projectProxyId");
	private final static FarmWormTaskManagerInter tasks = (FarmWormTaskManagerInter) BeanFactory
			.getBean("farm_worm_taskProxyId");
	private final static FarmWormUrlfilterManagerInter urlFilter = (FarmWormUrlfilterManagerInter) BeanFactory
			.getBean("farm_worm_urlfilterProxyId");
	private WormUtilsInter wormUtils = WormUtilsImpl.getInstance();
}
