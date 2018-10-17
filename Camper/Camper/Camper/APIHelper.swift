//
//  APIHelper.swift
//  Camper
//
//  Created by Ertheo Siswadi on 9/26/18.
//  Copyright © 2018 Ertheo Siswadi. All rights reserved.
//

import Foundation

class APIHelper
{
    init() {
        
    }
    func postRequest(input:[String:Any], completeHandler:@escaping(_ resp:[String:Any])->())
    {
        let endpoint : String = "http://server.esiswadi.de/camper"
        guard let url = URL(string: endpoint)
            else{
                print("Error: cannot create url from endpoint")
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let todo : [String: Any] =
            ["name": input["name"]!,
             "username": input["username"]!,
             "birthdate": input["birthdate"]!,
             "password": input["password"]!,
             "profilepic":input["profilepic"]!,
             "favlocation":input["favlocation"]!]
        
        let jsonTodo : Data
        do{
            jsonTodo = try JSONSerialization.data(withJSONObject: todo, options: [])
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: todo, options: [])
            
        }
        catch{
            print("Error: cannot create JSON from todo")
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let responseData = data
                else{
                    print("Error")
                    return
            }
            
            do
            {
                guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String:Any] else{
                    print("Could not get JSON from responseData")
                    return
                }
                
                completeHandler(receivedTodo)
                //get username from post result
                guard let todoUsername = receivedTodo["username"] as? String
                    else{
                        print("Could not get todoID")
                        return
                }
                print("debug - post - The username is \(todoUsername)")
                
            }
            catch{
                print("error parsing response from post")
                return
            }
        }
        task.resume()
    }
    
    //blocking
    func doesUsernameExist(usr:String) -> Bool
    {
        var toReturn : Bool = true
        let semaphore = DispatchSemaphore(value: 0)
        getRequest(username: usr) { (profile) in
            if profile["username"] as! String == ""
            {
                print("debug - im here0")
                toReturn = false
            }
            semaphore.signal()
        }
        semaphore.wait()
        return toReturn
    }
    
    func getRequest(username: String, completeHandler: @escaping (_ profile: [String:Any]) -> ())
    {
        let endpoint:String = "http://server.esiswadi.de/camper/\(username)"//https://jsonplaceholder.typicode.com/todos/2
        print("debug - get - url \(endpoint)")
        let url = URL(string: endpoint)
        let urlRequest = URLRequest(url: url!)

        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        var toReturn:[String:Any] = [:]
        
        let task = session.dataTask(with: urlRequest, completionHandler: {(data, response, error) -> Void in
            
            guard let responseData = data else {
                print("Error: did not receive data/username/profile doesnt exist")
                //send emptystring to callback func completeHandler
                completeHandler(["username":""])
                return
            }
            do
            {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])as? [String: Any]
                else{
                    completeHandler(["username":""])
                    return
                }

                print("todo is: " + (todo.description))
                toReturn = todo
                
                completeHandler(toReturn)
                DispatchQueue.main.async {
                }
            }
            catch
            {
                print("error jsonserial")
                completeHandler(["username":""])
                return
            }
        })

        task.resume()
    }
}
