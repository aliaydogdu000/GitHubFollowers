

import UIKit

class SearchVC: UIViewController {
    
    let imageLogo = UIImageView()
    let usernameTxtField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var logoImageViewTopConstrains:NSLayoutConstraint!
    
    var isUsernameEntered:Bool{
        return !usernameTxtField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageview()
        configureTextField()
        configureButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTxtField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        
    }
    func createDismissKeyboardTapGesture(){
        let tap = UIGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    func configureLogoImageview(){
        view.addSubview(imageLogo)
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        imageLogo.image = Images.ghLogo
        
        let topConstraintsConstant :CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        logoImageViewTopConstrains = imageLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintsConstant)
        logoImageViewTopConstrains.isActive = true
        
        NSLayoutConstraint.activate([
            imageLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 80),
            imageLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLogo.heightAnchor.constraint(equalToConstant: 200),
            imageLogo.widthAnchor.constraint(equalToConstant: 200),
             
            
        ])
        
    }
    
    func configureTextField(){
        view.addSubview(usernameTxtField)
        usernameTxtField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTxtField.topAnchor.constraint(equalTo: imageLogo.bottomAnchor,constant: 48),
            usernameTxtField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            usernameTxtField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            usernameTxtField.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
    @objc func pushFollowerListVC(){
        guard isUsernameEntered  else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username.We need to know who to look for 🤔.", buttonTitle: "OK.")
            return
            }
        usernameTxtField.resignFirstResponder()
        
        let followerListVC = FollowerListVC(username: usernameTxtField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func configureButton(){
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant:50)
        ])
    }
    
}
extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
