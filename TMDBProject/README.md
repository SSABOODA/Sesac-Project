# TMDB

## 프로젝트 소개
<p align="center" width="100%">
  <img src="https://github.com/SSABOODA/Sesac-Project/assets/69753846/03a83f02-2e05-41d1-896a-bcb8a49ff894" width="100%">
</p>

### 앱 소개
- 영화나 드라마등을 검색을 통해서 알아보거나 요즘 뜨는 컨텐츠, 비슷한 장르의 컨텐츠를 알아볼 수 있는 앱입니다.

### 주요 기능
- 영화, 드라마 검색 기능이 있어요
- 검색한 컨텐츠의 상세정보(줄거리, 캐스팅 정보)등을 알 수 있어요
- 드라마의 시리즈별 정보를 알 수 있어요
- 해당 컨텐츠의 유사한 장르의 작품들을 만나볼 수 있어요

### 프로젝트 기간
- 2023.08.14 ~ 23.08.18

### 프로젝트 참여 인원
- 1명(개인)

### 사용된 기술 스택
- **Framework**<br>
`UIKit(+Storyboard)`
- **Library**<br>
`Alamofire`, `Kingfisher`, `Snapkit`, `SwiftJSON`
- **Design Pattern**<br>
`MVC`

<br>
<br>

## 구현 기능
- **UITableView**를 활용하여 영화, 드라마 데이터를 메인 검색 View UI를 구성하였습니다.
- **UICollectionViewFlowLayout**기반의 **UICollectionView**를 사용하였고 Section HeaderView를 구성하여 시리즈별 컨테츠 UI를 구성하였습니다.
- **WebKit**을 활용하여 Video와 유사한 장르 컨텐츠의 유튜브 광고 영상을 WebView로 나타낼 수 있도록 하였습니다.
- **Alamofire**를 사용하였고 TMDB의 API를 활용하여 UI를 구성하였습니다.

<br>
<br>

## Trouble Shooting
### 1. 여러 네트워크 통신의 작업 중단 시점에 cell reload 하기.
#### 문제 상황
하나의 View에 동시에 네트워크 요청을 할 때 해당 View의 cell을 갱신하기 위해 각각의 네트워크 요청 작업마다 reload를 하기 보다 모든 작업이 끝났을 때 한번만 cell을 reload한다면 계속 reload하는 리소스 낭비를 줄여볼 수 있을 것 같다는 생각을 하게되었습니다.
#### 문제 해결




