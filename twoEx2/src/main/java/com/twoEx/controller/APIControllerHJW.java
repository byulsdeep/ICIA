package com.twoEx.controller;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.twoEx.bean.GetMyPageBean;
import com.twoEx.bean.NoticeBean;
import com.twoEx.bean.Tt;
import com.twoEx.service.ClassroomManagement;
import com.twoEx.service.MyPage;
import com.twoEx.utils.Encryption;

@RestController
public class APIControllerHJW {
	@Autowired
	private MyPage mypage;
	@Autowired
	private ClassroomManagement cm;
	@Autowired
	private Encryption enc;

	@SuppressWarnings("unchecked")
	@PostMapping("/orderList6Months")
	public List<GetMyPageBean> orderList6Months(Model model) {
		System.out.println("APIctl : orderList6Months");
		
		mypage.backController("orderList6Months", model);
		
		System.out.println("api contoller6 데이터 :" + model.getAttribute("json_orderList6"));
		
		return (List<GetMyPageBean>)model.getAttribute("json_orderList6");
	}
	
	@SuppressWarnings("unchecked")
	@PostMapping("/orderList3Months")
	public List<GetMyPageBean> orderList3Months(Model model) {
		System.out.println("APIctl : orderList3Months");
		
		mypage.backController("orderList3Months", model);
		
		System.out.println("api contoller3 데이터 :" + model.getAttribute("json_orderList3"));
		
		return (List<GetMyPageBean>)model.getAttribute("json_orderList3");
	}
	@SuppressWarnings("unchecked")
	@PostMapping("/orderListMonth")
	public List<GetMyPageBean> orderListMonth(Model model) {
		System.out.println("APIctl : orderListMonth");
		
		mypage.backController("orderListMonth", model);
		
		System.out.println("api contoller1 데이터 :" + model.getAttribute("json_orderList1"));
		
		return (List<GetMyPageBean>)model.getAttribute("json_orderList1");
	}
	
	@SuppressWarnings("unchecked")
	@PostMapping("/orderDate")
	public List<GetMyPageBean> orderDate(Model model, @ModelAttribute GetMyPageBean GPB) {
		
		System.out.println("orderDate 값 ");
		System.out.println(GPB.getOrderFromDate());
		System.out.println(GPB.getOrderToDate());
		
		mypage.backController("orderDate", model);

		return (List<GetMyPageBean>)model.getAttribute("json_orderDate");
	}
	@SuppressWarnings("unchecked")
	@PostMapping("/deleteNotice")
	public List<NoticeBean> deleteNotice(Model model, @ModelAttribute NoticeBean nb) {
		System.out.println("deleteNotice");	
		model.addAttribute(nb);	
		System.out.println(nb);
		this.cm.backController("deleteNotice", model);	
		return (List<NoticeBean>)model.getAttribute("refreshedList");
	}
	@SuppressWarnings("unchecked")
	@PostMapping("/updateNotice")
	public List<NoticeBean> updateNotice(Model model, @ModelAttribute NoticeBean nb) {
		System.out.println("updateNotice");	
		model.addAttribute(nb);	
		System.out.println(nb);
		this.cm.backController("updateNotice", model);	
		return (List<NoticeBean>)model.getAttribute("refreshedList");
	}		
	
	@SuppressWarnings("unchecked")
	@PostMapping("/testEnc")
	public void testEnc(Model model, @ModelAttribute Tt tt) {
		System.out.println("test");	
		System.out.println("힌트:"+ tt.getHint());
		System.out.println("값:"+ tt.getValue());
		
		
		try {
			System.out.println("암호화 : " +this.enc.aesEncode(tt.getValue(),tt.getHint()));
		} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException | NoSuchPaddingException
				| InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}		
	
	@SuppressWarnings("unchecked")
	@PostMapping("/testDec")
	public void testDec(Model model, @ModelAttribute Tt tt) {
		System.out.println("test");	
		System.out.println("힌트:"+ tt.getHint());
		System.out.println("값:"+ tt.getValue());
		
		
		try {
			System.out.println("복호화 : " +this.enc.aesDecode(tt.getValue(), tt.getHint()));
		} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException | NoSuchPaddingException
				| InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}		

}
