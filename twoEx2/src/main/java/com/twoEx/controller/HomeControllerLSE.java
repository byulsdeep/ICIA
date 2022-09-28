/*
 * package com.twoEx.controller;
 * 
 * import java.util.Locale; import org.springframework.stereotype.Controller;
 * import org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod;
 * 
 * @Controller public class HomeControllerLSE {
 * 
 * @RequestMapping(value = "/", method = RequestMethod.GET) public String
 * home(Locale locale, Model model) {
 * 
 * 
 * return "home"; }
 * 
 * }
 */


package com.twoEx.controller;


import java.io.IOException;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.twoEx.bean.BuyerAccessLogBean;
import com.twoEx.bean.BuyerBean;
import com.twoEx.bean.CategoriesBean;
import com.twoEx.bean.ProductBean;
import com.twoEx.bean.SellerBean;
import com.twoEx.service.SellerAuthentication;
import com.twoEx.service.KakaoAuthentication;
import com.twoEx.service.ProductView;
import com.twoEx.utils.ProjectUtils;


@Controller
public class HomeControllerLSE {
	@Autowired
	private SqlSessionTemplate session;
	@Autowired
	private ProjectUtils pu;
	
	@Autowired
	private KakaoAuthentication kakaoService;
	@Autowired
	private SellerAuthentication auth;
	@Autowired
	private ProductView pv;


	@RequestMapping(value="/moveCategory", method = RequestMethod.POST)
	public ModelAndView moveCategory(ModelAndView mav, @ModelAttribute CategoriesBean cteb) {
		System.out.println("[출력] Home-moveCategory");
		System.out.println("Home 카테고리 코드 :  " + cteb.getCteCode());
		mav.addObject(cteb);
		this.pv.backController("moveCategory", mav);
		return mav;
	}
	
	
	@RequestMapping(value="/moveProductInfo", method = RequestMethod.POST)
	public ModelAndView moveProductInfo(ModelAndView mav, @ModelAttribute ProductBean pb) {
		System.out.println("[출력] Home-moveProductInfo");
		System.out.println("Home 상품 코드 :  " + pb.getPrdCode());
		mav.addObject(pb);
		this.pv.backController("moveProductInfo", mav);
		return mav;
	}
	
	@PostMapping("/searchProduct")
	public ModelAndView searchProduct(ModelAndView mav, @ModelAttribute CategoriesBean cteb) {
		System.out.println("[출력] Home-searchProduct");
		
		System.out.println("검색어 :  " + cteb.getKeyword());
		mav.addObject(cteb);
		this.pv.backController("searchProduct", mav);
		return mav;
	}
	
	@PostMapping("/moveSellerShop")
	public ModelAndView moveSellerShop(ModelAndView mav, @ModelAttribute SellerBean sb, @ModelAttribute CategoriesBean cteb) {
		System.out.println("[출력] Home- moveSellerShop");
		System.out.println("셀러코드 :  " + sb.getSelCode());
		//System.out.println("셀러코드 :  " + cteb.getCurrentPage());
		mav.addObject(sb);
		mav.addObject(cteb);
		this.pv.backController("moveSellerShop", mav);
		return mav;
	}
	
}

