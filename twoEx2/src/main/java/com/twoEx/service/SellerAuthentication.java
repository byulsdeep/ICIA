package com.twoEx.service;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.twoEx.bean.SellerAccessLogBean;
import com.twoEx.bean.SellerBean;
import com.twoEx.inter.ServicesRule;
import com.twoEx.utils.Encryption;
import com.twoEx.utils.ProjectUtils;

@Service
public class SellerAuthentication implements ServicesRule {
	@Autowired
	private SqlSessionTemplate session;
	@Autowired
	private Encryption enc;
	@Autowired 
	private ProjectUtils pu;

	public void backController(String serviceCode, ModelAndView mav) {
		System.out.println("Authentication/backController");
		switch(serviceCode) {
		case "moveSelectJoin":
			this.moveSelectJoin(mav);
			break;
		case "moveSellerJoin":
			this.moveSellerJoin(mav);
			break;	
		case "insertSeller":
			this.insertSeller(mav);
			break;	
		case "sellerLogIn":
			this.sellerLogIn(mav);
			break;	
		case "sellerLogOut":
			this.sellerLogOut(mav);
			break;		
		}
	}

	public void backController(String serviceCode, Model model) {}

	private void sellerLogOut(ModelAndView mav) {
		mav.setViewName("mainPage");
		//새로고침제어
		if(isSession()) {
			SellerAccessLogBean sal = new SellerAccessLogBean();
			String accessInfo = null;
			try {
				accessInfo = (String)pu.getAttribute("accessInfo");
				pu.removeAttribute("accessInfo");
				sal.setSalAction(-1);
				
				JsonParser parser = new JsonParser();
				JsonElement bean = parser.parse(accessInfo);
				String selCode = bean.getAsJsonObject().get("selCode").getAsString();
				sal.setSalSelCode(selCode);
				this.session.insert("insSellerAccessLog", sal);	
			} catch (Exception e) {e.printStackTrace();}
		}
	}

	private void sellerLogIn(ModelAndView mav) {
		mav.setViewName("mainPage");
		//새로고침 제어
		if(!isSession()){
			SellerBean sb = (SellerBean)mav.getModel().get("sellerBean");		
			if(convertToBool(this.session.selectOne("isSeller", sb))) {
				String password = this.session.selectOne("getSellerEncodedPassword", sb);
				if(enc.matches(sb.getSelPassword(), password)) {
					SellerAccessLogBean sal = new SellerAccessLogBean();
					sal.setSalSelCode(sb.getSelCode());
					try {
						if(convertToBool(this.session.selectOne("isSellerAccess", sal))) {
							//강제로그아웃
							sal.setSalAction(-1);
							if(convertToBool(this.session.insert("insSellerAccessLog", sal))) {
								System.out.println("force logout insert success");
							}
						}
					} catch (Exception e) {e.printStackTrace();}

					sal.setSalAction(1);
					if(convertToBool(session.insert("insSellerAccessLog", sal))) {
						SellerBean se = (SellerBean) session.selectList("getSellerAccessInfo", sb).get(0);
						try {
							se.setSelNickname(enc.aesDecode(se.getSelNickname(), se.getSelCode()));
							se.setSelProfile(enc.aesDecode(se.getSelProfile(), se.getSelCode()));
							se.setSelEmail(enc.aesDecode(se.getSelEmail(), se.getSelCode()));
							se.setSelShopName(enc.aesDecode(se.getSelShopName(), se.getSelCode()));

						} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
								| NoSuchPaddingException | InvalidAlgorithmParameterException
								| IllegalBlockSizeException | BadPaddingException e1) {e1.printStackTrace();}
						se.setUserType("seller");
						String accessInfo = new Gson().toJson(se);
						try {
							pu.setAttribute("accessInfo", accessInfo);
						} catch (Exception e) {e.printStackTrace();}
					}
				}
			}
		}
	}

	private void insertSeller(ModelAndView mav) {
		SellerBean sb = (SellerBean)mav.getModel().get("sellerBean");
		if(!isSession()) {
			//암호화; selCode 사용
			sb.setSelPassword(enc.encode(sb.getSelPassword()));
			try {
				sb.setSelNickname(enc.aesEncode(sb.getSelNickname(), sb.getSelCode()));
				sb.setSelProfile(enc.aesEncode(sb.getSelProfile(), sb.getSelCode()));
				sb.setSelEmail(enc.aesEncode(sb.getSelEmail(), sb.getSelCode()));
				sb.setSelShopName(enc.aesEncode(sb.getSelShopName(), sb.getSelCode()));
			} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException | NoSuchPaddingException
					| InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException e) {e.printStackTrace();}
			this.session.insert("insSeller", sb);
		}
		mav.setViewName("mainPage");
	}

	private void moveSellerJoin(ModelAndView mav) {	
		mav.setViewName("sellerJoin");		
	}

	private void moveSelectJoin(ModelAndView mav) {	
		mav.setViewName("selectJoin");
	}

	private boolean convertToBool(int result) {
		return result >= 1 ? true : false;
	}

	boolean isSession() {
		boolean isSession = false;
		try {
			isSession = (this.pu.getAttribute("accessInfo")) != null ? true : false;		
		} catch (Exception e) {e.printStackTrace();}
		return isSession;
	}
}
