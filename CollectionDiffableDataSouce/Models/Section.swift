//
//  Section.swift
//  CollectionDiffableDataSouce
//
//  Created by Evandro Rodrigo Minamoto
//

import Foundation

struct Section: Decodable, Hashable {
    let id: UUID = UUID()
    let type: String
    let title: String
    let subtitle: String
    let items: [App]
    
    enum CodingKeys: String, CodingKey {
        case type
        case title
        case subtitle
        case items
    }
}
