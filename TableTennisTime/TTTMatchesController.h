//
//  TTTMatchesController.h
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TTTMatchesController : NSWindowController
@property (weak) IBOutlet NSTextField *playerNames;
@property (weak) IBOutlet NSMatrix *numPlayers;
@property (weak) IBOutlet NSMatrix *matchType;

- (IBAction)numPlayersChanged:(id)sender;
@end
