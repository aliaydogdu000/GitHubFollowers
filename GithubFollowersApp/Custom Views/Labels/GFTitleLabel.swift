

import UIKit

class GFTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textalignment:NSTextAlignment,fontSize: CGFloat){
        super.init(frame: .zero)
        self.textAlignment = textalignment
        self.font = UIFont.systemFont(ofSize: fontSize,weight: .bold)
        configure()
    }
    private func configure(){
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}