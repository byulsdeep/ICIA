package com.twoEx.bean;

import java.util.List;

import lombok.Data;

@Data
public class ProductBean {
	private String prdCteCode;
	private String prdSelCode;
	private String prdCode;
	private String prdName;
	private String prdInfo;
	private String prdType;
	private String prdStartDate;
	private String prdEndDate;
	private String prdPrice;

	//카테고리 네임
	private String cteName;
	
	//0914 추가
	private String selShopName;
	private String selNickname;
	
	private List<SellerCategoriesBean>  categories;
	private String prfLocation;
	
	// 0916 추가, 상품별 주문 갯수
	private String rankNum;
	private String countNum;
	
	// 0917 파일등록
	private String prfCode;
	private String prfName;
	
	
}
