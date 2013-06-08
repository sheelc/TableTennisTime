//
//  TTTMatchesController.m
//  TableTennisTime
//
//  Created by Sheel Choksi on 5/19/13.
//  Copyright (c) 2013 Sheel's Code. All rights reserved.
//

#import "TTTMatchesController.h"

@implementation TTTMatchesController
{
    TTTMatch* match;
    NSMutableAttributedString* placeholder;
}

- (TTTMatchesController*)initWithMatch:(TTTMatch*)selectedMatch
{
    self = [super initWithWindowNibName:@"TTTMatchesController"];
    match = selectedMatch;
    placeholder = [[NSMutableAttributedString alloc] initWithString:@"Jack & Jill (Required)" attributes:@{NSForegroundColorAttributeName: [NSColor grayColor]}];
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [[self.playerNames cell] setPlaceholderAttributedString:placeholder];
    if(match.names) {
        [self.playerNames setStringValue:match.names];
    }
    if (match.numPlayers) {
        [self.numPlayers selectCellAtRow:0 column:[match.numPlayers intValue] - 1];
    }
    if (match.matchType) {
        [self.matchType selectCellAtRow:0 column: [match.matchType isEqualToString:@"singles"] ? 0 : 1];
    }
    [self toggleSinglesOption];

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
        [self.playerNames setBackgroundColor:[NSColor redColor]];
        [self.playerNames setTextColor:[NSColor whiteColor]];
        [placeholder setAttributes:@{NSForegroundColorAttributeName: [NSColor whiteColor]} range:NSMakeRange(0,[placeholder length])];
        [[self.playerNames cell] setPlaceholderAttributedString:placeholder];
        return;
    }
    
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setValue:[self.playerNames stringValue] forKey:@"names"];
    
    int playerCount = (int) [self.numPlayers selectedColumn] + 1;
    [options setValue:[NSNumber numberWithInt: playerCount] forKey:@"numPlayers"];
    
    [options setValue:[[[self.matchType selectedCell] title] lowercaseString] forKey:@"matchType"];
    
    [match createMatchFromOptions:options];
    [[self window] close];
}

@end
