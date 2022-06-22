

import UIKit

class GFSecondarytitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fonSize : CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fonSize,weight: .medium)
        configure()
    }
    private func configure(){
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        
    }


}