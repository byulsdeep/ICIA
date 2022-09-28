package com.twoEx.bean;

import java.util.List;

import lombok.Data;

@Data
public class AssignmentBean {
	private String assClaSelCode;
	private String assClaCteCode;
	private String assClaPrdCode;
	private String assCode;
	private String assName;
	private String assInfo;
	private String assStartDate;
	private String assEndDate;
	private String assMaxGrade;
	private String assBuyCode;
	private String assBuyDate;
	private String assState;
	private String assState2;
	
	private List<SubmittedAssignmentBean> submittedAssignment;
}
