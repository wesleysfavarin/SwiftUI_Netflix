//
//  AppState.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import Foundation

fileprivate var savePath: URL!
fileprivate let encoder = JSONEncoder()
fileprivate let decoder = JSONDecoder()

struct AppState: FluxState {
    var moviesState: MoviesState
    var castsState: CastsState
    
    
    init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory,
                                                                in: .userDomainMask,
                                                                appropriateFor: nil,
                                                                create: false)
            savePath = documentDirectory.appendingPathComponent("userData")
        } catch let error {
            fatalError("Ops ocorreu um erro ao criar/salvar: \(error)")
        }
        
        if let data = try? Data(contentsOf: savePath),
            let moviesState = try? decoder.decode(MoviesState.self, from: data) {
            self.moviesState = moviesState
        } else {
            self.moviesState = MoviesState()
        }
        self.castsState = CastsState()
    }
    
    func archiveState() {
        guard let data = try? encoder.encode(moviesState) else {
            return
        }
        try? data.write(to: savePath)
    }
    
    #if DEBUG
    init(moviesState: MoviesState, castsState: CastsState) {
        self.moviesState = moviesState
        self.castsState = castsState
    }
    #endif
}
