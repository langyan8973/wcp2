<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--文档表单-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
		<form id="dom_formFarmdoc">
			<input type="hidden" id="entity_id" name="entity.id"
				value="${entity.id}">
			<table class="editTable">
				<tr>
					<td class="title">
						标题:
					</td>
					<td colspan="3">
						<input type="text" style="width: 410px;"
							class="easyui-validatebox"
							data-options="required:true,validType:[,'maxLength[128]']"
							id="entity_title" name="entity.title" value="${entity.title}">
					</td>
				</tr>
				<tr>
					<td class="title">
						<a href="javascript:void(0)" id="mb" class="easyui-menubutton"
							data-options="menu:'#mm',iconCls:'icon-graphic-design',plain:false">内容</a>
						<div id="mm" style="width: 160px;">
							<div id="openKindEditorId" data-options="iconCls:'icon-edit'">
								在超文本编辑器中打开
							</div>
						</div>
					</td>
					<td colspan="3">
						<textarea name="content" id="contentId" class="easyui-validatebox"
							data-options="required:true,validType:[,'maxLength[12000]']"
							style="height: 100px; width: 410px;">${entity.texts.text1}</textarea>
					</td>
				</tr>
				<tr>
					<td class="title">
						分类:
					</td>
					<td>
						<c:if test="${doctype!=null&&doctype.id!=null}">
			                  ${doctype.name}
			                  <input type="hidden" name='doctype.id'
								value="${doctype.id}" />
						</c:if>
						<c:if test="${doctype==null||doctype.id==null}">
			                   无
			            </c:if>
					</td>
					<td class="title">
						状态:
					</td>
					<td>
						<select name="entity.state" id="entity_state"
							style="width: 120px;" val="${entity.state}">
							<option value="1">
								开放
							</option>
							<option value="0">
								禁用
							</option>
							<option value="2">
								待审核
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="title">
						摘要:
					</td>
					<td colspan="3">
						<textarea rows="2" style="width: 410px;"
							class="easyui-validatebox"
							data-options="validType:[,'maxLength[128]']"
							id="entity_docdescribe" name="entity.docdescribe">${entity.docdescribe}</textarea>
					</td>
				</tr>
				<tr>
					<td class="title">
						Tag标签:
					</td>
					<td colspan="3">
						<input type="text" style="width: 410px;"
							class="easyui-validatebox"
							data-options="validType:[,'maxLength[512]']" id="entity_tagkey"
							name="entity.tagkey" value="${entity.tagkey}">
					</td>
				</tr>
				<tr>
					<td class="title">
						来源:
					</td>
					<td colspan="3">
						<input type="text" style="width: 410px;"
							class="easyui-validatebox"
							data-options="validType:[,'maxLength[128]']" id="entity_source"
							name="entity.source" value="${entity.source}">
					</td>
				</tr>
				<tr>
					<td class="title">
						所属组:
					</td>
					<td>
						<select id="entity_docgroupid" name="entity.docgroupid"
							style="width: 120px;" val="${entity.docgroupid}">
							<option value="">
								无
							</option>
							<c:forEach var="node" items="${result.resultList}">
								<option value="${node.ID}">
									${node.GROUPNAME}
								</option>
							</c:forEach>
						</select>
					</td>
					<td class="title">
						简短标题:
					</td>
					<td>
						<input type="text" style="width: 120px;"
							class="easyui-validatebox"
							data-options="validType:[,'maxLength[32]']"
							id="entity_shorttitle" name="entity.shorttitle"
							value="${entity.shorttitle}">
					</td>
				</tr>
				<tr>
					<td class="title">
						读权限:
					</td>
					<td>
						<select name="entity.readpop" id="entity_readpop"
							style="width: 120px;" val="${entity.readpop}">
							<option value="0">
								本人
							</option>
							<option value="1">
								公开
							</option>
							<option value="2">
								小组
							</option>
							<option value="3">
								禁止
							</option>
						</select>
					</td>
					<td class="title">
						写权限:
					</td>
					<td>
						<select name="entity.writepop" id="entity_writepop"
							style="width: 120px;" val="${entity.writepop}">
							<option value="0">
								本人
							</option>
							<option value="1">
								公开
							</option>
							<option value="2">
								小组
							</option>
							<option value="3">
								禁止
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="title">
						内容类型:
					</td>
					<td>
						<select name="entity.domtype" id="entity_domtype"
							style="width: 120px;" val="${entity.domtype}">
							<option value="1">
								HTML文档
							</option>
							<option value="2">
								txt
							</option>
							<option value="3">
								html站点
							</option>
						</select>
					</td>
					<td class="title">
						内容图ID:
					</td>
					<td>
						<c:if test="${pageset.pageType!=0}">
							<input type="button" id="uploadButton" value="上传内容图" />
							<script type="text/javascript">
	$(function() {
		var uploadbutton;
		uploadbutton = KindEditor.uploadbutton( {
			button : KindEditor('#uploadButton')[0],
			fieldName : 'imgFile',
			url : 'admin/FPupload.do',
			afterUpload : function(data) {
				if (data.error === 0) {
					$("#entity_fileid").val(data.id);
					$("#imgFileboxId").html(
							"<a  target='_blank'  href='" + data.url
									+ "'>下载</a>");
				} else {
					if (data.message) {
						alert(data.message);
					} else {
						alert('请检查文件格式');
					}
				}
			},
			afterError : function(str) {
				alert('自定义错误信息: ' + str);
			}
		});
		uploadbutton.fileBox.change(function(e) {
			uploadbutton.submit();
		});
	});
