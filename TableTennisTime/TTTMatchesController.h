//
//  TTTMatchesController.h
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TTTMatch.h"

@interface TTTMatchesController : NSWindowController
@property (weak) IBOutlet NSTextField *playerNames;
@property (weak) IBOutlet NSMatrix *numPlayers;
@property (weak) IBOutlet NSMatrix *matchType;
@property (weak) IBOutlet NSTextField *requestTTL;
@property (weak) IBOutlet NSTextField *errorMessage;


- (id)initWithMatch:(TTTMatch*)match;
- (IBAction)numPlayersChanged:(id)sender;
- (IBAction)createMatch:(id)sender;
@end
