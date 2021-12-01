//
//  SelectedMenuView.swift
//  SetviceHours
//
//  Created by DENIS SYTYTOV on 13.12.2020.
//

import SwiftUI

struct SelectedMenuView: View {
    
    
    
    @ObservedObject var selectedReport =  SelectedReport()
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var reports = CollectionOfReports()
    @State private var isCreateReportViewOpen = false
    @State private var isWrongDate = false
    @State private var date = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(reports.items, id: \.date){item in
                        Text(item.date)
                            .onTapGesture{
                                selectedReport.report = item
                                self.mode.wrappedValue.dismiss()
                            }
                    }
                    .onMove{ indices, newOffset in
                        self.reports.items.move(fromOffsets: indices, toOffset: newOffset)
                    }
                    .onDelete{ indexSet in
                        self.reports.items.remove(atOffsets: indexSet)
                    }
                }
                if isCreateReportViewOpen{
                    VStack{
                        Spacer()
                        Form{
                            TextField("Месяц и год", text: $date)
                            Button("Создать"){
                                if date != "" {
                                    self.reports.items.append(Report(date))
                                    date = ""
                                    self.isCreateReportViewOpen.toggle()
                                }else{
                                    isWrongDate = true
                                }
                            }
                            .alert(isPresented: $isWrongDate){
                                Alert(title: Text("Ошибка"), message: Text("Введите месяц и год"),dismissButton: .default(Text("Понятно")))
                            }
                            
                        }.frame(width: 400, height: 150, alignment: .top)
                    }
                }
            }
            .navigationBarTitle("Выберите месяц",displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.mode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.backward")
            }),
                trailing:
                    HStack{
                        Button(action: {
                            isCreateReportViewOpen.toggle()
                        }, label: {
                            Image(systemName: "plus").foregroundColor(.blue)
                        })
                        
                        EditButton().padding(.all)
                    })
            
        }
        
    }
}


//
//struct SelectedMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedMenuView(selectedReport: Report("adscs"))
//    }
//}
