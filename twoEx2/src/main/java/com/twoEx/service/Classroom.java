package com.twoEx.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.twoEx.bean.AssignmentBean;
import com.twoEx.bean.BuyerBean;
import com.twoEx.bean.ClassroomBean;
import com.twoEx.bean.CurriculumBean;
import com.twoEx.bean.LocationBean;
import com.twoEx.bean.ProductBean;
import com.twoEx.bean.ScheduleBean;
import com.twoEx.bean.SubmittedAssignmentBean;
import com.twoEx.bean.SubmittedAssignmentFileBean;
import com.twoEx.inter.ServicesRule;
import com.twoEx.utils.ProjectUtils;

import net.coobird.thumbnailator.Thumbnailator;

@Service
public class Classroom implements ServicesRule {
	@Autowired
	private SqlSessionTemplate session;
	@Autowired
	private ProjectUtils pu;

	public void backController(String serviceCode, ModelAndView mav) {
		System.out.println("classroomBackController");
		String accessInfo = null;
		String buyCode=null;
		String selCode=null;
		String userType=null;

		//세션 유무 확인 및 세션의 유저타입 유저코드 저장
		try {
			accessInfo=(String)this.pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
			userType=bean.getAsJsonObject().get("userType").getAsString();
			mav.addObject("userType", userType);
			if(userType.equals("buyer")) {buyCode=bean.getAsJsonObject().get("buyCode").getAsString();
			mav.addObject("buyCode", buyCode);
			}
			else {selCode=bean.getAsJsonObject().get("selCode").getAsString();
			mav.addObject("selCode", selCode);}
		} catch (Exception e) {
			e.printStackTrace();	
			mav.setViewName("mainPage");
			return;
		}
		switch(serviceCode) {
		case "moveDashboard":
			this.moveDashboard(mav);
			break;
		case "moveCurriculum":
			this.moveCurriculum(mav);
			break;	
		case "moveAssignment":
			this.moveAssignment(mav);
			break;	
		case "moveLocation":
			this.moveLocation(mav);
			break;
		case "moveSchedule":
			this.moveSchedule(mav);
			break;

		case "submitAssignment":
			this.submitAssignment(mav);
			break;
		case "unsubmitAssignment":
			this.unsubmitAssignment(mav);
			break;

		default:
		}
	}


	private void moveDashboard(ModelAndView mav) {
		System.out.println("무브대시보드서비스");
		String message = null;
		ClassroomBean cb = (ClassroomBean)mav.getModel().get("classroomBean");
		cb = (ClassroomBean)this.session.selectOne("getClassCurInfoDas", cb);
		if( Integer.parseInt(cb.getClaCurDay()) < 0) {
			cb.setClaCurPercentage("0");
			cb.setClaCurDay("0");
		}
		String json = new Gson().toJson(cb);
		System.out.println(json);
		mav.addObject("classInfo", json);
		message = "classroom/dashboard";

		mav.setViewName(message);
	}

	private void moveCurriculum(ModelAndView mav) {
		System.out.println("무브커리큘럼서비스");
		String message = null;
		//타이틀정보 저장
		ClassroomBean cb = (ClassroomBean)mav.getModel().get("classroomBean");
		String json = new Gson().toJson(cb);
		System.out.println(json);
		mav.addObject("classInfo", json);

		//커리컬럼 정보 조회 및 저장
		List<CurriculumBean> cbl = this.session.selectList("getCurriculumInfo", cb);
		String json2 = new Gson().toJson(cbl);
		System.out.println(json2);
		mav.addObject("curriculumInfo", json2);
		message = "classroom/curriculum";
		mav.setViewName(message);
	}

