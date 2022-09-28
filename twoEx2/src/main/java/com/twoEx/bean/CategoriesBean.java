package com.twoEx.bean;

import lombok.Data;

@Data
public class CategoriesBean {
	private String cteCode;
	private String cteName;
	private String cteSymbol;
	
	
	/* 추가 index */
	private String keyword;
	private int totalNum;
	private int numInPage;
	private int totalPage;
	private int currentPage;
	private int startPage;
	private int endPage;
	
	/* DB 넘기는 상품 rownum 데이터 */
	private int numStart;
	private int numEnd;
}
