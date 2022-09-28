package com.twoEx.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.twoEx.bean.AssignmentBean;
import com.twoEx.bean.ClassroomBean;
import com.twoEx.bean.CurriculumBean;
import com.twoEx.bean.LocationBean;
import com.twoEx.bean.NoticeBean;
import com.twoEx.bean.StudentBean;
import com.twoEx.bean.SubmittedAssignmentBean;
import com.twoEx.inter.ServicesRule;
import com.twoEx.utils.Encryption;
import com.twoEx.utils.ProjectUtils;

@Service
public class ClassroomManagement implements ServicesRule {
	@Autowired
	private SqlSessionTemplate session;
	@Autowired
	private ProjectUtils pu;
	@Autowired
	private SellerAuthentication sa;
	@Autowired
	private Encryption enc;

	public void backController(String serviceCode, ModelAndView mav) {
		mav.setViewName("mainPage");
		if (sa.isSession()) {
			switch (serviceCode) {
			case "moveSellerMyClass":
				moveSellerMyClass(mav);
				break;
			case "moveManageCurriculum":
				moveManageCurriculum(mav);
				break;
			case "moveManageStudent":
				moveManageStudent(mav);
				break;
			case "moveManageAssignment":
				moveManageAssignment(mav);
				break;
			case "moveManageGrade":
				moveManageGrade(mav);
				break;
			case "moveManageNotice":
				moveManageNotice(mav);
				break;
			case "moveManageMap":
				moveManageMap(mav);
				break;
			case "moveAssignmentDetail":
				moveAssignmentDetail(mav);
				break;

			}
		}
	}

	public void backController(String serviceCode, Model model) {
		if (sa.isSession()) {
			switch (serviceCode) {
			case "banChat":
				banChat(model);
				break;
			case "unBanChat":
				unBanChat(model);
				break;
			case "getNewNoticeCode":
				getNewNoticeCode(model);
				break;
			case "addNotice":
				addNotice(model);
				break;	
			case "addLocation":
				addLocation(model);
				break;
			case "updLocation":
				updLocation(model);
				break;
			case "delLocation":
				delLocation(model);
				break;
			case "addAssignment":
				addAssignment(model);
				break;
			case "updAssignment":
				this.updAssignment(model);
				break;
			case "delAssignment":
				this.delAssignment(model);
				break;
			case "updGrade":
				this.updGrade(model);
				break;

				/* 경준쿤 */
			case "insCurriculum":
				this.insCurriculum(model);
				break;
			case "updCurriculum":
				this.updCurriculum(model);
				break;
			case "delCurriculum":
				this.delCurriculum(model);
				break;
			case "insAssignment":
				this.insAssignment(model);
				break;
				/* 진우쿤의 잡 */
			case "deleteNotice":
				this.deleteNotice(model);
				break;
			case "updateNotice":
				this.updateNotice(model);
				break;

			}
		}
	}

	@Transactional
	private void updateNotice(Model model) {
		NoticeBean nb = (NoticeBean) model.getAttribute("noticeBean");
		session.update("updateNotice", nb);
		List<NoticeBean> list = session.selectList("getNotice", nb);
		System.out.println(nb);
		model.addAttribute("refreshedList", list);

	}

	@Transactional
	private void deleteNotice(Model model) {
		NoticeBean nb = (NoticeBean) model.getAttribute("noticeBean");
		session.delete("deleteNotice", nb);
		List<NoticeBean> list = session.selectList("getNotice", nb);
		System.out.println(nb);
		model.addAttribute("refreshedList", list);

	}
	/*
	private ModelAndView moveManageCurriculum(ModelAndView mav) {
		mav.setViewName("classroomManagement/manageCurriculum");
		ClassroomBean cb = (ClassroomBean)mav.getModel().get("classroomBean");
		List<ClassroomBean> list = session.selectList("getCurriculumParent", cb);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String sysout = gson.toJson(list);
		System.out.println(sysout);
		String jsonList = new Gson().toJson(list);
		mav.addObject("jsonClassroomInfo", jsonList);
		return mav;
	}
	 */
	private void moveManageCurriculum(ModelAndView mav) {
		mav.setViewName("classroomManagement/manageCurriculum");
		ClassroomBean cb = (ClassroomBean)mav.getModel().get("classroomBean");
		String message;

		mav.addObject("classInfo", new Gson().toJson(cb));

		//커리컬럼 정보 조회 및 저장
		List<CurriculumBean> cbl = this.session.selectList("getCurriculumInfo", cb);
		String json2 = new Gson().toJson(cbl);
		System.out.println(json2);
		mav.addObject("curriculumInfo", json2);
		message = "classroomManagement/manageCurriculum";
		mav.setViewName(message);

	}

