import Foundation

class StockMaximize {
    
    func countProfit(prices: [Int]) -> Int {
        if prices.isEmpty  {
            return 0
        }
        var stack = [DayAction]()
        var results = [Int]()
        
        stack.append(DayAction(day: 0, stocks: 0, money: 0))
        while !stack.isEmpty {
            let dayAction = stack.popLast()!
            let last = dayAction.day + 1 == prices.count
            let dayPrice = prices[dayAction.day]
            if last {
                results.append(dayAction.money + dayAction.stocks * dayPrice)
            }
            else {
                (-1...dayAction.stocks).forEach{
                    i in
                    stack.append(DayAction(day: dayAction.day+1, stocks: dayAction.stocks - i, money: dayAction.money + i * dayPrice))
                }
            }
        }
        return results.max() ?? 0
    }

    private struct DayAction{
        let day: Int
        let stocks: Int
        let money: Int
    }
}
