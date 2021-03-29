//
//  HomeCollectionViewController.swift
//  WeatherApp
//
//  Created by PMTIOS on 27/03/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    @IBOutlet weak var collectionView:UICollectionView!
    
    var cities:[WeatherResponse] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    var deleteItem:Int = -1{
        didSet{
            rightBtn.image = UIImage(named: (deleteItem != -1) ? "trash" : "plus")
            toggleCellSelection()
        }
    }
    
    lazy var rightBtn = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(tappedRightBtn))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
        collectionView.delegate = self
        collectionView.dataSource = self
        
        registerActions()
        navigationItem.rightBarButtonItem = rightBtn
        collectionView.register(getNib("CityWeatherItemCollectionViewCell"), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deleteItem = -1
        cities = AccountManager.shared.locations
        fetchWeatherData()
    }
    
    @IBAction func tappedRightBtn(_ sender:Any){
        if deleteItem != -1 {
            showAlert(title: "Delete", msg: "Are you sure want to delete?", btn1Name: "Proceed", btn2Name: "Cancel", btn1Action: { [weak self] in
                guard let self = self else { return }
                self.cities.remove(at: self.deleteItem)
                AccountManager.shared.locations = self.cities
                self.deleteItem = -1
            }) {
                self.deleteItem = -1
            }
            
        }else{
            let controller = AddCityViewController(nibName: "AddCityViewController", bundle: nil)
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CityWeatherItemCollectionViewCell)!
        let weather = cities[indexPath.row]
        cell.setDetails(weather)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width:CGFloat = min(view.frame.size.width,400)
        let height = min(width/3, 100)
        return CGSize(width: width-20, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        deleteItem = -1
        let controller = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        controller.selectedCity = cities[indexPath.row]
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
//        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(disableDelete)))
    }
    
    @IBAction func disableDelete(){
        deleteItem = -1
        let controller = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        navigationController?.pushViewController(controller, animated: true)
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
    
    @IBAction func tappedHelp(){
        let helpController = HelpViewController(nibName: "HelpViewController", bundle: nil)
        navigationController?.pushViewController(helpController, animated: true)
    }
    
    func toggleCellSelection() {
        if let cell = collectionView.cellForItem(at: IndexPath(row: (deleteItem != -1 ? deleteItem : 0), section: 0)) as? CityWeatherItemCollectionViewCell{
            cell.isItemSelecte = (deleteItem != -1)
        }
    }
}

//API Calls
extension HomeCollectionViewController{
    func fetchWeatherData(){
            cities.indices.forEach{ (idx) in
            let item = cities[idx]
                guard let coordinates = item.coord else {return}
            HttpManager.shared.fetchWeather(coordinates) { [weak self] (response, error) in
                if let error = error{
                    self?.showAlert(title: error, msg: "", btn1Name: "OK")
                }else if let response = response as? WeatherResponse{
                    DispatchQueue.main.async {
                        self?.cities[idx] = response
                    }
                }
            }
        }
    }
}
