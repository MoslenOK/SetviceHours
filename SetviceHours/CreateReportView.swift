

import SwiftUI

struct CreateReportView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var reports: CollectionOfReports
    @State private var isWrongDate = false
    @State private var date = ""
    
    
    var body: some View {
        VStack{
            Spacer()
            Form{
                TextField("Месяц и год", text: $date)
                Button("Создать"){
                    if date != "" {
                        self.reports.items.append(Report(date))
                        self.presentationMode.wrappedValue.dismiss()
                    }else{
                        isWrongDate = true
                    }
                    
                }.alert(isPresented: $isWrongDate){
                    Alert(title: Text("Ошибка"), message: Text("Введите месяц и год"),dismissButton: .default(Text("Понятно")))
                }
                
            }.frame(width: 430, height: 150, alignment: .top)
            
        }
        
        
        
    }
}

struct CreateReportView_Previews: PreviewProvider {
    static var previews: some View {
        CreateReportView(reports: CollectionOfReports())
    }
}
