//
//  ArtistController.m
//  FavoriteArtists
//
//  Created by Craig Swanson on 4/19/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

#import "ArtistController.h"

@implementation ArtistController


// Snippet for writing to the documents directory
//NSDictionary *dict = @{@"key2":@"Eezy",@"key1": @"Tutorials", @"key3":@"Website"};
//NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
//NSString *documentsDirectory = [pathArray objectAtIndex:0];
//NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"myDict.plist"];
//NSURL *url = [NSURL fileURLWithPath:filePath];
//BOOL status = [dict writeToURL:url atomically:YES];
//NSLog(@"Write Status %d",status);

// Snippet for reading from the documents directory
//NSURL *url = [NSURL URLWithString:@"http://ios.eezytutorials.com/sample-files/sample-dictionary-plist.plist"];
//NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfURL:url];
//NSLog(@"%@",url);

@end
