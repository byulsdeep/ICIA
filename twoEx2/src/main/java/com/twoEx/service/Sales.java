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




	//	????????? ???????????? ?????? - > ???????????????????????????
	private void regCte(ModelAndView mav) {
		String message = "????????????????????????";
		// TODO Auto-generated method stub
		ProductBean prd = (ProductBean)mav.getModel().get("productBean");
		System.out.println("backattack");
		System.out.println(prd);
		if(this.convertToBool(this.session.insert("insCte", prd))) {
			mav.addObject("message2", "?????????????????? ??????");			
		}else {
			mav.addObject("message2", "?????????????????? ??????");	
		}
		mav.addObject("selectCte", insCTE(prd,"prdCteCode"));
		mav.addObject("checkedCte",makeSelectCTE(prd,"prdCteCode"));
		mav.addObject("list", prdInfo(prd));		
		mav.setViewName("myShop/myshop");	
	}

		//???????????????????????? ??????
		private void moveRegisterGoods(ModelAndView mav) {
			ProductBean prd = (ProductBean)mav.getModel().get("productBean");
			
			mav.addObject("selectCte", insCTE(prd, "prdCteCode"));
			mav.addObject("checkedCte", makeSelectCTE(prd, "prdCteCode"));
			String getPrdCode= this.session.selectOne("getPrdCode",prd);
			
			mav.addObject("selectData", this.makeSelectCTE(prd,"prdCteCode"));						  
			mav.addObject("prdCode", getPrdCode);	
			
			mav.setViewName("myShop/registerProduct");
			
		}
	//???????????? -> ??????????????????
	private void registerProduct(ModelAndView mav) {
		String message = "???????????? ??????";
		ProductBean prd = (ProductBean)mav.getModel().get("productBean");	
	
		
		if(this.convertToBool(this.session.insert("regProduct",prd))) {
			mav.addObject("selectCte", insCTE(prd, "prdCteCode"));
			mav.addObject("checkedCte", makeSelectCTE(prd, "prdCteCode"));
			//??????????????? ????????? ?????????
			if(prd.getPrfName()!="") {
			this.session.insert("insPrf",prd);	
			}
				if(prd.getPrdType().equals("C")) {
					//???????????? ?????? ???????????? ???????????? ???????????? ??????
					this.session.insert("insClassRoom",prd);			
				}		
				mav.addObject("message", "??????????????????");										
			}else {
				mav.addObject("message", "??????????????????");	
				String getPrdCode= this.session.selectOne("getPrdCode",prd);
				
				mav.addObject("selectData", this.makeSelectCTE(prd,"prdCteCode"));						  
				mav.addObject("prdCode", getPrdCode);	
				mav.setViewName("myShop/registerProduct");
			}
		mav.addObject("sellerInfoBean", selInfo(prd));
		mav.addObject("list", prdInfo(prd));		
		mav.setViewName("myShop/myshop");
	}
	
	//????????????????????? ??????
	private void moveUpdProduct(ModelAndView mav) {
		ProductBean prd = (ProductBean)mav.getModel().get("productBean");
		mav.addObject("selectData", this.makeSelectCTE(prd,"prdCteCode"));
		
		mav.addObject("selCode", prd.getPrdSelCode());
		mav.addObject("getProductInfo", updPrd(prd));
		mav.setViewName("myShop/updProduct");		
	}
	//???????????? -> ??????????????????
	private void updProduct(ModelAndView mav) {
		String message = "???????????? ??????";
		ProductBean prd = (ProductBean)mav.getModel().get("productBean");	
		
		if(this.convertToBool(this.session.update("updProduct",prd))) {
			mav.addObject("message1", "???????????? ??????");
			}
		mav.addObject("sellerInfoBean", selInfo(prd));
		mav.addObject("list", prdInfo(prd));
		mav.setViewName("myShop/myshop");
	}

	//????????????,?????? ????????? ??????
	private void moveModifyProduct(ModelAndView mav) {
		ProductBean sel;		

		sel = (ProductBean)mav.getModel().get("productBean");
		
		mav.addObject("selectCte", insCTE(sel, "prdCteCode"));
		mav.addObject("checkedCte", makeSelectCTE(sel, "prdCteCode"));
		mav.addObject("productList", prdList(sel));
		mav.setViewName("myShop/productManagement");
	}

	//???????????? ????????? ??????????????? ??????
	private void moveMyshop(ModelAndView mav) {
		ProductBean sel;		
		sel = (ProductBean)mav.getModel().get("productBean");
		mav.addObject("selectCte", insCTE(sel, "prdCteCode"));
		mav.addObject("checkedCte", makeSelectCTE(sel, "prdCteCode")); 
		mav.addObject("list", prdInfo(sel));
		mav.addObject("sellerInfoBean", selInfo(sel));
		
		mav.setViewName("myShop/myshop");
	}
	
	//????????????
	private void delProduct(ModelAndView mav) {
		String message = "???????????? ??????";
		ProductBean sel;		
		sel = (ProductBean)mav.getModel().get("productBean");
		mav.addObject("selectCte", insCTE(sel, "prdCteCode"));
		mav.addObject("checkedCte", makeSelectCTE(sel, "prdCteCode"));
		
		if(this.convertToBool(session.delete("delProduct",sel))) {			
			mav.addObject("message", "???????????? ??????");
		}else {
			mav.addObject("message", "???????????? ??????");			
		}
			mav.addObject("productList", prdList(sel));
			mav.setViewName("myShop/productManagement");
		
	}
	
	//????????? ?????? ?????? // ?????? ??????
	private SellerBean selInfo(ProductBean pb) {
		System.out.println("[??????] selInfo ????????? ??????");
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
	
	
	//????????? ???????????? ??????
	private String prdInfo(ProductBean pb) {
		StringBuffer sb = new StringBuffer();
		List<ProductBean> aulList = new ArrayList<ProductBean>();
		aulList = this.session.selectList("getProduct", pb);
		System.out.print(pb);
		//sb.append("<div id='prdSize'>"+"????????? ?????? ??? : "+"("+aulList.size()+")"+"</div>");		
		for(ProductBean prb:aulList) {	
			sb.append("<div class=\"product__item\">");
			sb.append("<div class=\"product__image__div\" onClick = \"moveProductInfo(\'"+ prb.getPrdCteCode()+"\', \'"+prb.getPrdSelCode()+"\', \'" + prb.getPrdCode() + "\')\">");
			sb.append("<img  class=\"product__image\"  src='"+this.session.selectOne("getPrdImg", prb)+"' onerror=\"this.src='res/imgs/test1.jpg';\">");
			sb.append("</div>");
			sb.append("<div class=\"product__title__div\">"+"???????????? : "+prb.getPrdName()+"</div>");			
			sb.append("<div class=\"product__price__div\">"+"?????? : "+prb.getPrdPrice()+"</div>");
			sb.append("<div class=\"product__etc__div\">");
			if(prb.getPrdType().equals("C")) {
				sb.append("<button class='more' onClick=\"classroom(\'"+prb.getPrdCode()+"\',\'"+prb.getPrdSelCode()+"\',\'"+prb.getPrdCteCode()+"\')\"/>???????????? ??????</button>");
			}	
			sb.append("</div>");
			sb.append("</div>");
		}
		
		return sb.toString();
	}
		//????????????,??????????????? ??????????????? ??????
	private String prdList(ProductBean pb) {
			StringBuffer sb = new StringBuffer();
			List<ProductBean> aulList = new ArrayList<ProductBean>();
			aulList = this.session.selectList("getProduct", pb);
			
			sb.append(
					"<div class=\"productQua\" >"+"????????? ?????? ??? : "+"("+aulList.size()+")" + "</div>");
			
			for(ProductBean prb:aulList) {
				sb.append("<div class=\"product__item updList\">");
				sb.append("<div class=\"product__image__div\">");
				sb.append("<img  class=\"product__image\" src='"+this.session.selectOne("getPrdImg", prb)+"' onerror=\"this.src='res/imgs/test1.jpg';\"'>");
				sb.append("</img>");
				sb.append("</div>");
				sb.append("<div  class=\"product__etc__div\" onClick=\"getPrdInfo(\'"+prb.getPrdCode()+"\')\"/>"+"???????????? : "+prb.getPrdName()+"</div>");
				/*sb.append("<div class=\"product__etc__div\">"+"???????????? : "+prb.getPrdInfo()+"</div>");*/				
				sb.append("<div class=\"product__price__div\">"+"?????? : "+prb.getPrdPrice()+"</div>");
				sb.append("<div class=\"product__etc__div2\">"+"?????? : "+prb.getPrdStartDate()+"~"+prb.getPrdEndDate()+"</div>");
				if(prb.getPrdType().equals("C")) {
					sb.append("<div class=\"product__etc__div2\">"+"???????????? : ??????"+"</div>");
				}else {
					sb.append("<div class=\"product__etc__div2\">"+"???????????? : ?????????"+"</div>");
				}
				sb.append("<div class=\"product__btn__div\">");
				sb.append("<input type='button' class='more' value='??????' onClick=\"moveUpdProduct(\'"+prb.getPrdCode()+"\',\'"+prb.getPrdSelCode()+"\',\'"+prb.getPrdCteCode()+"\')\"/>");
				sb.append("<input type='button' class='more' value='??????' onClick=\"delProduct(\'"+prb.getPrdCode()+"\',\'"+prb.getPrdCteCode()+"\',\'" + prb.getPrdSelCode()+"\')\"/>");
				sb.append("</div>");
				sb.append("</div>");
			}
			return sb.toString();
		}
	
	//????????????????????? ????????? ?????? ??????
	private String updPrd(ProductBean pb) {
		StringBuffer sb = new StringBuffer();
		List<ProductBean> aulList = new ArrayList<ProductBean>();
		aulList = this.session.selectList("getProductInfo", pb);
		sb.append("<form name='updGoods'>");
		sb.append("<div class='joinId'>");
		for(ProductBean prb:aulList) {
		
			sb.append(   																	
					 	"    <div class=\"regPrdName\">\r\n"
					+ "    <label for=\"Name\">????????????</label><br>\r\n"				 			
					+ "    <input class=\"registerPrdName\" type=\"text\" name=\"prdName\" class=\"input text medium\" placeholder=\"????????????\" value='"+prb.getPrdName()+"' style=\"width:400px;height:51px;font-size:15px;\"/><br><br>\r\n"
					+ "    </div>\r\n"
					+ "    \r\n"
					+ "    <div class=\"regPrdInfo\">\r\n"
					+ "    <label for=\"Inf0\">????????????</label><br>\r\n"
					+ "    <input type='text' name=\"prdInfo\" placeholder=\"????????????\" class=\"input text medium\" value='"+prb.getPrdInfo()+"' style=\"width:400px;height:51px;font-size:15px;\"></input><br><br>\r\n"
					+ "    </div>\r\n"
					+ "    \r\n"
					+ "    <div class=\"regPrdStart\">\r\n"
					+ "    <label for=\"Start\">?????????</label><br>\r\n"
					+ "    <input class=\"sellseShopName\" type=\"date\"  name=\"prdStartDate\" value='"+prb.getPrdStartDate().substring(0,10)+"' class=\"input text medium\" placeholder=\"?????????\" style=\"width:400px;height:51px;font-size:15px;\"></input><br><br>\r\n"
					+ "    </div>\r\n"
					+ "    \r\n"
					+ "    <div class=\"regPrdEnd\">\r\n"
					+ "    <label for=\"End\">?????????</label><br>\r\n"
					+ "    <input class=\"sellseShopName\" type=\"date\"  name=\"prdEndDate\" value='"+prb.getPrdEndDate().substring(0,10)+"' class=\"input text medium\" placeholder=\"?????????\" style=\"width:400px;height:51px;font-size:15px;\"></input><br><br>\r\n"
					+ "    </div>\r\n"
					+ "    \r\n"
					+ "    <div class=\"regPrdPrice\">\r\n"
					+ "    <label for=\"Price\">??????</label><br>\r\n"
					+ "    <input class=\"sellseShopName\" type=\"text\"  name=\"prdPrice\" value='"+prb.getPrdPrice()+"' class=\"input text medium\" placeholder=\"????????????\" style=\"width:400px;height:51px;font-size:15px;\"/><br><br>\r\n"
					+ "    </div>\r\n"
					+ "    \r\n"
					+ "     <div class=\"regProduct\">\r\n"
					+ "    <label for=\"product\">??????????????????</label><br>\r\n"
					+ "    	<input type='button' class='content__btn btn__small' value='??????' onClick=\"updProduct(\'"+prb.getPrdCode()+"\',\'"+prb.getPrdSelCode()+"\',\'"+prb.getPrdCteCode()+"\')\"/><br><br>"	);					
		}
		sb.append("</div>");
		sb.append("</form>");
		return sb.toString();
	}
	
	
	
	
	//???????????? ????????? ?????? ???????????? ?????? select ???
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
	
	//???????????? ???????????? ??????????????? DB????????? ????????????????????? ??????
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
