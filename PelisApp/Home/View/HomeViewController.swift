//
//  HomeViewController.swift
//  PelisApp
//
//  Created by sebastian abarzua on 14-07-22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableViewListMovie: UITableView!
    @IBOutlet weak var activityLoad: UIActivityIndicatorView!
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    private var movies = [Movie]()
    private var filtroMovie = [Movie]()
    
    lazy var searchController: UISearchController = ({
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .black
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "buscar tu pelicula"
        return controller
    })()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pelis App"
        configureTableView()
        viewModel.bind(view: self, router: router)
        getData()
        managerSearchController()
    }
    
    private func configureTableView(){
        tableViewListMovie.rowHeight = UITableView.automaticDimension
        tableViewListMovie.register(UINib(nibName: "movieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
    }
    
    private func getData(){
        return viewModel.getListMovieData()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { movies in
                    self.movies = movies
                    self.reloadTableView()
            }, onError:{ error in
                print(error.localizedDescription)
            }, onCompleted: {
            }).disposed(by: disposeBag)
    }
    
    private func reloadTableView(){
        DispatchQueue.main.async {
            self.activityLoad.stopAnimating()
            self.activityLoad.isHidden = true
            self.tableViewListMovie.reloadData()
        }
    }
    
    private func managerSearchController(){
        let searchBar = searchController.searchBar
        searchController.delegate = self
        tableViewListMovie.tableHeaderView = searchBar
        tableViewListMovie.contentOffset = CGPoint(x: 0, y: searchBar.frame.height)
        
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
                .subscribe(onNext: { (result) in
                    self.filtroMovie  = self.movies.filter({ movie in
                        self.reloadTableView()
                        return movie.title.contains(result)
                    })
                    self.tableViewListMovie.reloadData()
                    return
                })
            .disposed(by: disposeBag)


    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""{
            return filtroMovie.count
        }else{
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! movieCell
        if searchController.isActive && searchController.searchBar.text != ""{
            cell.imgMovie.imageUrlServer(urlString: "\(Constans.URL.urlImage+self.filtroMovie[indexPath.row].posterPath)", placeHolderImage: UIImage(named: "claqueta-de-cine")!)
            cell.lblTitulo.text = filtroMovie[indexPath.row].title
            cell.lblSinopsis.text = filtroMovie[indexPath.row].overview
        }else{
            cell.imgMovie.imageUrlServer(urlString: "\(Constans.URL.urlImage+self.movies[indexPath.row].posterPath)", placeHolderImage: UIImage(named: "claqueta-de-cine")!)
            cell.lblTitulo.text = movies[indexPath.row].title
            cell.lblSinopsis.text = movies[indexPath.row].overview
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != ""{
            viewModel.makeDetailView(movieId: String(self.filtroMovie[indexPath.row].id))
        }else{
            viewModel.makeDetailView(movieId: String(self.movies[indexPath.row].id))
        }
    }

}

extension HomeViewController : UISearchControllerDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searchController.isActive = false
        reloadTableView()
    }
}
