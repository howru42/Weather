//
//  HomeCollectionViewController.swift
//  WeatherApp
//
//  Created by PMTIOS on 27/03/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var cities:[Location] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    var deleteItem:Int = -1{
        didSet{
            rightBtn.image = UIImage(named: (deleteItem != -1) ? "trash" : "plus")
        }
    }
    
    lazy var rightBtn = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(tappedRightBtn))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
//        collectionView.backgroundColor = .lightGray
        registerActions()
        navigationItem.rightBarButtonItem = rightBtn
        collectionView.register(getNib("CityWeatherItemCollectionViewCell"), forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deleteItem = -1
        cities = AccountManager.shared.locations
    }
    
    @IBAction func tappedRightBtn(_ sender:Any){
        let controller = AddCityViewController(nibName: "AddCityViewController", bundle: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CityWeatherItemCollectionViewCell)!
        let location = cities[indexPath.row]
        cell.setDetails(location.cityName, "30", "31 / 29","Cloudy")
        cell.dropShadow(color: .darkGray, offSet:  CGSize(width: -1, height: 1))
    
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

extension HomeCollectionViewController:UIGestureRecognizerDelegate{
    func registerActions() {
        let gesture : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        gesture.minimumPressDuration = 0.5
        gesture.delegate = self
        gesture.delaysTouchesBegan = true
        collectionView.addGestureRecognizer(gesture)
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(disableDelete)))
    }
    
    @IBAction func disableDelete(){
        deleteItem = -1
    }
    
    @IBAction func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer){
        if (gestureRecognizer.state != .ended){
            return
        }
        let point = gestureRecognizer.location(in: collectionView)
        if let indexPath : NSIndexPath = (collectionView.indexPathForItem(at: point)) as NSIndexPath?{
            deleteItem = (deleteItem == -1) ? indexPath.row : -1
        }
    }
}
