package com.twoEx.service;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.twoEx.bean.ClassroomBean;
import com.twoEx.bean.ProductBean;
import com.twoEx.bean.ProductFile;
import com.twoEx.bean.ProductFileBean;
import com.twoEx.bean.SellerBean;
import com.twoEx.bean.SubmittedAssignmentBean;
import com.twoEx.utils.Encryption;
import com.twoEx.utils.ProjectUtils;

@Service
public class Sales {
	@Autowired
	private SqlSessionTemplate session;
	@Autowired
	private Encryption enc;
	@Autowired 
	private ProjectUtils pu;

	public void backController(String serviceCode, ModelAndView mav) {
		System.out.println("Authentication/backController");
		try {
			if(this.pu.getAttribute("accessInfo") !=null) {
			switch(serviceCode) {
			case "moveRegisterGoods":
				this.moveRegisterGoods(mav);
				break;
			case "moveMyshop":
				this.moveMyshop(mav);
				break;
			case "moveModifyProduct":
				this.moveModifyProduct(mav);
				break;
			case "registerProduct":
				this.registerProduct(mav);
				break;
			case "moveUpdProduct":
				this.moveUpdProduct(mav);
				break;
			case "updProduct":
				this.updProduct(mav);
				break;
				
			case "regCte":
				this.regCte(mav);
				break;
			case "delProduct":
				this.delProduct(mav);
				break;
		
				
				}
			}else {
				mav.setViewName("mainPage");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

	
//	private void upload_ok(ModelAndView mav) {
//		// TODO Auto-generated method stub
//		MultipartFile files = ((MultipartFile)mav.getModel().get("uploadFile"));
//		ProductFile sab = (ProductFile)mav.getModel().get("prf");
//		ProductBean pb = (ProductBean)mav.getModel().get("productBean");
//		String json = new Gson().toJson(pb);
//		
//		mav.addObject("prdInfo", json);
//		String message;
//		
//		int result1 =this.session.insert("insPrf", sab);
//	}




	//	판매자 전문분야 등록 - > 마이샵페이지로이동
	private void regCte(ModelAndView mav) {
		String message = "전문분야등록실패";
		// TODO Auto-generated method stub
		ProductBean prd = (ProductBean)mav.getModel().get("productBean");
		System.out.println("backattack");
		System.out.println(prd);
		if(this.convertToBool(this.session.insert("insCte", prd))) {
			mav.addObject("message2", "전문분야등록 성공");			
		}else {
			mav.addObject("message2", "전문분야등록 실패");	
		}
		mav.addObject("selectCte", insCTE(prd,"prdCteCode"));
		mav.addObject("checkedCte",makeSelectCTE(prd,"prdCteCode"));
		mav.addObject("list", prdInfo(prd));		
		mav.setViewName("myShop/myshop");	
	}

		//상품등록페이지로 이동
		private void moveRegisterGoods(ModelAndView mav) {
			ProductBean prd = (ProductBean)mav.getModel().get("productBean");
			
			mav.addObject("selectCte", insCTE(prd, "prdCteCode"));
			mav.addObject("checkedCte", makeSelectCTE(prd, "prdCteCode"));
			String getPrdCode= this.session.selectOne("getPrdCode",prd);
			
			mav.addObject("selectData", this.makeSelectCTE(prd,"prdCteCode"));						  
			mav.addObject("prdCode", getPrdCode);	
			
			mav.setViewName("myShop/registerProduct");
			
		}
	//상품등록 -> 마이샵페이지
	private void registerProduct(ModelAndView mav) {
		String message = "상품등록 실패";
		ProductBean prd = (ProductBean)mav.getModel().get("productBean");	
	
		
		if(this.convertToBool(this.session.insert("regProduct",prd))) {
			mav.addObject("selectCte", insCTE(prd, "prdCteCode"));
			mav.addObject("checkedCte", makeSelectCTE(prd, "prdCteCode"));
			//상품이지미 파일이 있을시
			if(prd.getPrfName()!="") {
			this.session.insert("insPrf",prd);	
			}
				if(prd.getPrdType().equals("C")) {
					//클래스룸 사용 상품이면 자동으로 클래스룸 생성
					this.session.insert("insClassRoom",prd);			
				}		
				mav.addObject("message", "상품등록성공");										
			}else {
				mav.addObject("message", "상품등록실패");	
				String getPrdCode= this.session.selectOne("getPrdCode",prd);
				
				mav.addObject("selectData", this.makeSelectCTE(prd,"prdCteCode"));						  
				mav.addObject("prdCode", getPrdCode);	
				mav.setViewName("myShop/registerProduct");
			}
		mav.addObject("sellerInfoBean", selInfo(prd));
		mav.addObject("list", prdInfo(prd));		
		mav.setViewName("myShop/myshop");
	}
	
	//상품수정페이지 이동
	private void moveUpdProduct(ModelAndView mav) {
		ProductBean prd = (ProductBean)mav.getModel().get("productBean");
		mav.addObject("selectData", this.makeSelectCTE(prd,"prdCteCode"));
		
		mav.addObject("selCode", prd.getPrdSelCode());
		mav.addObject("getProductInfo", updPrd(prd));
		mav.setViewName("myShop/updProduct");		
	}
	//상품수정 -> 마이샵페이지
	private void updProduct(ModelAndView mav) {
		String message = "상품수정 실패";
		ProductBean prd = (ProductBean)mav.getModel().get("productBean");	
		
		if(this.convertToBool(this.session.update("updProduct",prd))) {
			mav.addObject("message1", "상품수정 성공");
			}
		mav.addObject("sellerInfoBean", selInfo(prd));
		mav.addObject("list", prdInfo(prd));
		mav.setViewName("myShop/myshop");
	}

	//상품수정,삭제 페이지 이동
	private void moveModifyProduct(ModelAndView mav) {
		ProductBean sel;		

		sel = (ProductBean)mav.getModel().get("productBean");
		
		mav.addObject("selectCte", insCTE(sel, "prdCteCode"));
		mav.addObject("checkedCte", makeSelectCTE(sel, "prdCteCode"));
		mav.addObject("productList", prdList(sel));
		mav.setViewName("myShop/productManagement");
	}

	//로그인한 판매자 마이샵으로 이동
	private void moveMyshop(ModelAndView mav) {
		ProductBean sel;		
		sel = (ProductBean)mav.getModel().get("productBean");
		mav.addObject("selectCte", insCTE(sel, "prdCteCode"));
		mav.addObject("checkedCte", makeSelectCTE(sel, "prdCteCode")); 
		mav.addObject("list", prdInfo(sel));
		mav.addObject("sellerInfoBean", selInfo(sel));
		
		mav.setViewName("myShop/myshop");
	}
	
	//상품삭제
	private void delProduct(ModelAndView mav) {
		String message = "상품삭제 실패";
		ProductBean sel;		
		sel = (ProductBean)mav.getModel().get("productBean");
		mav.addObject("selectCte", insCTE(sel, "prdCteCode"));
		mav.addObject("checkedCte", makeSelectCTE(sel, "prdCteCode"));
		
		if(this.convertToBool(session.delete("delProduct",sel))) {			
			mav.addObject("message", "상품삭제 성공");
		}else {
			mav.addObject("message", "상품삭제 실패");			
		}
			mav.addObject("productList", prdList(sel));
			mav.setViewName("myShop/productManagement");
		
	}
	
	//판매자 정보 출력 // 상은 작성
	private SellerBean selInfo(ProductBean pb) {
		System.out.println("[출력] selInfo 메서드 입구");
		StringBuffer sb = new StringBuffer();
		SellerBean sellerBean = new SellerBean();
		sellerBean.setSelCode(pb.getPrdSelCode());
		List<SellerBean> sellerBeanList = new ArrayList<SellerBean>();
		sellerBeanList = this.session.selectList("getSellerInfo2",sellerBean);
		
		if(sellerBeanList.size()>0) {
			try {
				sellerBeanList.get(0).setSelShopName(this.enc.aesDecode(sellerBeanList.get(0).getSelShopName(), sellerBeanList.get(0).getSelCode()));
				sellerBeanList.get(0).setSelNickname(this.enc.aesDecode(sellerBeanList.get(0).getSelNickname(), sellerBeanList.get(0).getSelCode()));
				sellerBeanList.get(0).setSelEmail(this.enc.aesDecode(sellerBeanList.get(0).getSelEmail(), sellerBeanList.get(0).getSelCode()));
				sellerBeanList.get(0).setSelProfile(this.enc.aesDecode(sellerBeanList.get(0).getSelProfile(), sellerBeanList.get(0).getSelCode()));
			} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException | NoSuchPaddingException
					| InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			sellerBean = sellerBeanList.get(0);
		}
		System.out.println("sellerBean : " + sellerBean);
		return sellerBean;
	}
	
	
	//판매자 상품목록 출력
	private String prdInfo(ProductBean pb) {
		StringBuffer sb = new StringBuffer();
		List<ProductBean> aulList = new ArrayList<ProductBean>();
		aulList = this.session.selectList("getProduct", pb);
		System.out.print(pb);
		//sb.append("<div id='prdSize'>"+"등록된 상품 수 : "+"("+aulList.size()+")"+"</div>");		
		for(ProductBean prb:aulList) {	
			sb.append("<div class=\"product__item\">");
			sb.append("<div class=\"product__image__div\" onClick = \"moveProductInfo(\'"+ prb.getPrdCteCode()+"\', \'"+prb.getPrdSelCode()+"\', \'" + prb.getPrdCode() + "\')\">");
			sb.append("<img  class=\"product__image\"  src='"+this.session.selectOne("getPrdImg", prb)+"' onerror=\"this.src='res/imgs/test1.jpg';\">");
			sb.append("</div>");
			sb.append("<div class=\"product__title__div\">"+"상품이름 : "+prb.getPrdName()+"</div>");			
			sb.append("<div class=\"product__price__div\">"+"가격 : "+prb.getPrdPrice()+"</div>");
			sb.append("<div class=\"product__etc__div\">");
			if(prb.getPrdType().equals("C")) {
				sb.append("<button class='more' onClick=\"classroom(\'"+prb.getPrdCode()+"\',\'"+prb.getPrdSelCode()+"\',\'"+prb.getPrdCteCode()+"\')\"/>클래스룸 이동</button>");
			}	
			sb.append("</div>");
			sb.append("</div>");
		}
		
		return sb.toString();
	}
		//상품수정,삭제페이지 상품리스트 출력
	private String prdList(ProductBean pb) {
			StringBuffer sb = new StringBuffer();
			List<ProductBean> aulList = new ArrayList<ProductBean>();
			aulList = this.session.selectList("getProduct", pb);
			
			sb.append(
					"<div class=\"productQua\" >"+"등록된 상품 수 : "+"("+aulList.size()+")" + "</div>");
			
			for(ProductBean prb:aulList) {
				sb.append("<div class=\"product__item updList\">");
				sb.append("<div class=\"product__image__div\">");
				sb.append("<img  class=\"product__image\" src='"+this.session.selectOne("getPrdImg", prb)+"' onerror=\"this.src='res/imgs/test1.jpg';\"'>");
				sb.append("</img>");
				sb.append("</div>");
				sb.append("<div  class=\"product__etc__div\" onClick=\"getPrdInfo(\'"+prb.getPrdCode()+"\')\"/>"+"상품이름 : "+prb.getPrdName()+"</div>");
				/*sb.append("<div class=\"product__etc__div\">"+"상품설명 : "+prb.getPrdInfo()+"</div>");*/				
				sb.append("<div class=\"product__price__div\">"+"가격 : "+prb.getPrdPrice()+"</div>");
				sb.append("<div class=\"product__etc__div2\">"+"기간 : "+prb.getPrdStartDate()+"~"+prb.getPrdEndDate()+"</div>");
				if(prb.getPrdType().equals("C")) {
					sb.append("<div class=\"product__etc__div2\">"+"클래스룸 : 사용"+"</div>");
				}else {
					sb.append("<div class=\"product__etc__div2\">"+"클래스룸 : 미사용"+"</div>");
				}
				sb.append("<div class=\"product__btn__div\">");
				sb.append("<input type='button' class='more' value='수정' onClick=\"moveUpdProduct(\'"+prb.getPrdCode()+"\',\'"+prb.getPrdSelCode()+"\',\'"+prb.getPrdCteCode()+"\')\"/>");
				sb.append("<input type='button' class='more' value='삭제' onClick=\"delProduct(\'"+prb.getPrdCode()+"\',\'"+prb.getPrdCteCode()+"\',\'" + prb.getPrdSelCode()+"\')\"/>");
				sb.append("</div>");
				sb.append("</div>");
			}
			return sb.toString();
		}
	
	//상품수정을위한 하나의 상품 출력
	private String updPrd(ProductBean pb) {
		StringBuffer sb = new StringBuffer();
		List<ProductBean> aulList = new ArrayList<ProductBean>();
		aulList = this.session.selectList("getProductInfo", pb);
		sb.append("<form name='updGoods'>");
		sb.append("<div class='joinId'>");
		for(ProductBean prb:aulList) {
		
			sb.append(   																	
					 	"    <div class=\"regPrdName\">\r\n"
					+ "    <label for=\"Name\">상품이름</label><br>\r\n"				 			
					+ "    <input class=\"registerPrdName\" type=\"text\" name=\"prdName\" class=\"input text medium\" placeholder=\"상품이름\" value='"+prb.getPrdName()+"' style=\"width:400px;height:51px;font-size:15px;\"/><br><br>\r\n"
					+ "    </div>\r\n"
					+ "    \r\n"
					+ "    <div class=\"regPrdInfo\">\r\n"
					+ "    <label for=\"Inf0\">상품설명</label><br>\r\n"
					+ "    <input type='text' name=\"prdInfo\" placeholder=\"상품정보\" class=\"input text medium\" value='"+prb.getPrdInfo()+"' style=\"width:400px;height:51px;font-size:15px;\"></input><br><br>\r\n"
					+ "    </div>\r\n"
					+ "    \r\n"
					+ "    <div class=\"regPrdStart\">\r\n"
					+ "    <label for=\"Start\">시작일</label><br>\r\n"
					+ "    <input class=\"sellseShopName\" type=\"date\"  name=\"prdStartDate\" value='"+prb.getPrdStartDate().substring(0,10)+"' class=\"input text medium\" placeholder=\"시작일\" style=\"width:400px;height:51px;font-size:15px;\"></input><br><br>\r\n"
					+ "    </div>\r\n"
					+ "    \r\n"
					+ "    <div class=\"regPrdEnd\">\r\n"
					+ "    <label for=\"End\">종료일</label><br>\r\n"
					+ "    <input class=\"sellseShopName\" type=\"date\"  name=\"prdEndDate\" value='"+prb.getPrdEndDate().substring(0,10)+"' class=\"input text medium\" placeholder=\"종료일\" style=\"width:400px;height:51px;font-size:15px;\"></input><br><br>\r\n"
					+ "    </div>\r\n"
					+ "    \r\n"
					+ "    <div class=\"regPrdPrice\">\r\n"
					+ "    <label for=\"Price\">가격</label><br>\r\n"
					+ "    <input class=\"sellseShopName\" type=\"text\"  name=\"prdPrice\" value='"+prb.getPrdPrice()+"' class=\"input text medium\" placeholder=\"상품가격\" style=\"width:400px;height:51px;font-size:15px;\"/><br><br>\r\n"
					+ "    </div>\r\n"
					+ "    \r\n"
					+ "     <div class=\"regProduct\">\r\n"
					+ "    <label for=\"product\">상품수정하기</label><br>\r\n"
					+ "    	<input type='button' class='content__btn btn__small' value='수정' onClick=\"updProduct(\'"+prb.getPrdCode()+"\',\'"+prb.getPrdSelCode()+"\',\'"+prb.getPrdCteCode()+"\')\"/><br><br>"	);					
		}
		sb.append("</div>");
		sb.append("</form>");
		return sb.toString();
	}
	
	
	
	
	//판매자가 가지고 있는 전문분야 선택 select 문
	public String makeSelectCTE(ProductBean pb,String objName) {
			StringBuffer sb = new StringBuffer();
			List<ProductBean> aulList = new ArrayList<ProductBean>();
			aulList = this.session.selectList("getCte",pb);
			
			sb.append("<select name='" + objName + "' id='common__select'>");
			for(ProductBean prd : aulList) {
				sb.append("<option class='select__option' value='" + prd.getPrdCteCode() + "'>" + prd.getCteName() +"["+prd.getPrdCteCode()+"]"+"</option>");
			}
			sb.append("</select>");

			return sb.toString();
		} 
	
	//판매자의 전문분야 등록을위한 DB에있는 카테고리리스트 출력
	private String insCTE(ProductBean pb,String objName) {
		StringBuffer sb = new StringBuffer();
		List<ProductBean> aulList = new ArrayList<ProductBean>();
		
		aulList = this.session.selectList("getJoinCte",pb);
		sb.append("<form name='insCte'>");
		for(ProductBean prd : aulList) {
		
			sb.append("<input type='checkbox' name='prdCteCode' value='"+prd.getPrdCteCode()+"'>"+prd.getCteName()+"</input>");			
		}
		sb.append("</form>");
		return sb.toString();
	} 
	
	private boolean convertToBool(int result) {
		return result >= 1 ? true : false;
	}
		
}
