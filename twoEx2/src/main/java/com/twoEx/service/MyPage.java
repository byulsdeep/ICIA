package com.twoEx.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.twoEx.bean.BuyerBean;
import com.twoEx.bean.ClassroomBean;
import com.twoEx.bean.GetMyPageBean;
import com.twoEx.bean.SellerBean;
import com.twoEx.inter.ServicesRule;
import com.twoEx.utils.Encryption;
import com.twoEx.utils.ProjectUtils;

@Service
public class MyPage implements ServicesRule {
	
	@Autowired
	private ProjectUtils pu;
	@Autowired
	private SqlSessionTemplate session;
	@Autowired
	private Encryption enc;


	@Override
	public void backController(String serviceCode, ModelAndView mav) {
		try {
			if(pu.getAttribute("accessInfo") != null) {
				System.out.println("[출력] accessInfo : " + pu.getAttribute("accessInfo"));
				switch(serviceCode) {
				case "moveAccountInfo":
					this.moveAccountInfo(mav);
					break;	
				case "updateEmail" :
					this.updateEmail(mav);
					break;
				case "updateRegion" :
					this.updateRegion(mav);
					break;
				case "moveOrderHistory" :
					this.moveOrderHistory(mav);
					break;
				case "moveViewHistory" :
					this.moveViewHistory(mav);
					break;
				case "moveMyClass" :
					this.moveMyClass(mav);
					break;
				case "moveWishList" :
					this.moveWishList(mav);
					break;
				}
			}else {
				pu.setAttribute("message", "로그인 부터 하시오");
			}
				
	} catch (Exception e) {e.printStackTrace();}
		
	}
	private void moveWishList(ModelAndView mav) {
		
		BuyerBean buy = new BuyerBean();
		String accessInfo = null;
		
		try {
			accessInfo = (String)pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
		    buy.setBuyCode(bean.getAsJsonObject().get("buyCode").getAsString());
		    System.out.println("------------here-------------");
		    System.out.println(accessInfo);
		    System.out.println(bean.getAsJsonObject().get("buyCode").getAsString());
		    System.out.println(buy.getBuyCode());
		    // 찜목록 제이슨 //
	        String json_WishList = new Gson().toJson(this.session.selectList("getWishList", buy));
	        System.out.println("json_WishList : " + json_WishList);
	        mav.addObject("json_WishList", json_WishList);
	        
	        
	        // 팔로우목록 제이슨 //
	        List<SellerBean> follow = this.session.selectList("getFollowList", buy);
	       
	        for(int i = 0; i < follow.size(); i++ ) {
	        	
	        	follow.get(i).setSelNickname(this.enc.aesDecode(follow.get(i).getSelNickname(), follow.get(i).getSelCode()));     
	 	        follow.get(i).setSelShopName(this.enc.aesDecode(follow.get(i).getSelShopName(), follow.get(i).getSelCode()));
	 	       
	        }
	       
	        String json_FollowList = new Gson().toJson(follow);
	        System.out.println("json_FollowList : " + json_FollowList);
	        
	        mav.addObject("json_FollowList", json_FollowList);
		} catch (Exception e) {e.printStackTrace();}
		
		mav.setViewName("wishList");
		
	}
	private void moveMyClass(ModelAndView mav) {
		BuyerBean buy = new BuyerBean();
		String accessInfo = null;
		
		try {
			accessInfo = (String)pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
		    buy.setBuyCode(bean.getAsJsonObject().get("buyCode").getAsString());
		    System.out.println("------------here-------------");
		    System.out.println(accessInfo);
		    System.out.println(bean.getAsJsonObject().get("buyCode").getAsString());
		    System.out.println(buy.getBuyCode());
		    // 마이 클래스 목록 제이슨 //
		    List<ClassroomBean> cb = this.session.selectList("getMoveClassList", buy);
		    
		    for(int i =0; i<cb.size(); i++ ) {
		    	System.out.println("복호화전:"+ cb.get(i).getSelNickName());
		    	 cb.get(i).setSelNickName(this.enc.aesDecode(cb.get(i).getSelNickName(), cb.get(i).getClaSelCode()));
		    	  System.out.println("복호화후:"+ cb.get(i).getSelNickName());
		    }
		    
		    
		   
		  
	        String json_MCList = new Gson().toJson(cb);
	        System.out.println("json_MCList : " + json_MCList);
	        mav.addObject("json_MCList", json_MCList);
		} catch (Exception e) {e.printStackTrace();}
		
		mav.setViewName("myClassList");
		
	}
	private void moveViewHistory(ModelAndView mav) {
		BuyerBean buy = new BuyerBean();
		String accessInfo = null;
		
		try {
			accessInfo = (String)pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
		    buy.setBuyCode(bean.getAsJsonObject().get("buyCode").getAsString());
		    System.out.println("------------here-------------");
		    System.out.println(accessInfo);
		    System.out.println(bean.getAsJsonObject().get("buyCode").getAsString());
		    System.out.println(buy.getBuyCode());
		    // 주문목록 제이슨 //
	        String json_VHList = new Gson().toJson(this.session.selectList("getViewHistoryList", buy));
	        System.out.println("json_VHList : " + json_VHList);
	        mav.addObject("json_VHList", json_VHList);
		} catch (Exception e) {e.printStackTrace();}
		
		
		mav.setViewName("viewHistroyListPage");
		

		
	}
	private void moveOrderHistory(ModelAndView mav) {
		BuyerBean buy = new BuyerBean();
		String accessInfo = null;
		
		try {
			accessInfo = (String)pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
		    buy.setBuyCode(bean.getAsJsonObject().get("buyCode").getAsString());

		    // 주문목록 제이슨 //
	        String json_ordersList = new Gson().toJson(this.session.selectList("getOrderList", buy));
	        System.out.println("json_ordersList : " + json_ordersList);
	        mav.addObject("json_ordersList", json_ordersList);
		} catch (Exception e) {e.printStackTrace();}
		
		mav.setViewName("ordersListPage");	
	}
	private void updateRegion(ModelAndView mav) {
		String accessInfo = null;
		BuyerBean buy = new BuyerBean();
		String message = null;
		
		buy = ((BuyerBean)mav.getModel().get("buyerBean"));
		
		try {
			accessInfo = (String)pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
		    buy.setBuyCode(bean.getAsJsonObject().get("buyCode").getAsString());
		    buy.setBuyRegion(this.enc.aesEncode(buy.getBuyRegion(),buy.getBuyCode()));
		    		
		    		
		    
		    if(this.convertToBool(this.session.update("updRegion", buy))){
		    	System.out.println("성공");
		    	mav.addObject("message", "지역 변경 완료");
		    }else {
		    	mav.addObject("message", "지역 변경 실패했습니다");
		    }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		this.moveAccountInfo(mav);
		
		}
	@Transactional
	private void updateEmail(ModelAndView mav) {
		String accessInfo = null;
		BuyerBean buy = new BuyerBean();
		String message = null;
		
		buy = ((BuyerBean)mav.getModel().get("buyerBean"));
		
		try {
			accessInfo = (String)pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
		    buy.setBuyCode(bean.getAsJsonObject().get("buyCode").getAsString());
		    buy.setBuyEmail(this.enc.aesEncode(buy.getBuyEmail(),buy.getBuyCode()));
		    		
		    		
		    
		    if(this.convertToBool(this.session.update("updEmail", buy))){
		    	System.out.println("성공");
		    	mav.addObject("message", "이메일 변경 성공했습니다");
		    }else {
		    	mav.addObject("message", "이메일 변경 실패했습니다");
		    }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		this.moveAccountInfo(mav);
		
		}
	
	//경준쿤이랑 moveMyPage 상의하세요
	private void moveAccountInfo(ModelAndView mav) {
		String accessInfo = null;
		BuyerBean buy = new BuyerBean();
		BuyerBean dec = new BuyerBean();
		try {
			accessInfo = (String)pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
		   buy.setBuyCode(bean.getAsJsonObject().get("buyCode").getAsString());
		   dec = this.session.selectOne("getBuyerAccessInfo", buy);
		   mav.addObject("buyNickname", this.enc.aesDecode(dec.getBuyNickname(), dec.getBuyCode()));
		   mav.addObject("buyEmail", this.enc.aesDecode(dec.getBuyEmail(), dec.getBuyCode()));
		   mav.addObject("buyRegion", this.enc.aesDecode(dec.getBuyRegion(), dec.getBuyCode()));
		   mav.addObject("buyProFile", this.enc.aesDecode(dec.getBuyProfile(), dec.getBuyCode()));
		   mav.addObject("buyAge", dec.getBuyAge());
		   mav.addObject("buyGender", dec.getBuyGender());
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
	
		
	
		mav.setViewName("myPage");
		
	}

	@Override
	public void backController(String serviceCode, Model model) {
		try {
			if(pu.getAttribute("accessInfo") != null) {
				switch(serviceCode) {
				case "orderList6Months":
					this.orderList6Months(model);
					break;	
				case "orderList3Months":
					this.orderList3Months( model);
					break;	
				case "orderListMonth":
					this.orderListMonth(model);
					break;
				case "orderDate":
					this.orderDate(model);
					break;
				}
			}else {
				pu.setAttribute("message", "로그인 부터 하시오");
			}
				
	} catch (Exception e) {e.printStackTrace();}
		
	}
	private void orderDate(Model model) {
		String accessInfo = null;
		GetMyPageBean gpb =  (GetMyPageBean)model.getAttribute("getMyPageBean");
		try {
			accessInfo = (String)pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
		    gpb.setBuyCode(bean.getAsJsonObject().get("buyCode").getAsString());

		    // 검색목록 제이슨 //
	     
	        System.out.println("json_orderDate : " + this.session.selectList("getOrderDate", gpb));
	        model.addAttribute("json_orderDate", this.session.selectList("getOrderDate", gpb));
		} catch (Exception e) {e.printStackTrace();}

	}
		
	
	private void orderListMonth( Model model) {
		BuyerBean buy = new BuyerBean();
		String accessInfo = null;
		
		try {
			accessInfo = (String)pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
		    buy.setBuyCode(bean.getAsJsonObject().get("buyCode").getAsString());

		    // 1개월 주문목록 제이슨 //
	        //String json_ordersList6 = new Gson().toJson(this.session.selectList("getOrderList6", buy));
	        System.out.println("json_orderList1 : " + this.session.selectList("getOrderList1", buy));
	        model.addAttribute("json_orderList1", this.session.selectList("getOrderList1", buy));
		} catch (Exception e) {e.printStackTrace();}

	}
	private void orderList3Months(Model model) {
		BuyerBean buy = new BuyerBean();
		String accessInfo = null;
		
		try {
			accessInfo = (String)pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
		    buy.setBuyCode(bean.getAsJsonObject().get("buyCode").getAsString());

		    // 3개월 주문목록 제이슨 //
	        //String json_ordersList6 = new Gson().toJson(this.session.selectList("getOrderList6", buy));
	        System.out.println("json_orderList3 : " + this.session.selectList("getOrderList3", buy));
	        model.addAttribute("json_orderList3", this.session.selectList("getOrderList3", buy));
		} catch (Exception e) {e.printStackTrace();}

	}
		
	private void orderList6Months(Model model) {
		BuyerBean buy = new BuyerBean();
		String accessInfo = null;
		
		try {
			accessInfo = (String)pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
		    buy.setBuyCode(bean.getAsJsonObject().get("buyCode").getAsString());

		    // 6개월 주문목록 제이슨 //
	        //String json_ordersList6 = new Gson().toJson(this.session.selectList("getOrderList6", buy));
	        System.out.println("json_orderList6 : " + this.session.selectList("getOrderList6", buy));
	        model.addAttribute("json_orderList6", this.session.selectList("getOrderList6", buy));
		} catch (Exception e) {e.printStackTrace();}

	}
		
	
	private boolean convertToBool(int result) {
		return result >= 1 ? true : false;
	}


}