//
//  FeatureCell.swift
//  CollectionDiffableDataSouce
//
//  Created by user208023 on 6/7/22.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
}

extension FeatureCell: ConfigureCell {
    
    func configure(with app: App) {
        tagLineLabel.text = app.tagline.uppercased()
        nameLabel.text = app.name
        subtitleLabel.text = app.subheading
    }
    
    
}

class FeatureCell: UICollectionViewCell {
    
    var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .quaternaryLabel
        return view
    }()
    
    let tagLineLabel: UILabel = {
        let label = UILabel()
//        label.text = "Exemplo"
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
//        label.text = "Subtitle Label"
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .secondaryLabel
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
//        label.text = "Name Label"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.backgroundColor = .random()
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [separator, tagLineLabel, nameLabel, subtitleLabel, imageView])
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FeatureCell: ViewCode {
    
    func buildViewHierarchy() {
        addSubview(stackView)
    }
    
    func addConstraints() {
        separator.constrainHeight(1)
        stackView.fillSuperview()
        stackView.setCustomSpacing(10, after: separator)
        stackView.setCustomSpacing(10, after: subtitleLabel)
    }
    
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct FeaturePreviews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = FeatureCell()
            let app = App(tagline: "Lorem ipsum", name: "Lorem ipsum", subheading: "Lorem ipsum")
            
            cell.configure(with: app)
            
            return cell
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 300))
    }
}


#endif
