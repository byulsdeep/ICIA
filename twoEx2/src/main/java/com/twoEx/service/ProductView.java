package com.twoEx.service;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.json.JSONObject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.twoEx.bean.BuyerBean;
import com.twoEx.bean.CategoriesBean;
import com.twoEx.bean.FollowBean;
import com.twoEx.bean.ProductBean;
import com.twoEx.bean.ProductFileBean;
import com.twoEx.bean.SellerBean;
import com.twoEx.bean.ViewHistoryBean;
import com.twoEx.inter.ServicesRule;
import com.twoEx.utils.Encryption;
import com.twoEx.utils.ProjectUtils;

@Service
public class ProductView implements ServicesRule{
	@Autowired
	private ProjectUtils pu;
	@Autowired
	private SqlSessionTemplate sst;
	@Autowired
	private Encryption enc;
	
	/* System.out.println("[출력] pv-moveCategery()입구 ");*/
	
	public void backController(String serviceCode, ModelAndView mav) {
		try {
			if((this.pu.getAttribute("accessInfo") != null)){
				System.out.println("[출력] pv-backController if");
				switch(serviceCode) {
			    case "moveCategory":
			    	this.moveCategory(mav);
			    	break;
			    case "searchProduct":
			    	System.out.println("[출력] pv case문-searchProduct 로그인 상태");
			    	this.searchProduct(mav);
			    	break;
			    case "moveProductInfo":
			    	this.moveProductInfo(mav);
			    	break;
			    case "moveSellerShop":
			    	this.moveSellerShop(mav);
			    	break;
			    default:
			    }
			}else{
				System.out.println("[출력] pv-backController else");
				switch(serviceCode) {
			    case "moveCategory":
			    	System.out.println("스위치문");
			    	this.moveCategory(mav);
			    	break;
			    case "searchProduct":
			    	System.out.println("[출력] pv case문-searchProduct 로그인 안됨");
			    	this.searchProduct(mav);
			    	break;
			    case "moveProductInfo":
			    	this.moveProductInfo(mav);
			    	break;
			    case "moveSellerShop":
			    	this.moveSellerShop(mav);
			    	break;
			    default:
			    }
			}
		} catch (Exception e) {e.printStackTrace();}
      
	}
	public void backController(String serviceCode, Model model) {
		String message;
		try {
			if(this.pu.getAttribute("accessInfo") != null)
				switch(serviceCode) {
				case "getMainCategories":
					this.getMainCategories(model);
					break;
				case "getProductListByRank":
					this.getProductListByRank(model);
					break;
				case "changeWish" :
					this.changeWish(model);
					break;
				case "changeFollow" :
					System.out.println("[출력] pv case문-changeFollow");
					this.changeFollow(model);
					break;
				case "moveIndexPage" :
					System.out.println("[출력] pv case문-moveIndexPage");
					this.makeProductList(model);
					break;
				case "moveKeywordPage" :
					System.out.println("[출력] pv case문-moveKeywordPage");
					this.makeProductList2(model);
				default:
			}else{
				switch(serviceCode) {
				case "getMainCategories":
					this.getMainCategories(model);
					break;
				case "getProductListByRank":
					this.getProductListByRank(model);
					break;
				case "changeWish" :
					message ="로그인 후 사용해주세요.";
					model.addAttribute("message", message);
					break;
				case "changeFollow" :
					System.out.println("[출력] pv case문-changeFollow");
					message ="로그인 후 사용해주세요.";
					model.addAttribute("message", message);
					break;
				case "moveIndexPage" :
					System.out.println("[출력] pv case문-movePageIndex");
					this.makeProductList(model);
					break;
				case "moveKeywordPage" :
					System.out.println("[출력] pv case문-moveKeywordPage");
					this.makeProductList2(model);
				default:
				}
			}
		} catch (Exception e) {e.printStackTrace();}
		
		
	}
	

	private void getMainCategories(Model model) {
		System.out.println("pv-getMainCategories 입구");
		/** 카테고리 메뉴 생성 **/	
		List<CategoriesBean> cteList = this.sst.selectList("getCategories");
		System.out.println(cteList);
		model.addAttribute("cteList", cteList);
	}
	
	
	private void getProductListByRank(Model model) {
		System.out.println("getProductListByRank 입구");
		Gson gson = new GsonBuilder().create();

				/* 상품 가져오기  */
				List<ProductBean> pbList = this.sst.selectList("getProductListByRank");
				System.out.println("pbList 확인 : " + pbList);
				
				
				/* 상품 관련 사진, 셀러 가져오기 */
				for(ProductBean pb : pbList) {			
					List<ProductFileBean> pfbList = this.sst.selectList("getProductFileUrl", pb);
					List<SellerBean> sbList = this.sst.selectList("getSellerInfo", pb);
					System.out.println("pfbList 확인 : " + pfbList);
					/* 사진 */
					if(pfbList!= null) {
						if(pfbList.size()>0) {/* out of index 피함*/
							if(pfbList.get(0).getPrfLocation() != null) {
								pb.setPrfLocation(pfbList.get(0).getPrfLocation());
								System.out.println(pb.getPrfLocation());
							}					
						}
					}
					
					
					/* 셀러 정보*/
					if(sbList!=null) {
						if(sbList.size()>0) {
							if(sbList.get(0).getSelShopName() !=null) {
								/*** 복호화 ***/
								try {
									pb.setSelShopName(this.enc.aesDecode(sbList.get(0).getSelShopName(), pb.getPrdSelCode()));
									pb.setSelNickname(this.enc.aesDecode(sbList.get(0).getSelNickname(), pb.getPrdSelCode()));
								} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
										| NoSuchPaddingException | InvalidAlgorithmParameterException | IllegalBlockSizeException
										| BadPaddingException e) 
								{e.printStackTrace(); }
								
							}
						}
					}
				}
				
