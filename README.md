# XcodeのようなSegmented Controlが欲しい
MacOSアプリを左側にNavigation Paneを用意したのですが、 Xcodeのナビゲーターの切り替えに相当するSegemented ControlをSwiftUIで作る方法が見つかりませんでした。

![](https://storage.googleapis.com/zenn-user-upload/909c23e70d30-20220626.png)
*この中段にあるようなSegmeneted Controllerを作りたい*

そこで、XcodeのSegmented Controlを模倣したUIを作成してみます。

# 通常のPickerを利用したSegmented Control
SwiftUIでは、「複数の状態を切り替える」場合はPickerのStyleにSegmentedPickerStyleを設定することで実現することができます。

```
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
        }
    }
}
```
※ カッコよく SF Symbols を利用してみました。

![](https://storage.googleapis.com/zenn-user-upload/4d363c81f13e-20220627.png)

このUIでも「Segmented Controlが欲しい」目的は達成できるのですが、Xcodeの直感的なUIを模倣すべく、独自にUI実装しました。

# XcodeのNavigation Paneを模倣したSegmented Control
実際には、単純にボタンを3つ並べ、ボタン押下時に画像を入れ替えることで現在のステータスが分かるようにしています。

SF Symbolsは .symbolVariantに値を指定することで、画像の入れ替えをすることができます。

![](https://storage.googleapis.com/zenn-user-upload/614d3d37934b-20220627.png)

これに三項演算子を組み合わせることで、状態を視覚的に表すことができます。

```
Image(systemName: "folder")
   .symbolVariant(isSelected ? .fill : .none)
```
   
実際に実装したコードはこちら。  
 
```
import SwiftUI

enum SideMenuSelection: String, CaseIterable  {
    case folders = "folder"
    case bubble = "bubble.left"
    case tag = "tag"
}

struct ContentView: View {
    
    @State var sideMenu : SideMenuSelection = .folders
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ForEach(SideMenuSelection.allCases, id: \.self) { sideMenuSelection in
                    Button(action: {
                        sideMenu = sideMenuSelection
                    }, label: {
                        Image(systemName: sideMenuSelection.rawValue)
                            .symbolVariant(sideMenu == sideMenuSelection ? .fill : .none)
                            .foregroundColor(sideMenu == sideMenuSelection ? .accentColor: .none)
                    })
                    .buttonStyle(.borderless)
                    .frame(width: 24)
                }
                Spacer()
            }
        }
    }
}
```
![](https://storage.googleapis.com/zenn-user-upload/d357eb6db456-20220627.png)

ソースコードはこちら
https://github.com/takahashikenichi/SegmentControlLikeXcode

https://github.com/takahashikenichi/SegmentControlLikeXcode/blob/main/SegmentedControlLikeXcode/ContentView.swift

