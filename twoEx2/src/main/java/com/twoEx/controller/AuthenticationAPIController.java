package com.twoEx.controller;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.twoEx.bean.SellerBean;
import com.twoEx.utils.ProjectUtils;

@RestController
public class AuthenticationAPIController {

	@Autowired
	private ProjectUtils pu;
	@Autowired
	private SqlSessionTemplate session;

	@RequestMapping(value = "/isSession", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String isSession (Model model) {
		System.out.println("isSession");
		String accessInfo = null;
		try {
			System.out.println("accessInfo: " + pu.getAttribute("accessInfo"));
			accessInfo = (String)pu.getAttribute("accessInfo");
		} catch (Exception e) {e.printStackTrace();
		}
		return accessInfo;
	}	
	
	@PostMapping("/checkSelCode")
	public String checkSelCode (Model model, @ModelAttribute SellerBean sb) {
		String selCode = "bad";
		
		if(!convertToBool(session.selectOne("checkSelCode", sb))) {
			selCode = "good";
		}
		return selCode;
	}
	
	private boolean convertToBool(int result) {
		return result >= 1 ? true : false;
	}
}

