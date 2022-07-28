//
//  HomeViewModel.swift
//  PelisApp
//
//  Created by sebastian abarzua on 14-07-22.
//

import Foundation
import RxSwift
import UIKit

class HomeViewModel{
    private weak var view: HomeViewController?
    private var router: HomeRouter?
    private var managerConections = ManagerConections()
    
    func bind(view:HomeViewController, router:HomeRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }

    func getListMovieData() -> Observable<[Movie]>{
        return managerConections.getPopularMovies()
    }
    
    func getImageForServer(urlString: String) -> Observable<UIImage>{
        return managerConections.GetImageForServer(urlString: urlString)
    }
    
    public func makeDetailView(movieId: String){
        router?.navegateToDetailView(movieID: movieId)
    }
    
    public func getImageMovie(urlString: String) -> Observable<UIImage>{
        return managerConections.GetImageForServer(urlString: urlString)
    }
}