	private void moveAssignment(ModelAndView mav) {
		System.out.println("무브어사인먼트서비스");
		String message = null;
		//타이틀정보 저장

		ClassroomBean cb = (ClassroomBean)mav.getModel().get("classroomBean");
		String userType= (String)mav.getModel().get("userType");
		if(userType.equals("buyer"))cb.setBuyCode((String)mav.getModel().get("buyCode"));
		String json = new Gson().toJson(cb);
		System.out.println(json);

		mav.addObject("classInfo", json);
		if(mav.getModel().get("userType").equals("buyer")) {//구매자라면
			//과제 정보 조회 및 저장
			//접속자 buy코드 클래스룸 빈에 저장
			cb.setBuyCode((String)mav.getModel().get("buyCode"));
			List<AssignmentBean> abl = this.session.selectList("getAssignmentInfo", cb);
			String json2 = new Gson().toJson(abl);
			System.out.println(json2);
			mav.addObject("assignmentInfo", json2);
			message = "classroom/assignment";
			mav.setViewName(message);

		}else {//판매자라면
			List<AssignmentBean> abl = this.session.selectList("getAssignmentInfo2", cb);
			if(abl.size()==0){//테이블에 데이터가 없을경우
				AssignmentBean assb = new AssignmentBean();
				assb.setAssClaSelCode(cb.getClaSelCode());
				assb.setAssClaCteCode(cb.getClaCteCode());
				assb.setAssClaPrdCode(cb.getClaPrdCode());
				abl.add(assb);
				String json2 = new Gson().toJson(abl);
				System.out.println(json2);
				mav.addObject("assignmentInfo", json2);
				message = "classroom/assignment";
				mav.setViewName(message);
			}else {String json2 = new Gson().toJson(abl);
			System.out.println(json2);
			mav.addObject("assignmentInfo", json2);
			message = "classroom/assignment";
			mav.setViewName(message);}
		}
	}
	private void moveSchedule(ModelAndView mav) {
		System.out.println("moveScheduleService");
		String message = null;
		//타이틀정보 저장
		ClassroomBean cb = (ClassroomBean)mav.getModel().get("classroomBean");
		String json = new Gson().toJson(cb);
		System.out.println(json);
		mav.addObject("classInfo", json);
		List<ScheduleBean> sbl = this.session.selectList("getScheduleInfo", cb);
		/*
		if(sbl.size()==0){//테이블에 데이터가 없을경우
			ScheduleBean sb = new ScheduleBean();
			sb.setAssClaSelCode(cb.getClaSelCode());
			sb.setAssClaCteCode(cb.getClaCteCode());
			sb.setAssClaPrdCode(cb.getClaPrdCode());
			sbl.add(assb);}
			*/
		for(int i=0; i< sbl.size(); i++) {
			sbl.get(i).setStart(sbl.get(i).getStart().substring(0, 10));
			sbl.get(i).setEnd(sbl.get(i).getEnd().substring(0, 10));
		}
		
		
		String json2 = new Gson().toJson(sbl);
		System.out.println(json2);
		mav.addObject("scheduleInfo", json2);
		message = "classroom/schedule";
		mav.setViewName(message);
	}
	private void moveLocation(ModelAndView mav) {
		System.out.println("moveLocationService");
		String message = null;
		//타이틀정보 저장
		ClassroomBean cb = (ClassroomBean)mav.getModel().get("classroomBean");
		String json = new Gson().toJson(cb);
		System.out.println(json);
		mav.addObject("classInfo", json);
		List<LocationBean> lbl = this.session.selectList("getLocationInfo2", cb);
		String json2 = new Gson().toJson(lbl);
		System.out.println(json2);
		mav.addObject("locationInfo", json2);

		message = "classroom/location";
		mav.setViewName(message);
	}


