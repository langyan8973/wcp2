<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-TAG/platForm.tld" prefix="PF"%>
<!--URL过滤器-->
<div class="easyui-layout" data-options="fit:true">
	<div class="TableTitle" data-options="region:'north',border:false">
		<c:if test="${pageset.pageType==1}">新增${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==2}">修改${JSP_Messager_Title}记录</c:if>
		<c:if test="${pageset.pageType==0}">浏览${JSP_Messager_Title}记录</c:if>
	</div>
	<div data-options="region:'center'">
		<form id="dom_formfarmwormurlfilter">
			<input type="hidden" name="entity.id" value="${entity.id}">
			<input type="hidden" name="entity.projectid" value="${proid}">
			<table class="editTable">
				<tr>
					<td class="title">
						备注:
					</td>
					<td colspan="3">
						<input type="text" style="width: 360px;"
							class="easyui-validatebox"
							data-options="required:true,validType:',maxLength[64]'"
							id="entity_pcontent" name="entity.pcontent"
							value="${entity.pcontent}">

					</td>
				</tr>
				<tr>
					<td class="title">
						正则表达式:
					</td>
					<td colspan="3">
						<input type="text" style="width: 360px;"
							class="easyui-validatebox"
							data-options="required:true,validType:',maxLength[128]'"
							id="entity_patenstr" name="entity.patenstr"
							value="${entity.patenstr}">

					</td>
				</tr>
				<tr>
					<td class="title">
						类型:
					</td>
					<td colspan="3">
						<select name="entity.ptype" id="entity_ptype"
							val="${entity.ptype}">
							<option value="1">
								黑名单
							</option>
							<option value="2">
								白名单
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="title">
						作用对象:
					</td>
					<td colspan="3">
						<select name="entity.funtype" id="entity_funtype"
							val="${entity.funtype}">
							<option value="1">
								种子页面URL
							</option>
							<option value="2">
								文档页面URL
							</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<table border="1" bordercolor="#000000">
							<tbody>
								<tr>
									<th colspan="4" style="background-color: black; color: white;">
										匹配规则
									</th>
								</tr>
								<tr>
									<th>
										<p>
											<span id="xn7_bfdb1ddbbe42a9c7b7e67d17f10da122"
												class="sentence">元字符</span>
										</p>
									</th>
									<th>
										<p>
											<span id="xn8_b140af3d7bfd40d88d0661a887aaba80"
												class="sentence">行为</span>
										</p>
									</th>
									<th>
										<p>
											<span id="xn9_1a79a4d60de6718e8e5b326e338ae533"
												class="sentence">示例</span>
										</p>
									</th>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn10_3389dae361af79b04c9c8e7057f60cc6"
												class="sentence">*</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn11_c17273a664dd06fa1a67e11699780b17"
												class="sentence">零次或多次匹配前面的字符或子表达式。</span>
										</p>
										<p>
											<span id="xn12_05824006c91d383636ac902487a29617"
												class="sentence">等效于 <span class="code">{0,}</span>。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn13_6c22e1461a8549c3cc0838897f393aba"
												class="sentence"><span class="code">zo*</span>
												与“z”和“zoo”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn14_26b17225b626fb9238849fd60eabdf60"
												class="sentence">+</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn15_83008e7a25e8ea5a16f0a6631be43366"
												class="sentence">一次或多次匹配前面的字符或子表达式。</span>
										</p>
										<p>
											<span id="xn16_3bb97af7f2ccfa796a49b0a61f90de9f"
												class="sentence">等效于 <span class="code">{1,}</span>。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn17_a50e78431ce02f097a96f3858d8c15be"
												class="sentence"><span class="code">zo+</span>
												与“zo”和“zoo”匹配，但与“z”不匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn18_d1457b72c3fb323a2671125aef3eab5d"
												class="sentence">?</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn19_324995f41d8c6248d4452c812ed1354a"
												class="sentence">零次或一次匹配前面的字符或子表达式。</span>
										</p>
										<p>
											<span id="xn20_9a786fcc293ebf0d295de4e5d9bef292"
												class="sentence">等效于 <span class="code">{0,1}</span>。</span>
										</p>
										<p>
											<span id="xn21_a3fd1ff019f8ecd656a31d8119f35c64"
												class="sentence">当 ?</span><span
												id="xn22_5bc7521a5b3ca2604f44006d9e26bdcc" class="sentence">紧随任何其他限定符（*、+、?、{<span
												class="parameter">n</span>}、{<span class="parameter">n</span>,}
												或 {<span class="parameter">n</span>,<span class="parameter">m</span>}）之后时，匹配模式是非贪婪的。</span><span
												id="xn23_aff9b5cdb0a3346a3cec89e86b3810e0" class="sentence">非贪婪模式匹配搜索到的、尽可能少的字符串，</span><span
												id="xn24_6c9596121555dfa0714fc3b2261e4922" class="sentence">而默认的贪婪模式匹配搜索到的、尽可能多的字符串。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn25_3a774ff7ed44e3a185ac58cd5350a80b"
												class="sentence"><span class="code">zo?</span>
												与“z”和“zo”匹配，但与“zoo”不匹配。</span>
										</p>
										<p>
											<span id="xn26_7d70c438277b13726bf9955137bc68c9"
												class="sentence"><span class="code">o+?</span>
												只与“oooo”中的单个“o”匹配，而 <span class="code">o+</span> 与所有“o”匹配。</span>
										</p>
										<p>
											<span id="xn27_bff261cdb79d0693b585c72e2b7d56df"
												class="sentence"><span class="code">do(es)?</span>
												与“do”或“does”中的“do”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn28_7e6a2afe551e067a75fafacf47a6d981"
												class="sentence">^</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn29_7f8edf3c6691cbb811545c47d2e2df9e"
												class="sentence">匹配搜索字符串开始的位置。</span><span
												id="xn30_376acd9c998d9a23877489b1b2a1edee" class="sentence">如果标志中包括
												<span class="code">m</span>（多行搜索）字符，^ 还将匹配 \n 或 \r 后面的位置。</span>
										</p>
										<p>
											<span id="xn31_57eedafc59d6536d272fe84fa749ee5d"
												class="sentence">如果将 ^ 用作括号表达式中的第一个字符，则会对字符集求反。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn32_882ab86395a80d9acb680449af242d91"
												class="sentence"><span class="code">^\d{3}</span>
												与搜索字符串开始处的 3 个数字匹配。</span>
										</p>
										<p>
											<span id="xn33_5a784cdb85372dfd0be9edb61f2c03f8"
												class="sentence"><span class="code">[^abc]</span> 与除
												a、b 和 c 以外的任何字符匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn34_c3e97dd6e97fb5125688c97f36720cbe"
												class="sentence">$</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn35_db5cbfc03633c307bfef10aae8430ff5"
												class="sentence">匹配搜索字符串结尾的位置。</span><span
												id="xn36_22be826ed156f7a7ac9ee5c0ae54fb79" class="sentence">如果标志中包括
												<span class="code">m</span>（多行搜索）字符，^ 还将匹配 \n 或 \r 前面的位置。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn37_6d6b36a9b1076b28fd592d7d5905d665"
												class="sentence"><span class="code">\d{3}$</span>
												与搜索字符串结尾处的 3 个数字匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn38_5058f1af8388633f609cadb75a75dc9d"
												class="sentence">.</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn39_14bddf3ef4e8a85a76ec59f3d57c269d"
												class="sentence">匹配除换行符 \n 之外的任何单个字符。</span><span
												id="xn40_ad93fca49b48bd6157718df74eb98bbd" class="sentence">若要匹配包括
												\n 在内的任意字符，请使用诸如 <span class="code">[\s\S]</span> 之类的模式。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn41_66f2d43fd67c3d6b1ff9a5bc2cd4682b"
												class="sentence"><span class="code">a.c</span>
												与“abc”、“a1c”和“a-c”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn42_d751713988987e9331980363e24189ce"
												class="sentence">[]</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn43_2516e8f4d220703499828d310514901d"
												class="sentence">标记括号表达式的开始和结尾。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn44_f0b0daacfef437c0fb3ae9ea3fd05947"
												class="sentence"><span class="code">[1-4]</span>
												与“1”、“2”、“3”或“4”匹配。</span><span
												id="xn45_b6290960d68d6e257362a7343bc56732" class="sentence"><span
												class="code">[^aAeEiIoOuU]</span> 与任何非元音字符匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn46_99914b932bd37a50b983c5e7c90ae93b"
												class="sentence">{}</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn47_d5fce86d1d830cc9612234715d3f7ee4"
												class="sentence">标记限定符表达式的开始和结尾。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn48_3edded8ddbac734c4323be426edc3326"
												class="sentence"><span class="code">a{2,3}</span>
												与“aa”和“aaa”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn49_bcd8b0c2eb1fce714eab6cef0d771acc"
												class="sentence">()</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn50_9ea769a4f7f7d8ceba37dff627962175"
												class="sentence">标记子表达式的开始和结尾。</span><span
												id="xn51_99cc56c93b6973ff82c1146f8e215860" class="sentence">可以保存子表达式以备将来之用。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn52_f0826bd63624918845fbf493c71135aa"
												class="sentence"><span class="code">A(\d)</span>
												与“A0”至“A9”匹配。</span><span
												id="xn53_ce54ed8c81c6081896b133b7bd81bed0" class="sentence">保存该数字以备将来之用。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											|
										</p>
									</td>
									<td>
										<p>
											<span id="xn54_ff3d4f7e6ca9045f8445aa6a3d469d78"
												class="sentence">指示在两个或多个项之间进行选择。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn55_94b0a7b8c04c73e4610678d008ca4007"
												class="sentence"><span class="code">z|food</span>
												与“z”或“food”匹配。</span><span
												id="xn56_8d0bab536509991433202809fa8e0882" class="sentence"><span
												class="code">(z|f)ood</span> 与“zood”或“food”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn57_6666cd76f96956469e7be39d750cc7d9"
												class="sentence">/</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn58_977d0fd9de092e7207600440d607da37"
												class="sentence">表示 JScript 中的文本正则表达式模式的开始或结尾。</span><span
												id="xn59_610b2de4d0628d65573516d7043c0aba" class="sentence">在第二个“/”后添加单字符标志可以指定搜索行为。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn60_bd23bae1ae76ec12a7ba24db21718b3b"
												class="sentence"><span class="code">/abc/gi</span>
												是与“abc”匹配的 JScript 文本正则表达式。</span><span
												id="xn61_f9dfa412ff77f57f3452842c2806c16e" class="sentence"><span
												class="code">g</span>（全局）标志指定查找模式的所有匹配项，<span class="code">i</span>（忽略大小写）标志使搜索不区分大小写。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn62_28d397e87306b8631f3ed80d858d35f0"
												class="sentence">\</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn63_455800aba3d1e6546a7dd46e09037a8e"
												class="sentence">将下一字符标记为特殊字符、文本、反向引用或八进制转义符。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn64_566f97d84ecfd1b3836d5f78d0f82369"
												class="sentence"><span class="code">\n</span> 与换行符匹配。</span><span
												id="xn65_d5b0930bc83dacc6a7ae7be4def90016" class="sentence"><span
												class="code">\(</span> 与“(”匹配。</span><span
												id="xn66_ea9b362e4fa9ac71e1f076cb2540904b" class="sentence"><span
												class="code">\\</span> 与“\”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<th colspan="4" style="background-color: black; color: white;">
										匹配类型
									</th>
								</tr>
								<tr>
									<th>
										<p>
											<span id="xn70_bfdb1ddbbe42a9c7b7e67d17f10da122"
												class="sentence">元字符</span>
										</p>
									</th>
									<th>
										<p>
											<span id="xn71_b140af3d7bfd40d88d0661a887aaba80"
												class="sentence">行为</span>
										</p>
									</th>
									<th>
										<p>
											<span id="xn72_1a79a4d60de6718e8e5b326e338ae533"
												class="sentence">示例</span>
										</p>
									</th>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn73_33527f533368b7017111c12d487e7ffb"
												class="sentence">.</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn74_9731096f0dc71fcbb1b7751ae1b2aecf"
												class="sentence">匹配一个任意字符</span>
										</p>
									</td>
									<td>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn73_33527f533368b7017111c12d487e7ffb"
												class="sentence">\b</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn74_9731096f0dc71fcbb1b7751ae1b2aecf"
												class="sentence">与一个字边界匹配；即字与空格间的位置。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn75_5c9b935c771cab813a705c7a7e99d4cb"
												class="sentence"><span class="code">er\b</span>
												与“never”中的“er”匹配，但与“verb”中的“er”不匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn76_33527f533368b7017111c12d487e7ffb"
												class="sentence">\B</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn77_e2c1d91e61443f85dde24756b7c59630"
												class="sentence">非边界字匹配。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn78_a7a2d6025da5df1fdcc0426f109c4a05"
												class="sentence"><span class="code">er\B</span>
												与“verb”中的“er”匹配，但与“never”中的“er”不匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn79_db67067ff09aa53777934fc90dd388b8"
												class="sentence">\d</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn80_54412e3e3efa31e690eee833788e024e"
												class="sentence">数字字符匹配。</span>
										</p>
										<p>
											<span id="xn81_2ad0b910446c2d3ff4e349908b842d8f"
												class="sentence">等效于 <span class="code">[0-9]</span>。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn82_471230c804113364d5339612ad508e2a"
												class="sentence">在搜索字符串“12 345”中，<span class="code">\d{2}</span>
												与“12”和“34”匹配。</span><span
												id="xn83_aa4aeb078ef1fad62df9f1a7262d4e34" class="sentence"><span
												class="code">\d</span> 与“1”、“2”、“3”、“4”和“5”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn84_db67067ff09aa53777934fc90dd388b8"
												class="sentence">\D</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn85_5ab50de23d3baa0eabcc5435094b7bac"
												class="sentence">非数字字符匹配。</span>
										</p>
										<p>
											<span id="xn86_66e65ad12b9eea763d28dac8c850b462"
												class="sentence">等效于 <span class="code">[^0-9]</span>。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn87_1350a0562b59e7f37ea817d54b2c13a1"
												class="sentence"><span class="code">\D+</span>
												与“abc123 def”中的“abc”和“def”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn88_bfa0252a9e76d616bb2fc0b4ef6ce98b"
												class="sentence">\w</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn89_74ca602a43e96054032aff083917e22f"
												class="sentence">与以下任意字符匹配：A-Z、a-z、0-9 和下划线。</span>
										</p>
										<p>
											<span id="xn90_7bdcf3c1425ce3984ba12896047af79b"
												class="sentence">等效于 <span class="code">[A-Za-z0-9_]</span>。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn91_af789bc5c6df7b8d10143549ec828dc7"
												class="sentence">在搜索字符串“The quick brown fox…”中，<span
												class="code">\w+</span> 与“The”、“quick”、“brown”和“fox”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn92_bfa0252a9e76d616bb2fc0b4ef6ce98b"
												class="sentence">\W</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn93_580788a13ff451378ac9f9364434b839"
												class="sentence">与除 A-Z、a-z、0-9 和下划线以外的任意字符匹配。</span>
										</p>
										<p>
											<span id="xn94_693046aa75afff2396963631f30197b4"
												class="sentence">等效于 <span class="code">[^A-Za-z0-9_]</span>。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn95_be377ad0d0ecbadd1f443abbc29c0778"
												class="sentence">在搜索字符串“The quick brown fox…”中，<span
												class="code">\W+</span> 与“…”和所有空格匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn96_1c3e6c3a45dd8061cd6a5b605a1f252e"
												class="sentence">[<span class="parameter">xyz</span>]</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn97_a5abb2ddb3812ca525aacd44d244001b"
												class="sentence">字符集。</span><span
												id="xn98_6079e6b46abfe0d0d792dc6018f84270" class="sentence">与任何一个指定字符匹配。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn99_72f1ae925a68eb60d2811a115d97bb63"
												class="sentence"><span class="code">[abc]</span>
												与“plain”中的“a”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn100_41a8a7cef72a1ecf4b8fbf7b627a71aa"
												class="sentence">[<span class="parameter">^xyz</span>]</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn101_e168c7fc67efaeef5aaeb17f08162e9a"
												class="sentence">反向字符集。</span><span
												id="xn102_d6e5fb2d42108ba4b070ab0c0585a3eb" class="sentence">与未指定的任何字符匹配。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn103_bc55ef119ae037744758599e41d25db8"
												class="sentence"><span class="code">[^abc]</span>
												与“plain”中的“p”、“l”、“i”和“n”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn104_eae4492a7dafdc74b33b485427c8785d"
												class="sentence">[<span class="parameter">a</span>-<span
												class="parameter">z</span>]</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn105_6a4bb199c1ae2dd5ae5c412b852b55ec"
												class="sentence">字符范围。</span><span
												id="xn106_8b31105f2b78d69bccb17a1e9a931938" class="sentence">匹配指定范围内的任何字符。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn107_68a88d77fc19a68d13ffd5f5636ca9c6"
												class="sentence"><span class="code">[a-z]</span>
												与“a”到“z”范围内的任何小写字母字符匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn108_1af241f0b7aef577ae5a16337c7be124"
												class="sentence">[^<span class="parameter">a</span>-<span
												class="parameter">z</span>]</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn109_1f8388964c6e33ef67c98bedf520256f"
												class="sentence">反向字符范围。</span><span
												id="xn110_d380030b11acec4a7e50ccefc1bfeae1" class="sentence">与不在指定范围内的任何字符匹配。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn111_0ab8f99170e941c67c743d2c263560bc"
												class="sentence"><span class="code">[^a-z]</span>
												与不在范围“a”到“z”内的任何字符匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn112_94ac0ed8c3516172593b9cf26b58004d"
												class="sentence">{<span class="parameter">n</span>}</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn113_937e179fa347d75648ab07ea0ba55385"
												class="sentence">正好匹配 <span class="parameter">n</span>
												次。</span><span id="xn114_5d7bbd00ac2931e3e6600c53a40ec5f7"
												class="sentence"><span class="parameter">n </span>是非负整数。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn115_c8648acb12549338811182430c170158"
												class="sentence"><span class="code">o{2}</span>
												与“Bob”中的“o”不匹配，但与“food”中的两个“o”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn116_028df23456bd9746fd738d5b85d57f3a"
												class="sentence">{<span class="parameter">n</span>,}</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn117_617e684a8cf55abe031d2ae54456f7e1"
												class="sentence">至少匹配 <span class="parameter">n
											</span>次。</span><span id="xn118_5d7bbd00ac2931e3e6600c53a40ec5f7"
												class="sentence"><span class="parameter">n </span>是非负整数。</span>
										</p>
										<p>
											<span id="xn119_51a72e726a67c49b5c782b3f98ae4906"
												class="sentence"><span class="code">*</span> 与 <span
												class="code">{0,}</span> 相等。</span>
										</p>
										<p>
											<span id="xn120_0806b68d054f80d84d05bd2075f73452"
												class="sentence"><span class="code">+</span> 与 <span
												class="code">{1,}</span> 相等。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn121_df60a87520337cbe1c9cc2b0e7b0f136"
												class="sentence"><span class="code">o{2,}</span>
												与“Bob”中的“o”不匹配，但与“foooood”中的所有“o”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn122_0057ef73ac62aa12b3d60f01a02967c8"
												class="sentence">{<span class="parameter">n</span>,<span
												class="parameter">m</span>}</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn123_1f9acb0d32e7bf647f50c34981f9e4a8"
												class="sentence">匹配至少 <span class="parameter">n</span>
												次，至多 <span class="parameter">m</span> 次。</span><span
												id="xn124_984fa81b94da439b114a904386d080d8" class="sentence"><span
												class="parameter">n</span> 和 <span class="parameter">m</span>
												是非负整数，其中 <span class="parameter">n</span> &lt;= <span
												class="parameter">m</span>。</span><span
												id="xn125_84a28fa0f971e485cfd635a2179d3ec1" class="sentence">逗号和数字之间不能有空格。</span>
										</p>
										<p>
											<span id="xn126_6f7d26a897156eb9377d3585bc1e6eb5"
												class="sentence"><span class="code">?</span> 与 <span
												class="code">{0,1}</span> 相等。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn127_808e06d639368a843357f9dbc8c09319"
												class="sentence">在搜索字符串“1234567”中，<span class="code">\d{1,3}</span>
												与“123”、“456”和“7”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn128_76f56211fede86888dd8f4847971cf05"
												class="sentence">(<span class="parameter">模式</span>)</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn129_7e0f5b9378918d6c933c8829f230ef74"
												class="sentence">与<span class="parameter">模式</span>
												匹配并保存匹配项。</span><span id="xn130_a66a5ee1a792af9a6896b6467fd7e78b"
												class="sentence">您可以从由 JScript 中的 <span><span
													class="input">exec Method</span> </span>返回的数组元素中检索保存的匹配项。</span><span
												id="xn131_07d225d1be5718a52a86a7b1b1a2b12f" class="sentence">若要匹配括号字符
												( )，请使用“\(”或者“\)”。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn132_ba4f035d8bebc7618b6c1019f50c90f8"
												class="sentence"><span class="code">(Chapter|Section)
													[1-9]</span> 与“Chapter 5”匹配，保存“Chapter”以备将来之用。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn133_f37529d9086c846a79e36c65637afdd3"
												class="sentence">(?:<span class="parameter">模式</span>)</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn134_4beeee96d9fc8fec810dae38acb3dd8a"
												class="sentence">与<span class="parameter">模式</span>
												匹配，但不保存匹配项；即不会存储匹配项以备将来之用。</span><span
												id="xn135_259f2e7c12a352775085ad0c78517d98" class="sentence">这对于用“or”字符
												(|) 组合模式部件的情况很有用。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn136_1660f52614dffce0dbfdecce1a31a658"
												class="sentence"><span class="code">industr(?:y|ies)</span>
												与 <span class="code">industry|industries</span> 相等。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn137_20682059cc3b1db31c7eb397b7c79b96"
												class="sentence">(?=<span class="parameter">模式</span>)</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn138_0acaf2343c45033753e6a7adc4a6eb19"
												class="sentence">积极的预测先行。</span><span
												id="xn139_d0dc157da71ee35904a85be2d2c45c6e" class="sentence">找到一个匹配项后，将在匹配文本之前开始搜索下一个匹配项。</span><span
												id="xn140_509ddd743bbe499612f19d9ee42cdd51" class="sentence">不会保存匹配项以备将来之用。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn141_ba362f0e5ce018223dd29b5cbcfac70e"
												class="sentence"><span class="code">^(?=.*\d).{4,8}$</span>
												对密码应用以下限制：其长度必须介于 4 到 8 个字符之间，并且必须至少包含一个数字。</span>
										</p>
										<p>
											<span id="xn142_3edc54abb7afbff732801c538e3f0664"
												class="sentence">在该模式中，<span class="code">.*\d</span>
												查找后跟有数字的任意多个字符。</span><span
												id="xn143_7172d6d2931d8057289699c2c6713b38" class="sentence">对于搜索字符串“abc3qr”，这与“abc3”匹配。</span>
										</p>
										<p>
											<span id="xn144_82c2515d29999f46b237b2b4365efee2"
												class="sentence">从该匹配项之前（而不是之后）开始，<span class="code">.{4,8}</span>
												与包含 4-8 个字符的字符串匹配。</span><span
												id="xn145_9ea5d9899d952998118ad7d59e490473" class="sentence">这与“abc3qr”匹配。</span>
										</p>
										<p>
											<span id="xn146_bb88f09c32a0d955ad0e6682031862ef"
												class="sentence"><span class="code">^</span> 和 <span
												class="code">$</span> 指定搜索字符串的开始和结束位置。</span><span
												id="xn147_3b42ad566d7d42a1e63a32d81f8c31f0" class="sentence">这将在搜索字符串包含匹配字符之外的任何字符时阻止匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn148_cf2903b3b6031d0621540ccecefbbe20"
												class="sentence">(?!<span class="parameter">模式</span>)</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn149_d24d1fcabc5e335e66153a4e04eb3b81"
												class="sentence">消极的预测先行。</span><span
												id="xn150_7b8fdcb665664bb512844af6b0597c0b" class="sentence">匹配与<span
												class="parameter">模式</span> 不匹配的搜索字符串。</span><span
												id="xn151_d0dc157da71ee35904a85be2d2c45c6e" class="sentence">找到一个匹配项后，将在匹配文本之前开始搜索下一个匹配项。</span><span
												id="xn152_509ddd743bbe499612f19d9ee42cdd51" class="sentence">不会保存匹配项以备将来之用。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn153_e38797b1f64c5d883e9f4be6adf0107a"
												class="sentence"><span class="code">\b(?!th)\w+\b</span>
												与不以“th”开头的单词匹配。</span>
										</p>
										<p>
											<span id="xn154_ffabbaa592882e6e9a91af9184997376"
												class="sentence">在该模式中，<span class="code">\b</span>
												与一个字边界匹配。</span><span id="xn155_94db612ff59b4c1e71c2fd8b939efcdb"
												class="sentence">对于搜索字符串“ quick ”，这与第一个空格匹配。</span><span
												id="xn156_85c6d238094d2bfff33b53e2e3f744b6" class="sentence"><span
												class="code">(?!th)</span> 与非“th”字符串匹配。</span><span
												id="xn157_1f0b9ebc8de82a51e028fd23f4874e9b" class="sentence">这与“qu”匹配。</span>
										</p>
										<p>
											<span id="xn158_193117b3d26c17640bb7656bdc13b4e1"
												class="sentence">从该匹配项开始，<span class="code">\w+</span>
												与一个字匹配。</span><span id="xn159_4d36ed2804c76728159302c5cf4b90e6"
												class="sentence">这与“quick”匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn160_837892ba743e661ea93ff557832a1042"
												class="sentence">\c<span class="parameter">x</span> </span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn161_ec6a2713d0028561e20c632fe8b4d450"
												class="sentence">匹配 <span class="parameter">x</span>
												指示的控制字符。</span><span id="xn162_428776d903b4bb98078d7383978b3b90"
												class="sentence"><span class="parameter">x</span>
												的值必须在 A-Z 或 a-z 范围内。</span><span
												id="xn163_fc53e320a841d9d7467b6a70098a31cf" class="sentence">如果不是这样，则假定
												c 就是文本“c”字符本身。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn164_2b4cc0cb948a6f24f5ada8b6fb1d1bc0"
												class="sentence"><span class="code">\cM</span> 与
												Ctrl+M 或一个回车符匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn165_c21b95ee398bd4fb0b9a0d2e55c2a861"
												class="sentence">\x<span class="parameter">n</span> </span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn166_dea552e3639f55aee76d1be10f56ba54"
												class="sentence">匹配 <span class="parameter">n</span>，此处的
												<span class="parameter">n</span> 是一个十六进制转义码。</span><span
												id="xn167_e428c2b1a31a7e84d96242804b83087a" class="sentence">十六进制转义码必须正好是两位数长。</span><span
												id="xn168_c7857d00b13de5e05edba38c70ce1326" class="sentence">允许在正则表达式中使用
												ASCII 代码。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn169_9ef730c18a24df2ff90214553bf3bbde"
												class="sentence"><span class="code">\x41</span>
												与“A”匹配。</span><span id="xn170_96f984e4a11670659349cc1fde8aaa2e"
												class="sentence"><span class="code">\x041</span>
												等效于后跟有“1”的“\x04”（因为 <span class="parameter">n</span>
												必须正好是两位数）。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn171_0b83729fe7117423513ffb3af6463edf"
												class="sentence">\<span class="parameter">num</span>
											</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn172_33c27ee059a76018c7429fad9627c82e"
												class="sentence">匹配 <span class="parameter">num</span>，此处的
												<span class="parameter">num</span> 是一个正整数。</span><span
												id="xn173_053f7970aa9a044ebc42b2c7114729b6" class="sentence">这是对已保存的匹配项的引用。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn174_23eba687c582098c5ba5a64df908553c"
												class="sentence"><span class="code">(.)\1</span>
												与两个连续的相同字符匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn175_a46e9478011538cbe89959d35960bce7"
												class="sentence">\<span class="parameter">n</span> </span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn176_d45f388ede6b743d8a4dce79dd5a6565"
												class="sentence">标识一个八进制转义码或反向引用。</span><span
												id="xn177_837c973107c2bd3aebf91d9b1e8de88c" class="sentence">如果
												\<span class="parameter">n</span> 前面至少有 <span
												class="parameter">n</span> 个捕获子表达式，那么 <span
												class="parameter">n</span> 是反向引用。</span><span
												id="xn178_409f3740cbda8aaaedcc5dafd426f10b" class="sentence">否则，如果
												<span class="parameter">n</span> 是八进制数 (0-7)，那么 <span
												class="parameter">n</span> 是八进制转义码。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn179_21de78e297704a92ccaf3fc11463459a"
												class="sentence"><span class="code">(\d)\1</span>
												与两个连续的相同数字匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn180_1025c482287560f30b62a0b03ca7da3c"
												class="sentence">\<span class="parameter">nm</span> </span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn181_d45f388ede6b743d8a4dce79dd5a6565"
												class="sentence">标识一个八进制转义码或反向引用。</span><span
												id="xn182_7aac2fb224daf66d82ad3c6ddc90db98" class="sentence">如果
												\<span class="parameter">nm</span> 前面至少有 <span
												class="parameter">nm</span> 个捕获子表达式，那么 <span
												class="parameter">nm</span> 是反向引用。</span><span
												id="xn183_fb66bee35ab3b34061fb15be2d4f5684" class="sentence">如果
												\<span class="parameter">nm</span> 前面至少有 <span
												class="parameter">n</span> 个捕获子表达式，则 <span class="parameter">n</span>
												是反向引用，后面跟有文本 <span class="parameter">m</span>。</span><span
												id="xn184_29d109f5c1602b04521bab8b00a6067f" class="sentence">如果上述情况都不存在，当
												<span class="parameter">n</span> 和 <span class="parameter">m</span>
												是八进制数字 (0-7) 时，\<span class="parameter">nm</span> 匹配八进制转义码 <span
												class="parameter">nm</span>。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn185_ad6c952ff08d30d92ef79caa6faa0352"
												class="sentence"><span class="code">\11</span>
												与制表符匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn186_8fe9a51a0c83cde4984d1c250fa2c6f9"
												class="sentence">\<span class="parameter">nml</span>
											</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn187_308bbd2ce96eeb1721b0e47888c0f9b9"
												class="sentence">当 <span class="parameter">n</span>
												是八进制数字 (0-3)，<span class="parameter">m</span> 和 <span
												class="parameter">l</span> 是八进制数字 (0-7) 时，匹配八进制转义码 <span
												class="parameter">nml</span>。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn188_7611aa4788e98d45a388a65482b2c45b"
												class="sentence"><span class="code">\011</span>
												与制表符匹配。</span>
										</p>
									</td>
								</tr>
								<tr>
									<td>
										<p>
											<span id="xn189_d20ce687cd149545facc8aa6974dce12"
												class="sentence">\u<span class="parameter">n</span> </span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn190_84f7e608a84044ecb927111892a53362"
												class="sentence">匹配 <span class="parameter">n</span>，其中
												<span class="parameter">n</span> 是以四位十六进制数表示的 Unicode 字符。</span>
										</p>
									</td>
									<td>
										<p>
											<span id="xn191_16f5f4d97c3bd1e253c918dae3a25fb9"
												class="sentence"><span class="code">\u00A9</span>
												与版权符号 (©) 匹配。</span>
										</p>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<c:if test="${pageset.pageType==1}">
					<!--新增-->
				</c:if>
				<c:if test="${pageset.pageType==2}">
					<!--修改-->
				</c:if>
				<c:if test="${pageset.pageType==0}">
					<!--浏览-->
				</c:if>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false">
		<div class="div_button" style="text-align: center; padding: 4px;">
			<c:if test="${pageset.pageType==1}">
				<a id="dom_add_entityfarmwormurlfilter" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">增加</a>
			</c:if>
			<c:if test="${pageset.pageType==2}">
				<a id="dom_edit_entityfarmwormurlfilter" href="javascript:void(0)"
					iconCls="icon-save" class="easyui-linkbutton">修改</a>
			</c:if>
			<a id="dom_cancle_formfarmwormurlfilter" href="javascript:void(0)"
				iconCls="icon-cancel" class="easyui-linkbutton"
				style="color: #000000;">取消</a>
		</div>
	</div>
</div>
<script type="text/javascript">
	var submitAddActionfarmwormurlfilter = 'admin/FarmWormUrlfilteraddCommit.do';
	var submitEditActionfarmwormurlfilter = 'admin/FarmWormUrlfiltereditCommit.do';
	var currentPageTypefarmwormurlfilter = '${pageset.pageType}';
	var submitFormfarmwormurlfilter;
	$(function() {
		//表单组件对象
		submitFormfarmwormurlfilter = $('#dom_formfarmwormurlfilter')
				.SubmitForm( {
					pageType : currentPageTypefarmwormurlfilter,
					grid : gridfarmwormurlfilter,
					currentWindowId : 'winfarmwormurlfilter'
				});
		//关闭窗口
		$('#dom_cancle_formfarmwormurlfilter').bind('click', function() {
			$('#winfarmwormurlfilter').window('close');
		});
		//提交新增数据
		$('#dom_add_entityfarmwormurlfilter').bind(
				'click',
				function() {
					submitFormfarmwormurlfilter
							.postSubmit(submitAddActionfarmwormurlfilter);
				});
		//提交修改数据
		$('#dom_edit_entityfarmwormurlfilter').bind(
				'click',
				function() {
					submitFormfarmwormurlfilter
							.postSubmit(submitEditActionfarmwormurlfilter);
				});
	});
	//-->
</script>