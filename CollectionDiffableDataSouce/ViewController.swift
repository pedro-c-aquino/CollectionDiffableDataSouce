//
//  ViewController.swift
//  CollectionDiffableDataSouce
//
//  Created by Evandro Rodrigo Minamoto 
//

import UIKit

class ViewController: UIViewController {
    
    let sections = [Section].parse(jsonFile: "sampleData")
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func createCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]
            
            switch section.type {
//            case "listTable":
//                return
            default:
                return self.createFeatureSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    func createFeatureSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(350))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return layoutSection
    }

}

extension ViewController: ViewCode {
    
    func buildViewHierarchy() {
        view.addSubview(collectionView)
    }
    
    func addConstraints() {
        collectionView.fillSuperview()
    }
    
    
}