	private ModelAndView moveManageStudent(ModelAndView mav) {
		mav.setViewName("classroomManagement/manageStudent");
		ClassroomBean cb = (ClassroomBean)mav.getModel().get("classroomBean");
		mav.addObject("classInfo", new Gson().toJson(cb));
		List<ClassroomBean> list = session.selectList("getStudentParent", cb);
		int i = 0;
		for (StudentBean sb : list.get(0).getStudent()) {
			try {
				sb.setStuBuyNickname(enc.aesDecode(sb.getStuBuyNickname(), sb.getStuOrdBuyCode()));
				sb.setStuBuyEmail(enc.aesDecode(sb.getStuBuyEmail(), sb.getStuOrdBuyCode()));
				sb.setStuBuyRegion(enc.aesDecode(sb.getStuBuyRegion(), sb.getStuOrdBuyCode()));
				sb.setStuBuyProfile(enc.aesDecode(sb.getStuBuyProfile(), sb.getStuOrdBuyCode()));
				i++;
			} catch (Exception e) {
			}
		}
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String sysout = gson.toJson(list);
		System.out.println(sysout);
		String jsonList = new Gson().toJson(list);
		mav.addObject("jsonClassroomInfo", jsonList);
		return mav;
	}

	private void banChat(Model model) {
		StudentBean sb = (StudentBean) model.getAttribute("studentBean");
		session.update("banChat", sb);
		StudentBean st = session.selectOne("getOneStudent", sb);
		try {
			st.setStuBuyNickname(enc.aesDecode(st.getStuBuyNickname(), st.getStuOrdBuyCode()));
		} catch (Exception e) {
		}
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String sysout = gson.toJson(st);
		System.out.println(sysout);
		model.addAttribute("refreshedList", st);
	}

	private void unBanChat(Model model) {
		StudentBean sb = (StudentBean) model.getAttribute("studentBean");
		session.update("unBanChat", sb);
		StudentBean st = session.selectOne("getOneStudent", sb);
		try {
			st.setStuBuyNickname(enc.aesDecode(st.getStuBuyNickname(), st.getStuOrdBuyCode()));
		} catch (Exception e) {
		}
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String sysout = gson.toJson(st);
		System.out.println(sysout);
		model.addAttribute("refreshedList", st);
	}

	private ModelAndView moveManageAssignment(ModelAndView mav) {
		mav.setViewName("classroomManagement/manageAssignment");
		ClassroomBean cb = (ClassroomBean)mav.getModel().get("classroomBean");
		mav.addObject("classInfo", new Gson().toJson(cb));
		List<ClassroomBean> list = session.selectList("getAssignmentParent", cb);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String sysout = gson.toJson(list);
		System.out.println(sysout);
		String jsonList = new Gson().toJson(list);
		mav.addObject("jsonClassroomInfo", jsonList);
		return mav;
	}

