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

    lazy var dataSource: UICollectionViewDiffableDataSource<Section, App> = createDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerCells()
        reloadSnapShotData()
    }
    
    func reloadSnapShotData() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, App>()
        snapshot.appendSections(sections)
        
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource.apply(snapshot)
        
    }
    
    func createDataSource() -> UICollectionViewDiffableDataSource<Section, App> {
        UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView) { collectionView, indexPath, app in
            switch self.sections[indexPath.section].type {
            case "listTable":
                return collectionView.configure(ListTableCell.self, with: app, for: indexPath)
            default:
                return collectionView.configure(FeatureCell.self, with: app, for: indexPath)
                
            }
        }
    }
    
    func registerCells() {
        collectionView.register(FeatureCell.self, forCellWithReuseIdentifier: FeatureCell.reuseIdentifier)
        collectionView.register(ListTableCell.self, forCellWithReuseIdentifier: ListTableCell.reuseIdentifier)
    }

    func createCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]
            
            switch section.type {
            case "listTable":
                return self.createListTableSection()
            default:
                return self.createFeatureSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    func createListTableSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 0)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        return layoutSection
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
