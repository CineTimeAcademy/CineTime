//
//  RecommendationsViewController.swift
//  CineTime
//
//  Created by Vinicius Mesquita on 09/06/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class RecommendationsViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic

        navigationController?.viewControllers.first?.navigationItem.title = "Recomendações"
        // Change large title color from rootViewController 
        self.navigationController?.viewControllers.first?             .navigationController?.navigationBar.largeTitleTextAttributes = [                 NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        let reco = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2))
        reco.backgroundColor = .red
        
        let collecReco = RecoCollectionView(frame: CGRect(x: 0, y: view.frame.height / 4, width: view.frame.width, height: view.frame.height / 4), collectionViewLayout: ZoomAndSnapFlowLayout())
        
        collecReco.backgroundColor = .blue
        reco.addSubview(collecReco)
        
        
        
        
        view.addSubview(reco)
    
        
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