</script>
						</c:if>
						<span id="imgFileboxId"> <c:if
								test="${entity.imgUrl!=null}">
								<a target='_blank' href='${entity.imgUrl}'>下载</a>
							</c:if> </span>
						<input type="hidden" id="entity_fileid" name="entity.imgid"
							value="${entity.imgid}">
					</td>
				</tr>
				<tr>
					<td class="title">
						作者:
					</td>
					<td>
						<input type="text" style="width: 120px;"
							class="easyui-validatebox"
							data-options="validType:[,'maxLength[32]']" id="entity_author"
							name="entity.author" value="${entity.author}">
					</td>
					<td class="title">
						发布时间:
					</td>
					<td>
						<input type="text" style="width: 120px;"
							class="easyui-datetimebox" data-options="required:true"
							id="entity_pubtime" name="entity.pubtime"
							value="${entity.pubtime}">
					</td>
				</tr>
				<c:if test="${pageset.pageType==0}">
					<tr>
						<td class="title">
							访问统计:
						</td>
						<td colspan="3">
							<input type="text" style="width: 410px;"
								class="easyui-validatebox"
								data-options="required:true,validType:[,'maxLength[16]']"
								id="entity_runinfoid" name="entity.runinfoid"
								value="${entity.runinfoid}">
						</td>
					</tr>
				</c:if>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false">
		<div class="div_button" style="text-align: center; padding: 4px;">
			<c:if test="${pageset.pageType==1}">
				<a id="dom_add_entityFarmdoc" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">增加</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
				<a id="dom_edit_entityFarmdoc" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">修改</a>
			</c:if>
			<a id="dom_cancle_formFarmdoc" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
	<div id="win"></div>
</div>
<script type="text/javascript">
	var submitAddActionFarmdoc = 'admin/FarmDocaddCommit.do';
	var submitEditActionFarmdoc = 'admin/FarmDoceditCommit.do';
	var currentPageTypeFarmdoc = '${pageset.pageType}';
	var submitFormFarmdoc;
	var editor;
	$(function() {
		//表单组件对象
		submitFormFarmdoc = $('#dom_formFarmdoc').SubmitForm( {
			pageType : currentPageTypeFarmdoc,
			grid : gridFarmdoc,
			currentWindowId : 'winFarmdoc'
		});
		//关闭窗口
		$('#dom_cancle_formFarmdoc').bind('click', function() {
			$('#winFarmdoc').window('close');
		});
		$('#openKindEditorId').bind('click', function() {
			$.farm.openWindow( {
				id : 'winEditDoc',
				width : 800,
				height : 450,
				modal : true,
				url : 'admin/FarmDoc_ACTION_KindEditor.do',
				title : '编辑'
			});
		});
		//提交新增数据
		$('#dom_add_entityFarmdoc').bind('click', function() {
			submitFormFarmdoc.postSubmit(submitAddActionFarmdoc);
		});
		//提交修改数据
		$('#dom_edit_entityFarmdoc').bind('click', function() {
			submitFormFarmdoc.postSubmit(submitEditActionFarmdoc);
		});
	});
	//-->
</script>