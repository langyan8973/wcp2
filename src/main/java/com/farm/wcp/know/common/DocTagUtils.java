package com.farm.wcp.know.common;

import java.util.List;

import com.farm.doc.server.commons.FarmDocFiles;
import com.farm.lucene.face.WordAnalyzerFace;

public class DocTagUtils {
	public static String getTags(String text) {
		String tag = "";
		List<Object[]> taglist = WordAnalyzerFace
				.parseHtmlWordCaseForSortList(FarmDocFiles.HtmlRemoveTag(text));
		for (Object[] Object : taglist.size() > 10 ? taglist.subList(0, 10)
				: taglist) {
			if (tag != null) {
				tag = tag + ",";
			}
			tag = tag + Object[0];
		}
		return tag;
	}
}
