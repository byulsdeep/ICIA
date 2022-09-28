package com.twoEx.bean;

import java.util.List;

import lombok.Data;

@Data
public class SellerBean {
	/* SELLER 테이블 컬럼 */
		private String selCode;
		private String selEmail;
		private String selNickname;
		private String selProfile;
		private String selShopName;
		private String selPassword;
	/* 추가 필드 */
		private String userType;
		private List<ProductBean> productBean;
	//특정기간 상품 구매 일정 출력(추가)
		private String ordFromDate;
		private String ordToDate;
}
