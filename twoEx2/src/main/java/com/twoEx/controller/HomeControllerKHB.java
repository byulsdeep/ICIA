package com.twoEx.controller;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.twoEx.bean.BuyerBean;
import com.twoEx.bean.ClassroomBean;
import com.twoEx.bean.CurriculumBean;
import com.twoEx.service.ClassroomManagement;
import com.twoEx.service.Master;
import com.twoEx.utils.ProjectUtils;

@Controller
public class HomeControllerKHB {
	@Autowired
	private ClassroomManagement cm;
	@Autowired
	private Master ma;
	@Autowired
	private ProjectUtils pu;
	@Autowired
	private SqlSessionTemplate session;
	
	@PostMapping("/moveSellerMyClass")
	public ModelAndView moveAccountInfo (ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveSellerMyClass");
		mav.addObject(cb);
		cm.backController("moveSellerMyClass", mav);
		return mav;
	}	
	/*
	@PostMapping("/moveManageCurriculum")
	public ModelAndView moveManageCurriculum (ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveManageCurriculum");
		mav.addObject(cb);
		cm.backController("moveManageCurriculum", mav);
		return mav;
	}
	*/	
	@PostMapping("/moveManageStudent")
	public ModelAndView moveManageStudent (ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveManageStudent");
		mav.addObject(cb);
		cm.backController("moveManageStudent", mav);
		return mav;
	}	
	@PostMapping("/moveManageAssignment")
	public ModelAndView moveManageAssignment (ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveManageAssignment");
		mav.addObject(cb);
		cm.backController("moveManageAssignment", mav);
		return mav;
	}	
	@PostMapping("/moveManageGrade")
	public ModelAndView moveManageGrade (ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveManageGrade");
		mav.addObject(cb);
		cm.backController("moveManageGrade", mav);
		return mav;
	}	
	@PostMapping("/moveManageNotice")
	public ModelAndView moveManageNotice (ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveManageNotice");
		mav.addObject(cb);
		cm.backController("moveManageNotice", mav);
		return mav;
	}	
	@PostMapping("/moveManageMap")
	public ModelAndView moveManageMap (ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveManageMap");
		mav.addObject(cb);
		cm.backController("moveManageMap", mav);
		return mav;
	}	
	@PostMapping("/moveAssignmentDetail")
	public ModelAndView moveAssignmentDetail (ModelAndView mav, @RequestParam Map<String, String> data, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveAssignmentDetail");
		mav.addObject("data", data);
		mav.addObject(cb);
		cm.backController("moveAssignmentDetail", mav);
		return mav;
	}	
	
	@RequestMapping(value = "/master", method = RequestMethod.GET)
	public String master(Model model) {
		System.out.println("master");
		return "master";
	}
	
	@PostMapping("/masterInsert")
	public ModelAndView masterInsert (ModelAndView mav, @ModelAttribute BuyerBean bb) {
		System.out.println("masterInsert");
		mav.addObject(bb);
		ma.masterInsert(mav);
		return mav;
	}	
	
	@PostMapping("/masterLogIn")
	public ModelAndView masterLogIn (ModelAndView mav, @ModelAttribute BuyerBean bb) {
		System.out.println("masterLogIn");
		mav.addObject(bb);
		ma.masterLogIn(mav);
		return mav;
	}	
	
	@PostMapping("/moveChat")
	public ModelAndView moveChat (ModelAndView mav, @ModelAttribute ClassroomBean cb) {

		String accessInfo = null;
		String buyCode=null;
		String selCode=null;
		String userType=null;

		try {
			accessInfo=(String)this.pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
			userType = bean.getAsJsonObject().get("userType").getAsString();
			mav.addObject("userType", userType);
			if(userType.equals("buyer")) {buyCode=bean.getAsJsonObject().get("buyCode").getAsString();
			mav.addObject("buyCode", buyCode);
			}
			else {selCode=bean.getAsJsonObject().get("selCode").getAsString();
			mav.addObject("selCode", selCode);}
		} catch (Exception e) {
			e.printStackTrace();	
			mav.setViewName("mainPage");
		}	

		mav.setViewName("classroom/chat");

		String json = new Gson().toJson(cb);
		mav.addObject("classInfo", json);

		List<CurriculumBean> cbl = this.session.selectList("getCurriculumInfo", cb);
		String json2 = new Gson().toJson(cbl);
		mav.addObject("curriculumInfo", json2);	

		return mav;
	}	
}