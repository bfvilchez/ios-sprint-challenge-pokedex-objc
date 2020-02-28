//
//  PokemonController.swift
//  Pokedex
//
//  Created by brian vilchez on 2/28/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import Foundation
import UIKit

class PokemonController: NSObject {
    
    // MARK: - helper methods
    @objc func fetchPokemons(completion: @escaping([BFVPokemon]?, NSError?) -> Void) {
        guard let pokemonResults = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return }
        var request = URLRequest(url: pokemonResults)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // checking for errors
            if let error = error as NSError? {
                print("error fetching pokemons: \(error)")
                completion(nil,error)
                return
            }
            
            //checking for data
            guard let pokemonData = data else { return }
            
            // convert json into model object
            do {
                guard let pokemonDictionary = try JSONSerialization.jsonObject(with: pokemonData, options: []) as? [String: Any],
                    let resultsArray = pokemonDictionary["results"] as? [[String: Any]] else { return }
                var pokemons = [BFVPokemon]()
                for dictionary in resultsArray {
                    let pokemon = BFVPokemon(dictionary: dictionary)
                    pokemons.append(pokemon)
                }
                
                completion(pokemons,nil)
                
            } catch let error as NSError {
                print("error decoding pokemons: \(error)")
                completion(nil,error)
                return
            }
        }.resume()
    }
    
    // method gets image to display on collectionVC
    @objc func fetchPokemonImage(forPokemon name: String, completion: @escaping(UIImage?, NSError?) -> Void = { _,_ in }) {
        let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")?.appendingPathComponent(name)
        guard let pokemonURL = baseURL else { return }
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // checking for errors
            if let error = error as NSError? {
                print("error fetching pokemons: \(error)")
                completion(nil,error)
                return
            }
            
            //checking for data
            guard let pokemonData = data else { return }
            
            // convert json into model object
            do {
                // TODO: create swift error
                guard let pokemonDictionary = try JSONSerialization.jsonObject(with: pokemonData, options: []) as? [String: Any],
                    let pokemonSprites = pokemonDictionary["sprites"] as? [String: Any],
                    let pokemonFrontSprite = pokemonSprites["front_default"] as? Data  else {return }
                
                let pokemonImage = UIImage(data: pokemonFrontSprite)
                completion( pokemonImage, nil)
                
            } catch let error as NSError {
                print("error decoding pokemons: \(error)")
                completion(nil,error)
            }
        }.resume()
    }
    
    func fetchPokemonDetails(for name: String, completion: @escaping(BFVPokemon?, NSError?) -> Void) {
        let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")?.appendingPathComponent(name)
        guard let pokemonURL = baseURL else { return }
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // checking for errors
            if let error = error as NSError? {
                print("error fetching pokemons: \(error)")
                completion(nil,error)
                return
            }
            
            //checking for data
            guard let pokemonData = data else { return }
            
            // convert json into model object
            do {
                guard let pokemonDictionary = try JSONSerialization.jsonObject(with: pokemonData, options: []) as? [String: Any] else { return }
                let pokemon = BFVPokemon(dictionary: pokemonDictionary)
                completion(pokemon, nil)
            } catch let error as NSError {
                print("error decoding pokemons: \(error)")
                completion(nil,error)
            }
        }.resume()
    }
    
    func fetchImage(_ pokemonImage: String, completion: @escaping(UIImage?,NSError?) -> Void) {
        guard let imageURL = URL(string: pokemonImage) else { return }
        var request = URLRequest(url: imageURL)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // checking for errors
            if let error = error as NSError? {
                print("error fetching pokemons: \(error)")
                completion(nil,error)
                return
            }
            
            //checking for data
            guard let pokemonData = data else { return }
            let image = UIImage(data: pokemonData)
            completion(image, nil)
         
        }.resume()
    }
}
