package com.farm.doc.impl;

import com.farm.doc.DocServiceInter;
import com.farm.doc.server.FarmDocManagerInter;
import com.farm.doc.server.FarmDocOperateRightInter;
import com.farm.doc.server.FarmDocRunInfoInter;
import com.farm.doc.server.FarmDocgroupManagerInter;
import com.farm.doc.server.FarmDocmessageManagerInter;
import com.farm.doc.server.FarmFileManagerInter;
import com.farm.web.spring.BeanFactory;

public class FarmDocService implements DocServiceInter {

	private final FarmFileManagerInter fileIMP = (FarmFileManagerInter) BeanFactory
			.getBean("farm_docFileProxyId");
	private final FarmDocManagerInter docIMP = (FarmDocManagerInter) BeanFactory
			.getBean("farm_docProxyId");
	private final  FarmDocgroupManagerInter groupIMP = (FarmDocgroupManagerInter) BeanFactory
	.getBean("farm_docgroupProxyId");
	private final  FarmDocmessageManagerInter messageIMP = (FarmDocmessageManagerInter) BeanFactory
	.getBean("farm_docmessageProxyId");
	private final  FarmDocOperateRightInter operateIMP = (FarmDocOperateRightInter) BeanFactory
	.getBean("farm_DocOperateProxyId");
	private final  FarmDocRunInfoInter runInfoIMP = (FarmDocRunInfoInter) BeanFactory
	.getBean("farm_docRunInfoProxyId");
	
	
	private static FarmDocService obj = new FarmDocService();

	public static DocServiceInter getInstance() {
		return obj;
	}

	@Override
	public FarmDocManagerInter getDocService() {
		return docIMP;
	}

	@Override
	public FarmFileManagerInter getFileService() {
		return fileIMP;
	}

	@Override
	public FarmDocgroupManagerInter getGroupService() {
		return groupIMP;
	}

	@Override
	public FarmDocmessageManagerInter getMessageService() {
		return messageIMP;
	}

	@Override
	public FarmDocOperateRightInter getOperateRightService() {
		return operateIMP;
	}

	@Override
	public FarmDocRunInfoInter getRunInfoService() {
		return runInfoIMP;
	}

}
