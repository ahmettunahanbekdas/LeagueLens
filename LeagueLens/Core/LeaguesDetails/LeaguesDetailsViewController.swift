//
//  LeaguesDetailsViewController.swift
//  MatchMinder
//
//  Created by Ahmet Tunahan Bekdaş on 31.03.2024.
//

import UIKit

protocol LeaguesDetailsViewControllerInterface: AnyObject {
    func configureView() 
}

class LeaguesDetailsViewController: UIViewController {
    private let viewModel = LeaguesDetailsViewModel()
    private var league: ResponseLeague
      
    
    init(league: ResponseLeague) {
        self.league = league
        super.init(nibName: nil, bundle: nil)
        //print(league.league?.name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension LeaguesDetailsViewController: LeaguesDetailsViewControllerInterface {
    
    func configureView() {
        view.backgroundColor = .systemGray
    }
    
   
    
}

