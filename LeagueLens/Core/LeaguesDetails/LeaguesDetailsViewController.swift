import UIKit

protocol LeaguesDetailsViewControllerInterface: AnyObject {
    func configureView()
    func configureCollectionView()
    func headerView()
    func reloadData()
}

final class LeaguesDetailsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    private var viewModel: LeaguesDetailsViewModelInterface
    private var selectedLeague: [LeagueStanding]
    
    private var headerImageView: HeaderImageView!
    private var headerLabel: UILabel!
    private var collectionView: UICollectionView!
    
    init(league: [LeagueStanding], viewModel: LeaguesDetailsViewModelInterface = LeaguesDetailsViewModel()) {
        self.selectedLeague = league
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        
        setupFavoriteButton()
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
    
    func configureView() {
        title = selectedLeague.first?.league?.name ?? "None"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

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
        headerLabel.textColor = .label
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
        return selectedLeague.first?.league?.standings?.first?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamsCollectionViewCell.reuseID, for: indexPath) as! TeamsCollectionViewCell
        if let standing = selectedLeague.first?.league?.standings?.first?[indexPath.item] {
            cell.setCell(
                rank: standing.rank!,
                teamImage: standing.team?.id ?? 0,
                teamName: standing.team?.name ?? "nil",
                win: standing.all?.win ?? 0,
                draw: standing.all?.draw ?? 0,
                lose: standing.all?.lose ?? 0,
                points: standing.points ?? 0,
                form: standing.form ?? " "
            )
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let teamID = selectedLeague.first?.league?.standings?.first?[indexPath.item].team?.id {
            print(teamID)
        }
    }
}

extension LeaguesDetailsViewController {
    func setupFavoriteButton() {
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc func favoriteButtonTapped() {
        guard let modelLeague = selectedLeague.first?.league else {
            return print("error")
        }
        print("Tapped")
    }
}

