
package com.twoEx.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.twoEx.bean.BuyerBean;
import com.twoEx.service.MyPage;

@Controller
public class HomeControllerHJW {
	@Autowired
	private MyPage mypage;

	//경준쿤이랑 moveMyPage 상의하세요
	@PostMapping("/moveAccountInfo")
	public ModelAndView moveAccountInfo (ModelAndView mav) {
		System.out.println("homectl : moveAccountInfo ");
		mypage.backController("moveAccountInfo", mav);
		return mav;
	}	
	
	@PostMapping("/updateEmail")
	public ModelAndView updateEmail (ModelAndView mav, @ModelAttribute BuyerBean buy) {
		System.out.println("updateEmail");
		System.out.println(buy);
		mav.addObject(buy);
		mypage.backController("updateEmail", mav);
		return mav;
	}	
	@PostMapping("/updateRegion")
	public ModelAndView updateRegion (ModelAndView mav, @ModelAttribute BuyerBean buy) {
		System.out.println("updateRegion");
		System.out.println(buy);
		mav.addObject(buy);
		mypage.backController("updateRegion", mav);
		return mav;
	}	
	@PostMapping("/moveOrderHistory")
	public ModelAndView moveOrderHistory (ModelAndView mav) {
		System.out.println("homectl : moveOrderHistory");
		
		mypage.backController("moveOrderHistory", mav);
		return mav;
		
		
	}	
	@PostMapping("/moveViewHistory")
	public ModelAndView moveViewHistory (ModelAndView mav) {
		System.out.println("homectl : moveViewHistory");
		
		mypage.backController("moveViewHistory", mav);
		return mav;
	}
	@PostMapping("/moveMyClass")
	public ModelAndView moveMyClass (ModelAndView mav) {
		System.out.println("homectl : moveMyClass");
		
		mypage.backController("moveMyClass", mav);
		return mav;
	}
	@PostMapping("/moveWishList")
	public ModelAndView moveWishList (ModelAndView mav) {
		System.out.println("homectl : moveWishList");
		
		mypage.backController("moveWishList", mav);
		return mav;
	}
	
	
	
}
