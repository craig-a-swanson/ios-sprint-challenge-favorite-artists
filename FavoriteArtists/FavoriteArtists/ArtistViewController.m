//
//  ArtistViewController.m
//  FavoriteArtists
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "ArtistViewController.h"
#import "Artist.h"
#import "ArtistController.h"

@interface ArtistViewController ()

// MARK: - Properties
@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) ArtistController *artistController;

// MARK: - IBOutlets
@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;

@end

@implementation ArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchbar.delegate = self;
    self.artistController = [[ArtistController alloc] init];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // get the text from search bar and perform search
}

@end
