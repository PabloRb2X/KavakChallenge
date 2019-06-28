//
//  DetailsController.swift
//  KavakChallenge
//
//  Created by Pablo Ramirez on 6/27/19.
//  Copyright © 2019 Pablo Ramirez. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    @IBOutlet weak var colorHair: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let detailsViewModel: DetailsViewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Description"

        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        nameLabel.text = detailsViewModel.gnome.name
        ageLabel.text = "Age: \(detailsViewModel.gnome.age)"
        weightLabel.text = "Weight: \(detailsViewModel.gnome.weight)"
        heightLabel.text = "Height: \(detailsViewModel.gnome.height)"
        if let image = detailsViewModel.image{
            imageView.image = image
        }
        else{
            imageView.backgroundColor = UIColor.lightGray
        }
        
        colorHair.backgroundColor = detailsViewModel.getHairColor(color: detailsViewModel.gnome.hairColor)
        colorHair.layer.cornerRadius = 5
        colorHair.layer.borderColor = UIColor.black.cgColor
        colorHair.layer.borderWidth = 1
    }

    
    @IBAction func segmentControlEvent(_ sender: UISegmentedControl) {
        
        tableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailsController: UITableViewDelegate{
    
}

extension DetailsController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return detailsViewModel.gnome.professions.count
        case 1:
            return detailsViewModel.gnome.friends.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell"){
            
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                cell.textLabel?.text = detailsViewModel.gnome.professions[indexPath.row]
            case 1:
                cell.textLabel?.text = detailsViewModel.gnome.friends[indexPath.row]
            default:
                break
            }
            cell.textLabel?.textAlignment = .center
            
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
}
