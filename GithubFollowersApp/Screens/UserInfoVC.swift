

import UIKit

protocol UserInfoVCDelegate: class {
    func didRequestFollowers(for username:String)
}

class UserInfoVC: GFDataLoadingVC {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemOne = UIView()
    let itemTwo = UIView()
    let dateLabel = GFBodyLabel(textalignment: .center)
    var itemViews :[UIView] = []
    
    
    var userName : String!
    weak var delegate:UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureScrollView()
        layoutUI()
        getUserInfo()
    }
    
    func configureVC(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubviews(contentView )
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo:  scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
        
    }
    
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else{return}
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "OK!")
            }
        }
    }
    
    func configureUIElements(with user:User){
        
        self.add(childVC: GFRepoItemVC(user: user,delegate: self), to: self.itemOne)
        self.add(childVC: GFFollowerItemVC(user: user,delegate: self), to: self.itemTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    
    func layoutUI(){
        let padding : CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView, itemOne, itemTwo, dateLabel]
        
        for itemView in itemViews{
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: contentView .topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemOne.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: padding),
            itemOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemTwo.topAnchor.constraint(equalTo: itemOne.bottomAnchor,constant: padding),
            itemTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemTwo.bottomAnchor,constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func add(childVC:UIViewController, to containerView: UIView ){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}

extension UserInfoVC:GFRepoItemVCDelegate{
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else{
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user invalid.", buttonTitle: "OK!")
            return
        }
        presentSafariVC(with: url)
    }
}

extension UserInfoVC: GFFollowerItemVCDelegate{
    
    func didTapGetFollowers(for user: User) {
        guard user.Followers !=  0 else {
            presentGFAlertOnMainThread(title: "No Followers.", message: "This user has no followers.", buttonTitle: "SO SAD!")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
