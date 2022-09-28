package com.twoEx.inter;

import java.util.List;

import com.twoEx.bean.CategoriesBean;
import com.twoEx.bean.FollowBean;
import com.twoEx.bean.ProductBean;
import com.twoEx.bean.ProductFileBean;
import com.twoEx.bean.ViewHistoryBean;

public interface MapperInterfaceLSE {
	public ProductBean getProductListByCategory(CategoriesBean cteb);
	public CategoriesBean getCategories();
	public ProductFileBean getProductFileUrl(ProductBean pb);
	/*public ProductBean getProductInfo(ProductBean pb);*/
	public ProductBean getProductInfo_LSE(ProductBean pb);
	
	public ViewHistoryBean insVHS(ViewHistoryBean vhb);
	public List<ViewHistoryBean> isViewHistory(ViewHistoryBean vhb);
	public List<FollowBean> isFollow(ViewHistoryBean vhb);
	
	/*
	public ProductFileBean getProductFileUrl(ProductBean pb);
	public ProductBean getProductInfo(ProductBean pb);
	*/
}