package com.twoEx.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.twoEx.bean.LocationBean;
import com.twoEx.bean.ProductBean;
import com.twoEx.service.ClassroomManagement;
import com.twoEx.service.ProductManagement;
import com.twoEx.service.Sales;

import java.util.List;
import java.util.Locale; import org.springframework.ui.Model; 
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.bind.annotation.RequestMethod; 
import org.springframework.web.bind.annotation.RestController;
  
  @RestController public class APIControllerSJH {
  
	  @Autowired
		private Sales sales;
	  @Autowired
		private ClassroomManagement cm;
  

  
  @PostMapping("/addLocation")
 	public List<LocationBean> addLocation (Model model,@ModelAttribute LocationBean prd) {
	  System.out.print(prd.getLocClaPrdCode());
 		model.addAttribute(prd);
 		cm.backController("addLocation",model);
 		return (List<LocationBean>)model.getAttribute("locInfo");
 	}
  
  @PostMapping("/updLocation")
	public List<LocationBean> updLocation (Model model,@ModelAttribute LocationBean prd) {
		model.addAttribute(prd);
		cm.backController("updLocation",model);
		return (List<LocationBean>)model.getAttribute("locInfo");
	}
  @PostMapping("/delLocation")
	public List<LocationBean> delLocation (Model model,@ModelAttribute LocationBean prd) {
		model.addAttribute(prd);
		cm.backController("delLocation",model);
		return (List<LocationBean>)model.getAttribute("locInfo");
	}
  }
 