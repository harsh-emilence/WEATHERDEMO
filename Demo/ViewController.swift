//
//  ViewController.swift
//  Demo
//
//  Created by Zimble on 21/07/21.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet var minTempLbl : UILabel!
    @IBOutlet var maxTempLbl : UILabel!
    
    var viewModel : ViewModelClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModelClass()
        bindToViewModel()
        viewModel.getApiResponse()
        // Do any additional setup after loading the view.
    }
    
    func bindToViewModel() {
        
        viewModel.model.listener = {[weak self] value in
            self?.minTempLbl.text = self?.viewModel.measureMentLbl(value: value.tempMin) ?? ""
            self?.maxTempLbl.text = self?.viewModel.measureMentLbl(value: value.tempMax) ?? ""
        }
         
    }


}

