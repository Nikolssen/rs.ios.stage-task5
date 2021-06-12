import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        var maxValue = 0
        let subfoods = foods.subarraySums
        let subdrinks = drinks.subarraySums
        for subfood in subfoods {
            for subdrink in subdrinks{
                if subfood.weight + subdrink.weight <= maxWeight {
                    let value =  min(subfood.value, subdrink.value)
                    if value > maxValue{
                        maxValue = value
                    }
                    
                }
            }
        }
        return maxValue
    }
}

extension Array where Element == Supply {
    var subarraySums: Set<SubSuply> {
        let sums = Set(self.reduce(into: [[]], {
            (result, element) in
            result.append(contentsOf: result.map {$0 + [element]})
        }).map({ $0.reduce(SubSuply(weight: 0, value: 0), {SubSuply(weight: $0.weight + $1.weight, value: $0.value + $1.value)})}))
        
        return sums
    }
}

struct SubSuply: Hashable, Equatable{
    var weight: Int
    var value: Int
}
