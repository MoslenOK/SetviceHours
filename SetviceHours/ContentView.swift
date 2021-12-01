

import SwiftUI




struct ContentView: View {
    
    
    @ObservedObject var selectedReport = SelectedReport()
    
    @State private var isMenuOpen = false
    @ObservedObject var reports = CollectionOfReports()
    var body: some View {
        
        NavigationView{
            List{
                Text("Месяц: \(selectedReport.report.date)")
                
                Text("Просмотры видео: \(selectedReport.report.numberOfVideo)")
                Text("Часы: \(selectedReport.report.hours)")
               
                Text("Изучения: \(selectedReport.report.studies)")
            }
            .navigationBarItems(trailing: Button(action: {
                isMenuOpen.toggle()
            }, label: {
                Text("Выбрать")
            })).fullScreenCover(isPresented: $isMenuOpen, content: {
                SelectedMenuView()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
    }
}
