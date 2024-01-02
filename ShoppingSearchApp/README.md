# ShoPick
<img src="https://github.com/SSABOODA/Sesac-Project/assets/69753846/088747c2-2fb4-4c58-b53a-fe6fbebf0147" height="100" width="100">

## 프로젝트 소개
<p align="center" width="100%">
    <img src="https://github.com/SSABOODA/Sesac-Project/assets/69753846/7abe5b6a-761b-4055-a49c-e84ac575b47c" width="100%">
</p>

### 앱 소개
네이버 ‘검색’ API를 활용하여 상품을 검색하여 상품을 확인하고 좋아요를 통해 상품을 관리하고 네이버 쇼핑과 연결되어 상품을 직접 구매할 수 있는 앱입니다.

### 주요 기능
- 상품 검색 기능
  - 네이버 쇼핑 '검색' API를 활용하였기 때문에 현재 네이버 쇼핑에 올라와있는 상품 기반으로 검색
- 정확도, 날짜순, 가격순으로 상품 filter 기능
- 네이버 서버 상품을 앱 내 Realm Database에 '좋아요' 기능을 통해 데이터 저장
  - 좋아요한 상품 목록 List 확인 기능
  - 좋아요한 상품 목록 검색 기능
- 상품 클릭 시 상세화면(웹뷰) 처리
  
### 프로젝트 기간
- 2023.09.07 ~ 2023.9.13

### 프로젝트 참여 인원
1명(개인)

### 사용된 기술 스택
- **Framework** <br>
`UIKit`,<br>
`URLSesstion`, `Network(NWPathMonitor)`
- **Library** <br>
`Kingfisher`, `Snapkit`, `Realm`, `Toast`
- **Design Pattern** <br>
`MVC Design Pattern`, `Repository Pattern`, `Singleton Pattern`
    
## 구현 기능
### 상품 데이터 검색
- 상품 데이터는 `UICollectionViewFlowLayout` 기반의 CollectionView를 사용하여 Cell을 구성하였습니다.
- 네이버 ‘검색’ API를 활용하여 검색 View를 구성하였습니다. 네트워크 통신에는 `URLSession` 을 사용하여 상품 데이터를 요청하였습니다.
- `Network` 프레임워크의 `NWPathMonitor` 객체를 활용해 현재 기기의 인터넷 연결 상태를 감지한 후 연결 상태에 따른 얼럿을 사용자에게 알리도록 구현하였습니다.
- 상품 목록 View에서는 `Pagination`을 구현하였고   `UICollectionViewDataSourcePrefetching` protocol을 채택하여 `prefetchItemsAt` 메서드를 활용하여 구현하였습니다. 
- 상품 데이터에 대해서는 여러 조건(정확도, 날짜순, 가격순) `Filter` 를 적용하여 유저의 편의성을 높이도록 하였습니다.
### 상품 좋아요
- 상품 좋아요는 `Realm Database` 를 사용하여 상품 데이터를 DB에 저장하도록 하였습니다.
- 상품의 상세정보는 `WebKit` 을 사용하여 직접 네이버 쇼핑 사이트로 이동하여 확인할 수 있도록 하였습니다.
- 좋아요 View의 상품들은 `실시간 검색`이 가능하도록 적용하였습니다.
- `Realm Notification Observer`를 활용해 모든 View에서 좋아요 상태가 `동기화` 되도록 구현하였습니다.

## Trouble Shooting
### 1. ViewController들 간에 좋아요 동기화 이슈
#### 문제 상황
여러가지 뷰에서 어떤 데이터에 대한 상태를 동기화하는 부분과 하나의 뷰에서 상태가 변경되었을 때 다른 뷰에서 상태가 실시간으로 변경되어야 하는 상황이 발생하였습니다.

문제는 상품 검색 후 ‘좋아요’를 눌렀을 경우 다른 뷰(좋아요 목록, 상품 상세 웹뷰, 상품 리스트)에서 상태가 동기화되어야하는 문제가 있었습니다.
#### 문제 해결
1. viewWillAppear
첫번째로 생각했던 방법은 사용자가 해당 View에 진입했을 경우 항상 데이터가 갱신되어야한다고 생각했습니다.
이전 화면에서 ‘좋아요’를 눌렀다면 다른 화면에서 이전 화면에서 변경했던 데이터를 갱신해야했기에 `viewWillAppear` 메서드에서 항상 최신 데이터를 받아서 해당 View의 UI를 갱신해주는 방식으로 해결했습니다.

<details>
	<summary>SearchViewController.swift</summary>

```swift
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateProductLikeData()
}

private func updateProductLikeData() {
    let productList = productTableRepository.fetch()
    for (index, item) in itemList.enumerated() {
        itemList[index].isLike = false
        for product in productList {
            if item.productId == product.productId {
                itemList[index].isLike = true
            }
        }
    }
    collectionView.reloadData()
}
```
</details>

하지만 곧 이 방식에 문제점이 존재한다는 사실을 깨달았습니다. 물론 데이터 갱신도 잘되고 사용자가 보기에도 UI상에 전혀 문제가 없었습니다. 만약 유저가 이전 화면에서 데이터를 변경하지 않고 다른 화면으로 넘어갔을 때도 항상 Realm DB에 해당 데이터를 fetch하고 데이터에 대한 변화가 있는지 조건 확인을 하는 로직이 항상 실행되게 됩니다. 물론 데이터가 작을 때는 문제가 되지 않겠지만 좋아요 데이터가 수십, 수백만개?가 된다고 가정한다면 불필요한 로직처리로 인한 리소스 낭비가 야기 될 것 같았습니다.

