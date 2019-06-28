//
//  MainController.swift
//  KavakChallenge
//
//  Created by Pablo Ramirez on 6/26/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var gnomeCollectionView: UICollectionView!
    var refresher: UIRefreshControl!
    
    var mainViewModel: MainViewModel = MainViewModel()
    
    var isFilter = false
    var isLoadData = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Gnome Twon"

        // Do any additional setup after loading the view.
        gnomeCollectionView.register(UINib(nibName: "GnomeViewCell", bundle: nil), forCellWithReuseIdentifier: "GnomeCell")
        gnomeCollectionView.delegate = self
        gnomeCollectionView.dataSource = self
        
        searchBar.delegate = self
        
        refresher = UIRefreshControl()
        gnomeCollectionView.alwaysBounceVertical = true
        refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        gnomeCollectionView.addSubview(refresher)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        mainViewModel.mainDelegate = self
        mainViewModel.getGnomesTown(isLoadData: isLoadData)
    }
    
    @objc func loadData(){
        
        isLoadData = false
        mainViewModel.getGnomesTown(isLoadData: isLoadData)
        stopRefresher()
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailController = segue.destination as? DetailsController{
            
            detailController.detailsViewModel.gnome = mainViewModel.selectedBrastlewark
            detailController.detailsViewModel.image = mainViewModel.selectedImage
        }
    }
}

extension MainController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GnomeViewCell else {return}
        
        if !isFilter{
            mainViewModel.selectedBrastlewark = mainViewModel.gnomes.brastlewark[indexPath.row]
        }
        else{
            mainViewModel.selectedBrastlewark = mainViewModel.filter[indexPath.row]
        }
        mainViewModel.selectedImage = cell.gnomeImage.image
        
        //navigationController?.pushViewController(detailsViewController, animated: true)
        self.performSegue(withIdentifier: "detailsSegue", sender: nil)
    }
}

extension MainController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !isFilter{
            return mainViewModel.gnomes.brastlewark.count
        }
        else{
            return mainViewModel.filter.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GnomeCell", for: indexPath) as? GnomeViewCell{
            
            if !isFilter{
                cell.initCell(gnome: mainViewModel.gnomes.brastlewark[indexPath.row], viewModelRef: mainViewModel, index: indexPath.row)
            }
            else{
                cell.initCell(gnome: mainViewModel.filter[indexPath.row], viewModelRef: mainViewModel, index: indexPath.row)
            }
            
            return cell
        }
        else{
            
            return UICollectionViewCell()
        }
    }
}

extension MainController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: gnomeCollectionView.frame.width * 0.95, height: gnomeCollectionView.frame.height * 0.25)
    }
}

extension MainController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isFilter = true
        
        if searchBar.text != ""{
            
            mainViewModel.filterResults(text: searchBar.text!)
        }
        else{
            
            isFilter = false
            mainViewModel.emptyFilter()
        }
        gnomeCollectionView.reloadData()
        
    }
}

extension MainController: MainProtocol{
    
    func didStartService() {
        self.showLoadingView()
    }
    
    func didSuccessService(isLoadData: Bool) {
        self.dismissLoadingView()
        self.isLoadData = isLoadData
        
        gnomeCollectionView.reloadData()
    }
    
    func didErrorService() {
        let alert = UIAlertController(title: "Error", message: "Ocurrió un error en la petición del servicio.", preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Reintentar", style: .default, handler: { (action:UIAlertAction) -> Void in
                                            
            self.mainViewModel.getGnomesTown(isLoadData: false)
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default) { (action: UIAlertAction) -> Void in
            
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(retryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
