//
//  DetailViewModel.swift
//  PelisApp
//
//  Created by sebastian abarzua on 17-07-22.
//

import Foundation
import RxSwift

class DetailViewModel {
    private var managerConections = ManagerConections()
    private(set) weak var view: DitailViewController?
    private var router: DetailRouter?
 
    func bind(view: DitailViewController, router: DetailRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getMovieData(movieID: String) -> Observable<MovieDetail>{
        return managerConections.getDetailMovie(movieId: movieID)
    }
    
    func getImageForServer(urlString: String) -> Observable<UIImage>{
        return managerConections.GetImageForServer(urlString: urlString)
    }
}
