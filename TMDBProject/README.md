# TodayMovie
<img src="https://github.com/SSABOODA/Sesac-Project/assets/69753846/b9ece1f7-e781-400c-b3ec-4759191c2085" height="100" width="100">

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
- **Framework**
`UIKit(+Storyboard)`
- **Library**
`Alamofire`, `Kingfisher`, `Snapkit`, `SwiftJSON`
- **Design Pattern**
`MVC`

<br>
<br>

## 구현 기능
- **UITableView**를 활용하여 영화, 드라마 데이터를 메인 검색 View UI를 구성하였습니다.
- **UICollectionViewFlowLayout**기반의 **UICollectionView**를 사용하였고 Section HeaderView를 구성하여 시리즈별 컨텐츠 UI를 구성하였습니다.
- **WebKit**을 활용하여 Video와 유사한 장르 컨텐츠의 유튜브 광고 영상을 WebView로 나타낼 수 있도록 하였습니다.
- **Alamofire**를 사용하였고 TMDB의 API를 활용하여 UI를 구성하였습니다.

<br>
<br>

## Trouble Shooting
### 1. 여러 네트워크 통신의 작업 중단 시점에 cell reload 하기
#### 문제 상황
하나의 View에 동시에 네트워크 요청을 할 때 해당 View의 cell을 갱신하기 위해 각각의 네트워크 요청 작업마다 reload를 하기 보다 모든 작업이 끝났을 때 한번만 cell을 reload한다면 계속 reload하는 리소스 낭비를 줄여볼 수 있을 것 같다는 생각을 하게되었습니다.
#### 문제 해결
첫 번째 해결방법으로 **completionHandler**를 통해 첫 번째 네트워크의 작업 마지막 시점에 구현해뒀던 **completionHandler**를 통해 시점을 전달하고 두 번째 네트워크 통신 작업에서 마지막 시점에 reload를 하는 방식으로 해결할 수 있었습니다.

하지만 네트워크 통신이 더 늘어난다면 callback 함수가 더욱 늘어나 코드 가독성이 떨어지고 디버깅도 어렵다고 판단하였고 다른 방법을 생각하였습니다.

- **DispatchGroup**
```swift
func callRequestVideo() {
    let group = DispatchGroup()
    
    group.enter()
    TMDBAPIManager.shared.callRequest(of: YoutubeVideo.self, type: .video, movieId: movieId, seriesId: nil, seasonId: nil) { data in
        self.video = data
        group.leave()
	}

    group.enter()
    TMDBAPIManager.shared.callRequest(of: SimilarMovieData.self, type: .similar, movieId: movieId, seriesId: nil, seasonId: nil) { data in
        self.similarVideo = data
        group.leave()
    }
	
    group.notify(queue: .main) {
        print("END")
        self.movieCollectionView.reloadData()
    }
}
```

**DispatchGroup**을 통해 group에 포함된 네트워크 요청들의 마지막 시점을 판단할 수 있게 되었고 마지막 시점에 cell을 갱신한다면 앞서 사용했던 두가지의 방법보다 훨씬 코드 가독성도 올라가고 cell을 매번 갱신하지 않아도 되어 리소스 낭비를 줄여볼 수 있게되었습니다.

### 2. tableView의 Cell 재사용 문제
#### 문제 상황
API에서 데이터를 받아와 tableView에 UI를 그리고 tableView를 scroll할 때 데이터 중복되는 현상 발생
#### 문제 해결
cell은 재사용 매커니즘에 의해 상단에서 사용되었던 cell이 화면에서 사라지게 될 때 하단으로 다시 재사용될 준비를 하게되며, 해당 작업을 할 때 cell에 데이터까지 모두 같이 메모리에 다시 올리게 되어 상단에서 보았던 데이터가 중복되어 나타나는 현상이었다는 사실을 알게되었고 **prepareForReuse** 메서드를 통해 cell이 재사용될 때 cell의 데이터를 초기화해주면서 해당 문제는 해결되었습니다.
```swift
override func prepareForReuse() {
    super.prepareForReuse()
    moviePosterImageView.image = UIImage(named: "emptyImage")
    blurImageView.image = UIImage(named: "emptyImage")
    movieTitleLabel.text = ""
}
```
