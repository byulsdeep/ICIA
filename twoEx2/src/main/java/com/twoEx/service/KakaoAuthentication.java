package com.twoEx.service;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.twoEx.bean.BuyerBean;
import com.twoEx.inter.ServicesRule;
import com.twoEx.utils.Encryption;
import com.twoEx.utils.ProjectUtils;

@Service
public class KakaoAuthentication implements ServicesRule {
	@Autowired
	private SqlSessionTemplate session;
	@Autowired
	private ProjectUtils pu;
	@Autowired
	private Encryption enc;

	public void backController(String serviceCode, ModelAndView mav) {
		System.out.println("KaKaoAuthentication/backController");
		switch(serviceCode) {
		case "insertKakao":
			this.insertKakao(mav);
			break;	
		}
	}

	public void backController(String serviceCode, Model model) {}

	@Transactional
	private void insertKakao(ModelAndView mav) {	
		//입력값
		BuyerBean bb = (BuyerBean)mav.getModel().get("buyerBean");
		//db로 보낼 값
		BuyerBean bd = new BuyerBean();
		try {
			bd.setBuyCode(bb.getBuyCode());
			bd.setBuyAge(bb.getBuyAge());
			bd.setBuyGender(bb.getBuyGender());
			bd.setBuyNickname(enc.aesEncode(bb.getBuyNickname(), bb.getBuyCode()));
			bd.setBuyProfile(enc.aesEncode(bb.getBuyProfile(), bb.getBuyCode()));
			bd.setBuyEmail(enc.aesEncode(bb.getBuyEmail(), bb.getBuyCode()));
			bd.setBuyRegion(enc.aesEncode(bb.getBuyRegion(), bb.getBuyCode()));
		} catch (InvalidKeyException | UnsupportedEncodingException | NoSuchAlgorithmException | NoSuchPaddingException
				| InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException e1) {e1.printStackTrace();}
		
		this.session.insert("insBuyer", bd);
		
		bb.setUserType("buyer");
		String accessInfo = new Gson().toJson(bb);
		try {
			pu.setAttribute("accessInfo", accessInfo);
		} catch (Exception e) {e.printStackTrace();}
		mav.setViewName("mainPage");

	}
	public String getReturnAccessToken(String code) {
		String access_token = "";
		String refresh_token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			//HttpURLConnection 설정 값 셋팅
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);


			// buffer 스트림 객체 값 셋팅 후 요청
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=628883e2413da0a633c8d3b53d91b08a");  //앱 KEY VALUE
			sb.append("&redirect_uri=http://192.168.0.133/kakao_callback"); // 앱 CALLBACK 경로
			/* 자기 키 복사하기 편하게 써두세요 */
			/* https://developers.kakao.com/ */
			/* root-context db 계정도 전환해서 사용하기 */
			/* "&redirect_uri=http://errorkillers.hoonzzang.com:20000/kakao_callback"
			 * 강한별 http://192.168.0.133 628883e2413da0a633c8d3b53d91b08a  
			 * 이경준 192.168.0.253 fe5c5e3b0473b8b623da3bc05a6ba479 172.30.1.47
			 * 하진우 192.168.0.9  67e077c6ce4c4c3ed58fc83d3a3a79c4
			 * 곽윤철 192.168.0.165  2f2662c79b2457f82f5e188d75b827ac
			 * 이상은 192.168.1.47 51a9dd8bb7a96129eb36d1848ea0bd73
			 * 심준호
			 * */
			sb.append("&code=" + code);
			bw.write(sb.toString());
			bw.flush();

			//  RETURN 값 result 변수에 저장
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String br_line = "";
			String result = "";

			while ((br_line = br.readLine()) != null) {
				result += br_line;
			}

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			// 토큰 값 저장 및 리턴
			access_token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_token = element.getAsJsonObject().get("refresh_token").getAsString();

			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return access_token;
	}

	public Map<String,Object> getUserInfo(String access_token) {
		Map<String,Object> resultMap =new HashMap<>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			//요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String br_line = "";
			String result = "";

			while ((br_line = br.readLine()) != null) {
				result += br_line;
			}
			System.out.println("response:" + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String id = element.getAsJsonObject().get("id").getAsString();
			String profile_image = properties.getAsJsonObject().get("profile_image").getAsString();

			resultMap.put("nickname", nickname);
			resultMap.put("id", id);
			resultMap.put("profile_image", profile_image);
			System.out.println(resultMap);
			/* resultMap.put("email", email); */

		} catch (IOException e) {e.printStackTrace();}
		return resultMap;
	}

	public void getLogout(String access_token) {
		String reqURL ="https://kapi.kakao.com/v1/user/logout";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");

			conn.setRequestProperty("Authorization", "Bearer " + access_token);
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			if(responseCode ==400)
				throw new RuntimeException("카카오 로그아웃 도중 오류 발생");

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String br_line = "";
			String result = "";
			while ((br_line = br.readLine()) != null) {
				result += br_line;
			}
			System.out.println("width=\"38\" height=\"38\"");
			System.out.println("결과");
			System.out.println(result);
		}catch(IOException e) {

		}
	}


}