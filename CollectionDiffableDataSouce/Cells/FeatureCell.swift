//
//  FeatureCell.swift
//  CollectionDiffableDataSouce
//
//  Created by user208023 on 6/7/22.
//

import UIKit

class FeatureCell: UICollectionViewCell {
    
    var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .quaternaryLabel
        return view
    }()
    
    let tagLineLabel: UILabel = {
        let label = UILabel()
        label.text = "Exemplo"
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Subtitle Label"
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name Label"
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [separator, tagLineLabel, subtitleLabel, nameLabel, imageView])
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
    }
    
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct FeaturePreviews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = FeatureCell()
            
            return cell
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 300))
    }
}


#endif
