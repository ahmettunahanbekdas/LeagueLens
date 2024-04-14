
import UIKit

protocol SearchResultViewControllerInterface: AnyObject {
    func configureResultCollectionView()
    func navigationSearchToDetailsLeagues(leagueDetails: [LeagueStanding])
}

class SearchResultViewController: UIViewController {
    
    private let viewModel =  SearchResultViewModel()
    var searchLeagues: [ResponseLeague] = []
    
    let searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: .deviceWidth - 10 , height: .deviceHeight/8)
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(LeaguesCollectionViewCell.self, forCellWithReuseIdentifier: LeaguesCollectionViewCell.reuseID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension SearchResultViewController:  SearchResultViewControllerInterface{
    func configureResultCollectionView() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectionView)
        searchResultCollectionView.frame = view.bounds
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
    }
    
    func navigationSearchToDetailsLeagues(leagueDetails: [LeagueStanding]) {
        DispatchQueue.main.async {
            guard !leagueDetails.isEmpty else {
                MakeAlertHelper.alertMassage(title: "League Detail Not Found", message: "Continue For Other Leagues", style: .alert, vc: self)
                return
            }
            let detailsLeague = LeaguesDetailsViewController(selectedLeague: leagueDetails)
            print(leagueDetails)
            self.present(detailsLeague, animated: true, completion: nil)
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchLeagues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeaguesCollectionViewCell.reuseID, for: indexPath) as? LeaguesCollectionViewCell else {
            return LeaguesCollectionViewCell()
        }
        cell.backgroundColor = .systemBackground
        let league = searchLeagues[indexPath.row]
        cell.leagueSetCell(league: league)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectedSearchLeagues(id: searchLeagues[indexPath.item].league?._id ?? 0)
        print("tapped")
    }
    
}
