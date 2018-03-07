//
//  RequestFactory.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/5/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import Foundation

struct RequestFactory {
    
    // Mark: - Parameters
    
    // The domain of all API requests being made
    private static let apiBaseURL = "jobposting28.azurewebsites.net"
    
    // The base paths for the relative API calls
    private static let apiTeamPath = "/api/team"
    private static let apiPlayerPath = "/api/player"
    
    
    // MARK: - Get Complete Lists of Models
    
    static func getPlayers() -> URLRequest {
        
        // Create the custom URL Components for the network call
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = RequestFactory.apiBaseURL
        urlComponents.path = RequestFactory.apiPlayerPath
        
        // Create and configure the URL Request
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        return request
    }
    
    static func getTeams() -> URLRequest {
        
        // Create the custom URL Components for the network call
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = RequestFactory.apiBaseURL
        urlComponents.path = RequestFactory.apiTeamPath
        
        // Create and configure the URL Request
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        return request
    }
    
    
    // MARK: Get List By Search Term
    
    static func getPlayers(byFirstName firstName: String, lastName: String) -> URLRequest? {
        
        let searchCriteria = sanitizeSearchTerm(firstName: firstName, lastName: lastName)
        
        // Create the custom URL Components for the network call
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = RequestFactory.apiBaseURL
        urlComponents.path = RequestFactory.apiPlayerPath
        if !searchCriteria.isEmpty {
            urlComponents.queryItems = [URLQueryItem(name: "criteria", value: searchCriteria)]
        }
        
        // Create and configure the URL Request
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        return request
    }
    
    
    // MARK: Get Model By Identifier
    
    static func getPlayer(byId id: Int) -> URLRequest {
        
        // Create the custom URL Components for the network call
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = RequestFactory.apiBaseURL
        urlComponents.path = RequestFactory.apiPlayerPath
        
        urlComponents.path += "/\(id)"
        
        // Create and configure the URL Request
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        return request
    }
    
    static func getTeam(byId id: Int) -> URLRequest {
        
        // Create the custom URL Components for the network call
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = RequestFactory.apiBaseURL
        urlComponents.path = RequestFactory.apiTeamPath
        
        urlComponents.path += "/\(id)"
        
        // Create and configure the URL Request
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        return request
    }
    
    
    // MARK: Get Detailed Model Info
    
    static func getPlayerStats(byId id: Int) -> URLRequest {
        
        // Create the custom URL Components for the network call
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = RequestFactory.apiBaseURL
        urlComponents.path = RequestFactory.apiPlayerPath
        
        urlComponents.path += "/\(id)/stats"
        
        // Create and configure the URL Request
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        return request
    }
    
    static func getTeamRoster(byId id: Int) -> URLRequest {
        
        // Create the custom URL Components for the network call
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = RequestFactory.apiBaseURL
        urlComponents.path = RequestFactory.apiTeamPath
        
        urlComponents.path += "/\(id)/roster"
        
        // Create and configure the URL Request
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        return request
    }
    
}


extension RequestFactory {
    
    // MARK: Utility Methods
    
    private static func sanitizeSearchTerm(firstName: String, lastName: String) -> String {
        
        var searchTerm = ""
        
        // Append first name if provided
        searchTerm += firstName
        searchTerm += (firstName != "" && lastName != "") ? " " : ""
        
        // Append last name if provided
        searchTerm += lastName
        
        return searchTerm
    }
}
