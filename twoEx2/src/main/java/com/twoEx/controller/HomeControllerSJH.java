package com.twoEx.controller;
  
  import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import
  org.springframework.web.bind.annotation.RequestMapping;
import
  org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.twoEx.bean.ProductBean;
import com.twoEx.bean.ProductFile;
import com.twoEx.service.ClassroomManagement;
import com.twoEx.service.ProductManagement;
import com.twoEx.service.Purchase;
import com.twoEx.service.Sales;

import lombok.extern.java.Log;
  
  @Controller 
  @Log
  public class HomeControllerSJH {
	  @Autowired
		private Sales sales;
	  @Autowired
	  	private SqlSessionTemplate session;
	  @Autowired
	  	private  Purchase purchase;
	  @Autowired
	  	private  ProductManagement pm;
	  @Autowired
	  	private  ClassroomManagement cm;
  
//마이샵 이동
		@RequestMapping(value = "/moveMyshop", method = RequestMethod.POST)
		public ModelAndView moveMyshop(ModelAndView mav,@ModelAttribute ProductBean pb) {
			System.out.println("moveMyshop");
			mav.addObject(pb);
			this.sales.backController("moveMyshop", mav);
			return mav;
		}
		//상품등록페이지 이동
		@RequestMapping(value = "/moveRegisterGoods", method = RequestMethod.POST)
		public ModelAndView moveregisterGoods(ModelAndView mav,@ModelAttribute ProductBean pb) {
			System.out.println("moveRegisterGoods");
			mav.addObject(pb);
			this.sales.backController("moveRegisterGoods", mav);
			return mav;
		}
		//상품등록
				@RequestMapping(value = "/registerProduct", method = RequestMethod.POST)
				public ModelAndView registerProduct(ModelAndView mav,@ModelAttribute ProductBean pb) {
					System.out.println("registerProduct");
					System.out.println(pb);
					mav.addObject(pb);
					this.sales.backController("registerProduct", mav);			
					return mav;
				}
				
				@RequestMapping(value = "/delProduct", method = RequestMethod.POST)
					public ModelAndView delProduct (ModelAndView mav,@ModelAttribute ProductBean prd) {
					mav.addObject(prd);
						this.sales.backController("delProduct", mav);		
						return mav;
					}
		//상품수정,삭제페이지 이동
		@RequestMapping(value = "/moveModifyProduct", method = RequestMethod.POST)
		public ModelAndView moveModifyProduct(ModelAndView mav,@ModelAttribute ProductBean pb) {
			System.out.println("moveModifyProduct");
			mav.addObject(pb);
			this.sales.backController("moveModifyProduct", mav);
			return mav;
		}
		
		//상품수정페이지 이동
				@RequestMapping(value = "/moveUpdProduct", method = RequestMethod.POST)
				public ModelAndView moveUpdProduct(ModelAndView mav,@ModelAttribute ProductBean pb) {
					System.out.println("moveUpdProduct");
					mav.addObject(pb);
					this.sales.backController("moveUpdProduct", mav);
					return mav;
				}
				
		//상품수정		
				@RequestMapping(value = "/updProduct", method = RequestMethod.POST)
				public ModelAndView updProduct(ModelAndView mav,@ModelAttribute ProductBean pb) {
					System.out.println("updProduct");
					mav.addObject(pb);
					this.sales.backController("updProduct", mav);			
					return mav;
				}	
				
				//판매자 전문분야 등록
				@RequestMapping(value = "/insCte", method = RequestMethod.POST)
				public ModelAndView insCte(ModelAndView mav,@ModelAttribute ProductBean pb) {
					System.out.println("insCte");
					mav.addObject(pb);
					this.sales.backController("insCte", mav);			
					return mav;
				}	
				
				
				//판매자 전문분야 등록
				@RequestMapping(value = "/regCte", method = RequestMethod.POST)
				public ModelAndView regCte(ModelAndView mav,@ModelAttribute ProductBean pb) {
					System.out.println("regCte");
					
					mav.addObject(pb);
					this.sales.backController("regCte", mav);			
					return mav;
				}
				

			
				
				@RequestMapping(value = "/moveOrder", method = RequestMethod.POST)
				public ModelAndView moveOrder(ModelAndView mav,@ModelAttribute ProductBean pb) {
					System.out.println("moveOrder");
					mav.addObject(pb);
				
					//mav.addObject(buy);
					this.purchase.backController("moveOrder", mav);
					return mav;
				}

			
	
				@PostMapping("/upload_ok")
				public ModelAndView upload(@RequestParam("file") MultipartFile file,ModelAndView mav,@ModelAttribute ProductBean pb) {
					
					
					
					
					String fileRealName = file.getOriginalFilename(); //파일명을 얻어낼 수 있는 메서드!
					long size = file.getSize(); //파일 사이즈
					
					System.out.println("파일명 : "  + fileRealName);
					System.out.println("용량크기(byte) : " + size);
					//서버에 저장할 파일이름 fileextension으로 .jsp이런식의  확장자 명을 구함
					String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
					String uploadFolder = "C:\\Users\\user\\git\\ExpertExchange\\twoEx\\src\\main\\webapp\\resources\\prdImage\\"+pb.getPrdSelCode();
					if(!new File(uploadFolder).exists()) new File(uploadFolder).mkdirs();
					//82103
					//"C:\\Users\\Byul\\git\\ExpertExchange\\twoEx\\src\\main\\webapp\\resources\\prdImage\\"
					
					mav.addObject("selectCte", insCTE(pb, "prdCteCode"));
					mav.addObject("checkedCte", makeSelectCTE(pb, "prdCteCode"));
					
					int fileNumber;
					if(new File(uploadFolder).list() == null) { 
						fileNumber=0; 
					}else {
						fileNumber = new File(uploadFolder).list().length;
					}
					System.out.println("폴더 내 파일의 갯수 : " + fileNumber);
					
					
				
					pb.setPrfName(fileRealName);
					pb.setPrfLocation("res/prdImage/"+pb.getPrdSelCode()+"/"+fileRealName);
					System.out.println("테이블 저장 로케이션 : " + pb.getPrfLocation());
					System.out.println("파일이름 : " + fileRealName);
					System.out.println("File Location : " + uploadFolder);
					
					/*
					  파일 업로드시 파일명이 동일한 파일이 이미 존재할 수도 있고 사용자가 
					  업로드 하는 파일명이 언어 이외의 언어로 되어있을 수 있습니다. 
					  타인어를 지원하지 않는 환경에서는 정산 동작이 되지 않습니다.(리눅스가 대표적인 예시)
					  고유한 랜던 문자를 통해 db와 서버에 저장할 파일명을 새롭게 만들어 준다.
					 */
					
					UUID uuid = UUID.randomUUID();
					System.out.println(uuid.toString());
					String[] uuids = uuid.toString().split("-");
					
					String uniqueName = uuids[0];
					System.out.println("생성된 고유문자열" + uniqueName);
					System.out.println("확장자명" + fileExtension);
					
					
					
					// File saveFile = new File(uploadFolder+"\\"+fileRealName); uuid 적용 전
												
					File saveFile = new File(uploadFolder+"\\"+fileRealName);  // 적용 후
					try {
					
						
						file.transferTo(saveFile); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
						
						String getPrdCode= this.session.selectOne("getPrdCode",pb);
						
						String prfCode=this.session.selectOne("getPrfCode",pb);

						
						mav.addObject("selectData", sales.makeSelectCTE(pb, "prdCteCode"));
						
						
						mav.addObject("prfLocation", pb.getPrfLocation());
						mav.addObject("prfCode", prfCode);
						mav.addObject("prfName", pb.getPrfName());
						mav.addObject("prdCode", getPrdCode);
						mav.setViewName("myShop/registerProduct");
						return mav;
						
						
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					return mav;
					
				}
				
				
				
				@RequestMapping(value = "/kakaopay", method = RequestMethod.POST)
			    public String kakaoPay(@ModelAttribute ProductBean pb,ModelAndView mav) {
			        log.info("kakaoPay post............................................");
			       
			        mav.addObject(pb);
			       System.out.println("홈커네임:"+pb.getPrdName());

			        return "redirect:" + purchase.kakaoPayReady(mav);
			 
			    }
			    
			    @GetMapping("/kakaoPaySuccess")
			    public ModelAndView kakaoPaySuccess(@RequestParam("pg_token") String pg_token, ModelAndView mav,@ModelAttribute ProductBean pb) {
			    	 mav.addObject(pb);
			        log.info("kakaoPaySuccess get............................................");
			        log.info("kakaoPaySuccess pg_token : " + pg_token);
//			        mav.addObject("info", purchase.kakaoPayInfo(pg_token, mav));
			        
			        purchase.kakaoPayInfo(pg_token, mav);
			        return mav;
			    	}
			    
			    @GetMapping("/kakaoPayCancel")
			    public String kakaoPayCancel() {
			    	
			    	
			    	return "productInfoPage";        
			    	}
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
  }
  