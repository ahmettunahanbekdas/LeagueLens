// LeaguesDetailsViewController.swift

import UIKit

protocol LeaguesDetailsViewControllerInterface: AnyObject {
    func configureCollectionView()
    func reloadData()
}

final class LeaguesDetailsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    private let viewModel = LeaguesDetailsViewModel()
    private var league: LeagueStanding
    
    private var collectionView: UICollectionView!
    
    init(league: LeagueStanding) {
        self.league = league
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 20
        let height: CGFloat = 100
        return CGSize(width: width, height: height)
    }
}

extension LeaguesDetailsViewController: LeaguesDetailsViewControllerInterface {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTeamsFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TeamsCollectionViewCell.self, forCellWithReuseIdentifier: TeamsCollectionViewCell.reuseID)
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
    }
}

extension LeaguesDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamsCollectionViewCell.reuseID, for: indexPath) as! TeamsCollectionViewCell
        cell.setCell(id: indexPath.row) // Set cell content here
        return cell
    }
}

