package com.twoEx.bean;

import java.util.List;

import lombok.Data;

@Data
public class ClassroomBean {
	private String buyCode;
	private String claSelCode;
	private String claPrdCode;
	private String claCteCode;
	private String claInfo;
	private String claName;
	private String claStartDate;
	private String claEndDate;
	private String claTotDay;
	private String claRemDay;
	private String claCurDay;
	private String claCurPercentage;
	private String selNickName;
	private String selShopName;
	private String claState1;
	private String claState2;
	private String prfLocation;
	
	private List<NoticeBean> notice;
	private List<ProductFileBean> productFile;	
	private List<LocationBean> location;
	/* khb */
	private List<CurriculumBean> curriculum;
	private List<StudentBean> student;
	private List<AssignmentBean> assignment;
	private String claCteName;
	
}
