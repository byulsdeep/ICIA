package com.twoEx.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.twoEx.bean.AssignmentBean;
import com.twoEx.bean.CurriculumBean;
import com.twoEx.bean.NoticeBean;
import com.twoEx.bean.StudentBean;
import com.twoEx.bean.SubmittedAssignmentBean;
import com.twoEx.service.ClassroomManagement;

@RestController
public class APIControllerKHB {
	@Autowired
	ClassroomManagement cm;

	@PostMapping("/banChat")
	public StudentBean banChat(Model model, @ModelAttribute StudentBean sb) {
		System.out.println("banChat");	
		model.addAttribute(sb);	
		this.cm.backController("banChat", model);	
		return (StudentBean)model.getAttribute("refreshedList");
	}	
	@PostMapping("/unBanChat")
	public StudentBean unBanChat(Model model, @ModelAttribute StudentBean sb) {
		System.out.println("unBanChat");	
		model.addAttribute(sb);	
		this.cm.backController("unBanChat", model);	
		return (StudentBean)model.getAttribute("refreshedList");
	}	
	@PostMapping("/getNewNoticeCode")
	public String getNewNoticeCode(Model model, @ModelAttribute NoticeBean nb) {
		System.out.println("getNewNoticeCode");	
		model.addAttribute(nb);	
		this.cm.backController("getNewNoticeCode", model);	
		return (String)model.getAttribute("newNoticeCode");
	}	
	@PostMapping("/addNotice")
	public List<NoticeBean> addNotice(Model model, @ModelAttribute NoticeBean nb) {
		System.out.println("addNotice");	
		model.addAttribute(nb);	
		this.cm.backController("addNotice", model);	
		return (List<NoticeBean>)model.getAttribute("refreshedList");
	}	
	@PostMapping("/addAssignment")
	public List<AssignmentBean> addAssignment(Model model, @ModelAttribute AssignmentBean ab) {
		System.out.println("addAssignment");	
		model.addAttribute(ab);	
		this.cm.backController("addAssignment", model);	
		return (List<AssignmentBean>)model.getAttribute("refreshedList");
	}	
	@PostMapping("/updAssignment")
	public List<AssignmentBean> updAssignment(Model model, @ModelAttribute AssignmentBean ab) {
		System.out.println("updAssignment");
		model.addAttribute(ab);
		this.cm.backController("updAssignment", model);
		return (List<AssignmentBean>)model.getAttribute("refreshedList");
	}
	@PostMapping("/delAssignment")
	public List<AssignmentBean> delAssignment(Model model, @ModelAttribute AssignmentBean ab) {
		System.out.println("delAssignment");
		model.addAttribute(ab);
		this.cm.backController("delAssignment", model);
		return (List<AssignmentBean>)model.getAttribute("refreshedList");
	}
	@PostMapping("/updGrade")
	public AssignmentBean updGrade(Model model, @ModelAttribute SubmittedAssignmentBean sb) {
		System.out.println("updGrade");
		model.addAttribute(sb);
		this.cm.backController("updGrade", model);
		return (AssignmentBean)model.getAttribute("refreshedList");
	}

	

	

	@RequestMapping(value = "/insNotice", method = RequestMethod.POST) 
	public List<NoticeBean> insNotice(Model model,@ModelAttribute NoticeBean nb) {
		model.addAttribute(nb);

		System.out.println(nb);


		this.cm.backController("insNotice", model);

		return (List<NoticeBean>)model.getAttribute("noticeInfo");
	}

	@RequestMapping(value = "/updNotice", method = RequestMethod.POST) 
	public List<NoticeBean> updNotice(Model model,@ModelAttribute NoticeBean nb) {
		model.addAttribute(nb);

		System.out.println(nb);


		this.cm.backController("updNotice", model);

		return (List<NoticeBean>)model.getAttribute("noticeInfo");
	}
	@RequestMapping(value = "/delNotice", method = RequestMethod.POST) 
	public List<NoticeBean> delNotice(Model model,@ModelAttribute NoticeBean nb) {
		model.addAttribute(nb);

		System.out.println(nb);


		this.cm.backController("delNotice", model);

		return (List<NoticeBean>)model.getAttribute("noticeInfo");
	}
}