	private ModelAndView moveAssignmentDetail(ModelAndView mav) {
		mav.setViewName("classroomManagement/assignmentDetail");
		
		ClassroomBean ca = (ClassroomBean)mav.getModel().get("classroomBean");

		mav.addObject("classInfo", new Gson().toJson(ca));
		Map<String, String> data = (Map<String, String>) mav.getModel().get("data");
		AssignmentBean ab = new AssignmentBean();

		ab.setAssCode(data.get("assCode"));
		ab.setAssClaSelCode(data.get("claSelCode"));
		ab.setAssClaCteCode(data.get("claCteCode"));
		ab.setAssClaPrdCode(data.get("claPrdCode"));
		List<AssignmentBean> list = session.selectList("getOneAssignment", ab);
		ClassroomBean cb = new ClassroomBean();
		cb.setClaSelCode(ab.getAssClaSelCode());
		cb.setClaCteCode(ab.getAssClaCteCode());
		cb.setClaPrdCode(ab.getAssClaPrdCode());
		cb = session.selectOne("getSellerClass", cb);
		cb.setAssignment(list);

		if(cb.getAssignment().get(0).getSubmittedAssignment() != null) {
			for(int i=0; i<cb.getAssignment().get(0).getSubmittedAssignment().size(); i++) {
				try {
					cb.getAssignment().get(0).getSubmittedAssignment().get(i).setSubBuyNickname(
							enc.aesDecode(
									cb.getAssignment().get(0).getSubmittedAssignment().get(i).getSubBuyNickname(), 
									cb.getAssignment().get(0).getSubmittedAssignment().get(i).getSubStuOrdBuyCode()
									)
							);
					cb.getAssignment().get(0).getSubmittedAssignment().get(i).setSubBuyProfile(
							enc.aesDecode(
									cb.getAssignment().get(0).getSubmittedAssignment().get(i).getSubBuyProfile(), 
									cb.getAssignment().get(0).getSubmittedAssignment().get(i).getSubStuOrdBuyCode()
									)
							);
				} catch (Exception e) {e.printStackTrace();}
			}
		}

		List<ClassroomBean> clist = new ArrayList<ClassroomBean>();
		clist.add(cb);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		System.out.println(gson.toJson(clist));
		String jsonList = new Gson().toJson(clist);
		System.out.println("List<ClassroomBean> : " + clist);
		System.out.println("jsonList : " + jsonList);
		mav.addObject("jsonClassroomInfo", jsonList);

		return mav;
	}
	private void updGrade(Model model) {
		SubmittedAssignmentBean sb = (SubmittedAssignmentBean) model.getAttribute("submittedAssignmentBean");

		session.update("updGrade", sb);

		AssignmentBean ab = new AssignmentBean();

		ab.setAssCode(sb.getSubAssCode());
		ab.setAssClaSelCode(sb.getSubAssClaSelCode());
		ab.setAssClaCteCode(sb.getSubAssClaCteCode());
		ab.setAssClaPrdCode(sb.getSubAssClaPrdCode());

		ab = (AssignmentBean) (session.selectList("getOneAssignment", ab)).get(0);

		for(int i=0; i<ab.getSubmittedAssignment().size(); i++) {
			try {
				ab.getSubmittedAssignment().get(i).setSubBuyNickname(
						enc.aesDecode(
								ab.getSubmittedAssignment().get(i).getSubBuyNickname(), 
								ab.getSubmittedAssignment().get(i).getSubStuOrdBuyCode()
								)
						);
				ab.getSubmittedAssignment().get(i).setSubBuyProfile(
						enc.aesDecode(
								ab.getSubmittedAssignment().get(i).getSubBuyProfile(), 
								ab.getSubmittedAssignment().get(i).getSubStuOrdBuyCode()
								)
						);
			} catch (Exception e) {e.printStackTrace();}
		}

		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		System.out.println(gson.toJson(ab)); 
		model.addAttribute("refreshedList", ab);
	}

	private ModelAndView moveManageGrade(ModelAndView mav) {
		mav.setViewName("classroomManagement/manageGrade");
		ClassroomBean cb = (ClassroomBean)mav.getModel().get("classroomBean");
		
		List<ClassroomBean> list = session.selectList("getAssignmentParent", cb);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String sysout = gson.toJson(list);
		System.out.println(sysout);
		String jsonList = new Gson().toJson(list);
		mav.addObject("jsonClassroomInfo", jsonList);
		return mav;
	}

	private ModelAndView moveManageNotice(ModelAndView mav) {
		mav.setViewName("classroomManagement/manageNotice");
		ClassroomBean cb = (ClassroomBean)mav.getModel().get("classroomBean");
		mav.addObject("classInfo", new Gson().toJson(cb));

		List<ClassroomBean> list = session.selectList("getNoticeParent", cb);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String sysout = gson.toJson(list);
		System.out.println(sysout);
		String jsonList = new Gson().toJson(list);
		mav.addObject("jsonClassroomInfo", jsonList);
		return mav;
	}

	private void addNotice(Model model) {
		NoticeBean nb = (NoticeBean) model.getAttribute("noticeBean");
		session.insert("addNotice", nb);
		List<NoticeBean> list = session.selectList("getNotice", nb);
		System.out.println(nb);
		model.addAttribute("refreshedList", list);
	}

