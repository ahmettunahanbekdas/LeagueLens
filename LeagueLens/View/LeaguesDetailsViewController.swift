
import UIKit

protocol LeaguesDetailsViewControllerDelegate: AnyObject {
    func configureLeaguesDetailsViewController()
    func configureLeaguesDetailsCollectionView()
    func leaguesDetailsHeaderView()
    func reloadData()
}

final class LeaguesDetailsViewController: UIViewController{
    
    private var viewModel: LeaguesDetailsViewModelDelegate
    private var inLeague: [LeagueStanding]
    private var leaguesDetailsLogoImageView: LeagueDetailsHeaderImageView!
    
    private var leaguesDetailsNameLabel: UILabel!
    private var leaguesDetailsCollectionView: UICollectionView!
    
    init(selectedLeague: [LeagueStanding], viewModel: LeaguesDetailsViewModelDelegate = LeaguesDetailsViewModel()) {
        self.inLeague = selectedLeague
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LeaguesDetailsViewController: LeaguesDetailsViewControllerDelegate,  UICollectionViewDelegateFlowLayout {
    func reloadData() {
        DispatchQueue.main.async {
            self.leaguesDetailsCollectionView.reloadData()
        }
    }
    
    func configureLeaguesDetailsViewController() {
        title = inLeague.first?.league?.name ?? "None"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func leaguesDetailsHeaderView() {
        let deviceHeight: CGFloat = CGFloat.deviceHeight
        let deviceWidth: CGFloat = CGFloat.deviceWidth
        
        leaguesDetailsLogoImageView = LeagueDetailsHeaderImageView(frame: .zero)
        leaguesDetailsLogoImageView.contentMode = .scaleAspectFit
        leaguesDetailsLogoImageView.clipsToBounds = true
        leaguesDetailsLogoImageView.detailDownloadLeaguesImage(league: inLeague.first!)
        leaguesDetailsLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leaguesDetailsLogoImageView)
        
        leaguesDetailsNameLabel = UILabel(frame: .zero)
        leaguesDetailsNameLabel.textAlignment = .center
        leaguesDetailsNameLabel.text = inLeague.first?.league?.name
        leaguesDetailsNameLabel.textColor = .label
        leaguesDetailsNameLabel.translatesAutoresizingMaskIntoConstraints = false
        leaguesDetailsNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        leaguesDetailsNameLabel.isHidden = false
        view.addSubview(leaguesDetailsNameLabel)
        
        NSLayoutConstraint.activate([
            leaguesDetailsLogoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: deviceWidth / 10),
            leaguesDetailsLogoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: deviceWidth / 5),
            leaguesDetailsLogoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -deviceWidth / 5),
            leaguesDetailsLogoImageView.heightAnchor.constraint(equalToConstant: deviceHeight / 5),
            
            leaguesDetailsNameLabel.topAnchor.constraint(equalTo: leaguesDetailsLogoImageView.bottomAnchor, constant: 8),
            leaguesDetailsNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            leaguesDetailsNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            leaguesDetailsNameLabel.heightAnchor.constraint(equalToConstant: deviceHeight / 10)
        ])
    }
    
    func configureLeaguesDetailsCollectionView() {
        leaguesDetailsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createCollectionViewFlowLayout())
        leaguesDetailsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        leaguesDetailsCollectionView.dataSource = self
        leaguesDetailsCollectionView.delegate = self
        leaguesDetailsCollectionView.register(TeamsCollectionViewCell.self, forCellWithReuseIdentifier: TeamsCollectionViewCell.reuseID)
        view.addSubview(leaguesDetailsCollectionView)
        
        NSLayoutConstraint.activate([
            leaguesDetailsCollectionView.topAnchor.constraint(equalTo: leaguesDetailsNameLabel.bottomAnchor),
            leaguesDetailsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leaguesDetailsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leaguesDetailsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        view.backgroundColor = .systemBackground
    }
}

extension LeaguesDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 20
        let height: CGFloat = collectionView.frame.height / 8
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inLeague.first?.league?.standings?.first?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamsCollectionViewCell.reuseID, for: indexPath) as! TeamsCollectionViewCell
        if let standing = inLeague.first?.league?.standings?.first?[indexPath.item] {
            cell.setTeamsCell(
                rank: standing.rank!,
                teamImage: standing.team?.id ?? 0,
                teamName: standing.team?.name ?? "none",
                win: standing.all?.win ?? 0,
                draw: standing.all?.draw ?? 0,
                lose: standing.all?.lose ?? 0,
                points: standing.points ?? 0,
                form: standing.form ?? "none"
            )
        }
        return cell
    }
}
