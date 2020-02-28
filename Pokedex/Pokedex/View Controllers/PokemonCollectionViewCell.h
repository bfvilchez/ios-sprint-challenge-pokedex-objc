//
//  PokemonCollectionViewCell.h
//  Pokedex
//
//  Created by brian vilchez on 2/28/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PokemonController ;
@class BFVPokemon;
NS_ASSUME_NONNULL_BEGIN

@interface PokemonCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property(nonatomic) BFVPokemon *pokemon;
@property PokemonController *pokemonController;
@end

NS_ASSUME_NONNULL_END
