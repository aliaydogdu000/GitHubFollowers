
import Foundation

enum GFError:String,Error{
    case invalidUsername = "This username created an invalid request.Please Try Again."
    case unableToComplete = "Please check your internet connection."
    case invalidResponse = "Invalid response from the server."
    case invalidData = "The data received from the server was invalid."
    case unableToFavorite = "There was an error favoriting this user.Please try again."
    case alreadyInFavorites = "You have already favorited this user."
}
