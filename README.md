# ECWeather
<img width="295" alt="image" src="https://github.com/pinocchio22/ECWeather/assets/61182499/1f14e8b7-270f-4c8a-a780-f4392de0d302">

## 🧑‍🤝‍🧑 Team Members (구성원)
<table>
  <tbody>
    <tr>
     <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/pinocchio22">
       <img src="https://avatars.githubusercontent.com/u/61182499?v=4" width="100px;" alt="최진훈"/>
       <br />
         <sub>
           <b>최진훈</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
    <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/sanc93">
       <img src="https://avatars.githubusercontent.com/u/60124491?v=4" width="100px;" alt="김상훈"/>
       <br />
         <sub>
           <b>김상훈</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
      <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/jingni1115">
       <img src="https://avatars.githubusercontent.com/u/105254025?v=4" width="100px;" alt="김지은"/>
       <br />
         <sub>
           <b>김지은</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
      <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/riyeonlee">
       <img src="https://avatars.githubusercontent.com/u/139096422?v=4" width="100px;" alt="이리연"/>
       <br />
         <sub>
           <b>이리연</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
      <td align="center" valign="top" width="14.28%">
       <a href="https://github.com/startingg">
       <img src="https://avatars.githubusercontent.com/u/132072642?v=4" width="100px;" alt="이시영"/>
       <br />
         <sub>
           <b>이시영</b>
         </sub>
       </a>
       <br />
       <sub>
           <b>iOS Developer</b>
       </sub>
       <br />
     </td>
  </tbody>
</table>

## E편한날씨

- 본인 위치를 기반으로 현재 날씨 확인 가능
- 세계 유명 지역 별 날씨 확인
- 사용자가 입력한 지역의 날씨 확인 가능
- 사용자가 원하는 온도 단위(섭씨, 화씨)로 변경 가능
 
개발기간: 2023/09/25 월요일 ~ 2023/10/06 목요일

발표: 2023/10/06 금요일


## 👨‍💻 역할분담 및 프로젝트 주요기능 

### 최진훈
- 지역별예보
- 깃허브 + 리드미

### 김상훈
- 알람설정 + 탭바
- 문서작성 + 시연영상

### 김지은
- 설정 + 현재위치 설정
- 발표 도우미
  
### 이리연
- 주간예보
- 발표

### 이시영
- 현재날씨 (메인)
- 발표 도우미

## ⚡️ 팀 규칙
### Commit Convention
<img width="808" alt="image" src="https://github.com/pinocchio22/ECWeather/assets/61182499/1031ab2b-a0c1-44a3-bd38-2a4ec530d5a1">

### Code Convention
### 코드 들여쓰기
- 콜론(`:`)을 쓸 때에는 콜론의 오른쪽에만 공백을 둡니다.

### 빈줄
- 빈줄에는 공백이 포함되지 않도록 합니다.
- MARK 구문 위와 아래에는 공백이 필요합니다.

### 임포트
- 모듈 임포트는 알파벳 순으로 정렬합니다. 내장 프레임워크를 먼저 임포트하고, 빈줄로 구분 후, 서드파티 프레임워크를 임포트합니다.

### 클래스와 구조체의 네이밍
- 클래스와 구조체의 이름에는 UpperCamelCase를 사용합니다

### 함수의 네이밍
- 함수 이름에는 lowerCamelCase를 사용합니다.
- Action 함수의 네이밍은 ‘주어+동사+목적어’형태를 사용합니다.
- Tap(눌렀다 뗌)*은 `UIControlEvents`의 `.touchUpInside`에 대응하고, *Press(누름)*는 `.touchDown`에 대응합니다.
- *will~*은 특정 행위가 일어나기 직전이고, *did~*는 특정 행위가 일어난 직후입니다.
- *should~*는 일반적으로 `Bool`을 반환하는 함수에 사용됩니다.
  
### 변수 & 상수 네이밍
- lowerCamelCase를 사용합니다.

## Git 브랜치 전략 (Git flow)
main : 메인 브랜치
dev :	개발 브랜치
feat/weekly-page :	탭1 - 주간예보
feat/regional-page :	탭2 - 지역별예보
feat/main-page :	탭3 - 현재날씨 (메인)
feat/alarm-page :	탭4 - 알람설정
feat/setting-page :	탭5 - 설정

## ⚙️ Requirements

### 기술 스택

- iOS 16.4 버전으로 개발
- 스토리보드 없이
- SnapKit
- Alamofire
- MapKit
- UserDefaults
- AVFoundation
- UserNotifications

- 필수 구현 기능(필수)
    - [x]  사용자 위치 지정
    - [x]  날씨 데이터
    - [x]  사용자 입력 (SearchPage 검색창)
    - [x]  날씨 표시
    - [x]  단위 변환
    - [x]  사용자 친화적인 인터페이스
    - [x]  데이터 새로 고침
    - [x]  배경 이미지
    
- 추가 구현 기능(선택)
    - [x]  알림
    - [x]  예보 (3시간별, 5일간)
    - [x]  위치 서비스
    - [x]  지도 통합
    - [x]  검색 기록
    - [ ]  애니메이션
    - [ ]  디자인 패턴 (MVVM)

## ✏️ 와이어프레임
  <table>
    <tr>
      <td>
        <img width="222" alt="image" src="https://github.com/pinocchio22/ECWeather/assets/61182499/89445b33-7e0d-497b-b102-f7e2fd01bf92">
      </td>
    </tr>
  </table>

  
  <table>
    <tr>
      <td>
        <img width="231" alt="image" src="https://github.com/pinocchio22/ECWeather/assets/61182499/aac746a4-92a5-4a3f-8a3f-3771da3e241d">
      </td>
      <td>
        <img width="211" alt="image" src="https://github.com/pinocchio22/ECWeather/assets/61182499/2dbf1803-af95-4e29-8661-2d93b7fb260f">
      </td>
      <td>
        <img width="230" alt="image" src="https://github.com/pinocchio22/ECWeather/assets/61182499/761ab572-a7b0-4010-8e68-43c0c5557846">
      </td>
    </tr>
  </table>
  
   <table>
    <tr>
       <td>
       <img width="215" alt="image" src="https://github.com/pinocchio22/ECWeather/assets/61182499/af79bfb9-e1c3-4a73-b1db-f03d7d6cbf11">
      </td>
      <td>
      <img width="226" alt="image" src="https://github.com/pinocchio22/ECWeather/assets/61182499/6eabfc4d-5a6d-402a-9c8e-54f18b1ff385">
      </td>
      <td>
       <img width="217" alt="image" src="https://github.com/pinocchio22/ECWeather/assets/61182499/cd2279ca-2281-4993-8304-411c6efae83e">
      </td>
    </tr>
  </table>

## 앱 대표 색상
<img width="679" alt="image" src="https://github.com/pinocchio22/ECWeather/assets/61182499/9150f72f-63e1-4b5e-918a-353b3053fa73">

## 🍰 디렉토리 구조
<img width="471" alt="image" src="https://github.com/pinocchio22/ECWeather/assets/61182499/4728784e-5621-44a9-965c-fe35e0ab377b">
