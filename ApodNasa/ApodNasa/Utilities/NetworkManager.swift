//
//  Connectivity.swift
//  ApodNasa
//
//  Created by Nitin Bhatia on 13/02/23.
//


import Network

protocol NetworkManagerDelegate{
    func didConnectionStatusChange()
}

class NetworkManager {
    static let shared = NetworkManager()
    
    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status ==  .satisfied}
    
    //delegate for independent view controllers
    var uiViewControllerDelegate : NetworkManagerDelegate?
    
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            
            debugPrint(path.usesInterfaceType(.wifi))
            
            if path.status == .satisfied {
                debugPrint("We're connected!")
                self?.toogleOfflineView(showOffllineView: false)
            } else {
                debugPrint("No connection.")
                self?.toogleOfflineView(showOffllineView: true)
            }
            
            debugPrint(path.isExpensive, "is connected to mobile network") //if connected to cellular
            
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    func toogleOfflineView(showOffllineView : Bool) {
        
        //doing this intentionally, becuase when application launches then top view controller is launcher vc which we are ignoring to show offline view
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute:  {
            self.uiViewControllerDelegate?.didConnectionStatusChange()
        })
    }
}
