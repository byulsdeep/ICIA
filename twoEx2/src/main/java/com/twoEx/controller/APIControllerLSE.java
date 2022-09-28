/*
 * package com.twoEx.controller;
 * 
 * import java.util.Locale; import org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod; import
 * org.springframework.web.bind.annotation.RestController;
 * 
 * @RestController public class APIControllerLSE {
 * 
 * @RequestMapping(value = "/", method = RequestMethod.GET) public String
 * home(Locale locale, Model model) {
 * 
 * return "home"; }
 * 
 * }
 */


package com.twoEx.controller;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.twoEx.bean.CategoriesBean;
import com.twoEx.bean.FollowBean;
import com.twoEx.bean.ViewHistoryBean;
import com.twoEx.service.ProductView;
import com.twoEx.utils.ProjectUtils;


@RestController
public class APIControllerLSE {

	@Autowired
	private ProjectUtils pu;
	@Autowired
	private SqlSessionTemplate session;

	@Autowired
	private ProductView pv;
	
	/*
	@PostMapping("/checkViewHistory")
	public void checkViewHistory(Model model) {
		System.out.println("API-checkViewHistory 입구");
		this.pv.backController("checkViewHistory", model);
	}
	*/
	
	//RequestMapping(value = "/getMainCategories", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@SuppressWarnings("unchecked")
	@PostMapping("/getMainCategories")
	public List<CategoriesBean> getMainCategory (Model model) {
		System.out.println("API-getMainCategories 입구");
		this.pv.backController("getMainCategories", model);
		
		return (List<CategoriesBean>)model.getAttribute("cteList");
		
	}	
	

	
	
	@PostMapping("/changeWish")
	public List<ViewHistoryBean> changeWish (Model model, @ModelAttribute ViewHistoryBean vhs) {
		System.out.println("API-changeWish 입구");
		this.pv.backController("changeWish", model);
		
		System.out.println("프론트 정보 vhs : " + model.getAttribute("viewHistoryBean"));
		
		return (List<ViewHistoryBean>)model.getAttribute("vhbList_back");
		
	}	
	
	@PostMapping("/changeFollow")
	public FollowBean changeFollow(Model model, @ModelAttribute FollowBean fb) {
		System.out.println("[출력] API-changeFollow 입구");
		this.pv.backController("changeFollow", model);
	
		return (FollowBean)model.getAttribute("followInfo");
	}
	@RequestMapping(value = "/moveIndexPage", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String moveIndexPage(Model model, @ModelAttribute CategoriesBean cb) {
		System.out.println("[출력] API-moveIndexPage 입구");
		this.pv.backController("moveIndexPage", model);
		
		return (String)model.getAttribute("json_pagingAndpbList");
	}
	
	
	@RequestMapping(value = "/moveKeywordPage", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String moveKeywordPage(Model model, @ModelAttribute CategoriesBean cb) {
		System.out.println("[출력] API-moveKeywordPage 입구");
		this.pv.backController("moveKeywordPage", model);
		
		return (String)model.getAttribute("json_pagingAndpbList");
	}
	
	
	@RequestMapping(value = "/getProductListByRank", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String getProductListByRank(Model model){
		System.out.println("[출력] API-getProductListByRank 입구");
		this.pv.backController("getProductListByRank", model);
		
		return (String)model.getAttribute("json_pbList");
	}
	//클래스 끝
}










