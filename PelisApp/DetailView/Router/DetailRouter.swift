//
//  DetailRouter.swift
//  PelisApp
//
//  Created by sebastian abarzua on 17-07-22.
//

import Foundation
import UIKit

class DetailRouter{
    var viewController: UIViewController{
        return createViewController()
    }
    var movieId : String?
    private var sourceView: UIViewController?
    
    init(movieId: String? = ""){
        self.movieId = movieId
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("error en carga de vista")}
        self.sourceView = view
    }
    
    private func createViewController() -> UIViewController {
        let view = DitailViewController(nibName: "DitailViewController", bundle: Bundle.main)
        view.movieID = self.movieId
        return view
    }
    
}

