//
//  BFVPokemon.h
//  Pokedex
//
//  Created by brian vilchez on 2/28/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFVPokemon : NSObject
@property(nonatomic) NSString *name;
@property(nonatomic) int pokemonID;
@property(nonatomic)NSArray *ablilities;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithName:(NSString *)name pokemonID:(int)pokemonID abilities:(NSArray *)abilities;

@end

NS_ASSUME_NONNULL_END
