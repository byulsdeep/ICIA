package com.twoEx.controller;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Locale;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.twoEx.bean.BuyerAccessLogBean;
import com.twoEx.bean.BuyerBean;
import com.twoEx.bean.SellerBean;
import com.twoEx.service.KakaoAuthentication;
import com.twoEx.service.SellerAuthentication;
import com.twoEx.utils.Encryption;
import com.twoEx.utils.ProjectUtils;



@Controller
public class AuthenticationController {
	@Autowired
	private KakaoAuthentication kakaoService;
	@Autowired
	private SqlSessionTemplate session;
	@Autowired
	private ProjectUtils pu;
	@Autowired
	private SellerAuthentication auth;
	@Autowired
	private Encryption enc;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

		System.out.println("on");
		return "mainPage";
	}

	@RequestMapping(value = "/sellerLogOut", method = RequestMethod.POST)
	public ModelAndView sellerLogOut(ModelAndView mav) {
		System.out.println("sellerLogOut");
		this.auth.backController("sellerLogOut", mav);
		return mav;
	}

	@RequestMapping(value = "/sellerLogIn", method = RequestMethod.POST)
	public ModelAndView sellerLogIn(ModelAndView mav, @ModelAttribute SellerBean sb) {
		System.out.println("sellerLogIn");
		mav.addObject(sb);
		this.auth.backController("sellerLogIn", mav);
		return mav;
	}

	@RequestMapping(value = "/insertSeller", method = RequestMethod.POST)
	public ModelAndView insertSeller(ModelAndView mav, @ModelAttribute SellerBean sb) {
		System.out.println("insertSeller");
		mav.addObject(sb);
		this.auth.backController("insertSeller", mav);
		return mav;
	}

	@RequestMapping(value = "/moveSellerJoin", method = RequestMethod.POST)
	public ModelAndView moveSellerJoin(ModelAndView mav) {
		System.out.println("moveSellerJoin");
		this.auth.backController("moveSellerJoin", mav);
		return mav;
	}

	@RequestMapping(value = "/moveSelectJoin", method = RequestMethod.POST)
	public ModelAndView moveSelectJoin(ModelAndView mav) {
		System.out.println("moveSelectJoin");
		this.auth.backController("moveSelectJoin", mav);
		return mav;
	}

	@RequestMapping(value = "/insertKakao", method = RequestMethod.POST)
	public ModelAndView insertKakao(ModelAndView mav, @ModelAttribute BuyerBean bb) {
		System.out.println("insertKakao");
		mav.addObject(bb);
		this.kakaoService.backController("insertKakao", mav);
		return mav;
	}

	@RequestMapping(value="/kakaoLogIn")
	public String kakaoLogin() {
		StringBuffer loginUrl = new StringBuffer();
		loginUrl.append("https://kauth.kakao.com/oauth/authorize?client_id=");
		loginUrl.append("628883e2413da0a633c8d3b53d91b08a"); 
		loginUrl.append("&redirect_uri=");
		loginUrl.append("http://192.168.0.133/kakao_callback");
		/* 자기 키 복사하기 편하게 써두세요 */
		/* https://developers.kakao.com/ */
		/* root-context db 계정도 전환해서 사용하기 */
		/* "http://errorkillers.hoonzzang.com:20000/kakao_callback"
		 * 강한별 http://192.168.0.133/kakao_callback 628883e2413da0a633c8d3b53d91b08a  
		 * 이경준 192.168.0.253 fe5c5e3b0473b8b623da3bc05a6ba479 172.30.1.47
		 * 하진우 192.168.0.9 67e077c6ce4c4c3ed58fc83d3a3a79c4
		 * 곽윤철 192.168.0.165  2f2662c79b2457f82f5e188d75b827ac
		 * 이상은 192.168.1.47 51a9dd8bb7a96129eb36d1848ea0bd73  
		 * 심준호
		 * */
		loginUrl.append("&response_type=code");
		return "redirect:"+loginUrl.toString();
	}

	@Transactional
	@RequestMapping(value = "/kakao_callback", method = RequestMethod.GET)
	public String redirectkakao(@RequestParam String code, HttpSession session) throws IOException {
		//새로고침 제어
		if(!isSession()) {
			System.out.println(code);
			
			//접속토큰 get
			String access_Token = kakaoService.getReturnAccessToken(code);

			//접속자 정보 get
			Map<String,Object> userInfo = kakaoService.getUserInfo(access_Token);
			System.out.println("컨트롤러 출력"+userInfo.get("nickname")+userInfo.get("profile_image"));
			System.out.println("-----------logIn");
			System.out.println(access_Token);
			System.out.println(userInfo.get("id"));

			//빈 준비 
			BuyerBean buy = new BuyerBean();
			BuyerAccessLogBean bal = new BuyerAccessLogBean();
			buy.setBuyCode((String)userInfo.get("id"));
			buy.setBuyNickname((String)userInfo.get("nickname"));
			buy.setBuyProfile((String)userInfo.get("profile_image"));
			buy.setUserType("buyer");
			System.out.println("-------------------------check");


			System.out.println(buy.getBuyCode());
			System.out.println(buy.getBuyNickname());
			System.out.println(buy.getBuyProfile());

			bal.setBuyerAccessLogCode((String)userInfo.get("id"));     		

			//회원유무 조회
			if(this.session.selectOne("isBuyer", buy) != null) {
				System.out.println("isBuyer=true");

				//여기서 페이지 전환 검토. 추가 유저 정보 필요함.
				/*
				 * 1. jsp 준비
				 * 2. 세션에 미리 카카오에서 받은 정보를 담아서 한꺼번에 db에 insert
				 * 
				 */

				//현재접속상태 확인
				try {
					if(convertToBool(this.session.selectOne("isBuyerAccess", bal))) {
						//강제로그아웃
						bal.setBuyerAccessLogAction(-1);
						if(convertToBool(this.session.insert("insBuyerAccessLog", bal))) {
							System.out.println("강제로그 아웃 성공");
						}
					} 
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("noAccessLogFound");
				}

				//접속기록 생성 
				bal.setBuyerAccessLogAction(1);
				if(convertToBool(this.session.insert("insBuyerAccessLog", bal))) {
					System.out.println("로그인 기록 성공");	
					//카카오 정보 업데이트
					try {
						buy.setBuyNickname(enc.aesEncode(buy.getBuyNickname(), buy.getBuyCode()));
						buy.setBuyProfile(enc.aesEncode(buy.getBuyProfile(), buy.getBuyCode()));
					} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
							| NoSuchPaddingException | InvalidAlgorithmParameterException | IllegalBlockSizeException
							| BadPaddingException e1) {e1.printStackTrace();}
					this.session.update("updateBuyerInfo", buy);
					//세션 (앱단) 생성 --> pu
					try {
						BuyerBean bd = (BuyerBean) this.session.selectList("getBuyerAccessInfo", buy).get(0);
						bd.setBuyEmail(enc.aesDecode(bd.getBuyEmail(), bd.getBuyCode()));
						bd.setBuyRegion(enc.aesDecode(bd.getBuyRegion(), bd.getBuyCode()));
						bd.setBuyNickname(enc.aesDecode(bd.getBuyNickname(), bd.getBuyCode()));
						bd.setBuyProfile(enc.aesDecode(bd.getBuyProfile(), bd.getBuyCode()));
						bd.setUserType("buyer");
						String accessInfo = new Gson().toJson(bd);
						pu.setAttribute("accessInfo", accessInfo);
						System.out.println("if: " + pu.getAttribute("accessInfo"));
					} catch (Exception e) {e.printStackTrace();}
				}
			} else {
				try {
					System.out.println("--------------joinkakao----check");

					System.out.println(buy.getBuyCode());
					System.out.println(buy.getBuyNickname());
					System.out.println(buy.getBuyProfile());
					//추가정보 저장 위해 임시 세션 이용
					pu.setAttribute("accessInfo", buy);
					System.out.println("else:" + pu.getAttribute("accessInfo"));

					//추가 정보 기입 페이지 이동
					return "kakaoJoin";

				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			/*------------------------------*/

			if(userInfo.get("nickname") !=null) {
				session.setAttribute("userId", userInfo.get("nickname"));
				session.setAttribute("access_Token", access_Token);
			}
		}

		return "mainPage";
	}
	
	@Transactional
	@RequestMapping(value="/kakaoLogOut")
	public String logout(ModelMap modelMap, HttpSession session)throws IOException {
		//새로고침제어
		if(isSession()) {
			String access_Token = (String)session.getAttribute("access_Token");
			System.out.println("-----------logOut");
			System.out.println(access_Token);
			System.out.println((String)session.getAttribute("id"));
			if(access_Token != null && !"".equals(access_Token)){
				kakaoService.getLogout(access_Token);
				session.removeAttribute("access_Token");
				session.removeAttribute("userId");
			}else {
				System.out.println("이미 로그아웃");
			}

			try {
				String accessInfo = (String)pu.getAttribute("accessInfo");

				BuyerAccessLogBean bal = new BuyerAccessLogBean();
				JsonParser parser = new JsonParser();
				JsonElement bean = parser.parse(accessInfo);
				String buyCode = bean.getAsJsonObject().get("buyCode").getAsString();
				bal.setBuyerAccessLogCode(buyCode);
				bal.setBuyerAccessLogAction(-1);
				if(convertToBool(this.session.insert("insBuyerAccessLog", bal))) {
					System.out.println("kakao logout insert success");
				}
				pu.removeAttribute("accessInfo");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			System.out.println("로그아웃");
		}

		return "mainPage";
		//return "redirect:/";
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