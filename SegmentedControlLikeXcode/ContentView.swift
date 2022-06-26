import SwiftUI

enum SideMenuSelection: String, CaseIterable  {
    case folders = "folder"
    case bubble = "bubble.left"
    case tag = "tag"
}

struct ContentView: View {
    
    @State var sideMenuStatus : SideMenuSelection = .folders
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Picker(selection: $sideMenuStatus, label: EmptyView(), content: {
                    ForEach(SideMenuSelection.allCases, id: \.self) { sideMenuSelection in
                        Image(systemName: sideMenuSelection.rawValue).font(.title).tag(sideMenuSelection)
                    }
                })
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 180, height:26, alignment: .center)
                
                Spacer()
            }
                        
            HStack {
                Spacer()
                ForEach(SideMenuSelection.allCases, id: \.self) { sideMenuSelection in
                    Button(action: {
                        sideMenuStatus = sideMenuSelection
                    }, label: {
                        Image(systemName: sideMenuSelection.rawValue)
                            .symbolVariant(sideMenuStatus == sideMenuSelection ? .fill : .none)
                            .foregroundColor(sideMenuStatus == sideMenuSelection ? .accentColor: .none)
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 24)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
