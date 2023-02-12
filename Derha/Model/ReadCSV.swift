//
//  ReadCSV.swift
//  Derha
//
//  Created by shahadmufleh on 14/11/2022.
//
//
import Foundation

//extension String{
//
//    //get the file name from a string
//    func fileName()-> String {
//
//        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
//
//    }
//
//    //get the file extension from a string
//    func fileExtension()-> String{
//
//        return URL(fileURLWithPath: self).pathExtension
//    }
//
//
//}
//
//
//func readCSVfile(inputFile: String, seperator: String)-> [String]{
//    //split the file name
//    let fileExtension = inputFile.fileExtension()
//    let fileName = inputFile.fileName()
//
//    //get the file URL
//    let fileURL = try! FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//
//let inputFile = fileURL.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
//
//    //get the data
//    do{
//        let savedData = try String(contentsOf: inputFile)
//        return savedData.components(separatedBy: seperator)
//
//    } catch {
//
//        return ["Error"]
//    }
//
//}

//var myData = readCSVfile(inputFile: "stock.csv", seperator: ",")

//print(myData)

