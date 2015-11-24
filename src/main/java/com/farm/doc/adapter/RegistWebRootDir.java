package com.farm.doc.adapter;

import javax.servlet.ServletContext;

import com.farm.parameter.service.impl.ConstantVarService;
import com.farm.web.task.ServletInitJobInter;

/**获得容器根路径
 * @author Administrator
 *
 */
public class RegistWebRootDir implements ServletInitJobInter {

	@Override
	public void execute(ServletContext context) {
		ConstantVarService.registConstant("farm.constant.webroot.path", context
				.getRealPath(""));
	}

}