				/* 프론트로 json 넘기기 */
				Gson gson_pretty = new GsonBuilder().setPrettyPrinting().create();
				
				
				String json_pbList_pretty = gson_pretty.toJson(pbList);
						System.out.println("json_pbList_pretty ");
						System.out.println(": " + json_pbList_pretty);
				
				String json_pbList = gson.toJson(pbList);
						System.out.println("json_pbList : " + json_pbList);
	
				///
				model.addAttribute("json_pbList", json_pbList);
			
	}
	
	/**************************** moveSellerShop *************************************************************/
	
	private void moveSellerShop(ModelAndView mav) {
		System.out.println("moveSellerShop 메서드");
		Gson gson = new GsonBuilder().create();
		
		CategoriesBean cteb = ((CategoriesBean)mav.getModel().get("categoriesBean"));
		SellerBean sb = ((SellerBean)mav.getModel().get("sellerBean"));
		
		
		/*** 상품리스트, 페이징인덱스 생성 *****/
		if(sb.getSelCode() != null) {
			// 현재 페이지 입력
			cteb.setCurrentPage(1);
			makeSellerInfo(mav, sb, gson);
			makeProductList_sellerShop(mav, sb, cteb, gson);
		}else {
			System.out.println("프론트 sb.getSelCode()d가 null");
		}
		
		
		mav.setViewName("sellerShopPage");
	}
	
	
	private void makeSellerInfo(ModelAndView mav, SellerBean sb, Gson gson) {
		System.out.println("makeSellerInfo 메서드");
		
		if(sb.getSelCode()!=null) {
			System.out.println("makeSellerInfo 메서드 if문");
			List<SellerBean> sbList = this.sst.selectList("getSellerInfo2", sb);
			
			System.out.println("sb.getSelCode() : " + sb.getSelCode());
			/*** 복호화 ***/
			try {
				sbList.get(0).setSelShopName(this.enc.aesDecode(sbList.get(0).getSelShopName(), sb.getSelCode()));//샵네임
				sbList.get(0).setSelNickname(this.enc.aesDecode(sbList.get(0).getSelNickname(), sb.getSelCode()));//셀러닉네임
				sbList.get(0).setSelEmail(this.enc.aesDecode(sbList.get(0).getSelEmail(),sb.getSelCode()));//셀러이메일
				sbList.get(0).setSelProfile(this.enc.aesDecode(sbList.get(0).getSelProfile(), sb.getSelCode()));//셀러 소개
			} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
					| NoSuchPaddingException | InvalidAlgorithmParameterException | IllegalBlockSizeException
					| BadPaddingException e) 
			{e.printStackTrace(); }
			System.out.println("sbList : " + sbList);
			String json_sbList = gson.toJson(sbList);
			mav.addObject("json_sbList", json_sbList);
			
		}else {
			System.out.println("프론트 sb.getSelCode()d가 null");
		}
	}

	
	/** 상품 리스트 불어오기 2번째 **********/
	private void makeProductList_sellerShop(ModelAndView mav, SellerBean sb, CategoriesBean cteb, Gson gson) {		
		System.out.println("[출력] makeProductList 입구");
		
		
		/*** 페이징 계산 ***///////////////////////////////////////////////////////
		int totalNum;
		int numInPage = 8;
		int totalPage;
		int groupSize = 5;
		System.out.println("[출력] cteb.getCurrentPage() : " + cteb.getCurrentPage());
		int currentPage = cteb.getCurrentPage();
		System.out.println("[출력] currentPage : " + currentPage);
		int startPage;
		int endPage;
		
		
		/* DB rownum */
		int numStart =1;
		int numEnd = 10;
		
		
		/* 토탈 넘버 */
		totalNum = this.sst.selectOne("getTotalNumBySeller", sb);
		System.out.println("서치 totalNum : " + totalNum);
				
		/* 페이지 갯수 계산 */
		if(totalNum>0) {
			if((totalNum % numInPage) > 0){
				totalPage = (totalNum / numInPage) + 1;
				System.out.println("숫자 totalPage : " + totalPage);
			}else {
				totalPage = (totalNum / numInPage);
				System.out.println("숫자 totalPage : " + totalPage);
			}
			
		
			/* DB에 넣는 상품 rownum 인덱스 */
			numStart = (currentPage-1)*numInPage + 1;
			numEnd = currentPage*numInPage;
			System.out.println("[출력] numStart : " + numStart);
			System.out.println("[출력] numEnd : " + numEnd);
			
			/* 페이지 그룹 관련 인덱스 */
		    startPage = ((currentPage-1)/groupSize) * groupSize + 1;
		    endPage = (((currentPage-1)/groupSize)+1) * groupSize;
		    System.out.println("[출력] startPage : " + startPage);
		    System.out.println("[출력] endPage : " + endPage);
		    
			cteb.setTotalNum(totalNum);
			cteb.setTotalPage(totalPage);
			cteb.setCurrentPage(currentPage);
			cteb.setNumInPage(numInPage);
			cteb.setNumStart(numStart);
			cteb.setNumEnd(numEnd);
			cteb.setStartPage(startPage);
			cteb.setEndPage(endPage);
			
			System.out.println("cteb 확인 : " + cteb);
			
		/*** 상품 가져오기 ***////////////////////////////////////////////////////////////////
			List<ProductBean> pbList = this.sst.selectList("getProductListBySeller", sb);
			
			/** 상품 사진 가져오기 **/
			for(ProductBean pb : pbList) {			
				List<ProductFileBean> pfbList = this.sst.selectList("getProductFileUrl", pb);
				System.out.println("pfbList 확인 : " + pfbList);
				
				if(pfbList!= null) {
					if(pfbList.size()>0) {/* out of index 피함*/
						if(pfbList.get(0).getPrfLocation() != null) {
							pb.setPrfLocation(pfbList.get(0).getPrfLocation());
							System.out.println(pb.getPrfLocation());
						}					
					}
				}
			}
			
		/*** 프론트로 json 넘기기 ***////////////////////////////////////////////////////////
			Gson gson_pretty = new GsonBuilder().setPrettyPrinting().create();
			/* 페이징 정보*/
			String json_paging = gson.toJson(cteb);
			mav.addObject("json_paging", json_paging);
			
			/* 상품 리스트 정보 */
			String json_pbList_pretty = gson_pretty.toJson(pbList);
					System.out.println("json_pbList_pretty ");
					System.out.println(": " + json_pbList_pretty);
			
			String json_pbList = gson.toJson(pbList);
					System.out.println("json_pbList : " + json_pbList);
			mav.addObject("json_pbList", json_pbList);
			
		}else {System.out.println("페이지가 없습니다.");}
		
	}
	
	
	private void makeProductList_sellerShop(Model model) {
		System.out.println("makeProductList2 입구");
		Gson gson = new GsonBuilder().create();
		
		/** 프론트에서 온 form 정보 **/
		CategoriesBean cteb = (CategoriesBean)model.getAttribute("categoriesBean");
		SellerBean sb = (SellerBean)model.getAttribute("sellerBean");

		if(cteb.getKeyword() != null) {
			
			
			/** 상품 리스트 불어오기 **********/
			/* 페이징 변수 */
			int totalNum;
			int numInPage = 8;
			int totalPage;
			int groupSize = 5;
			int currentPage;
			int startPage;
			int endPage;
			
			/* DB rownum */
			int numStart =1;
			int numEnd = 10;
			
			/**** 프론트 정보 ****/
			currentPage = cteb.getCurrentPage();
			System.out.println("프론트 currentPage :  " + cteb.getCurrentPage());
			
			/* 토탈 넘버 */
			totalNum = this.sst.selectOne("getTotalNumBySeller", sb);
					
			/* 페이지 갯수 계산 */
			
				//totalPage = ( (totalNum - 1) / numInPage ) + 1   <-다른방법
			if(totalNum>0) {
				if((totalNum % numInPage) > 0){
					totalPage = (totalNum / numInPage) + 1;
					System.out.println("숫자 totalPage : " + totalPage);
				}else {
					totalPage = (totalNum / numInPage);
					System.out.println("숫자 totalPage : " + totalPage);
				}
				
				/* DB에 넣는 상품 rownum 인덱스 */
				numStart = (currentPage-1)*numInPage + 1;
				numEnd = currentPage*numInPage;
				
				/* 페이지 그룹 관련 인덱스 */
			    startPage = ((currentPage-1)/groupSize) * groupSize + 1;
			    endPage = (((currentPage-1)/groupSize)+1) * groupSize;

				cteb.setTotalNum(totalNum);
				cteb.setTotalPage(totalPage);
				cteb.setCurrentPage(currentPage);
				cteb.setNumInPage(numInPage);
				cteb.setNumStart(numStart);
				cteb.setNumEnd(numEnd);
				
				cteb.setStartPage(startPage);
				cteb.setEndPage(endPage);
				System.out.println("cteb 확인 : " + cteb);
				
				/* 상품 가져오기  */
				List<ProductBean> pbList = this.sst.selectList("getProductListBySeller", sb);
				System.out.println("pbList 확인 : " + pbList);
				
				/* 상품 사진 가져오기 */
				for(ProductBean pb : pbList) {			
					List<ProductFileBean> pfbList = this.sst.selectList("getProductFileUrl", pb);
					System.out.println("pfbList 확인 : " + pfbList);
					
					if(pfbList!= null) {
						if(pfbList.size()>0) {/* out of index 피함*/
							if(pfbList.get(0).getPrfLocation() != null) {
								pb.setPrfLocation(pfbList.get(0).getPrfLocation());
								System.out.println(pb.getPrfLocation());
							}					
						}
					}
				}
				
				/* 프론트로 json 넘기기 */
				Gson gson_pretty = new GsonBuilder().setPrettyPrinting().create();
				
				
				String json_pbList_pretty = gson_pretty.toJson(pbList);
						System.out.println("json_pbList_pretty ");
						System.out.println(": " + json_pbList_pretty);
				
				String json_pbList = gson.toJson(pbList);
						System.out.println("json_pbList : " + json_pbList);
				
				String json_paging = gson.toJson(cteb);
				
				String json_pagingAndpbList = json_paging +"&"+json_pbList;
				
				///
				model.addAttribute("json_pagingAndpbList", json_pagingAndpbList);
				/*
				model.addAttribute("json_paging", json_paging);
				model.addAttribute("json_pbList", json_pbList);
				*/
			}else {System.out.println("페이지가 없습니다.");}
		
		}
	}
	
	
	
	
	
	
	
	

	/********************************** search *************************************************************************/
	private void searchProduct(ModelAndView mav) {
		System.out.println("[출력] pv searchProduct 메서드");
		Gson gson = new GsonBuilder().create();
		
		CategoriesBean cteb = ((CategoriesBean)mav.getModel().get("categoriesBean"));
	
		
		/*** 상품리스트, 페이징인덱스 생성 *****/
		if(cteb.getKeyword() != null) {
			System.out.println("프론트 cteb.getKeyword : " + cteb.getKeyword());
			// 현재 페이지 입력
			cteb.setCurrentPage(1);
			makeProductList2(mav, cteb, gson);
		}else {
			System.out.println("프론트 cteb.getKeyword가 null");
		}
	
		mav.setViewName("searchPage");
		
	}
	
	
	
	
	
	
	/** 상품 리스트 불어오기 2번째 **********/
	private void makeProductList2(ModelAndView mav, CategoriesBean cteb, Gson gson) {		
		System.out.println("[출력] makeProductList 입구");
		
		String keyword = cteb.getKeyword();
		/*** 페이징 계산 ***///////////////////////////////////////////////////////
		int totalNum;
		int numInPage = 8;
		int totalPage;
		int groupSize = 5;
		System.out.println("[출력] cteb.getCurrentPage() : " + cteb.getCurrentPage());
		int currentPage = cteb.getCurrentPage();
		System.out.println("[출력] currentPage : " + currentPage);
		int startPage;
		int endPage;
		
		
		/* DB rownum */
		int numStart =1;
		int numEnd = 10;
		
		
		/* 토탈 넘버 */
		totalNum = this.sst.selectOne("getTotalNumBySearch", cteb);
		System.out.println("서치 totalNum : " + totalNum);
				
		/* 페이지 갯수 계산 */
		if(totalNum>0) {
			if((totalNum % numInPage) > 0){
				totalPage = (totalNum / numInPage) + 1;
				System.out.println("숫자 totalPage : " + totalPage);
			}else {
				totalPage = (totalNum / numInPage);
				System.out.println("숫자 totalPage : " + totalPage);
			}
			
		
			/* DB에 넣는 상품 rownum 인덱스 */
			numStart = (currentPage-1)*numInPage + 1;
			numEnd = currentPage*numInPage;
			System.out.println("[출력] numStart : " + numStart);
			System.out.println("[출력] numEnd : " + numEnd);
			
			/* 페이지 그룹 관련 인덱스 */
		    startPage = ((currentPage-1)/groupSize) * groupSize + 1;
		    endPage = (((currentPage-1)/groupSize)+1) * groupSize;
		    System.out.println("[출력] startPage : " + startPage);
		    System.out.println("[출력] endPage : " + endPage);
		    
			cteb.setTotalNum(totalNum);
			cteb.setTotalPage(totalPage);
			cteb.setCurrentPage(currentPage);
			cteb.setNumInPage(numInPage);
			cteb.setNumStart(numStart);
			cteb.setNumEnd(numEnd);
			cteb.setStartPage(startPage);
			cteb.setEndPage(endPage);
			
			System.out.println("cteb 확인 : " + cteb);
			
		/*** 상품 가져오기 ***////////////////////////////////////////////////////////////////
			List<ProductBean> pbList = this.sst.selectList("getProductListBySearch", cteb);
			
			/** 상품 사진 가져오기 **/
			for(ProductBean pb : pbList) {			
				List<ProductFileBean> pfbList = this.sst.selectList("getProductFileUrl", pb);
				List<SellerBean> sbList = this.sst.selectList("getSellerInfo", pb);
				System.out.println("pfbList 확인 : " + pfbList);
				
				if(pfbList!= null) {
					if(pfbList.size()>0) {/* out of index 피함*/
						if(pfbList.get(0).getPrfLocation() != null) {
							pb.setPrfLocation(pfbList.get(0).getPrfLocation());
							System.out.println(pb.getPrfLocation());
						}					
					}
				}
				
				/* 셀러 정보*/
				if(sbList!=null) {
					if(sbList.size()>0) {
						if(sbList.get(0).getSelShopName() !=null) {
							/*** 복호화 ***/
							try {
								pb.setSelShopName(this.enc.aesDecode(sbList.get(0).getSelShopName(), pb.getPrdSelCode()));
								pb.setSelNickname(this.enc.aesDecode(sbList.get(0).getSelNickname(), pb.getPrdSelCode()));
							} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
									| NoSuchPaddingException | InvalidAlgorithmParameterException | IllegalBlockSizeException
									| BadPaddingException e) 
							{e.printStackTrace(); }
							
						}
					}
				}
				
			}
			
		/*** 프론트로 json 넘기기 ***////////////////////////////////////////////////////////
			Gson gson_pretty = new GsonBuilder().setPrettyPrinting().create();
			/* 페이징 정보*/
			String json_paging = gson.toJson(cteb);
			mav.addObject("json_paging", json_paging);
			
			/* 상품 리스트 정보 */
			String json_pbList_pretty = gson_pretty.toJson(pbList);
					System.out.println("json_pbList_pretty ");
					System.out.println(": " + json_pbList_pretty);
			
			String json_pbList = gson.toJson(pbList);
					System.out.println("json_pbList : " + json_pbList);
			mav.addObject("json_pbList", json_pbList);
			
		}else {System.out.println("페이지가 없습니다.");
			cteb.setTotalNum(0);
			cteb.setTotalPage(0);
			String json_paging = gson.toJson(cteb);
			mav.addObject("json_paging", json_paging);
			
		}
		
	}
	
	
	private void makeProductList2(Model model) {
		System.out.println("makeProductList2 입구");
		Gson gson = new GsonBuilder().create();
		
		/** 프론트에서 온 form 정보 **/
		CategoriesBean cteb = (CategoriesBean)model.getAttribute("categoriesBean");
		
		if(cteb.getKeyword() != null) {
			
			/** keyword **/
			String keyword = cteb.getKeyword();
			
			/** 상품 리스트 불어오기 **********/
			/* 페이징 변수 */
			int totalNum;
			int numInPage = 8;
			int totalPage;
			int groupSize = 5;
			int currentPage;
			int startPage;
			int endPage;
			
			/* DB rownum */
			int numStart =1;
			int numEnd = 10;
			
			/**** 프론트 정보 ****/
			currentPage = cteb.getCurrentPage();
			System.out.println("프론트 currentPage :  " + cteb.getCurrentPage());
			
			/* 토탈 넘버 */
			totalNum = this.sst.selectOne("getTotalNumBySearch", cteb);
					
			/* 페이지 갯수 계산 */
			
				//totalPage = ( (totalNum - 1) / numInPage ) + 1   <-다른방법
			if(totalNum>0) {
				if((totalNum % numInPage) > 0){
					totalPage = (totalNum / numInPage) + 1;
					System.out.println("숫자 totalPage : " + totalPage);
				}else {
					totalPage = (totalNum / numInPage);
					System.out.println("숫자 totalPage : " + totalPage);
				}
				
				/* DB에 넣는 상품 rownum 인덱스 */
				numStart = (currentPage-1)*numInPage + 1;
				numEnd = currentPage*numInPage;
				
				/* 페이지 그룹 관련 인덱스 */
			    startPage = ((currentPage-1)/groupSize) * groupSize + 1;
			    endPage = (((currentPage-1)/groupSize)+1) * groupSize;

				cteb.setTotalNum(totalNum);
				cteb.setTotalPage(totalPage);
				cteb.setCurrentPage(currentPage);
				cteb.setNumInPage(numInPage);
				cteb.setNumStart(numStart);
				cteb.setNumEnd(numEnd);
				
				cteb.setStartPage(startPage);
				cteb.setEndPage(endPage);
				System.out.println("cteb 확인 : " + cteb);
				
				/* 상품 가져오기  */
				List<ProductBean> pbList = this.sst.selectList("getProductListBySearch", cteb);
				System.out.println("pbList 확인 : " + pbList);
				
				/* 상품 사진 가져오기 */
				for(ProductBean pb : pbList) {			
					List<ProductFileBean> pfbList = this.sst.selectList("getProductFileUrl", pb);
					List<SellerBean> sbList = this.sst.selectList("getSellerInfo", pb);
					System.out.println("pfbList 확인 : " + pfbList);
					
					if(pfbList!= null) {
						if(pfbList.size()>0) {/* out of index 피함*/
							if(pfbList.get(0).getPrfLocation() != null) {
								pb.setPrfLocation(pfbList.get(0).getPrfLocation());
								System.out.println(pb.getPrfLocation());
							}					
						}
					}
					
					/* 셀러 정보*/
					if(sbList!=null) {
						if(sbList.size()>0) {
							if(sbList.get(0).getSelShopName() !=null) {
								/*** 복호화 ***/
								try {
									pb.setSelShopName(this.enc.aesDecode(sbList.get(0).getSelShopName(), pb.getPrdSelCode()));
									pb.setSelNickname(this.enc.aesDecode(sbList.get(0).getSelNickname(), pb.getPrdSelCode()));
								} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
										| NoSuchPaddingException | InvalidAlgorithmParameterException | IllegalBlockSizeException
										| BadPaddingException e) 
								{e.printStackTrace(); }
								
							}
						}
					}
					
				}//for문 끝
				
				/* 프론트로 json 넘기기 */
				Gson gson_pretty = new GsonBuilder().setPrettyPrinting().create();
				
				
				String json_pbList_pretty = gson_pretty.toJson(pbList);
						System.out.println("json_pbList_pretty ");
						System.out.println(": " + json_pbList_pretty);
				
				String json_pbList = gson.toJson(pbList);
						System.out.println("json_pbList : " + json_pbList);
				
				String json_paging = gson.toJson(cteb);
				
				String json_pagingAndpbList = json_paging +"&"+json_pbList;
				
				///
				model.addAttribute("json_pagingAndpbList", json_pagingAndpbList);
				/*
				model.addAttribute("json_paging", json_paging);
				model.addAttribute("json_pbList", json_pbList);
				*/
			}else {System.out.println("페이지가 없습니다.");}
		
		}
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////
	private void moveCategory(ModelAndView mav) {
		System.out.println("[출력] pv-moveCategery()입구 ");
		Gson gson = new GsonBuilder().create();
		
		/** 프론트에서 온 form 정보 **/
		CategoriesBean cteb = ((CategoriesBean)mav.getModel().get("categoriesBean"));
		
		/** 카테고리 메뉴 생성 **/
		List<CategoriesBean> cteList = this.sst.selectList("getCategories");	
			System.out.println("cteList : " + cteList);
		String json_cteList = gson.toJson(cteList);
				System.out.println("json_cteList : " + json_cteList);
		mav.addObject("json_cteList", json_cteList);
		
		/** 카테고리 타이틀 생성 **/
		for(CategoriesBean ctb : cteList) {
			if(cteb.getCteCode().equals(ctb.getCteCode())) {
				
				String json_titleCteName = gson.toJson(ctb.getCteName());
					System.out.println("타이틀 네임 : " + json_titleCteName);
				mav.addObject("json_titleCteName", json_titleCteName);
			}
		}
		
		/*** 상품리스트, 페이징인덱스 생성 ****************************/
		if(cteb.getCteCode() != null) {
			System.out.println("프론트 cteb.getCteCode : " + cteb.getCteCode());
			// 현재 페이지 입력
			cteb.setCurrentPage(1);
			makeProductList(mav, cteb, gson);
		}
	
		
		
		
		/*** 페이지 반환 ********************************************/
		mav.setViewName("categoryPage");
		
	}//메서드 끝
	
	
	
	
	
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/** 상품 리스트 불어오기 **********/
	private void makeProductList(ModelAndView mav, CategoriesBean cteb, Gson gson) {		
		System.out.println("[출력] makeProductList 입구");
		/*** 페이징 계산 ***///////////////////////////////////////////////////////
		int totalNum;
		int numInPage = 8;
		int totalPage;
		int groupSize = 5;
		System.out.println("[출력] cteb.getCurrentPage() : " + cteb.getCurrentPage());
		int currentPage = cteb.getCurrentPage();
		System.out.println("[출력] currentPage : " + currentPage);
		int startPage;
		int endPage;
		
		
		/* DB rownum */
		int numStart =1;
		int numEnd = 10;
		
		
		/* 토탈 넘버 */
		totalNum = this.sst.selectOne("getTotalNumByCategory", cteb);
				
		/* 페이지 갯수 계산 */
		if(totalNum>0) {
			if((totalNum % numInPage) > 0){
				totalPage = (totalNum / numInPage) + 1;
				System.out.println("숫자 totalPage : " + totalPage);
			}else {
				totalPage = (totalNum / numInPage);
				System.out.println("숫자 totalPage : " + totalPage);
			}
			
		
			/* DB에 넣는 상품 rownum 인덱스 */
			numStart = (currentPage-1)*numInPage + 1;
			numEnd = currentPage*numInPage;
			
			/* 페이지 그룹 관련 인덱스 */
		    startPage = ((currentPage-1)/groupSize) * groupSize + 1;
		    endPage = (((currentPage-1)/groupSize)+1) * groupSize;
		    System.out.println("[출력] endPage : " + endPage);
		    
			cteb.setTotalNum(totalNum);
			cteb.setTotalPage(totalPage);
			cteb.setCurrentPage(currentPage);
			cteb.setNumInPage(numInPage);
			cteb.setNumStart(numStart);
			cteb.setNumEnd(numEnd);
			cteb.setStartPage(startPage);
			cteb.setEndPage(endPage);
			
			System.out.println("cteb 확인 : " + cteb);
			
		/*** 상품 가져오기 ***////////////////////////////////////////////////////////////////
			List<ProductBean> pbList = this.sst.selectList("getProductListByCategory2", cteb);
			
			/** 셀러 정보, 상품 사진 가져오기 **/
			for(ProductBean pb : pbList) {			
				List<SellerBean> sbList = this.sst.selectList("getSellerInfo", pb);
				List<ProductFileBean> pfbList = this.sst.selectList("getProductFileUrl", pb);
				System.out.println("pfbList 확인 : " + pfbList);
				
				/* 사진 */
				if(pfbList!= null) {
					if(pfbList.size()>0) {/* out of index 피함*/
						if(pfbList.get(0).getPrfLocation() != null) {																		
							pb.setPrfLocation(pfbList.get(0).getPrfLocation());
							System.out.println(pb.getPrfLocation());
						}					
					}
				}
				
				/* 셀러 정보*/
				if(sbList!=null) {
					if(sbList.size()>0) {
						if(sbList.get(0).getSelShopName() !=null) {
							/*** 복호화 ***/
							try {
								pb.setSelShopName(this.enc.aesDecode(sbList.get(0).getSelShopName(), pb.getPrdSelCode()));
								pb.setSelNickname(this.enc.aesDecode(sbList.get(0).getSelNickname(), pb.getPrdSelCode()));
							} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
									| NoSuchPaddingException | InvalidAlgorithmParameterException | IllegalBlockSizeException
									| BadPaddingException e) 
							{e.printStackTrace(); }
							
						}
					}
				}
			}
			
			
		/*** 프론트로 json 넘기기 ***////////////////////////////////////////////////////////
			Gson gson_pretty = new GsonBuilder().setPrettyPrinting().create();
			
			
			String json_pbList_pretty = gson_pretty.toJson(pbList);
					System.out.println("json_pbList_pretty ");
					System.out.println(": " + json_pbList_pretty);
			
			String json_pbList = gson.toJson(pbList);
					System.out.println("json_pbList : " + json_pbList);
			
			String json_paging = gson.toJson(cteb);
			mav.addObject("json_paging", json_paging);
			mav.addObject("json_pbList", json_pbList);
			
		}else {System.out.println("페이지가 없습니다.");}
		
	}
	
	
	private void makeProductList(Model model) {
		Gson gson = new GsonBuilder().create();
		
		/** 프론트에서 온 form 정보 **/
		CategoriesBean cteb = (CategoriesBean)model.getAttribute("categoriesBean");
		
		if(cteb.getCteCode() != null) {
			
			/** 상품 리스트 불어오기 **********/
			/* 페이징 변수 */
			int totalNum;
			int numInPage = 8;
			int totalPage;
			int groupSize = 5;
			int currentPage;
			int startPage;
			int endPage;
			
			/* DB rownum */
			int numStart =1;
			int numEnd = 10;
			
			/**** 프론트 정보 ****/
			currentPage = cteb.getCurrentPage();
			System.out.println("프론트 currentPage :  " + cteb.getCurrentPage());
			
			/* 토탈 넘버 */
			totalNum = this.sst.selectOne("getTotalNumByCategory", cteb);
					
			/* 페이지 갯수 계산 */
			
				//totalPage = ( (totalNum - 1) / numInPage ) + 1   <-다른방법
			if(totalNum>0) {
				if((totalNum % numInPage) > 0){
					totalPage = (totalNum / numInPage) + 1;
					System.out.println("숫자 totalPage : " + totalPage);
				}else {
					totalPage = (totalNum / numInPage);
					System.out.println("숫자 totalPage : " + totalPage);
				}
				
				/* DB에 넣는 상품 rownum 인덱스 */
				numStart = (currentPage-1)*numInPage + 1;
				numEnd = currentPage*numInPage;
				
				/* 페이지 그룹 관련 인덱스 */
			    startPage = ((currentPage-1)/groupSize) * groupSize + 1;
			    endPage = (((currentPage-1)/groupSize)+1) * groupSize;

				cteb.setTotalNum(totalNum);
				cteb.setTotalPage(totalPage);
				cteb.setCurrentPage(currentPage);
				cteb.setNumInPage(numInPage);
				cteb.setNumStart(numStart);
				cteb.setNumEnd(numEnd);
				
				cteb.setStartPage(startPage);
				cteb.setEndPage(endPage);
				System.out.println("cteb 확인 : " + cteb);
				
				/* 상품 가져오기  */
				List<ProductBean> pbList = this.sst.selectList("getProductListByCategory2", cteb);
				System.out.println("pbList 확인 : " + pbList);
				
				/* 상품 사진 가져오기 */
				for(ProductBean pb : pbList) {			
					List<ProductFileBean> pfbList = this.sst.selectList("getProductFileUrl", pb);
					List<SellerBean> sbList = this.sst.selectList("getSellerInfo", pb);
					System.out.println("pfbList 확인 : " + pfbList);
					
					if(pfbList!= null) {
						if(pfbList.size()>0) {/* out of index 피함*/
							if(pfbList.get(0).getPrfLocation() != null) {
								pb.setPrfLocation(pfbList.get(0).getPrfLocation());
								System.out.println(pb.getPrfLocation());
							}					
						}
					}
					
					/* 셀러 정보*/
					if(sbList!=null) {
						if(sbList.size()>0) {
							if(sbList.get(0).getSelShopName() !=null) {
								/*** 복호화 ***/
								try {
									pb.setSelShopName(this.enc.aesDecode(sbList.get(0).getSelShopName(), pb.getPrdSelCode()));
									pb.setSelNickname(this.enc.aesDecode(sbList.get(0).getSelNickname(), pb.getPrdSelCode()));
								} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
										| NoSuchPaddingException | InvalidAlgorithmParameterException | IllegalBlockSizeException
										| BadPaddingException e) 
								{e.printStackTrace(); }
								
							}
						}
					}
				}//for문 끝
				
				/* 프론트로 json 넘기기 */
				Gson gson_pretty = new GsonBuilder().setPrettyPrinting().create();
				
				
				String json_pbList_pretty = gson_pretty.toJson(pbList);
						System.out.println("json_pbList_pretty ");
						System.out.println(": " + json_pbList_pretty);
				
				String json_pbList = gson.toJson(pbList);
						System.out.println("json_pbList : " + json_pbList);
				
				String json_paging = gson.toJson(cteb);
				
				String json_pagingAndpbList = json_paging +"&"+json_pbList;
				
				///
				model.addAttribute("json_pagingAndpbList", json_pagingAndpbList);
				/*
				model.addAttribute("json_paging", json_paging);
				model.addAttribute("json_pbList", json_pbList);
				*/
			}else {System.out.println("페이지가 없습니다.");}
		
		}
	}
	
	
	
	private void moveProductInfo(ModelAndView mav){
		System.out.println("[출력] pv-moveProductInfo()입구 ");
		Gson gson = new GsonBuilder().create();
		ViewHistoryBean vhb = new ViewHistoryBean();
		/** 프론트에서 온 form 정보 **/
		ProductBean pb = ((ProductBean)mav.getModel().get("productBean"));
			System.out.println(" 프론트 ProductBean : " + pb);
	
		/** 셀러샵 정보 ******************************/
			
		SellerBean sellerInfo = (SellerBean)this.sst.selectList("getSellerInfo", pb).get(0);
		System.out.println("sellerInfo : " + sellerInfo);
		try {
			sellerInfo.setSelNickname(this.enc.aesDecode(sellerInfo.getSelNickname(), pb.getPrdSelCode()));
			sellerInfo.setSelShopName(this.enc.aesDecode(sellerInfo.getSelShopName(), pb.getPrdSelCode()));
		} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException
				| NoSuchPaddingException | InvalidAlgorithmParameterException | IllegalBlockSizeException
				| BadPaddingException e) 
		{e.printStackTrace(); }
		
		String json_sellerInfo = gson.toJson(sellerInfo);
		
		
		mav.addObject("json_sellerInfo", json_sellerInfo);
		
			
		/** 상품 정보 ******************************/
			//System.out.println("SSS : " + this.sst.selectList("getProductInfo_LSE", pb));
		ProductBean productInfo = (ProductBean)this.sst.selectList("getProductInfo_LSE", pb).get(0);
		System.out.println("ProductInfo : " + productInfo);
		
		
		/** 상품 사진 ****/
		/* 상품 사진 가져오기 */
		ProductFileBean pfb = this.sst.selectOne("getProductFileUrl", pb);
		if(pfb != null) {
			if(pfb.getPrfLocation() != null) {
				productInfo.setPrfLocation(pfb.getPrfLocation());
				System.out.println("[출력] 상품정보 상품사진주소 : " + productInfo.getPrfLocation());
			}
		}
		
		String json_productInfo = gson.toJson(productInfo);
		mav.addObject("productInfo", productInfo);
		mav.addObject("json_productInfo", json_productInfo);
		
		
		/*
		String json_pbList = gson.toJson(null)
		mav.addObject("ProductInfo", pb2);
		*/
		
		/** 구매하기 버튼 **/
		
		
		/** 조회 기록 ******************************/
		/* 1. 세션 확인
		 * 2. 세션 없으면 실행하지 않음
		 * 3. 세션 있으면 VIEWHISTORY에 접근
		 * 	3-1. 이미 레코드 있으면, UPDATE
		 *	3-2. 레코드 없으면, INSERT
		 * */
		try {
			System.out.println("[출력] 상품조회 관련 try문 입구");
			System.out.println("[출력] 세션 accessInfo :  "+ this.pu.getAttribute("accessInfo"));
			if(this.pu.getAttribute("accessInfo") != null) {
				JSONObject json_buySession = new JSONObject((String)this.pu.getAttribute("accessInfo"));
				
					//System.out.println("[출력] json_buySession : " + json_buySession);
				
				
				if(json_buySession != null) {
					System.out.println("[출력] 상품조회 관련 if문 입구");
					
					//String buyCode = json_buySession.getString("buyCode");
					vhb.setVhsBuyCode(json_buySession.getString("buyCode"));
					vhb.setVhsPrdCteCode(pb.getPrdCteCode());
					vhb.setVhsPrdSelCode(pb.getPrdSelCode());
					vhb.setVhsPrdCode(pb.getPrdCode());
					System.out.println("vhb : " + vhb);
					
					// 레코드 유무 파악.
					List<ViewHistoryBean> vhbList = this.sst.selectList("isViewHistory", vhb);
					//ViewHistoryBean vhbList = (ViewHistoryBean)this.sst.selectList("isViewHistory", vhb).get(0);
					if(vhbList != null) {
						String result = Integer.toString(vhbList.size());
						///* String result = this.sst.selectOne("isViewHistory", vhb);*/
						System.out.println("isViewHistory 결과 :  " + result);
						if(result.equals("1")) {
							// 조회시간 update
							if(this.convertToBool(this.sst.update("updVhsDate", vhb))) {
								System.out.println("[출력] 조회시간 업데이트 성공");
								this.checkWish(mav, vhbList, gson);
							}else {
								System.out.println("[출력] 조회시간 업데이트 실패");
							}
							
						}else if(result.equals("0")){
							// 최초조회 insert
							if(this.convertToBool(this.sst.insert("insVHS", vhb))) {
								System.out.println("[출력] 최초조회 인서트 성공");
								List<ViewHistoryBean> vhbList2 = this.sst.selectList("isViewHistory", vhb);
								this.checkWish(mav, vhbList2, gson);
							}else {
								System.out.println("[출력] 최초조회 인서트 실패");
							}
						}else {
							System.out.println("DB 테이블 상태 파악 필요");
						}
						//this.checkWish(mav, vhbList, gson);
					}
					/** 팔로우 상태 확인 *******************************/
					System.out.println("checkFollow 전 라인");
					System.out.println("checkFollow 전 vhb : " + vhb);
					this.checkFollow(mav, vhb, gson);
						
				}
			}
			System.out.println("try문 안 vhb 정보 :  " + vhb);
		} catch (Exception e) {	e.printStackTrace();}
		

		System.out.println("mav에 들어간 json_folbList :  " +	mav.getModel().get("json_folbList"));
		
		/*** JSP 페이지 반환 ******************************/
		System.out.println("[출력] pv-moveProductInfo()출구 ");
		mav.setViewName("productInfoPage");
	}
	

	private void checkFollow(ModelAndView mav, ViewHistoryBean vhb, Gson gson) {
		if(vhb != null) {
			if((vhb.getVhsBuyCode() != null)&(vhb.getVhsPrdSelCode() != null)) {
					System.out.println("[출력] 팔로우 지점 vhb 정보 :  " + vhb);
				List<FollowBean> folbList = this.sst.selectList("isFollow", vhb);
				System.out.println("[출력] 첫번째 fbList :  " + folbList);
				
				if((folbList != null)&(folbList.size()==1)){
					folbList.get(0).setFolAction("Y");
					System.out.println("[출력] fbList.size()==1 fbList 정보:  " + folbList);
					String json_folbList = gson.toJson(folbList.get(0));
					mav.addObject("json_folbList", json_folbList);
				}else if(folbList.size()==0) {
					FollowBean fb= new FollowBean();
					fb.setFolBuyCode(vhb.getVhsBuyCode());
					fb.setFolSelCode(vhb.getVhsPrdSelCode());
					fb.setFolAction("N");
					folbList.add(fb);
					System.out.println("[출력] fbList.size()==0, fbList 정보 :  " + folbList);
					String json_folbList = gson.toJson(folbList.get(0));
					mav.addObject("json_folbList", json_folbList);
				}else {
					System.out.println("Follow DB 정보 이상");
				}
				
			}
		}
	}
	
	private void changeFollow(Model model) {
		FollowBean fb = (FollowBean)model.getAttribute("followBean");
		System.out.println("[출력] pv-changeFollow 입구");
		System.out.println("[출력] 프론트 fb :"  + fb);
		if(fb != null) {
			if((fb.getFolBuyCode() != null)&(fb.getFolSelCode() != null)) {
				if(fb.getFolAction().equals("N")) { /* N -> Y로 변화 */
					if(this.convertToBool(this.sst.insert("insFollow", fb))) {
						System.out.println("[출력] 팔로우 insert 성공");
						fb.setFolAction("Y");
						model.addAttribute("followInfo", fb);
					}else {
						System.out.println("[출력] 팔로우 insert 실패");
					}
				}else if(fb.getFolAction().equals("Y")) { /* Y -> N로 변화 */
					if(this.convertToBool(this.sst.delete("delFollow", fb))) {
						System.out.println("[출력] 팔로우 delete 성공");
						fb.setFolAction("N");
						model.addAttribute("followInfo", fb);
					}else {
						System.out.println("[출력] 팔로우 delete 실패");
					}
				}
			}else {
				System.out.println("[출력] 프론트 FollowBean 데이터문제2");
			}
		}else {
			System.out.println("[출력] 프론트 FollowBean 데이터문제1");
		}
		
	}
	
	
	private void checkWish(ModelAndView mav, List<ViewHistoryBean> vhbList, Gson gson) {
		if(vhbList != null) {
			if(vhbList.size()>0) {
				// 과거 코드 ViewHistoryBean vhb = vhbList.get(0);
				
				String json_vhb = gson.toJson(vhbList.get(0));
				System.out.println("[출력] checkWish - json_vhb 정보 :  " + json_vhb);
				mav.addObject("json_vhb", json_vhb);
				
			}
		}
	}
	
	private void changeWish(Model model) {
		System.out.println("[출력] pv-changeWish입구 ");
		ViewHistoryBean vhb = (ViewHistoryBean)model.getAttribute("viewHistoryBean");
		String wishAction = vhb.getVhsWishAction();
		if(wishAction.equals("Y")){
			if(this.convertToBool(this.sst.update("updVhsNo", vhb))){
				System.out.println("[출력] 위시 N로 변경 성공");
			}else {
				System.out.println("[출력] 위시 N로 변경 실패");
			}
		}else if(wishAction.equals("N")) {
			if(this.convertToBool(this.sst.update("updVhsYes", vhb))){
				System.out.println("[출력] 위시 Y로 변경 성공");
			}else {
				System.out.println("[출력] 위시 Y로 변경 실패");
			}
		}else {
			System.out.println("[출력] wishAction 프론트 정보가 잘못됨");
		}
		
		List<ViewHistoryBean> vhbList_back = this.sst.selectList("isViewHistory", vhb);
		//ViewHistoryBean vhb_callback = (ViewHistoryBean)this.sst.selectList("isViewHistory", vhb).get(0);
		System.out.println("체인지 후 정보 vhbList_back" + vhbList_back);
		model.addAttribute("vhbList_back", vhbList_back);
	}
	

	
	
	private boolean convertToBool(int result) {
		return result >= 1 ? true : false;
	}
}



