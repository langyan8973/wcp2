package com.farm.wcp.know.common;

import org.apache.lucene.document.Field.Index;
import org.apache.lucene.document.Field.Store;

import com.farm.doc.domain.FarmDoc;
import com.farm.doc.domain.FarmDoctype;
import com.farm.doc.server.commons.FarmDocFiles;
import com.farm.lucene.adapter.DocMap;

/**
 * 生成全文检索时辅助生成索引元数据对象
 * 
 * @author Administrator
 * 
 */
public class LuceneDocUtil {
	public static DocMap getDocMap(FarmDoc doc) {
		String text = "";
		if(doc.getTexts()!=null){
			text=doc.getTexts().getText1();
		}
		text = FarmDocFiles.HtmlRemoveTag(text);
		DocMap map = new DocMap(doc.getId());
		String typeAll = "";
		// 拼接所有上级分类用于索引
		if (doc.getCurrenttypes() != null) {
			for (FarmDoctype node : doc.getCurrenttypes()) {
				if (typeAll.equals("")) {
					typeAll = node.getName();
				} else {
					typeAll = typeAll + "/" + node.getName();
				}
			}
		}
		map.put("TYPENAME", typeAll, Store.YES, Index.ANALYZED);
		map.put("TAGKEY", doc.getTagkey(), Store.YES, Index.ANALYZED);
		map.put("TITLE", doc.getTitle(), Store.YES, Index.ANALYZED);
		map.put("AUTHOR", doc.getAuthor(), Store.YES, Index.ANALYZED);
		map.put("DOCDESCRIBE", doc.getDocdescribe(), Store.YES, Index.ANALYZED);
		map.put("VISITNUM", "0", Store.YES, Index.ANALYZED);
		map.put("PUBTIME", doc.getPubtime(), Store.YES, Index.ANALYZED);
		map.put("USERID", doc.getCuser(), Store.YES, Index.ANALYZED);
		map.put("DOMTYPE", doc.getDomtype(), Store.YES, Index.ANALYZED);
		map.put("TEXT", text, Store.YES, Index.ANALYZED);
		return map;
	}
}