	private void getNewNoticeCode(Model model) {
		NoticeBean nb = (NoticeBean) model.getAttribute("noticeBean");
		String newNoticeCode = session.selectOne("getNewNoticeCode", nb);
		System.out.println(newNoticeCode);
		model.addAttribute("newNoticeCode", newNoticeCode);
	}

	private void addAssignment(Model model) {
		AssignmentBean ab = (AssignmentBean) model.getAttribute("assignmentBean");
		session.insert("addAssignment", ab);
		List<AssignmentBean> list = session.selectList("getAssignment", ab);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String sysout = gson.toJson(list);
		System.out.println(sysout);
		model.addAttribute("refreshedList", list);
	}
	private void updAssignment(Model model) {
		AssignmentBean ab = (AssignmentBean) model.getAttribute("assignmentBean");
		session.update("updAssignment", ab);
		List<AssignmentBean> list = session.selectList("getAssignment", ab);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String sysout = gson.toJson(list);
		System.out.println(sysout);
		model.addAttribute("refreshedList", list);
	}
	private void delAssignment(Model model) {
		AssignmentBean ab = (AssignmentBean) model.getAttribute("assignmentBean");
		List<AssignmentBean> list = new ArrayList<AssignmentBean>();
		try {
			int real = session.delete("delAssignment", ab);
			System.out.println(real);
			if(convertToBool(real)){
				list = session.selectList("getAssignment", ab);
				if(list.size() == 0) {
					AssignmentBean as = new AssignmentBean();
					as.setAssCode("special");
					list.add(as);
				}
				Gson gson = new GsonBuilder().setPrettyPrinting().create();
				System.out.println(gson.toJson(list));		
			}		
		} catch(Exception e) {System.out.println("fail");}

		model.addAttribute("refreshedList", list);
	}

	/* 준호쿤 */
	private ModelAndView moveManageMap(ModelAndView mav) {
		mav.setViewName("classroomManagement/manageMap");
		ClassroomBean cb = (ClassroomBean) mav.getModel().get("classroomBean");
		mav.addObject("classInfo", new Gson().toJson(cb));


		LocationBean loc = this.session.selectOne("getLocationPOS", cb);
		String locCode = this.session.selectOne("getLocCode",cb);

		mav.addObject("claPrdCode", cb.getClaPrdCode());
		mav.addObject("claSelCode", cb.getClaSelCode());
		mav.addObject("claCteCode", cb.getClaCteCode());
		mav.addObject("locPOS", loc);
		mav.addObject("locInfo", locInfo(cb));
		mav.addObject("getLocCode", locCode);
		return mav;
	}

	private String locInfo(ClassroomBean cb) {
		StringBuffer sb = new StringBuffer();
		List<LocationBean> aulList = new ArrayList<LocationBean>();
		aulList = this.session.selectList("getLocationInfo", cb);
		for(LocationBean loc:aulList) {
			sb.append("<form>");
			sb.append("</br>");
			sb.append("지도 코드 :"+"<div id='locCode' style'display:none'>"+loc.getLocCode()+"</div>");sb.append("</br>");			
			sb.append("장소이름 :"+"<div id='locName'>"+loc.getLocName()+"</div>");sb.append("</br>");
			sb.append("상세주소 :"+"<div id='locInfo'>"+loc.getLocInfo()+"</div>");sb.append("</br>");
			sb.append("<div style=\"display:none\" id='locClaPrdCode'>"+loc.getLocClaPrdCode()+"</div>");sb.append("</br>");
			sb.append("<div  style=\"display:none\" id='locClaSelCode'>"+loc.getLocClaSelCode()+"</div>");sb.append("</br>");
			sb.append("<div  style=\"display:none\" id='locClaCteCode'>"+loc.getLocClaCteCode()+"</div>");sb.append("</br>");
			sb.append("</form>");
		}
		return sb.toString();
	}

	private void updLocation(Model model) {
		LocationBean lb = (LocationBean)model.getAttribute("locationBean");
		session.update("updLocation", lb);
		List<LocationBean> list = session.selectList("getlocInfo", lb);				
		System.out.println(lb);
		model.addAttribute("locInfo", list);

	}
	private void addLocation(Model model) {
		LocationBean lb = (LocationBean)model.getAttribute("locationBean");
		session.insert("addLocation", lb);
		List<LocationBean> list = session.selectList("getlocInfo", lb);		
		System.out.println(lb);
		model.addAttribute("locInfo", list);

	}	

