//
//  ArtistTableViewController.m
//  FavoriteArtists
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "ArtistTableViewController.h"
#import "Artist.h"
#import "ArtistController.h"
#import "ArtistViewController.h"
#import "ArtistDetailViewController.h"

@interface ArtistTableViewController ()

@property (nonatomic) ArtistController *artistController;

@property (strong, nonatomic) IBOutlet UILabel *artistNameLabel;

@end

@implementation ArtistTableViewController

- (instancetype)initWithArtists:(NSArray<Artist *> *)artists {
    if (self = [super init]) {
        _artists = artists;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.artistController = [[ArtistController alloc] init];
    [self.artistController loadArtistsFromDirectory];
    self.artists = _artistController.artists;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.artistController.artists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArtistCell" forIndexPath:indexPath];
    
    Artist *currentArtist = self.artistController.artists[indexPath.row];
    cell.textLabel.text = currentArtist.strArtist;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Formed in %d", currentArtist.intFormedYear];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if ([segue.identifier  isEqual: @"AddArtistSegue"]) {
        ArtistViewController *artistVC = segue.destinationViewController;
        
        artistVC.artistController = self.artistController;
        artistVC.delegate = self;
    }
    
    if ([segue.identifier isEqual: @"ArtistDetailSegue"]) {
        ArtistDetailViewController *artistDetailVC = segue.destinationViewController;
        
        Artist *currentArtist = self.artistController.artists[indexPath.row];
        artistDetailVC.artist = currentArtist;
    }
}

- (void)getArtistsArray:(NSArray<Artist *> *)artists {
    self.artists = artists;
    [self.tableView reloadData];
}

@end
