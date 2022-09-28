package com.twoEx.controller;

import java.util.Locale;

import javax.swing.plaf.synth.SynthStyleFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.twoEx.bean.ClassroomBean;
import com.twoEx.bean.SubmittedAssignmentBean;
import com.twoEx.service.Classroom;
import com.twoEx.service.ClassroomManagement;


@RestController


public class HomeControllerLGJ {

	@Autowired
	private Classroom cla;
	@Autowired
	private ClassroomManagement clm;
	
	@RequestMapping(value = "/moveDashboard", method = RequestMethod.POST)
	public ModelAndView moveDashboard(Locale locale, ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveDashboard");
		mav.addObject(cb);
		this.cla.backController("moveDashboard", mav);
		return mav;
	}	
	@RequestMapping(value = "/moveCurriculum", method = RequestMethod.POST)
	public ModelAndView moveCurriculum(Locale locale, ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("movecurriculum");
		mav.addObject(cb);
		this.cla.backController("moveCurriculum", mav);
		return mav;
	}
	@RequestMapping(value = "/moveAssignment", method = RequestMethod.POST)
	public ModelAndView moveAssignment(Locale locale, ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveAssignment");
		mav.addObject(cb);
		this.cla.backController("moveAssignment", mav);
		return mav;
	}
	@RequestMapping(value = "/moveLocation", method = RequestMethod.POST)
	public ModelAndView moveLocation(Locale locale, ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveLocation");
		mav.addObject(cb);
		this.cla.backController("moveLocation", mav);
		return mav;
	}
	@RequestMapping(value = "/moveSchedule", method = RequestMethod.POST)
	public ModelAndView moveSchedule(Locale locale, ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveSchedule");
		mav.addObject(cb);
		this.cla.backController("moveSchedule", mav);
		return mav;
	}
	@RequestMapping(value = "/submitAssignment", method = RequestMethod.POST)
	public ModelAndView submitAssignment(ModelAndView mav, @ModelAttribute SubmittedAssignmentBean sub,@ModelAttribute ClassroomBean cb, @RequestParam("uploadFile") MultipartFile[] files) {
		System.out.println("submitAssignment");
		mav.addObject("uploadFile", files);
		mav.addObject("sab",sub);
		mav.addObject(cb);
		this.cla.backController("submitAssignment", mav);
		return mav;
	}
	@RequestMapping(value = "/unsubmitAssignment", method = RequestMethod.POST)
	public ModelAndView unsubmitAssignment(ModelAndView mav, @ModelAttribute SubmittedAssignmentBean sab, @ModelAttribute ClassroomBean cb) {
		System.out.println("unsubmitAssignment");
		System.out.println("1"+sab);
		mav.addObject(sab);
		mav.addObject(cb);
		this.cla.backController("unsubmitAssignment", mav);
		return mav;
	}
	
	
	
	
	@RequestMapping(value = "/moveManageCurriculum", method = RequestMethod.POST)
	public ModelAndView moveManageCurriculum(Locale locale, ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveManageCurriculum");
		mav.addObject(cb);
		this.clm.backController("moveManageCurriculum", mav);
		
		return mav;
	}
	/*
	@RequestMapping(value = "/moveManageAssignment", method = RequestMethod.POST)
	public ModelAndView moveManageAssignment(Locale locale, ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveManageAssignment");
		mav.addObject(cb);
		this.clm.backController("moveManageAssignment", mav);
		
		return mav;
	}
	@RequestMapping(value = "/moveManageNotice", method = RequestMethod.POST)
	public ModelAndView moveManageNotice(Locale locale, ModelAndView mav, @ModelAttribute ClassroomBean cb) {
		System.out.println("moveManageNotice");
		mav.addObject(cb);
		this.clm.backController("moveManageNotice", mav);
		
		return mav;
	}
	*/
	
	
}