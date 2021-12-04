//
//  ModelOfDataBase.swift
//  Slow
//
//  Created by Петр Ларочкин on 04.12.2021.
//

import Foundation
// думал что потребуется
enum Sex {
    case Male
    case Female
}

struct ModelOfDatabase {
    var email: String
    var age : Int
    var sex : Sex
    var height : Float
    var dailyWaterIntake: Int
    var historyOfDrinks : [Date : Int]
}
