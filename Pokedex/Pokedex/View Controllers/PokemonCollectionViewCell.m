//
//  PokemonCollectionViewCell.m
//  Pokedex
//
//  Created by brian vilchez on 2/28/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

#import "PokemonCollectionViewCell.h"
#import "BFVPokemon.h"
#import "Pokedex-Swift.h"

@interface PokemonCollectionViewCell ()
@end

@implementation PokemonCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _pokemon = [[BFVPokemon alloc] init];
        _pokemonController = [[PokemonController alloc] init];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _pokemon = [[BFVPokemon alloc] init];
        _pokemonController = [[PokemonController alloc] init];
    }
    return self;
}

- (void)configureViews {
    self.pokemonName.text = self.pokemon.name;
    [[self pokemonController] fetchPokemonImageForPokemon:self.pokemon.name completion:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (error) {
            return;
        }
        
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.pokemonImage.image = image;
            });
        }
    }];
}

-(void)setPokemon:(BFVPokemon *)pokemon {
    _pokemon = pokemon;
    [self configureViews];
}

@end