2. Realm Notification
`Realm` 데이터베이스에 KVO 기반의 `Notification`을 지원하고 있었습니다. 해당 객체 또는 해당 객체의 특정 필드의 변화가 감지될 때 변경 결과를 알수 있도록 `observer`를 설정할 수 있습니다.
```swift
final class SearchViewController: BaseViewController {
    var products: Results<ProductTable>!
    var notificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
            setRealmNotification()
	}

    private func setRealmNotification() {
        let realm = try! Realm()
        products = realm.objects(ProductTable.self)

        notificationToken = products?.observe { [unowned self] changes in
            switch changes {
            case .initial(let products):
                print("Initial count: \(products.count)")
            case .update(let products, let deletions, let insertions, let modifications):
		self.collectionView.reloadData()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
}
```

`ProductTable` 에 변화가 생겼을 때 Observer를 통해서 변화의 결과를 받게 되고 `.update` case에서 변화가 있을 때만 collectionView를 reloadData 하게 설계를 했습니다. 
그 결과 데이터 변화가 없음에도 Realm DB에서 데이터를 `fetch`하는 상황을 없앨 수 있게 되었습니다.

### 2. 네트워크 상태 감지 후 에러 핸들링
#### 문제 상황
네트워크 연결 상황에 따라 만약 어떤 네트워크에도 연결되어 있지 않다면 사용자에게 얼럿을 보내 연결 네트워크 연결 상태가 없다는 정보를 알려주고 싶었습니다.

#### 문제 해결
문제 해결을 위해 우선 네트워크 연결을 감지할 수 있는 기능을 구현해야했습니다. `Network` 프레임워크에`NWPathMonitor` 라는 클래스를 통해 네트워크 연결을 감지할 수 있었습니다.

<details>
	<summary>NetworkMonitor.swift</summary>

```swift
import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unowned
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unowned
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        print(#function)
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
            
            if self?.isConnected == true {
                print("연결 상태")
            } else {
                print("연결 안된 상태")
            }
        }
    }
    
    public func stopMonitoring() {
        print(#function)
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
            print("Wifi에 연결")
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
            print("cellular에 연결")
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
            print("ethernet에 연결")
        } else {
            connectionType = .unowned
            print("unowned ..")
        }
    }
}

```
</details>

<details>
	<summary>SearchViewController.swift</summary>

```swift
private func fetchData(query: String, sort: String, start: Int) {
    guard !query.isEmpty else {
        self.showNoQueryAlert()
        return
    }
        
    self.showIndicatorView(
        activityIndicatorView: self.activityIndicatorView,
        status: true
    )
        
    APIManager.shared.callRequest(
        query: query,
        apiType: .shopping,
        sort: sort,
        start: start
    ) { result in
        switch result {
        case .success(let shoppingData):
            self.shopping = shoppingData
            self.total = shoppingData.total ?? 0
            self.itemList += shoppingData.items ?? []

	    DispatchQueue.main.async {
                guard !self.itemList.isEmpty else {
                    self.noResultQueryAlert() // 검색 결과 없을 때 얼럿
                    self.showIndicatorView(
                        activityIndicatorView: self.activityIndicatorView,
                        status: false
                    )
                    return
                }

                self.collectionView.reloadData()
                self.showIndicatorView(
                    activityIndicatorView: self.activityIndicatorView,
                    status: false
                )

                if start == Constants.APIParameter.start {
                    self.collectionView.setContentOffset(.zero, animated: true)
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.showIndicatorView(
                    activityIndicatorView: self.activityIndicatorView,
                    status: false
                )
                self.searchEmptyView.isHidden = true
                switch error {case .networkingError:
                    let networkStatus = self.checkNetworkStatus()
                    if !networkStatus {
                        // 네트워크 연결을 확인 요청 얼럿
                        self.showAlertIfNoInternetNetworkConnection()
                    } else {
                        // 인터넷 연결은 되어 있지만 api 통신시 네트워크 에러 시 얼럿
                        self.showNetworkingErrorAlert(title: Constants.NetworkErrorAlertText.networkingError) {}
                    }
                case .parseError:
                    self.showNetworkingErrorAlert(title: Constants.NetworkErrorAlertText.parseError) {}
                case .dataError:
                    print("dataError")
                }
                self.collectionView.reloadData()
                }
            }
        }
    }

```
</details>

##### 네트워크 에러 핸들링
```swift
switch error {
    case .networkingError:
    let networkStatus = self.checkNetworkStatus()
    if !networkStatus {
        // 네트워크 연결을 확인 요청 얼럿
        self.showAlertIfNoInternetNetworkConnection()
    } else {
        // 인터넷 연결은 되어 있지만 api 통신시 네트워크 에러 시 얼럿
        self.showNetworkingErrorAlert(title: Constants.NetworkErrorAlertText.networkingError) {}
    }
    case .parseError:
        self.showNetworkingErrorAlert(title: Constants.NetworkErrorAlertText.parseError) {}
    case .dataError:
        print("dataError")
}
```

앱 사용 중 사용자가 `Wifi` 나 `Cellular` 둘 중 하나라도 연결된 상태가 아닌 상태에서 검색을 시도하여 Network Request를 보낸다면  인터넷 연결이 되어 있지 않다라는 얼럿의 띄워 사용자에게 인터넷 연결을 유도할 수 있도록 처리하였습니다.
