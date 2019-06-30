//
//  DiscoverFilterForm.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct DiscoverFilterForm : View {
    @EnvironmentObject private var store: Store<AppState>
    @Binding var isPresented: Bool
    
    let datesText = ["Randomizar",
                     "1950-1960",
                     "1960-1970",
                     "1970-1980",
                     "1980-1990",
                     "1990-2000",
                     "2000-2010",
                     "2010-2020"]
    let datesInt = [0, 1950, 1960, 1970, 1980, 1990, 2000, 2010]
    
    @State var selectedDate: Int = 0
    @State var selectedGenre: Int = 0
    @State var selectedCountry: Int = 0
    
    var currentFilter: DiscoverFilter? {
        store.state.moviesState.discoverFilter
    }
    
    var formFilter: DiscoverFilter? {
        if selectedGenre == 0 && selectedCountry == 0 && selectedDate == 0 {
            return nil
        }
        var startDate: Int?
        var endDtate: Int?
        var genre: Int?
        var region: String?
        
        if selectedDate > 0 {
            startDate = datesInt[selectedDate]
            endDtate = startDate! + 10
        }
        if selectedGenre > 0 {
            genre = genres![selectedGenre].id
        }
        if selectedCountry > 0 {
            region = NSLocale.isoCountryCodes[selectedCountry - 1]
        }
        return DiscoverFilter(year: DiscoverFilter.randomYear(),
                              startYear: startDate,
                              endYear: endDtate,
                              sort: DiscoverFilter.randomSort(),
                              genre: genre,
                              region: region)
    }
    
    var genres: [Genre]? {
        return store.state.moviesState.genres
    }
    
    var countries: [String] {
        get {
            var countries: [String] = ["Randomizar"]
            for code in NSLocale.isoCountryCodes {
                let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                let name = NSLocale(localeIdentifier: "pt_BR").displayName(forKey: NSLocale.Key.identifier, value: id)!
                countries.append(name)
            }
            return countries
        }
    }
    
    var body: some View {
        return NavigationView {
            Form {
                Section(header: Text("Filtrar configuração"), content: {
                    Picker(selection: $selectedDate,
                           label: Text("Ano"),
                           content: {
                            ForEach(0 ..< self.datesText.count) {
                                Text(self.datesText[$0]).tag($0)
                            }
                    })
                    
                    if self.genres != nil {
                        Picker(selection: $selectedGenre,
                               label: Text("Genero"),
                               content: {
                                ForEach(0 ..< self.genres!.count) {
                                    Text(self.genres![$0].name).tag($0)
                                }
                        })
                    }
                    
                    Picker(selection: $selectedCountry,
                           label: Text("País"),
                           content: {
                            ForEach(0 ..< self.countries.count) {
                                Text(self.countries[$0]).tag($0)
                            }
                    })
                })
                
                Section {
                    Button(action: {
                        self.isPresented = false
                        let filter = self.formFilter ?? DiscoverFilter.randomFilter()
                        self.store.dispatch(action: MoviesActions.ResetRandomDiscover())
                        self.store.dispatch(action: MoviesActions.FetchRandomDiscover(filter: filter))
                    }, label: {
                        Text("Salvar e filtrar filmes").color(.green)
                    })
                    
                    Button(action: {
                        self.isPresented = false
                    }, label: {
                        Text("Cancelar").color(.red)
                    })
                }
                
                Section {
                    Button(action: {
                        self.selectedCountry = 0
                        self.selectedDate = 0
                        self.selectedGenre = 0
                        self.isPresented = false
                        self.store.dispatch(action: MoviesActions.ResetRandomDiscover())
                        self.store.dispatch(action: MoviesActions.FetchRandomDiscover())
                    }, label: {
                        Text("Resetar randomização").color(.blue)
                    })
                }
                }
                .navigationBarTitle(Text("Buscar filtro"))
                .onAppear {
                    if let startYear = self.currentFilter?.startYear {
                        self.selectedDate = self.datesInt.firstIndex(of: startYear) ?? 0
                    }
                    if let genre = self.currentFilter?.genre {
                        self.selectedGenre = self.genres?.firstIndex{ $0.id == genre } ?? 0
                    }
                    if let region = self.currentFilter?.region,
                        let index = NSLocale.isoCountryCodes.firstIndex(of: region) {
                        self.selectedCountry = index + 1
                    }
                    self.store.dispatch(action: MoviesActions.FetchGenres())
            }
        }
    }
}

#if DEBUG
struct DiscoverFilterForm_Previews : PreviewProvider {
    static var previews: some View {
        DiscoverFilterForm(isPresented: .constant(false)).environmentObject(store)
    }
}
#endif
