//
//  Model.swift
//  Movies
//
//  Created by Prog on 18/10/19.
//  Copyright © 2019 Prog. All rights reserved.
//

import Foundation

struct Root: Decodable {
    let Title: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Actors: String
    let Plot: String
    let Poster: String
    let Language: String
}
