package com.twoEx.bean;

import java.util.List;


import lombok.Data;

@Data
public class OrdersBean {
	private String buyCode;
	private String Date;
	private List<ProductBean> productBean;
}
