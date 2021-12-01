
import Foundation

class Report: NSObject, NSCoding, Identifiable, Codable{
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(date, forKey: "date")
        coder.encode(numberOfVideo, forKey: "numberOfVideos")
        coder.encode(hours, forKey: "hours")
        coder.encode(studies, forKey: "studies")
    }
    
    required init?(coder: NSCoder) {
        id = coder.decodeObject(forKey: "id") as? UUID ?? UUID()
        date = coder.decodeObject(forKey: "date") as? String ?? ""
        numberOfVideo = coder.decodeObject(forKey: "numberOfVideos") as? Int ?? 0
        hours = coder.decodeObject(forKey: "hours") as? Int ?? 0
        studies = coder.decodeObject(forKey: "studies") as? Int ?? 0
    }
    
    var id = UUID()
    let date: String
    var numberOfVideo = 0
    var hours = 0
    var studies = 0
    
    
    
    init(_ date: String) {
        self.date = date
    }
}

class CollectionOfReports: ObservableObject {
    @Published var items = [Report](){
        didSet {
            let  encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Report].self, from: items){
                self.items = decoded
                return
            }
        }
        
    }
}

class SelectedReport: ObservableObject {
    @Published var report: Report {
        didSet{
            let  encoder = JSONEncoder()
            if let encoded = try? encoder.encode(report){
                UserDefaults.standard.set(encoded, forKey: "select")
            }
        }
        
    }
    
    init(){
        if let report = UserDefaults.standard.data(forKey: "select"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(Report.self, from: report){
                self.report = decoded
                return
            }
        }
        report = Report("Error1")
    }
}

