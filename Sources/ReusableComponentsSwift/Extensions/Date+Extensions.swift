import UIKit

extension Date {
    
    public enum DateFormats: String {
        case yyyyMMdd = "yyyy-MM-dd"
        case yyyyMMddHHmmssZ = "yyyy-MM-dd HH:mm:ssZ"
        case yyyyMMddHHmm = "yyyy-MM-dd HH:mm"
        case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
        case MMMddyyyy = "MMMM dd, yyyy"
        case EdMMMyyyyHHmmssZ = "E, d MMM yyyy HH:mm:ss Z"
    }
    
    public func toString(format: DateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
    public func dateAndTimetoString(format: DateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
    public func timeIn24HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
