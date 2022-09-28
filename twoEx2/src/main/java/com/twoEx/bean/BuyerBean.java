package com.twoEx.bean;

import lombok.Data;

@Data
public class BuyerBean {
	private String buyCode;
	private String buyEmail;
	private String buyAge;
	private String buyGender;
	private String buyRegion;
	private String buyNickname;
	private String buyProfile;
	private String userType;
	private String message; // 로그인 후 메인페이지 이동시 세션 확인용 메세지 
}
