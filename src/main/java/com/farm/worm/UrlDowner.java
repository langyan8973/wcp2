package com.farm.worm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.farm.core.auth.domain.LoginUser;
import com.farm.web.spring.BeanFactory;
import com.farm.worm.Worm.WORM_STATE;
import com.farm.worm.domain.FarmWormAttrparse;
import com.farm.worm.domain.FarmWormDocattr;
import com.farm.worm.domain.FarmWormProject;
import com.farm.worm.domain.FarmWormTask;
import com.farm.worm.server.FarmWormAttrparseManagerInter;
import com.farm.worm.server.FarmWormDocattrManagerInter;
import com.farm.worm.server.FarmWormProjectManagerInter;
import com.farm.worm.server.FarmWormTaskManagerInter;
import com.farm.worm.server.WormDocHandleInter;
import com.farm.worm.server.WormDocHandlePara;
import com.farm.worm.server.common.Consoles;
import com.farm.worm.server.common.DocParse;
import com.farm.worm.server.common.WormUtilsImpl;
import com.farm.worm.server.common.WormUtilsInter;

/**
 * 文档下载线程
 * 
 * @author 王东
 * 
 */
public class UrlDowner implements Runnable {
	private FarmWormProject project;
	private Consoles console;
	private LoginUser currentUser;
	private WormInter worm;

	public UrlDowner(FarmWormProject project, Consoles console,
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
		console.info("文档下载中");
		try {
			runDownDocs();
		} catch (Exception e) {
			console.error("项目异常" + e + ":" + e.getMessage());
		} finally {
			worm.setState(WORM_STATE.STOPED);
		}
		worm.setState(WORM_STATE.STOPED);
		console.info("项目已经停止");
	}

	private void runDownDocs() {
		List<DocParse> parse = new ArrayList<DocParse>();
		// 获取项目信息
		{
			for (FarmWormAttrparse node : attrParses.getParseByProId(project
					.getId())) {
				parse.add(new DocParse(node.getAttrselect(), node
						.getAttrselecttype(), node.getId(), node.getAttrkey()));
			}
		}
		// 循环从库里取种子并解析
		{
			while (worm.getState().equals(WORM_STATE.RUNING.getState())) {
				List<FarmWormTask> tasklist = tasks.getDocTaskings(project
						.getId());
				if (tasklist.size() <= 0) {
					break;
				}
				for (FarmWormTask task : tasklist) {
					if (!worm.getState().equals(WORM_STATE.RUNING.getState())) {
						break;
					}
					try {
						tasks.editTaskState(task.getId(), "2");
						List<Map<String, String>> texts = wormUtils
								.parsePageDoc(task.getUrl(), parse, project
										.getTimeout(), project.getWaittime(),
										project.getAgent());
						if (!runHandle(project, texts)) {
							for (Map<String, String> text : texts) {
								FarmWormDocattr attr = new FarmWormDocattr();
								attr.setPcontent(text.get("TEXT"));
								attr.setAttrparseid(text.get("ID"));
								attr.setTaskid(task.getId());
								attr.setProjectid(project.getId());
								attrs.insertFarmWormDocattrEntity(attr,
										currentUser);
							}
						}
					} catch (Exception e) {
						console.warn("任务" + task.getUrl() + "解析失败");
						try {
							task.setPstate("4");
							String error = e.toString() + e.getMessage();
							task.setPcontent(error.length() > 500 ? error
									.substring(0, 499) : error);
							tasks.editFarmWormTaskEntity(task, currentUser);
						} catch (Exception e1) {
							tasks.editTaskState(task.getId(), "4");
						}
						continue;
					}
					console.info("文档" + task.getUrl() + "下载完成");
					tasks.editTaskState(task.getId(), "3");
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
	 * 调用文档下载的外部监听接口
	 * 
	 * @param pro项目信息
	 * @param texts
	 *            文档内容
	 * @throws ClassNotFoundException
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 */
	@SuppressWarnings("unchecked")
	private boolean runHandle(FarmWormProject pro,
			List<Map<String, String>> texts) throws ClassNotFoundException,
			InstantiationException, IllegalAccessException {
		if (pro.getHandleclass() != null
				&& pro.getHandleclass().trim().length() > 0) {
			boolean isTrueClass = false;
			Class handleclass = Class.forName(pro.getHandleclass().trim());
			for (Class cla : handleclass.getInterfaces()) {
				if (cla.equals(WormDocHandleInter.class)) {
					isTrueClass = true;
					break;
				}
			}
			if (isTrueClass == false) {
				throw new RuntimeException("未实现要求接口");
			}
			WormDocHandleInter handle = (WormDocHandleInter) handleclass
					.newInstance();
			Map<String, String> map = new HashMap<String, String>();
			for (Map<String, String> node : texts) {
				map.put(node.get("KEY"), node.get("TEXT"));
			}
			// 从表单值构造参数对象
			WormDocHandlePara para = new WormDocHandlePara(pro.getHandlepara());
			handle.handle(map, pro, para);
			return true;
		} else {
			return false;
		}
	}

	private final static FarmWormProjectManagerInter projects = (FarmWormProjectManagerInter) BeanFactory
			.getBean("farm_worm_projectProxyId");
	private final static FarmWormDocattrManagerInter attrs = (FarmWormDocattrManagerInter) BeanFactory
			.getBean("farm_worm_docattrProxyId");
	private final static FarmWormAttrparseManagerInter attrParses = (FarmWormAttrparseManagerInter) BeanFactory
			.getBean("farm_worm_attrparseProxyId");
	private final static FarmWormTaskManagerInter tasks = (FarmWormTaskManagerInter) BeanFactory
			.getBean("farm_worm_taskProxyId");
	private WormUtilsInter wormUtils = WormUtilsImpl.getInstance();
}
