//
//  TTTMatchRequestController.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTMatchRequestController.h"

@implementation TTTMatchRequestController
{
    TTTMatchRequest *matchRequest;
    NSMutableAttributedString *placeholder;
}

- (id)initWithMatchRequest:(TTTMatchRequest *)givenMatchRequest
{
    self = [super initWithWindowNibName:@"TTTMatchRequestController"];
    if (self) {
        matchRequest = givenMatchRequest;
        placeholder = [[NSMutableAttributedString alloc] initWithString:@"Jack & Jill (Required)" attributes:@{NSForegroundColorAttributeName: [NSColor grayColor]}];
    }

    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];

    [[self.playerNames cell] setPlaceholderAttributedString:placeholder];
    if(matchRequest.names) {
        [self.playerNames setStringValue:matchRequest.names];
    }
    if (matchRequest.numPlayers) {
        [self.numPlayers selectCellAtRow:0 column:[matchRequest.numPlayers intValue] - 1];
    }
    if (matchRequest.matchType) {
        [self.matchType selectCellAtRow:0 column: [matchRequest.matchType isEqualToString:@"singles"] ? 0 : 1];
    }
    if (matchRequest.requestTTL) {
      [self.requestTTL setStringValue:[matchRequest.requestTTL stringValue]];
    }

    [self toggleSinglesOption];
    [self.errorMessage setHidden:YES];
}

- (IBAction)numPlayersChanged:(id)sender
{
    [self toggleSinglesOption];
}

- (void) toggleSinglesOption
{
    if([self.numPlayers selectedColumn] > 0) {
        [[self.matchType cellWithTag:1] setState: NSOffState];
        [[self.matchType cellWithTag:2] setState: NSOnState];
        [[self.matchType cellWithTag:1] setEnabled: NO];
        [self.matchType selectCellAtRow:0 column:1];
    } else {
        [[self.matchType cellWithTag:1] setEnabled: YES];
    }
}

- (IBAction)createMatch:(id)sender
{
    if(![[self.playerNames stringValue] length]) {
        [self.errorMessage setStringValue:@"Player names are required"];
        [self.errorMessage setHidden:NO];
        return;
    }

    NSInteger ttl = [self.requestTTL integerValue];
    if(ttl < 1 || ttl > 540) {
      [self.errorMessage setStringValue:@"Request time to live should be between 1 and 540"];
      [self.errorMessage setHidden:NO];
      return;
    }

    [self.errorMessage setHidden:YES];
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setValue:[NSNumber numberWithInteger:ttl] forKey:@"requestTTL"];
    [options setValue:[self.playerNames stringValue] forKey:@"names"];
    
    int playerCount = (int) [self.numPlayers selectedColumn] + 1;
    [options setValue:[NSNumber numberWithInt: playerCount] forKey:@"numPlayers"];
    
    [options setValue:[[[self.matchType selectedCell] title] lowercaseString] forKey:@"matchType"];
    
  [matchRequest createMatchFromOptions:options onComplete: ^(BOOL success) {
    if(success) {
      [[self window] close];
    } else {
      [self.errorMessage setStringValue:@"There was a problem creating the match. Please try again later"];
      [self.errorMessage setHidden:NO];
    }
  }];
}

@end
