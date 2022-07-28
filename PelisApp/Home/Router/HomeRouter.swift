//
//  HomeRouter.swift
//  PelisApp
//
//  Created by sebastian abarzua on 14-07-22.
//

import Foundation
import UIKit

class HomeRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = HomeViewController(nibName: "HomeViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("error en carga de vista")}
        self.sourceView = view
    }
    
    public func navegateToDetailView(movieID: String){
        let detailView = DetailRouter(movieId: movieID).viewController
        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }
}
