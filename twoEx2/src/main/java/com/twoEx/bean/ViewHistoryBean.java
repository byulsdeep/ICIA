package com.twoEx.bean;


import lombok.Data;

@Data
public class ViewHistoryBean {
	private String vhsBuyCode;
	private String vhsDate;
	private String vhsPrdCode;
	private String vhsPrdSelCode;
	private String vhsPrdCteCode;
	private String vhsWishAction;

	/* 추가 */
	private String message; //로그인 하라는 메세지 전달용
}
