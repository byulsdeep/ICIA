
 package com.twoEx.controller;
 
 import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import
 org.springframework.web.bind.annotation.RequestMapping;
import
 org.springframework.web.bind.annotation.RequestMethod;
import
 org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.twoEx.bean.AssignmentBean;
import com.twoEx.bean.CurriculumBean;
import com.twoEx.bean.NoticeBean;
import com.twoEx.bean.SubmittedAssignmentBean;
import com.twoEx.service.Classroom;
import com.twoEx.service.ClassroomManagement;
 
 @RestController public class APIControllerLGJ {
	 @Autowired
	 ClassroomManagement cm;
	
	 
	 @RequestMapping(value = "/updCurriculum", method = RequestMethod.POST) 
		public List<CurriculumBean> updCurriculum(Model model,@ModelAttribute CurriculumBean cb) {
			model.addAttribute(cb);

			System.out.println(cb);


			this.cm.backController("updCurriculum", model);

			return (List<CurriculumBean>)model.getAttribute("curriculumInfo");
		}
		@RequestMapping(value = "/delCurriculum", method = RequestMethod.POST) 
		public List<CurriculumBean> delCurriculum(Model model,@ModelAttribute CurriculumBean cb) {
			model.addAttribute(cb);

			System.out.println(cb);


			this.cm.backController("delCurriculum", model);

			return (List<CurriculumBean>)model.getAttribute("curriculumInfo");
		}
		
		/* 경준쿤 */
		@RequestMapping(value = "/insCurriculum", method = RequestMethod.POST) 
		public List<CurriculumBean> insCurriculum(Model model,@ModelAttribute CurriculumBean cb) {
			model.addAttribute(cb);

			System.out.println(cb);


			this.cm.backController("insCurriculum", model);

			return (List<CurriculumBean>)model.getAttribute("curriculumInfo");
		}
		
		/*
		@RequestMapping(value = "/insAssignment", method = RequestMethod.POST) 
		public List<AssignmentBean> insAssignment(Model model,@ModelAttribute AssignmentBean ab) {
			System.out.println("apiController(insAssignment)");
			model.addAttribute(ab);

			System.out.println(ab);


			this.cm.backController("insAssignment", model);

			return (List<AssignmentBean>)model.getAttribute("assignmentInfo");
		}
		*/
 }
