

import Foundation

extension String{
    
    func convertToDisplayFormat() ->String{
        guard let date = self.convertToDate() else {return "N/A "}
        return date.convertToMonthYearFormat()
        
    }
}
