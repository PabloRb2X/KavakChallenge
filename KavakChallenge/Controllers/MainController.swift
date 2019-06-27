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
    
    var mainViewModel: MainViewModel = MainViewModel()
    
    var isFilter = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gnomeCollectionView.register(UINib(nibName: "GnomeViewCell", bundle: nil), forCellWithReuseIdentifier: "GnomeCell")
        gnomeCollectionView.delegate = self
        gnomeCollectionView.dataSource = self
        
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchBar.text = ""
        mainViewModel.emptyFilter()
        
        mainViewModel.mainDelegate = self
        mainViewModel.getGnomesTown()
    }

}

extension MainController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = DetailsController()
        if !isFilter{
            detailsViewController.detailsViewModel.gnome = mainViewModel.gnomes.brastlewark[indexPath.row]
        }
        else{
            detailsViewController.detailsViewModel.gnome = mainViewModel.filter[indexPath.row]
        }
        
        navigationController?.pushViewController(detailsViewController, animated: true)
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
                cell.initCell(gnome: mainViewModel.gnomes.brastlewark[indexPath.row])
            }
            else{
                cell.initCell(gnome: mainViewModel.filter[indexPath.row])
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
    
    func didSuccessService() {
        self.dismissLoadingView()
        
        gnomeCollectionView.reloadData()
    }
    
    func didErrorService() {
        let alert = UIAlertController(title: "Error", message: "Ocurrió un error en la petición del servicio.", preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Reintentar", style: .default, handler: { (action:UIAlertAction) -> Void in
                                            
            self.mainViewModel.getGnomesTown()
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default) { (action: UIAlertAction) -> Void in
            
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(retryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
