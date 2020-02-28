//
//  BFVPokemon.m
//  Pokedex
//
//  Created by brian vilchez on 2/28/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

#import "BFVPokemon.h"

@implementation BFVPokemon

- (instancetype)initWithName:(NSString *)name pokemonID:(int)pokemonID abilities:(NSArray *)abilities sprite:(NSString *)sprite{
    self = [super init];
    if (self) {
        _name = name;
        _ablilities = abilities;
        _pokemonID = pokemonID;
        _sprite = sprite;
    }
    return self;
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    int pokemonID = [dictionary[@"id"] intValue];
    NSString *name = dictionary[@"name"];
    NSArray * abilities = dictionary[@"abilities"];
    NSString *sprite = dictionary[@"sprites"][@"front_default"];
    NSLog(@"%@", abilities);
    return [self initWithName:name pokemonID:pokemonID abilities:abilities sprite:sprite];
}


@end
