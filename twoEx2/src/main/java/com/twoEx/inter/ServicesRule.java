package com.twoEx.inter;

import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

public interface ServicesRule {
	public void backController(String serviceCode, ModelAndView mav);
	public void backController(String serviceCode, Model model);
}
