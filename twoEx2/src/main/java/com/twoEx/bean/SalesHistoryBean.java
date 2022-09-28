package com.twoEx.bean;

import lombok.Data;

@Data
public class SalesHistoryBean {
	//판매한 상품 리스트 조회 빈
	private String ordBuyCode;
	private String ordDate;
	private String ordPrdSelCode;
	private String prdName;
	private String prdPrice;
	private String prfLocation;
	private String prfFilName;
	private String ordPrdCteCode;
	private String ordPrdCode;
}
