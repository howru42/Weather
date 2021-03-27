//
//  HomeCollectionViewController.swift
//  WeatherApp
//
//  Created by PMTIOS on 27/03/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(tappedAdd))
        collectionView.register(getNib("CityWeatherItemCollectionViewCell"), forCellWithReuseIdentifier: reuseIdentifier)
    }

    @IBAction func tappedAdd(_ sender:Any){
        print("Something....")
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CityWeatherItemCollectionViewCell)!
        cell.setDetails("Hyderabad", "30", "31 / 29","Cloudy")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width:CGFloat = min(view.frame.size.width,400)
        let height = min(width/3, 120)
        return CGSize(width: width-20, height: height)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
