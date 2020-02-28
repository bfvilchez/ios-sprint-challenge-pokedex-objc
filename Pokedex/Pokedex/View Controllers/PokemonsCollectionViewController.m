//
//  PokemonsCollectionViewController.m
//  Pokedex
//
//  Created by brian vilchez on 2/28/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

#import "PokemonsCollectionViewController.h"
#import "Pokedex-Swift.h"
#import "BFVPokemon.h"
#import "PokemonCollectionViewCell.h"

@interface PokemonsCollectionViewController ()
@property(nonatomic) NSMutableArray<BFVPokemon *> *pokemons;
@property(nonatomic) PokemonController *pokemonController;
@end

@implementation PokemonsCollectionViewController

static NSString * const reuseIdentifier = @"PokemonCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self pokemonController] fetchPokemonsWithCompletion:^(NSArray<BFVPokemon *> * _Nullable pokemons, NSError * _Nullable error) {
        if (error) {
            return;
        }
        
        if (pokemons) {
            dispatch_async(dispatch_get_main_queue(), ^{
            [[self pokemons] addObjectsFromArray:pokemons];
            [[self collectionView] reloadData];
        });
    }
        
    } ];
    
  //  [[self collectionView] registerClass:PokemonCollectionViewCell.self forCellWithReuseIdentifier:reuseIdentifier];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pokemonController = [[PokemonController alloc] init];
        _pokemons = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _pokemonController = [[PokemonController alloc] init];
        _pokemons = [[NSMutableArray alloc] init];
    }
    return self;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"PokemonDetailSegue"]) {
       NSIndexPath *indexPath = [[self collectionView] indexPathForCell:sender];
        PokemonDetailViewController *pokemonDetailVC = segue.destinationViewController;
        pokemonDetailVC.pokemon = [[self pokemons] objectAtIndex:indexPath.item];
        pokemonDetailVC.pokemonController = [self pokemonController];
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pokemons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PokemonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    BFVPokemon *pokemon = [[self pokemons] objectAtIndex:indexPath.row];
    cell.pokemonController = self.pokemonController;
    cell.pokemon = pokemon;
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
