//
//  NetworkMonitor.swift
//  ShoppingSearchApp
//
//  Created by 한성봉 on 2023/09/13.
//

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
        print("init 호출")
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        print(#function)
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            print("path: \(path)")
            
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
