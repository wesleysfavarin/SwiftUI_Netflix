//
//  SettingsForm.swift
//  SwiftUIMovies
//
//  Created by wesley s favarin on 30/06/19.
//  Copyright © 2019 wesley s favarin. All rights reserved.
//

import SwiftUI

struct SettingsForm : View {
    @State var selectedRegion: Int = 0
    @State var alwaysOriginalTitle: Bool = false
    @Environment(\.isPresented) var isPresented
    
    var countries: [String] {
        get {
            var countries: [String] = []
            for code in NSLocale.isoCountryCodes {
                let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                let name = NSLocale(localeIdentifier: "pt_BR").displayName(forKey: NSLocale.Key.identifier, value: id)!
                countries.append(name)
            }
            return countries
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Região preferencia"),
                        footer: Text("Região é usada para exibir uma lista de filmes mais precisos"),
                        content: {
                            Toggle(isOn: $alwaysOriginalTitle) {
                                Text("Sempre motrar titulo original")
                            }
                            Picker(selection: $selectedRegion,
                                   label: Text("Região"),
                                   content: {
                                    ForEach(0 ..< self.countries.count) {
                                        Text(self.countries[$0]).tag($0)
                                    }
                            })
                })
                Section(header: Text("Dados do aplicativo"), footer: Text("Nenhuma dessas funções estão funcionando ainda;)"), content: {
                    Text("Exportar meus dados")
                    Text("Backup no iCloud")
                    Text("Restaurar do iCloud")
                    Text("Resetar dados do app").color(.red)
                })
                }.onAppear{
                    if let index = NSLocale.isoCountryCodes.firstIndex(of: AppUserDefaults.region) {
                        self.selectedRegion = index
                    }
                    self.alwaysOriginalTitle = AppUserDefaults.alwaysOriginalTitle
                }.navigationBarItems(trailing: Button(action: {
                    AppUserDefaults.region = NSLocale.isoCountryCodes[self.selectedRegion]
                    AppUserDefaults.alwaysOriginalTitle = self.alwaysOriginalTitle
                    self.isPresented?.value = false
                }, label: {
                    Text("Salvar")
                }))
                .navigationBarTitle(Text("Configuração"))
        }
    }
}

#if DEBUG
struct SettingsForm_Previews : PreviewProvider {
    static var previews: some View {
        SettingsForm()
    }
}
#endif
