//
//  DashboardViewModel.swift
//  MERCYDA TRACK
//
//  Created by test on 04/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

class DashboardViewModel  {
    // MARK: - Properties
    private let networkServiceCalls = NetworkServiceCalls()
    
    
}
extension DashboardViewModel {
    
    
    func filterVehicleData(type:String, data:[Vehicle],completion:@escaping([Vehicle]) -> Void){
         let resultData = data.filter { $0.last_updated_data?.vehicle_mode == type}
         completion(resultData)
    }
    
    func filterOfflineData(data:[Vehicle],completion:@escaping([Vehicle]) -> Void){
        var filteredData = [Vehicle]()
        for i in 0..<data.count{
            if let lastUpdatedData = data[i].last_updated_data{
                printLog(i)
                let sourTimeInMilliSecond = lastUpdatedData.source_date
                let timeWithotMilliSecond = sourTimeInMilliSecond!/1000
                let sourceDate = Utility.getDateFromTimeStamp(sourceDate:timeWithotMilliSecond)
                let dayTimePeriodFormatter = DateFormatter()
                dayTimePeriodFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        // dayTimePeriodFormatter.dateFormat = "dd/mm/YYYY hh:mm a"
                dayTimePeriodFormatter.timeZone = .current
                let dateString = dayTimePeriodFormatter.string(from: sourceDate)
                printLog(dateString)
                
                
                let calender:Calendar = Calendar.current
                let currentDateFormat  =  dayTimePeriodFormatter.date(from:getCurrentDateTime())
                printLog(dayTimePeriodFormatter.string(from: currentDateFormat!))
                let components: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from:sourceDate, to: currentDateFormat!)
                printLog("Minute :\(String(components.minute!))")
                if components.minute! > 10{
                    filteredData.append(data[i])
                }
                
            }else{
                filteredData.append(data[i])
            }
        }
        completion(filteredData)
    }
    
    func filterOnlineData(data:[Vehicle],completion:@escaping([Vehicle]) -> Void){
        var filteredData = [Vehicle]()
               for i in 0..<data.count{
                   if let lastUpdatedData = data[i].last_updated_data{
                       printLog(i)
                       let sourTimeInMilliSecond = lastUpdatedData.source_date
                       let timeWithotMilliSecond = sourTimeInMilliSecond!/1000
                       let sourceDate = Utility.getDateFromTimeStamp(sourceDate:timeWithotMilliSecond)
                       let dayTimePeriodFormatter = DateFormatter()
                       dayTimePeriodFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                               // dayTimePeriodFormatter.dateFormat = "dd/mm/YYYY hh:mm a"
                       dayTimePeriodFormatter.timeZone = .current
                       let dateString = dayTimePeriodFormatter.string(from: sourceDate)
                       printLog(dateString)
                       
                       
                       let calender:Calendar = Calendar.current
                       let currentDateFormat  =  dayTimePeriodFormatter.date(from:getCurrentDateTime())
                       printLog(dayTimePeriodFormatter.string(from: currentDateFormat!))
                       let components: DateComponents = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from:sourceDate, to: currentDateFormat!)
                       printLog("Minute :\(String(components.minute!))")
                       if components.minute! < 10{
                        
                           printLog("appendData")
                           filteredData.append(data[i])
                       }
                       
                   }
               }
               completion(filteredData)
    }
    
    
    
    func getVehicleCount(completion: @escaping (WebServiceResult<getVehiclesCountResponse, String>) -> Void) {
        self.networkServiceCalls.getVehiclesCount { (state) in
            switch state {
            case .success(let result as getVehiclesCountResponse):
                completion(.success(result))
                printLog("Vechile details Count \(result)")
            case .failure(let error):
                completion(.failure(error))
                printLog(error)
            default:
                completion(.failure(AppSpecificError.unknownError.rawValue))
            }
        }
    }
    
    func getVehicleList(completion: @escaping (WebServiceResult<[Vehicle],String>) -> Void){
        self.networkServiceCalls.getVehiclesList { (state) in
            switch state{
            case .success( let result as [Vehicle]):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            default:
                completion(.failure(AppSpecificError.unknownError.rawValue))
                
            }
        }
    }
    
    func getDeviceData(completion: @escaping (WebServiceResult<[DeviceDataResponse], String>) -> Void) {
        self.networkServiceCalls.getDeviceData(serialNumber: "IRNS1309", enableSourceDate: "true", startTime: "1593628200000", endTime: "1593714600000") { (state) in
            switch state {
            case .success(let result as [DeviceDataResponse]):
                completion(.success(result))
                printLog("Vechile details Count \(result)")
            case .failure(let error):
                completion(.failure(error))
                printLog(error)
            default:
                completion(.failure(AppSpecificError.unknownError.rawValue))
            }
        }
    }
   func getCurrentDateTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateTime = formatter.string(from: date)
        return dateTime
    }
}

   



