package com.twoEx.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.twoEx.bean.OrderBean;
import com.twoEx.bean.ProductBean;
import com.twoEx.bean.SellerBean;
import com.twoEx.service.ProductManagement;

@Controller public class HomeControllerKYC {
	@Autowired
	private ProductManagement pm;
	
	@RequestMapping(value = "/moveSalesHistory", method = RequestMethod.POST) 
		public ModelAndView moveSalesHistory(ModelAndView mav, @ModelAttribute OrderBean ob, @ModelAttribute ProductBean prd) {
			mav.addObject(ob);
			mav.addObject(prd);
			System.out.println(ob);
			this.pm.backController("moveSalesHistory", mav);

		return mav; 
 	}
	
	@RequestMapping(value = "/moveStatistics", method = RequestMethod.POST) 
	public ModelAndView moveStatistics(ModelAndView mav,@ModelAttribute ProductBean pb) {
		mav.addObject(pb);
		this.pm.backController("moveStatistics", mav);

	return mav; 
	}
	
	
	@RequestMapping(value = "/getMaketStatistics", method = RequestMethod.POST) 
	public ModelAndView getMaketStatistics(ModelAndView mav,@ModelAttribute ProductBean pb) {
		mav.addObject(pb);
		this.pm.backController("getMaketStatistics", mav);

	return mav; 
	}

 }
 