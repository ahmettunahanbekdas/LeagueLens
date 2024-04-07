// LeaguesDetailsViewController.swift

import UIKit

protocol LeaguesDetailsViewControllerInterface: AnyObject {
    func configureCollectionView()
    func headerView()
    func reloadData()
}

final class LeaguesDetailsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    private let viewModel = LeaguesDetailsViewModel()
    private var selectedLeague: [LeagueStanding]
    
    private var headerImageView: HeaderImageView!
    private var headerLabel: UILabel!
    private var collectionView: UICollectionView!
    
    init(league: [LeagueStanding]) {
        self.selectedLeague = league
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
    
    func headerView() {
        let headerHeight: CGFloat = CGFloat.deviceHeight
        let headerWidth: CGFloat = CGFloat.deviceWidth
        
        headerImageView = HeaderImageView(frame: .zero)
        headerImageView.contentMode = .scaleAspectFit
        headerImageView.clipsToBounds = true
        headerImageView.detailDownloadLeaguesImage(league: selectedLeague.first!)
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerImageView)
        
        headerLabel = UILabel(frame: .zero)
        headerLabel.textAlignment = .center
        headerLabel.text = selectedLeague.first?.league?.name
        headerLabel.textColor = .black
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: headerWidth / 5),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -headerWidth / 5),
            headerImageView.heightAnchor.constraint(equalToConstant: headerHeight / 6),
            
            headerLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 8),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headerLabel.heightAnchor.constraint(equalToConstant: headerHeight / 10)
        ])
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createTeamsFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TeamsCollectionViewCell.self, forCellWithReuseIdentifier: TeamsCollectionViewCell.reuseID)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.backgroundColor = .systemBackground
    }
}

extension LeaguesDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedLeague.first?.league?.standings?.first!.count ?? 0
    }
    
    // func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamsCollectionViewCell.reuseID, for: indexPath) as! TeamsCollectionViewCell
    //     cell.setCell(teamName: selectedLeague.first?.league?.standings?.first![indexPath.item].team?.name ?? "nil",
    //                  teamID: selectedLeague.first?.league?.standings?.first![indexPath.item].team?.id ?? 0,
    //                  rank: selectedLeague.first?.league?.standings?.first![indexPath.item].rank ?? 0,
    //                  points: selectedLeague.first?.league?.standings?.first![indexPath.item].points ?? 0,
    //                  form: "www",
    //                  win: 22,
    //                  draw: 22,
    //                  lose: 22
    //     )
    //     return cell
    // }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamsCollectionViewCell.reuseID, for: indexPath) as! TeamsCollectionViewCell
        cell.setCell(
            rank: selectedLeague.first?.league?.standings?.first![indexPath.item].rank ?? 0,
            teamImage: selectedLeague.first?.league?.standings?.first![indexPath.item].team?.id ?? 0,
            teamName: selectedLeague.first?.league?.standings?.first![indexPath.item].team?.name ?? "nil",
            win: selectedLeague.first?.league?.standings?.first![indexPath.item].all?.win ?? 0,
            draw: selectedLeague.first?.league?.standings?.first![indexPath.item].all?.draw ?? 0,
            lose: selectedLeague.first?.league?.standings?.first![indexPath.item].all?.lose ?? 0,
            points: selectedLeague.first?.league?.standings?.first![indexPath.item].points ?? 0,
            form: selectedLeague.first?.league?.standings?.first![indexPath.item].form ?? " "
        )
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(selectedLeague.first?.league?.standings?.first![indexPath.item].team?.id ?? 0)
    }
}