	private void submitAssignment(ModelAndView mav) {
		System.out.println("submitAssignmentService");
		MultipartFile[] files = ((MultipartFile[])mav.getModel().get("uploadFile"));
		SubmittedAssignmentBean sab = (SubmittedAssignmentBean)mav.getModel().get("sab");
		System.out.println(sab);
		ClassroomBean cb = (ClassroomBean)mav.getModel().get("classroomBean");
		String json = new Gson().toJson(cb);
		System.out.println(json);
		mav.addObject("classInfo", json);
		String message;
		int result1 =this.session.insert("insSubmittedAssignment", sab);
		boolean checkFile = sab.getSubmittedAssignmentFile()!=null;
		if(checkFile){
		System.out.println("파일이 있는 서브밋이에요");
		System.out.println(result1);
		System.out.println(files);
		if(files != null) {System.out.println("파일이 있다");}
		String userFolderName = sab.getSubAssClaSelCode()+ sab.getSubAssClaCteCode() + sab.getSubAssClaPrdCode() + sab.getSubAssCode() + sab.getSubStuOrdBuyCode();
		String uploadPath = "C:\\Users\\user\\git\\ExpertExchange\\twoEx\\src\\main\\webapp\\resources\\submittedAssignment\\" + userFolderName;
		//삭제 경로도 변경해야함 		
		//"C:\\Users\\we285\\git\\ExpertExchange\\twoEx\\src\\main\\webapp\\resources\\submittedAssignment\\" 집 
		//"C:\\Users\\Lee\\git\\ExpertExchange\\twoEx\\src\\main\\webapp\\resources\\submittedAssignment\\" 노트북
		//"C:\\Users\\Byul\\git\\ExpertExchange\\twoEx\\src\\main\\webapp\\resources\\submittedAssignment\\" KHB
		System.out.println(uploadPath);
		if(!new File(uploadPath).exists()) new File(uploadPath).mkdirs();
		//썸네일용 폴더
		//if(!new File(uploadPath + "\\" + "small").exists()) new File(uploadPath + "\\" + "small").mkdirs();
		int fileNumber;
		if(new File(uploadPath).list() == null) { 
			fileNumber=0; 
		}else {
			fileNumber = new File(uploadPath).list().length;
		}
		System.out.println("폴더 내 파일의 갯수 : " + fileNumber);
		/* 해당 경로의 저장된 파일의 개수 파악*/
		for(SubmittedAssignmentFileBean safb : sab.getSubmittedAssignmentFile()) {
			safb.setSbfFilCode(String.format("%04d", fileNumber));
			System.out.println("File Code : " + safb.getSbfFilCode());
			safb.setSbfFilName(safb.getSbfFilName().substring(safb.getSbfFilName().lastIndexOf("\\")+1));
			System.out.println("File Name : " + safb.getSbfFilName());
			safb.setSbfLocation( "res/submittedAssignment/" + userFolderName); 
			System.out.println("테이블 저장 로케이션 : " + safb.getSbfLocation());
			System.out.println("File Location : " + uploadPath);
			fileNumber++;
		}	
		System.out.println(files.length);
		String fileName;
		int idx = 0;
		for(MultipartFile file : files) {
			System.out.println("Physical File Name : " + file.getOriginalFilename());
			System.out.println("Save File Name : " + (fileName = file.getOriginalFilename()));
			System.out.println("Physical File Info : " + file.getContentType());
			
			/* S : DB의 FILE 정보 INSERT */ /* E : DB의 FILE 정보 INSERT */
			
			try {
				File f =new File(uploadPath +"\\"+ fileName);
				file.transferTo(f);
			} catch (IllegalStateException | IOException e) {e.printStackTrace();}
			idx++;
			System.out.println(idx+"이건 무슨뜻일까");
		} 

		for(SubmittedAssignmentFileBean safb : sab.getSubmittedAssignmentFile()) {
			System.out.println("파일코드 : "+ safb.getSbfFilCode());
			System.out.println("파일이름 : "+ safb.getSbfFilName());
			System.out.println("파일위치 : "+ safb.getSbfLocation());
		}
		System.out.println(sab);
		int result = this.session.insert("insSubmittedAssignmentFile", sab);
		System.out.println("업로드한 파일 개수 : "+ result);
		}
		
		List<AssignmentBean> abl = this.session.selectList("getAssignmentInfo", cb);
		String json2 = new Gson().toJson(abl);
		System.out.println(json2);
		mav.addObject("assignmentInfo", json2);
		message = "classroom/assignment";
		mav.setViewName(message);
	}	
	//이미지 파일인지 확인하는 메서드
	private boolean checkImage(File file) {
		boolean check = false;
		try {
			String fileType = Files.probeContentType(file.toPath());
			System.out.println(fileType);
			check = fileType.startsWith("image");

		} catch (IOException e) {e.printStackTrace();}
		return check;
	}

