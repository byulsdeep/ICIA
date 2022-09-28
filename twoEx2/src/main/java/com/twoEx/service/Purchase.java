package com.twoEx.service;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.twoEx.bean.BuyerBean;
import com.twoEx.bean.ClassroomBean;
import com.twoEx.bean.KakaoPayApprovalVO;
import com.twoEx.bean.KakaoPayReadyVO;
import com.twoEx.bean.LocationBean;
import com.twoEx.bean.OrderBean;
import com.twoEx.bean.OrderDetailBean;
import com.twoEx.bean.ProductBean;
import com.twoEx.bean.StudentBean;
import com.twoEx.utils.Encryption;
import com.twoEx.utils.ProjectUtils;

import lombok.extern.java.Log;

@Service
@Log
public class Purchase {
	@Autowired
	private ProjectUtils pu;
	@Autowired
	private SqlSessionTemplate session;
	@Autowired
	private Encryption enc; 
	
    private static final String HOST = "https://kapi.kakao.com";
    
    private KakaoPayReadyVO kakaoPayReadyVO;
    private KakaoPayApprovalVO kakaoPayApprovalVO;
    
	public void backController(String serviceCode, ModelAndView mav) {
		try {
			if(this.pu.getAttribute("accessInfo") !=null) {
				switch(serviceCode) {
				case "moveOrder":
					this.moveOrder(mav);
					break;
				default:
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
    
    
    public String kakaoPayReady(ModelAndView mav) {
    	String accessInfo = null;
    	BuyerBean buy = new BuyerBean();
    	ProductBean prd;
    	String order_id = null;
    	String prdSelCode = null;
    	String prdCteCode = null;
    	String prdCode = null;
    	String prdType = null;
    	Date date = new Date();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
    	
    	
    	
    	
    	
    	prd = (ProductBean)mav.getModel().get("productBean");
        RestTemplate restTemplate = new RestTemplate();
        
        try {
			accessInfo = (String)pu.getAttribute("accessInfo");
			
		} catch (Exception e1) {
			e1.printStackTrace();
		}
        
        JsonParser parser = new JsonParser();
        JsonElement bean = parser.parse(accessInfo);
        buy.setBuyCode(bean.getAsJsonObject().get("buyCode").getAsString());
        prd.setPrdName(((ProductBean)mav.getModel().get("productBean")).getPrdName());
        
        
        order_id = sdf.format(date) + buy.getBuyCode() + prd.getPrdName();
        prdSelCode = prd.getPrdSelCode();
        prdCteCode = prd.getPrdCteCode();
        prdCode = prd.getPrdCode();
        prdType = prd.getPrdType();
        System.out.println("판매자 카테고리 :"+prdCteCode);
        //주문번호 세션에 저장
        try {
			this.pu.setAttribute("orderId", order_id);
			this.pu.setAttribute("OrdPrdSelCode", prdSelCode);
			this.pu.setAttribute("OrdPrdCteCode", prdCteCode);
			this.pu.setAttribute("OrdPrdCode", prdCode);
			this.pu.setAttribute("prdType", prdType);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
        
        
        
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();

        //카카오디벨로퍼 adminKey 변경
        headers.add("Authorization", "KakaoAK " + "41ef7321e8c2032aac3bbc63d952a625");
        /* 기본값 c415186a9d7b6d348692407421d627ed 
         * 강한별 41ef7321e8c2032aac3bbc63d952a625 192.168.0.133
         * 하진우 4edb19486059d94ec8260c53755bb193 192.168.0.10
         * 이상은 ff8d1e2806175b51e0d34fde608e13eb 192.168.1.47
         * https://errorkillers.hoonzzang.com:20000
         * 
         * */
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        System.out.println("결제정보1:"+order_id);
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", order_id);
        params.add("partner_user_id", buy.getBuyCode());
        params.add("item_name", prd.getPrdName());
        params.add("quantity", "1");
        params.add("total_amount",prd.getPrdPrice().replaceAll("\\,", ""));
        params.add("tax_free_amount", "100");
        params.add("approval_url", "http://192.168.0.133/kakaoPaySuccess");
        params.add("cancel_url", "http://192.168.0.133/kakaoPayCancel");
        params.add("fail_url", "http://192.168.0.133/kakaoPaySuccessFail");
        //"http://errorkillers.hoonzzang.com:20000/kakaoPaySuccess"
         HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
 
        try {
            kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
            
            log.info("" + kakaoPayReadyVO);
            
            return kakaoPayReadyVO.getNext_redirect_pc_url();
 
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        /*** 오더 정보 ***/
        

      
        Gson gson = new GsonBuilder().create();
        String json__orderInfo = gson.toJson(prd);
        mav.addObject("json__orderInfo", prd);
        
        mav.setViewName("orderCompletePage");
        return "/orderCompletePage";
        
    }
    
    public KakaoPayApprovalVO kakaoPayInfo(String pg_token,ModelAndView mav) {
    	ProductBean sel = new ProductBean();		
    	String accessInfo = null;
    	BuyerBean buy = new BuyerBean();
    	Date date = new Date();
        String order_id = null;
        String prdSelCode = null;
        OrderBean ord= new OrderBean();
        StudentBean stu = new StudentBean();
    	OrderDetailBean odb = new OrderDetailBean();
    	sel = (ProductBean)mav.getModel().get("productBean");
    	try {
			accessInfo = (String)pu.getAttribute("accessInfo");

		} catch (Exception e1) {
			e1.printStackTrace();
		}

        JsonParser parser = new JsonParser();
        JsonElement bean = parser.parse(accessInfo);
        buy.setBuyCode(bean.getAsJsonObject().get("buyCode").getAsString());
    	
        log.info("KakaoPayInfoVO............................................");
        log.info("-----------------------------");
        
        
       RestTemplate restTemplate = new RestTemplate();
       //주문번호 생성
       try {
		order_id = ((String)this.pu.getAttribute("orderId"));
		prdSelCode = ((String)this.pu.getAttribute("prdSelCode"));
		ord.setOrdBuyCode(buy.getBuyCode());
		ord.setOrdPrdSelCode((String)this.pu.getAttribute("OrdPrdSelCode"));
		ord.setOrdPrdCteCode((String)this.pu.getAttribute("OrdPrdCteCode"));
		ord.setOrdPrdCode((String)this.pu.getAttribute("OrdPrdCode"));
		sel.setPrdType((String)this.pu.getAttribute("prdType"));
	} catch (Exception e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
       stu.setStuClaSelCode(ord.getOrdPrdSelCode());
       stu.setStuClaCteCode(ord.getOrdPrdCteCode());
       stu.setStuClaPrdCode(ord.getOrdPrdCode());
       stu.setStuOrdBuyCode(ord.getOrdBuyCode());
       System.out.println("토큰정보"+ pg_token);
       System.out.println("결제정보2:"+order_id);
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        //카카오디벨로퍼 adminKey 변경
        headers.add("Authorization", "KakaoAK " + "41ef7321e8c2032aac3bbc63d952a625");
        /* 기본값 c415186a9d7b6d348692407421d627ed
         * 강한별 41ef7321e8c2032aac3bbc63d952a625
         * 하진우 4edb19486059d94ec8260c53755bb193
         * 이상은 ff8d1e2806175b51e0d34fde608e13eb
         * 
         * 
         * */
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
 
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", kakaoPayReadyVO.getTid());
        params.add("partner_order_id",order_id);
        params.add("partner_user_id", buy.getBuyCode());
        params.add("pg_token", pg_token);        
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        try {
            kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
            log.info("" + kakaoPayApprovalVO);
            
            Gson gson = new GsonBuilder().setPrettyPrinting().create();
    		System.out.println(gson.toJson(stu));
    		
            if(sel.getPrdType().equals("C")) {
            	this.session.insert("insOrder", ord);
            	this.session.insert("insStu", stu);
            }else {
            	this.session.insert("insOrder", ord);
            }
         
            
           OrderDetailBean list = (OrderDetailBean) session.selectList("getLastOrder", ord).get(0);
           try {
			list.setOdtBuyEmail(enc.aesDecode(list.getOdtBuyEmail(), list.getOdtBuyCode()));
			list.setOdtBuyNickname(enc.aesDecode(list.getOdtBuyNickname(), list.getOdtBuyCode()));
	        list.setOdtBuyProfile(enc.aesDecode(list.getOdtBuyProfile(), list.getOdtBuyCode()));
		} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException | NoSuchPaddingException
				| InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
            String prdImg = this.session.selectOne("getOrderPrdImg", ord);
           
    		String jsonList = new Gson().toJson(list);
    		mav.addObject("jsonOrderInfo", jsonList);
    		mav.addObject("getPrdImg", prdImg);
    		
            mav.setViewName("orderCompletePage");
            
           
        
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        return null;
    }
    
    
//    private String ordInfo(OrderBean ord) {
//		StringBuffer sb = new StringBuffer();
//		List<OrderDetailBean> aulList = new ArrayList<OrderDetailBean>();
//		aulList = this.session.selectList("getLastOrder", ord);
//		sb.append("<div>");
//		for(OrderDetailBean odb:aulList) {			
//			try {
//				sb.append("<div id='buEmail'>"+this.enc.aesDecode(odb.getBuy_email(),odb.getOrd_buycode())+"</div>");
//				sb.append("<div id='buyNickname'>"+this.enc.aesDecode(odb.getBuy_nickname(),odb.getOrd_buycode())+"</div>");
//				sb.append("<div id='buyProfile'>"+this.enc.aesDecode(odb.getBuy_profile(),odb.getOrd_buycode())+"</div>");
//				sb.append("<div id='prdName'>"+odb.getPrd_name()+"</div>");
//				sb.append("<div id='prdPrice'>"+odb.getPrd_price()+"</div>");
//				sb.append("<div id='ordDate'>"+odb.getOrd_date()+"</div>");				
//			} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
//					| NoSuchPaddingException | InvalidAlgorithmParameterException | IllegalBlockSizeException
//					| BadPaddingException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}
//		sb.append("</div>");
//		return sb.toString();
//	}
    
    
    private void moveOrder(ModelAndView mav) {
    	ProductBean prd= (ProductBean)mav.getModel().get("productBean");
    	
    	ProductBean ord = this.session.selectOne("getOrderProduct", prd);

		mav.addObject("product", ord);
		mav.setViewName("purchaseDetail");
	}
    
   
    private String prdInfo(ProductBean pb) {
		StringBuffer sb = new StringBuffer();
		List<ProductBean> aulList = new ArrayList<ProductBean>();
		aulList = this.session.selectList("getOrderProduct", pb);
		sb.append("<form name='product'>");
		for(ProductBean prb:aulList) {			
			sb.append("</br>");
			sb.append("<img src="+this.session.selectList("getPrdImg", pb)+"></img>");
			sb.append("<div id='prdName'>"+prb.getPrdName()+"</div>");
			sb.append("<div>"+prb.getPrdInfo()+"</div>");
			sb.append("<div id='prdPrice'>"+prb.getPrdPrice()+"</div>");
			sb.append("<div style=\"display:none\" id='prdCode'>"+prb.getPrdCode()+"</div>");
			sb.append("<div style=\"display:none\" id='prdSelCode'>"+prb.getPrdSelCode()+"</div>");
			sb.append("<div style=\"display:none\" id='prdCteCode'>"+prb.getPrdCteCode()+"</div>");			
		}	
		sb.append("</form>");
		return sb.toString();
	}
}