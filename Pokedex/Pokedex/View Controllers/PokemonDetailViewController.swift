//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by brian vilchez on 2/28/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var ablilitiesLabel: UILabel!
    @objc var pokemonController: PokemonController?
    @objc var pokemon: BFVPokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemon = pokemon else { return }
        title = pokemon.name
        getPokemonDetails(pokemon.name)
    }
    
    private func getPokemonDetails(_ name: String) {
        pokemonController?.fetchPokemonDetails(for: name, completion: { (fetchedPokemon, error) in
            
            if let error = error {
                print("failed to fetch pokemon details: \(error)")
            } else {
                DispatchQueue.main.async {
                    guard let fetchedPokemon = fetchedPokemon else { return }
                    self.pokemon = fetchedPokemon
                    self.pokemonIDLabel.text = "\(fetchedPokemon.pokemonID)"
                    self.fetchPokemonImage(fetchedPokemon.sprite)
                }
            }
        })
    }
    
    private func fetchPokemonImage(_ image: String) {
        pokemonController?.fetchImage(image, completion: { (image, error) in
            if let error = error {
                print("failed to fetch pokemon image: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
            }
        })
    }
}
