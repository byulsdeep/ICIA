package com.twoEx.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.twoEx.bean.BuyerBean;
import com.twoEx.utils.Encryption;
import com.twoEx.utils.ProjectUtils;

@Service
public class Master {
	@Autowired
	private Encryption enc;
	@Autowired
	private SqlSessionTemplate session;
	@Autowired
	private ProjectUtils pu;

	public ModelAndView masterInsert(ModelAndView mav) {
		System.out.println("masterInsert");

		mav.setViewName("master");
		String isSuccess = null;
		BuyerBean bb = (BuyerBean) mav.getModel().get("buyerBean");

		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		System.out.println(gson.toJson(bb));

		try {
			bb.setBuyEmail(enc.aesEncode(bb.getBuyEmail(), bb.getBuyCode()));
			bb.setBuyRegion(enc.aesEncode(bb.getBuyRegion(), bb.getBuyCode()));
			bb.setBuyNickname(enc.aesEncode(bb.getBuyNickname(), bb.getBuyCode()));
			bb.setBuyProfile(enc.aesEncode(bb.getBuyProfile(), bb.getBuyCode()));

			if (session.insert("masterInsert", bb) != 0) {
				System.out.println("success");
				isSuccess = "success";
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
			isSuccess = String.valueOf(e);
		}

		mav.addObject("isSuccess", isSuccess);
		return mav;
	}

	public ModelAndView masterLogIn(ModelAndView mav) {
		System.out.println("masterLogIn");

		mav.setViewName("master");

		BuyerBean bb = (BuyerBean) mav.getModel().get("buyerBean");

		BuyerBean bd = (BuyerBean) this.session.selectList("getBuyerAccessInfo", bb).get(0);
		try {
			bd.setBuyEmail(enc.aesDecode(bd.getBuyEmail(), bd.getBuyCode()));
			bd.setBuyRegion(enc.aesDecode(bd.getBuyRegion(), bd.getBuyCode()));
			bd.setBuyNickname(enc.aesDecode(bd.getBuyNickname(), bd.getBuyCode()));
			bd.setBuyProfile(enc.aesDecode(bd.getBuyProfile(), bd.getBuyCode()));
			bd.setUserType("buyer");
			String accessInfo = new Gson().toJson(bd);
			pu.setAttribute("accessInfo", accessInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}

		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		System.out.println(gson.toJson(bd));

		List<BuyerBean> list = session.selectList("masterLogIn", bb);

		for (int i = 0; i < list.size(); i++) {
			try {
				list.get(i).setBuyEmail(enc.aesDecode(list.get(i).getBuyEmail(), list.get(i).getBuyCode()));
				list.get(i).setBuyRegion(enc.aesDecode(list.get(i).getBuyRegion(), list.get(i).getBuyCode()));
				list.get(i).setBuyNickname(enc.aesDecode(list.get(i).getBuyNickname(), list.get(i).getBuyCode()));
				list.get(i).setBuyProfile(enc.aesDecode(list.get(i).getBuyProfile(), list.get(i).getBuyCode()));
			} catch (Exception e) {
			}
		}
		list.add(bd);

		String text = "<div>";
		for (int i = 0; i < list.size(); i++) {
			if(i == list.size()-1) {
				text += "<div><b> LOGGED IN AS: " + list.get(i) + "</b></div>";
			} else {
				text += "<div>" + list.get(i) + "</div>";
			}
		}
		text += "</div>";

		System.out.println(gson.toJson(list));
		mav.addObject("isSuccess", text);
		return mav;
	}
}
