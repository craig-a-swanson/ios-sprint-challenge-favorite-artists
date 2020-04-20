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
@property (strong, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistFormedLabel;
@property (strong, nonatomic) IBOutlet UITextView *artistBioTextView;

@end

@implementation ArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchbar.delegate = self;
    self.artistController = [[ArtistController alloc] init];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _artistName = searchBar.text;
    [_artistController fetchArtist:_artistName completionHandler:^(Artist * _Nullable artist, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.artistNameLabel.text = artist.strArtist;
            self.artistFormedLabel.text = [NSString stringWithFormat:@"%d", artist.intFormedYear];
            self.artistBioTextView.text = artist.strBiographyEN;
        });
    }];
}

@end