	private void unsubmitAssignment(ModelAndView mav) {
		System.out.println("unsubmitAssignmentService");
		ClassroomBean cb = (ClassroomBean)mav.getModel().get("classroomBean");
		String json = new Gson().toJson(cb);
		System.out.println(json);
		mav.addObject("classInfo", json);
		
		SubmittedAssignmentBean sab = (SubmittedAssignmentBean)mav.getModel().get("submittedAssignmentBean");
		System.out.println("아잇:"+sab);
		
		
		boolean fileCheck = sab.getSbfFilName() == null;
		
		if(fileCheck)System.out.println("파일 없다요 ");
		
		
		
		if(fileCheck==false){
		
		List<SubmittedAssignmentFileBean> safb = this.session.selectList("getSubmittedAssignmentFile", sab);
		
		//if(safb.isEmpty() == false) {
		String deleteFolderPath = null;
		String deleteFilePath = null;
		for( int i = 0; i <safb.size(); i++ ) {
		//현재 게시판에 존재하는 파일객체를 만듬
		System.out.println(safb.get(i).getSbfLocation().substring(4));
		deleteFolderPath = "res\\" + safb.get(i).getSbfLocation().substring(4);
		deleteFilePath = deleteFolderPath+"\\"+safb.get(i).getSbfFilName();
	    System.out.println("deletePath :"+ deleteFilePath);
	    //물리주소 C:\\Users\\Lee\\git\\ExpertExchange\\twoEx\\src\\main\\webapp\\resources\
	         //"C:\\Users\\Byul\\git\\ExpertExchange\\twoEx\\src\\main\\webapp\\resources\\" KHB 
	    File file = new File(deleteFilePath);
		System.out.println(deleteFilePath);
		if(file.exists()) { // 파일이 존재하면
			System.out.println("파일이존재한다");
		}
			file.delete(); // 파일 삭제	
			System.out.println("파일삭제함");
		}
		
		//폴더삭제
		File file = new File(deleteFolderPath);
		System.out.println(deleteFolderPath);
		if(file.exists()) { // 파일이 존재하면
			System.out.println("폴더가 존재한다");
		}
			file.delete(); // 파일 삭제	
			System.out.println("폴더 삭제함");
		
		
		
		String message;
	    System.out.println("2"+sab.getSubmittedAssignmentFile());
		if(sab.getSubmittedAssignmentFile() != 	 null) {//등록된 파일이 있는 경우
			
			if(convertToBoolean(this.session.delete("unsubmitAssignmentFile", sab))){
			System.out.println("suf삭제 완료");
			
			}else {// 파일이 있으나 삭제 실패함
				System.out.println("파일이 있으나 삭제 실패함");
				}
	    	}
		}
		//등록 sub 삭제
		System.out.println("SUB삭제전");
		if(convertToBoolean(this.session.delete("unsubmitAssignment", sab))){
				System.out.println("sub삭제 완료");
				//sub 삭제 완료
				System.out.println("2"+cb);
				
				String message = null;
				List<AssignmentBean> abl = this.session.selectList("getAssignmentInfo", cb);
				String json2 = new Gson().toJson(abl);
				System.out.println(json2);
				mav.addObject("assignmentInfo", json2);
				message = "classroom/assignment";
				mav.setViewName(message);
			}
		
	}



	@Override
	public void backController(String serviceCode, Model model) {
		// TODO Auto-generated method stub
		System.out.println("classroomBackController");
		String accessInfo = null;
		String buyCode=null;
		String selCode=null;
		String userType=null;

		//세션 유무 확인 및 세션의 유저타입 유저코드 저장
		try {
			accessInfo=(String)this.pu.getAttribute("accessInfo");
			JsonParser parser = new JsonParser();
			JsonElement bean = parser.parse(accessInfo);
			userType=bean.getAsJsonObject().get("userType").getAsString();
			model.addAttribute("userType", userType);
			if(userType.equals("buyer")) {buyCode=bean.getAsJsonObject().get("buyCode").getAsString();
			model.addAttribute("buyCode", buyCode);
			}
			else {selCode=bean.getAsJsonObject().get("selCode").getAsString();
			model.addAttribute("selCode", selCode);}
		} catch (Exception e) {
			e.printStackTrace();	

			return;
		}

	}

	private boolean convertToBoolean(int value) {
		return value == 0? false:true;
	}


}
