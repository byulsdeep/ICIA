<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>::: TwoEX ::: 교환 플랫폼 </title>
    <!-- 기타 meta 정보 -->
      <meta
        name="mainPage"
        content="TwoEx site"
      />
      <meta name="author" content="TwoEX" />
      <link rel="icon" type="image/png" href="" />
   
    <!-- LOGO, FONT SOURCE-->
      <script src="https://kit.fontawesome.com/1066a57f0b.js" crossorigin="anonymous"></script>
      <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&family=Russo+One&display=swap" 
      rel="stylesheet">

    <!-- JS, CSS 연결 -->
       <link rel="stylesheet" href="res/css/style.css" />
       <link rel="stylesheet" href="res/css/kakaoJoin.css" />
      <script src="res/js/main.js" defer></script>
      <script src="res/js/header.js" defer></script>
    
    <!-- CSS 영역 ------------------------------>
    <style>
      /** 로고1 오리지날
       font-family: 'Russo One', sans-serif;  -- 400 */
      @import url('https://fonts.googleapis.com/css2?family=Russo+One&display=swap');

      /** 로고2 대안
       font-family: 'Orbitron', sans-serif; weight 800, 900 */
      @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@800;900&display=swap');

      /** 로고3
        font-family: 'Exo', sans-serif;  */
      @import url('https://fonts.googleapis.com/css2?family=Exo:wght@800;900&display=swap');

      /** 본문1
       font-family: 'Noto Sans KR', sans-serif;  --- 300, 400, 700 */
      @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap');

      /** 본문2
       font-family: 'Spoqa Han Sans Neo', 'sans-serif';*/
      @import url('https://spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css');
    </style>

    <!-- 스크립트 영역-->
    <script>
        function regMember(){
          const form = document.getElementsByName("reg")[0];
          form.action = "insertKakao";
          form.method = "post";
          form.submit();
        }
    </script>
  </head>
  <body id="joinPage__body">
    <!-- [ Join ] -->
    <section id="join__title__section">
     <div class="joinPage__logo">
       <span class="joinPage__twoEx" onclick="moveMainPage()"> <i class="fa-solid fa-arrow-right-arrow-left JoinPage"></i> Two EX</span>
       <span class="joinPage__expertsExchange">Experts Exchange</span>
     </div>
   </section>
   <section id="join__section">
       <div class="join__container">
           <h2 class="join__title">구매자 회원가입</h2><br>
           <form name="reg">
                 <div class="item__div">
                      <div class="item__label">아이디 : </div>
                      <div class="item__ino__div">
                          <input class="item__input" type="text" name="buyCode" placeholder="아이디" value="${accessInfo.buyCode}" readonly/>
                      </div>
                 </div>
                 <div class="item__div">
                     <div class="item__label">닉네임 : </div>
                     <div class="item__ino__div">
                           <input class="item__input" type="text" name="buyNickname" placeholder="닉네임" value="${accessInfo.buyNickname}" readonly/>
                     </div>
                 </div>
                 <div class="item__div">
                     <div class="item__label">이메일 : </div>
                     <div class="item__ino__div">
                         <input class="item__input" type="text" name="buyEmail" placeholder="이메일" value="" />
                     </div>
                 </div>
                 <div class="item__div">
                     <div class="item__label">생년 : </div>
                     <div class="item__ino__div">
                         <input class="item__input" type = "text" name="buyAge" placeholder="생년" value=""/>
                     </div>
                 </div>
                 <div class="item__div">
                     <div class="item__label">성별 : </div>
                     <div class="item__info__div">
                             <select class="item__input" name="buyGender" >
                               <option value="M">남</option>
                               <option value="F">여</option>
                             </select>
                     </div>
                 </div>
                 <div class="item__div">
                   <div class="item__label">지역 : </div>
                   <select class="item__select" name="buyRegion">
                       <option value="">지역 선택</option>
                       <option value="서울특별시">서울특별시</option>
                       <option value="부산광역시">부산광역시</option>
                       <option value="인천광역시">인천광역시</option>
                       <option value="대구광역시">대구광역시</option>
                       <option value="광주광역시">광주광역시</option>
                       <option value="대전광역시">대전광역시</option>
                       <option value="울산광역시">울산광역시</option>
                       <option value="세종특별자치시">세종특별자치시</option>
                       <option value="경기도">경기도</option>
                       <option value="강원도">강원도</option>
                       <option value="충청북도">충청북도</option>
                       <option value="충청남도">충청남도</option>
                       <option value="경상북도">경상북도</option>
                       <option value="경상남도">경상남도</option>
                       <option value="전라북도">전라북도</option>
                       <option value="전라남도">전라남도</option>
                       <option value="제주특별자치도">제주특별자치도</option>
                   </select>	
                  </div>
                  <input type="hidden" name="buyProfile" value="${accessInfo.buyProfile}">
                 <input type="button" class="content__btn btn__blueGreen large" onClick="regMember()" value="회원가입"/> 
              </form>
           </div>
       </section>
   </body>
 </html>
