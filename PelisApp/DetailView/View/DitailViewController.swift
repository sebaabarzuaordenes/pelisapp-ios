//
//  DitailViewController.swift
//  PelisApp
//
//  Created by sebastian abarzua on 17-07-22.
//

import UIKit
import RxSwift

class DitailViewController: UIViewController {

    @IBOutlet private weak var titleHeader: UILabel!
    @IBOutlet private weak var imgMovie: UIImageView!
    @IBOutlet private weak var dateReleast: UILabel!
    @IBOutlet private weak var tiuloOrigina: UILabel!
    @IBOutlet private weak var popularidad: UILabel!
    @IBOutlet private weak var numeroVotos: UILabel!
    @IBOutlet private weak var promedioVotos: UILabel!
    @IBOutlet private weak var sinopsis: UILabel!
    
    var movieID: String?
    private var router = DetailRouter()
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataAndShowDetailMovie()
        viewModel.bind(view: self, router: router)
    }
    
    private func getDataAndShowDetailMovie(){
        guard let idMovie = movieID else { return }
        print(idMovie)
        return viewModel.getMovieData(movieID: idMovie).subscribe { movie in
            self.showMovieData(movie: movie)
        } onError: { error in
            print("un error en la carga de detall \(error)")
        } onCompleted: {
        }.disposed(by: disposeBag)
    }
    
    private func getImageMovie(movie: MovieDetail) {
        return viewModel.getImageForServer(urlString: Constans.URL.urlImage+movie.posterPath)
            .subscribe(
                onNext: { image in
                    DispatchQueue.main.async {
                        self.imgMovie.image = image
                    }
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
            }).disposed(by: disposeBag)

    }

    func showMovieData(movie: MovieDetail) {
        DispatchQueue.main.async {
            self.titleHeader.text = movie.title
            self.getImageMovie(movie: movie)
            self.dateReleast.text = movie.releaseDate
            self.tiuloOrigina.text = movie.originalTitle
            self.popularidad.text = "\(movie.popularity)"
            self.promedioVotos.text = "\(movie.voteAverage)"
            self.numeroVotos.text = "\(movie.voteCount)"
            self.sinopsis.text = movie.overview
        }
    }
}
