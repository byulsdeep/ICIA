package com.twoEx.controller;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.bind.annotation.RequestMethod; 
import org.springframework.web.bind.annotation.RestController;

import com.twoEx.bean.OrderBean;
import com.twoEx.bean.SalesHistoryBean;
import com.twoEx.bean.SellerBean;
import com.twoEx.service.ProductManagement;


@RestController public class APIControllerKYC {
	@Autowired
	private ProductManagement pm;
	@RequestMapping(value = "/getJanMonthsDate", method = RequestMethod.POST) 
		public List<SalesHistoryBean> getJanMonthsDate(Model model,@ModelAttribute SellerBean sb) {
			model.addAttribute(sb);
			this.pm.backController("getJanMonthsDate", model);

		return (List<SalesHistoryBean>)model.getAttribute("getJanMonthsSalesList");
	}

	@RequestMapping(value = "/getMarMonthsDate", method = RequestMethod.POST) 
	public List<SalesHistoryBean> getMarMonthsDate(Model model,@ModelAttribute SellerBean sb) {
		model.addAttribute(sb);
		this.pm.backController("getMarMonthsDate", model);

	return (List<SalesHistoryBean>)model.getAttribute("getMarMonthsSalesList");
	}
	
	@RequestMapping(value = "/getJunMonthsDate", method = RequestMethod.POST) 
	public List<SalesHistoryBean> getJunMonthsDate(Model model,@ModelAttribute SellerBean sb) {
		model.addAttribute(sb);
		this.pm.backController("getJunMonthsDate", model);

	return (List<SalesHistoryBean>)model.getAttribute("getJunMonthsSalesList");
	}
	@RequestMapping(value = "/getSalesHistory", method = RequestMethod.POST) 
	public List<SalesHistoryBean> getSalesHistory(Model model,@ModelAttribute SellerBean sb) {
		model.addAttribute(sb);
		System.out.println(sb.getOrdFromDate());
		this.pm.backController("getSalesHistory", model);
	return (List<SalesHistoryBean>)model.getAttribute("getSalesHistoryList");
	}

}
 