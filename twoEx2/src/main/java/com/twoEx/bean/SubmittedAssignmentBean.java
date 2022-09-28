package com.twoEx.bean;

import java.util.List;

import lombok.Data;

@Data
public class SubmittedAssignmentBean {
	private String subAssClaSelCode;
	private String subAssClaCteCode;
	private String subAssClaPrdCode;
	private String subAssCode;
	private String subStuOrdBuyCode;
	private String subStuOrdDate;
	private String subGrade;
	private String subInfo;
	private String subDate;
	private String sbfFilName;
	
	private List<SubmittedAssignmentFileBean>  submittedAssignmentFile;
	
	/* KHB */
	private String subBuyNickname;
	private String subBuyProfile;
}
