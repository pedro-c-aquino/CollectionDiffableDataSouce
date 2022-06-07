//
//  ListTableCell.swift
//  CollectionDiffableDataSouce
//
//  Created by user208023 on 6/7/22.
//

import UIKit

class ListTableCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .label
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
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stackView.alignment = .fill
        stackView.spacing = 20
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

extension ListTableCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(stackView)
    }
    
    func addConstraints() {
        stackView.fillSuperview()
        imageView.constrainSize(CGSize(width: 30, height: 30))
    }
    
    
}

extension ListTableCell: ConfigureCell {
    
    func configure(with app: App) {
        nameLabel.text = app.name
        
    }
    
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ListTablePreviews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = ListTableCell()
            let app = App(tagline: "Lorem ipsum", name: "Lorem ipsum", subheading: "Lorem ipsum")
            
            cell.configure(with: app)
            
            return cell
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 35))
    }
}


#endif

