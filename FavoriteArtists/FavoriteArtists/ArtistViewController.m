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
@property (strong, nonatomic) Artist *currentArtist;
@property (strong, nonatomic) NSArray<Artist *> *artists;

// MARK: - IBOutlets
@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;
@property (strong, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistFormedLabel;
@property (strong, nonatomic) IBOutlet UITextView *artistBioTextView;

@end

@implementation ArtistViewController

@synthesize artistController = _artistController;
@synthesize delegate = _delegate;

- (void)setArtistController:(ArtistController *)artistController {
    _artistController = artistController;
    _artists = _artistController.artists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchbar.delegate = self;
}

- (IBAction)saveArtist:(UIBarButtonItem *)sender {
    [self.artistController saveArtistWithName:_currentArtist.strArtist founded:_currentArtist.intFormedYear biography:_currentArtist.strBiographyEN];
    _artists = _artistController.artists;
    [self.delegate getArtistsArray:_artists];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _artistName = searchBar.text;
    [_artistController fetchArtist:_artistName completionHandler:^(Artist * _Nullable artist, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.currentArtist = artist;
            self.artistNameLabel.text = artist.strArtist;
            self.artistFormedLabel.text = [NSString stringWithFormat:@"Formed in %d", artist.intFormedYear];
            self.artistBioTextView.text = artist.strBiographyEN;
        });
    }];
}


@end
