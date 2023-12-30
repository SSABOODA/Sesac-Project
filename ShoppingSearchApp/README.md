# ShoppingSearchApp

# 상품 검색 과제 프로젝트

# 프로젝트 설명
네이버 '검색' API를 활용하여 상품을 검색할 수 있고 검색한 상품을 Realm Database를 활용해 상품 데이터를 저장할 수 있도록 하는 앱입니다.

# 요구사항
- 다크모드만 지원하도록 적용하였습니다.
- 가로모드는 지원하지 않도록 적용하였습니다.
- iOS 13 버전을 최소지원 버전입니다.

# 기술스택
- MVC 패턴을 사용하여 프로젝트를 진행하였습니다.
## 사용된 라이브러리
- Snapkit
- Realm
- Toast

# 기능
- 상품 검색 기능
  - 네이버 쇼핑 '검색' API를 활용하였기 때문에 현재 네이버 쇼핑에 올라와있는 상품 기반으로 검색
- 정확도, 날짜순, 가격순으로 상품 filter 기능
- 네이버 서버 상품을 앱 내 Realm Database에 '좋아요' 기능을 통해 데이터 저장
  - 좋아요한 상품 목록 List 확인 기능
  - 좋아요한 상품 목록 검색 기능
- 상품 클릭 시 상세화면(웹뷰) 처리

# 과제 진행 시 이슈
## 어려웠던 점
- 뷰컨트롤러 간 데이터 전달을 버튼 클릭 시 전환되는 화면으로 전달하는 방법만 알고 있었는데 Tabbar 버튼 클릭 간에 데이터 전달 방법을 몰랐어서 고전하였지만 해결하였습니다.
- API를 통해 응답받은 데이터와 Realm DB에 저장해야하는 데이터간의 정보 싱크를 맞추는 작업이 조금 힘들었습니다.
  - 천천히 논리를 설계하며 문제를 해결하였고, tabbar 전환 간의 데이터 전달과 적절한 컬렉션 뷰 리로드 등을 활용해 해결할 수 있었습니다.

# 회고
- 프로젝트 기획만 봤을 때는 완성 기간이 짧을 줄 알았으나 디테일한 기능 '좋아요' 싱크 기능 등에서 시간이 많이 소요되었고 작업을 들어가기전 조금 더 디테일한 부분을 체크하면서 공수 산정을 해야겠다는 생각을 하였습니다.
- 코드 내 모든 상수(문자열, 정수 값)들을 열거형 처리하지 못하였습니다.
  - 처음부터 열거형 구조를 설계하지 않고 모두 적용 후에 처리하려고 하니 마감기한내에 다하지 못했던 부분이 아쉬웠습니다.
 

# How to add a collapsible section in markdown
## 1. Example
<details>
  <summary>Click me</summary>

  ### Heading
  1. Foo
  2. Bar
     * Baz
     * Qux

  ### Some Javascript
  ```swift
  override func viewWillAppear(_ animated: Bool) {
	super.viewWillAppear(animated)
	updateProductLikeData()
  }
  ```
</details>


# How to add a collapsible section in markdown