	private void delLocation(Model model) {
		LocationBean lb = (LocationBean)model.getAttribute("locationBean");
		session.insert("delLocation", lb);
		List<LocationBean> list = session.selectList("getlocInfo", lb);	
		System.out.println(lb);
		model.addAttribute("locInfo", list);
	}

	/* 경준쿤 */

	private void insCurriculum(Model model) {// 추가및 수정을 나눔
		System.out.println("addCurriculum");
		CurriculumBean cb = (CurriculumBean) model.getAttribute("curriculumBean");
		ClassroomBean clab = new ClassroomBean();
		clab.setClaSelCode(cb.getCurClaSelCode());
		clab.setClaCteCode(cb.getCurClaCteCode());
		clab.setClaPrdCode(cb.getCurClaPrdCode());

		this.session.insert("insCurriculum", cb);
		List<CurriculumBean> cbl = this.session.selectList("getCurriculumInfo", clab);
		model.addAttribute("curriculumInfo", cbl);

	}

	private void updCurriculum(Model model) {
		System.out.println("updCurriculum");
		CurriculumBean cb = (CurriculumBean) model.getAttribute("curriculumBean");


		ClassroomBean clab = new ClassroomBean();
		clab.setClaSelCode(cb.getCurClaSelCode());
		clab.setClaCteCode(cb.getCurClaCteCode());
		clab.setClaPrdCode(cb.getCurClaPrdCode());

		this.session.update("updCurriculum", cb);// 수정결과 확인하는법 ?
		List<CurriculumBean> cbl = this.session.selectList("getCurriculumInfo", clab);
		System.out.println(cbl);
		model.addAttribute("curriculumInfo", cbl);

	}

	private void delCurriculum(Model model) {
		System.out.println("delCurriculum");
		CurriculumBean cb = (CurriculumBean) model.getAttribute("curriculumBean");
		ClassroomBean clab = new ClassroomBean();
		clab.setClaSelCode(cb.getCurClaSelCode());
		clab.setClaCteCode(cb.getCurClaCteCode());
		clab.setClaPrdCode(cb.getCurClaPrdCode());
		this.session.delete("delCurriculum", cb);
		List<CurriculumBean> cbl = this.session.selectList("getCurriculumInfo", clab);
		if (cbl.size() == 0) {// 커리컬럼 테이블이 비어있을경우 제어
			System.out.println("커리컬럼지우기 커리컬럼 테이블 내용 없음");
			CurriculumBean curb = new CurriculumBean();
			curb.setCurClaSelCode(clab.getClaSelCode());
			curb.setCurClaCteCode(clab.getClaCteCode());
			curb.setCurClaPrdCode(clab.getClaPrdCode());
			cbl.add(curb);
			model.addAttribute("curriculumInfo", cbl);
		} else {
			model.addAttribute("curriculumInfo", cbl);
		}

	}

	private void insAssignment(Model model) {// 과제 추가
		System.out.println("insAssignment");
		AssignmentBean ab = (AssignmentBean) model.getAttribute("assignmentBean");
		ClassroomBean clab = new ClassroomBean();
		clab.setClaSelCode(ab.getAssClaSelCode());
		clab.setClaCteCode(ab.getAssClaCteCode());
		clab.setClaPrdCode(ab.getAssClaPrdCode());
		if (model.getAttribute("selCode").equals(ab.getAssClaSelCode())) {// 세션의 셀코드와 받아온 셀코드가 일치하면
			System.out.println("셀코드일치");
			this.session.insert("insAssignment", ab);
			List<AssignmentBean> abl = this.session.selectList("getAssignmentInfo2", clab);
			model.addAttribute("assignmentInfo", abl);
		} else {
			return;
		}
	}

	private ModelAndView moveSellerMyClass(ModelAndView mav) {
		mav.setViewName("sellerMyClass");
		ClassroomBean cb = (ClassroomBean) mav.getModel().get("classroomBean");
		List<ClassroomBean> list = session.selectList("getSellerClassList", cb);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String sysout = gson.toJson(list);
		System.out.println(sysout);
		String jsonList = new Gson().toJson(list);
		mav.addObject("jsonSellerClassList", jsonList);
		return mav;
	}

	private boolean convertToBool(int result) {
		return result >= 1 ? true : false;
	}

}